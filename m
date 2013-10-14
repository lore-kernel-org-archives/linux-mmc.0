From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 5/5] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type
Date: Mon, 14 Oct 2013 10:44:46 +0200
Message-ID: <20131014104446.60dbf1d7@ipc1.ka-ro>
References: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
	<1381739024-24924-6-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:57410 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab3JNIo4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Oct 2013 04:44:56 -0400
In-Reply-To: <1381739024-24924-6-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Dong Aisheng <b29396@freescale.com>, linux-arm-kernel@lists.infradead.org


Shawn Guo wrote:
> We now have 'flags' in struct pltfm_imx_data to identify the features
> and quirks for ESDHC variants running on different i.MX SoCs.  The en=
um
> imx_esdhc_type can be eliminated by interpreting the ESDHC variants w=
ith
> the ESDHC_FLAG_* flags.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   52 +++++---------------------=
----------
>  1 file changed, 6 insertions(+), 46 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sd=
hci-esdhc-imx.c
> index f1e1385..f2cd5b0 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -100,18 +100,15 @@
[...]
> +#define IMX35_ESDHC	(ESDHC_FLAG_ENGCM07207)
> +#define IMX51_ESDHC	(0)
> +#define IMX53_ESDHC	(ESDHC_FLAG_MULTIBLK_NO_INT)
> +#define IMX6Q_USDHC	(ESDHC_FLAG_USDHC)
> =20
Useless parenthesis.

Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
