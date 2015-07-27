From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Get quirks from device tree
Date: Mon, 27 Jul 2015 10:23:50 +0200
Message-ID: <55B5EA96.6020604@monstr.eu>
References: <1437984249-18332-1-git-send-email-shawn.lin@rock-chips.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="st4TV3ufhtf1bmHltxJekItQmX8tSB1WL"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36905 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbbG0IXy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jul 2015 04:23:54 -0400
Received: by wibud3 with SMTP id ud3so104432292wib.0
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2015 01:23:53 -0700 (PDT)
In-Reply-To: <1437984249-18332-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-arm-kernel@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--st4TV3ufhtf1bmHltxJekItQmX8tSB1WL
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/27/2015 10:04 AM, Shawn Lin wrote:
> This patch adds the interface to get quirks from dts, and
> there is no need to assign different quirks by condition statement
> of arasan IP version.
>=20
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>=20
>  drivers/mmc/host/sdhci-of-arasan.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhc=
i-of-arasan.c
> index ef5a7d2..db07788 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -132,6 +132,7 @@ static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, s=
dhci_arasan_suspend,
>  static int sdhci_arasan_probe(struct platform_device *pdev)
>  {
>  	int ret;
> +	u32 quirktab[2];
>  	struct clk *clk_xin;
>  	struct sdhci_host *host;
>  	struct sdhci_pltfm_host *pltfm_host;
> @@ -172,6 +173,12 @@ static int sdhci_arasan_probe(struct platform_devi=
ce *pdev)
>  		goto clk_disable_all;
>  	}
> =20
> +	if (of_property_read_u32_array(pdev->dev.of_node,
> +				       "arasan,quirks", &quirktab[0], 2)) {

This is not documented anywhere that's why you should send binding to DT
mailing list and get ACK for it.

> +		host->quirks |=3D quirktab[0];
> +		host->quirks2 |=3D quirktab[1];
> +	}
> +
>  	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) =
{
>  		host->quirks |=3D SDHCI_QUIRK_NO_HISPD_BIT;
>  		host->quirks2 |=3D SDHCI_QUIRK2_HOST_NO_CMD23;
>=20

Also is there any binding which is done in this way?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--st4TV3ufhtf1bmHltxJekItQmX8tSB1WL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAlW16pYACgkQykllyylKDCFbEACdELRM6TCVtCjKlFnCX0nP3WKu
HRkAnA+NLHJbxJSW7IqJ3nFQwnSvp7eu
=AYJo
-----END PGP SIGNATURE-----

--st4TV3ufhtf1bmHltxJekItQmX8tSB1WL--
