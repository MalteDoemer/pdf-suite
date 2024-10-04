pkgname=pdf-suite
pkgver="1.0.0"
pkgrel="1"
pkgdesc="This packages contains two simple bash files that can be used to work with pdfs."
arch=("any")
depends=("poppler" "img2pdf")
license=("MIT")
source=("pdf-combiner.sh" "pdf-compressor.sh")
sha512sums=("SKIP" "SKIP")

package() {
    mkdir -p "${pkgdir}/usr/bin/"

    cp "${srcdir}/pdf-combiner.sh" "${pkgdir}/usr/bin/pdf-combiner"
    chmod +x "${pkgdir}/usr/bin/pdf-combiner"

    cp "${srcdir}/pdf-compressor.sh" "${pkgdir}/usr/bin/pdf-compressor"
    chmod +x "${pkgdir}/usr/bin/pdf-compressor"
}