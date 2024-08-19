<?= $this->extend('auth/templates/index'); ?>

<?= $this->section('content'); ?>
<div class="container">

    <!-- Outer Row -->
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card o-hidden border-0 shadow-lg my-5">
                <div class="card-body p-0">
                    <!-- Nested Row within Card Body -->
                    <div class="row">
                        <div class="col-lg">
                            <div class="p-5">
                                <div class="text-center">
                                    <h1 class="h4 text-gray-900 mb-4">Selamat Datang!</h1>
                                </div>
                                <?= session()->get('pesan') ?>
                                <?= session()->get('level') ?>
                                <form action='/auth/login' method='post' class="user">
                                    <div class="form-group">
                                        <input type="text" class="form-control form-control-user" id="username" name="username" aria-describedby="emailHelp" placeholder="Masukkan Username...">
                                    </div>
                                    <div class="form-group">
                                        <input type="password" class="form-control form-control-user" id="password" name="password" placeholder="Kata Sandi">
                                    </div>
                                    <div class="form-group">
                                        <div class="custom-control custom-checkbox small">
                                            <input type="checkbox" class="custom-control-input" id="customCheck">
                                            <label class="custom-control-label" for="customCheck">Ingat
                                                Aku</label>
                                        </div>
                                    </div>
                                    <button class="btn btn-primary btn-user btn-block">
                                        Masuk
                                    </button>
                                    <a href="/Home/register" class="btn btn-primary btn-user btn-block">
                                        Daftar
                                    </a>
                                </form>
                                <hr>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>


    <!-- Include the noteModal.php -->
    <?= view('auth/noteModal'); ?>


    <!-- Script to automatically open the modal when the page loads -->
    <script type="text/javascript">
        $(document).ready(function() {
            $('#noteModal').modal('show');
        });
    </script>

</div>

<?= $this->endSection(); ?>