#include <enulib/enu.hpp>
using namespace enumivo;
class hello : public enumivo::contract {
  public:
      using contract::contract;

      [[enumivo::action]]
      void hi( account_name user ) {
         print( "Hello, ", name{user} );
      }
};

ENUMIVO_ABI( hello, (hi) )
