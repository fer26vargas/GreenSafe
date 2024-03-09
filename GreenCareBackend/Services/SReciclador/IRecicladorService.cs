using GreenCareBackend.Models;

namespace GreenCareBackend.Services.SReciclador
{
    public interface IRecicladorService
    {
        Task<int> RegisterAsRecycler(Recycler recycler);

        Task<bool> HistorialRutas(int idUser);

    }
}
