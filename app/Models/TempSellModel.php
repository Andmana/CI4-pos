<?php

namespace App\Models;

use CodeIgniter\Model;

class TempSellModel extends Model
{
    protected $table      = 'temp_sell';
    public function findData()
    {
        return $this->table('temp_sell')->join('product', 'sellProduct_temp=id_product');
    }

    function getItem($productId, $userId)
    {

        $builder = $this->db->table('temp_sell')
            ->where('sellProduct_temp', $productId)
            ->where('sellinvoice_temo', $userId);
        $log = $builder->get()->getRow();
        return $log;
    }
}
