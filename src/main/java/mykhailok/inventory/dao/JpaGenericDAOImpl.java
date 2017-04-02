package mykhailok.inventory.dao;

import mykhailok.inventory.model.NamedEntity;
import org.springframework.core.GenericTypeResolver;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.math.BigInteger;
import java.util.List;
import java.util.Set;

public class JpaGenericDAOImpl<T extends NamedEntity> implements AbstractDAO<T> {
    @PersistenceContext
    EntityManager em;

    public T save(T t) {
        if (t.isNew()) {
            em.persist(t);
            return t;
        }
        return em.merge(t);
    }

    @Override
    public void delete(BigInteger id) {
        T t = get(id);
        if (t != null) {
            em.remove(t);
        }
    }

    @Override
    public T get(BigInteger id) {
        return em.find(getClazz(), id);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<T> getAll() {
        return em.createQuery("FROM " + getClazz().getSimpleName()).getResultList();
    }

    @SuppressWarnings("unchecked")
    private Class<T> getClazz() {
        return (Class<T>) GenericTypeResolver.resolveTypeArgument(getClass(), JpaGenericDAOImpl.class);
    }
}
