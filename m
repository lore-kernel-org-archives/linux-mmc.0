From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/5] mmc: remove .owner field for drivers using
 module_platform_driver
Date: Mon, 18 Aug 2014 16:19:56 +0200
Message-ID: <3815db00-4b32-4484-b97e-2144dc5abb45@BY2FFO11FD040.protection.gbl>
References: <1407860069-12706-1-git-send-email-peter.griffin@linaro.org>
 <1407860069-12706-2-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8058146358217523511=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1407860069-12706-2-git-send-email-peter.griffin@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tgih.jun@samsung.com, jh80.chung@samsung.com, chris@printf.net, ulf.hansson@linaro.org, jarkko.lavinen@nokia.com, balajitk@ti.com, baohua@kernel.org, viresh.linux@gmail.com, ian.molton@codethink.co.uk, maxime.ripard@free-electrons.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, spear-devel@list.st.com, linux-tegra@vger.kernel.org, michal.simek@xilinx.com, swarren@wwwdotorg.org
Cc: lee.jones@linaro.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

--===============8058146358217523511==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="fbjn4odFFoAwguFUomUaQxkj0tNXNrD4r"

--fbjn4odFFoAwguFUomUaQxkj0tNXNrD4r
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 08/12/2014 06:14 PM, Peter Griffin wrote:
> This patch removes the superflous .owner field for drivers which
> use the module_platform_driver API, as this is overriden in
> platform_driver_register anyway.
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/mmc/host/jz4740_mmc.c      | 1 -
>  drivers/mmc/host/moxart-mmc.c      | 1 -
>  drivers/mmc/host/mxcmmc.c          | 1 -
>  drivers/mmc/host/mxs-mmc.c         | 1 -
>  drivers/mmc/host/omap.c            | 1 -
>  drivers/mmc/host/omap_hsmmc.c      | 1 -
>  drivers/mmc/host/pxamci.c          | 1 -
>  drivers/mmc/host/rtsx_pci_sdmmc.c  | 1 -
>  drivers/mmc/host/rtsx_usb_sdmmc.c  | 1 -
>  drivers/mmc/host/s3cmci.c          | 1 -
>  drivers/mmc/host/sdhci-bcm-kona.c  | 1 -
>  drivers/mmc/host/sdhci-bcm2835.c   | 1 -
>  drivers/mmc/host/sdhci-cns3xxx.c   | 1 -
>  drivers/mmc/host/sdhci-dove.c      | 1 -
>  drivers/mmc/host/sdhci-esdhc-imx.c | 1 -
>  drivers/mmc/host/sdhci-msm.c       | 1 -
>  drivers/mmc/host/sdhci-of-arasan.c | 1 -
>  drivers/mmc/host/sdhci-of-esdhc.c  | 1 -
>  drivers/mmc/host/sdhci-of-hlwd.c   | 1 -
>  drivers/mmc/host/sdhci-pxav2.c     | 1 -
>  drivers/mmc/host/sdhci-pxav3.c     | 1 -
>  drivers/mmc/host/sdhci-s3c.c       | 1 -
>  drivers/mmc/host/sdhci-sirf.c      | 1 -
>  drivers/mmc/host/sdhci-spear.c     | 1 -
>  drivers/mmc/host/sdhci-tegra.c     | 1 -
>  drivers/mmc/host/sh_mmcif.c        | 1 -
>  drivers/mmc/host/sh_mobile_sdhi.c  | 1 -
>  drivers/mmc/host/sunxi-mmc.c       | 1 -
>  28 files changed, 28 deletions(-)

I have checked this for all xilinx drivers we have in the tree
and I have sent similar patches.
This problem is probably in all subsystems.
With communication with Mark Brown. Don't you have
cocinelle script for fixing this everywhere?

Thanks,
Michal




--fbjn4odFFoAwguFUomUaQxkj0tNXNrD4r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlPyC5IACgkQykllyylKDCHd3QCfT2L7l1xjP/Mc6c/ym+/aRN6t
er0AnR/VATsUMTIO6Lr8XTeDvzl6m0QG
=Glle
-----END PGP SIGNATURE-----

--fbjn4odFFoAwguFUomUaQxkj0tNXNrD4r--


--===============8058146358217523511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8058146358217523511==--
