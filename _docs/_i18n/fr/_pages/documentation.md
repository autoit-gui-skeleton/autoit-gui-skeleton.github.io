<!-- Breadcrumb navigation -->
<nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="{{ site.url }}{{ site.baseurl }}/">Entrée</a></li>
        <li class="breadcrumb-item active" aria-current="page">Documentation</li>
    </ol>
</nav>


<!-- Card's documentation -->
<div class="container">
    <p class="mt-5 mb-5">Le plus simple pour démarrer avec AGS est de cloner un projet example sur Github, ou bien d'utiliser l'application en ligne de commande AGS-console, qui permet de générer  rapidement un nouveau projet AGS depuis un template choisi, et ensuite de commencer la lecture avec : "<a href="{{ site.url }}{{ site.baseurl }}/documentation/getting-started">1. Démarrer avec AGS</a>".</p>

    <div class="row">

        <div class="col-sm-12 mb-5">
            <div class="card">
                <div class="animated-zoom-img">
                    <a href="{{ site.url }}{{ site.baseurl }}/documentation/getting-started">
                        <img class="card-img-top animation-img" src="{{ site.url }}{{ site.baseurl_root }}/assets/img/documentation/hand-3285912_1920.jpg" alt="Card image cap">
                    </a>
                </div>
                <div class="card-body">
                    <h4 class="card-title mt-0"><a href="{{ site.url }}{{ site.baseurl }}/documentation/getting-started">1. Démarrer avec AGS</a></h4>
                    <hr/>
                    <p class="card-text">Vue d'ensemble des concepts, de l'organisation du code et des principaux outils d'AGS.</p>
                    <a href="{{ site.url }}{{ site.baseurl }}/documentation/getting-started" class="black-text d-flex justify-content-end"><h6>{% t global.read %} <i class="fa fa-angle-double-right"></i></h6></a>
                </div>
            </div>
        </div>

        <div class="col-sm-12 mb-5">
            <div class="card">
                <div class="animated-zoom-img">
                    <a href="{{ site.url }}{{ site.baseurl }}/documentation/code-organization">
                        <img class="card-img-top" src="{{ site.url }}{{ site.baseurl_root }}/assets/img/documentation/computer.jpeg" alt="Card image cap">
                    </a>
                </div>
                <div class="card-body">
                    <h4 class="card-title mt-0"><a href="{{ site.url }}{{ site.baseurl }}/documentation/code-organization">2. Organisation du code</a></h4>
                    <hr/>
                    <p class="card-text">Explique l'organisation du code d'un projet qui respecte les conventions et l'architecture d'AGS.</p>
                    <a href="{{ site.url }}{{ site.baseurl }}/documentation/code-organization" class="black-text d-flex justify-content-end"><h6>{% t global.read %} <i class="fa fa-angle-double-right"></i></h6></a>
                </div>
            </div>
        </div>

        <div class="col-sm-12 mb-5">
            <div class="card">
                <div class="animated-zoom-img">
                    <a href="{{ site.url }}{{ site.baseurl }}/documentation/creating-setup-package-autoit-application">
                        <img class="card-img-top" src="{{ site.url }}{{ site.baseurl_root }}/assets/img/pixabay/jigsaw-puzzle-712465_1920.jpg" alt="Creating d'installeur Windows - setup - pour des applications AutoIt">
                    </a>
                </div>
                <div class="card-body">
                    <h4 class="card-title mt-0"><a href="{{ site.url }}{{ site.baseurl }}/documentation/creating-setup-package-autoit-application">3. Creating d'installeur Windows - setup - pour des applications AutoIt</a></h4>
                    <hr/>
                    <p class="card-text">Afin de faciliter le déploiement d'une application Windows, AGS propose une approche automatisée de la solution <a href="http://www.jrsoftware.org/isinfo.php">InnoSetup</a> pour générer des installeurs Windows.</p>
                    <a href="{{ site.url }}{{ site.baseurl }}/documentation/creating-setup-package-autoit-application" class="black-text d-flex justify-content-end"><h6>{% t global.read %} <i class="fa fa-angle-double-right"></i></h6></a>
                </div>
            </div>
        </div>

    </div>
</div>