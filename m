From: Mark Brown <broonie@kernel.org>
Subject: Re: next/master boot: 179 boots: 11 failed, 167 passed with 1
 offline (next-20180731)
Date: Tue, 31 Jul 2018 17:06:23 +0100
Message-ID: <20180731160623.GH5719@sirena.org.uk>
References: <5b607cc4.1c69fb81.6c1d6.6534@mx.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3175613517232453340=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5b607cc4.1c69fb81.6c1d6.6534@mx.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Ludovic Barre <ludovic.barre@st.com>
Cc: kernel-build-reports@lists.linaro.org, khilman@baylibre.com, linux-mmc@vger.kernel.org, linux-next@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============3175613517232453340==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gKijDXBCEH69PxaN"
Content-Disposition: inline


--gKijDXBCEH69PxaN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2018 at 08:14:12AM -0700, kernelci.org bot wrote:

Today's -next fails to boot on a variety of Qualcomm 32 bit platforms:

>     multi_v7_defconfig:
>         qcom-apq8064-cm-qs600:
>             lab-baylibre-seattle: new failure (last pass: next-20180730)
>         qcom-apq8064-ifc6410:
>             lab-baylibre-seattle: new failure (last pass: next-20180730)
>=20
>     qcom_defconfig:
>         qcom-apq8064-cm-qs600:
>             lab-baylibre-seattle: new failure (last pass: next-20180730)

The logs are all somewhat similar, for example:

   https://storage.kernelci.org/next/master/next-20180731/arm/multi_v7_defc=
onfig/lab-baylibre-seattle/boot-qcom-apq8064-cm-qs600.html

detects a DMA problem during MMCI initialization:

[    2.237566] mmci-pl18x 121c0000.sdcc: mmc2: PL180 manf 51 rev0 at 0x121c=
0000 irq 32,0 (pio)
[    2.244790] mmci-pl18x 121c0000.sdcc: DMA channels RX dma2chan1, TX dma2=
chan2
[    2.271722] mmci-pl18x 12400000.sdcc: error during DMA transfer!
[    2.271757] mmci-pl18x 12400000.sdcc: buggy DMA detected. Taking evasive=
 action.
[    2.276798] ------------[ cut here ]------------
[    2.284185] WARNING: CPU: 0 PID: 0 at ../include/linux/dma-mapping.h:551=
 bam_free_chan+0x2d8/0x2e0
[    2.288772] Modules linked in:
[    2.297534] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-rc7-next-20=
180731 #1

then panics:

[    2.513796] ------------[ cut here ]------------
[    2.518367] kernel BUG at ../mm/vmalloc.c:1608!
[    2.522968] Internal error: Oops - BUG: 0 [#1] SMP ARM

trying to release the DMA channel.  I've not done any bisection or
anything but I do note 8bb2299d2d0b5cc (mmc: mmci: Add and implement a
->dma_setup() callback for qcom dml) and some related commits in the MMC
tree.

More details for each of the failed boots at:

  https://kernelci.org/boot/id/5b6054f559b5144b9396baa9/
  https://kernelci.org/boot/id/5b60551259b5144abb96bab6/
  https://kernelci.org/boot/id/5b6054e259b5144b1e96bab2/

including full logs, details of the build and so on.

--gKijDXBCEH69PxaN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltgiP8ACgkQJNaLcl1U
h9D2GQf/a6b1VF7LuVwtXj8TF0zF4ZYBg+iI4bWY0djl1iD7Xx87fqsQ1rmQrzy6
pyBgKCZcb66v514+Qj4FKLkO9D9iFxFM4FNJjvXFchlxiL4fO/4cyeRjpgXMwmww
/4AUgAxTO7Za2xKZ4ysk5BVQ2845oEYn01Gxc1IyC0m8gXuv3rSOSKBCBWFc+WEC
4+e2QFecVsi7whSMrGLuWdPACXpK4NjBh9ScA/HbWAjT/Gl8XNmZtvyYnp0DcrJY
2kyBGreEemiE8voSLDmYyMerSCsuqbn+FLwH1tGTn2v7mDd0xExEatQtNWuVwC1X
KiToDsKyf9zMi12kL29DIAN/uCdW6w==
=K646
-----END PGP SIGNATURE-----

--gKijDXBCEH69PxaN--


--===============3175613517232453340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3175613517232453340==--
