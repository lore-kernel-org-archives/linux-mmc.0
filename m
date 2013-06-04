From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 05/10] mmc: dw_mmc-pltfm: remove static from
 dw_mci_pltfm_remove
Date: Tue, 04 Jun 2013 12:59:11 +0900
Message-ID: <51AD660F.7060508@samsung.com>
References: <201306030055.15413.heiko@sntech.de>
 <201306030058.27184.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:27792 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756623Ab3FDD65 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jun 2013 23:58:57 -0400
In-reply-to: <201306030058.27184.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mike Turquette <mturquette@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Seungwon Jeon <tgih.jun@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Jaehoon Chung <jh80.chung@samsung.com>, Olof Johansson <olof@lixom.net>, John Stultz <john.stultz@linaro.org>, Grant Likely <grant.likely@linaro.org>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, devicetree-discuss@lists.ozlabs.org

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 06/03/2013 07:58 AM, Heiko St=FCbner wrote:
> dw_mci_pltfm_remove gets exported and used by dw_mmc-exynos, so shoul=
d
> not be static.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/mmc/host/dw_mmc-pltfm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mm=
c-pltfm.c
> index 37873f1..0048da8 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -68,7 +68,7 @@ static int dw_mci_pltfm_probe(struct platform_devic=
e *pdev)
>  	return dw_mci_pltfm_register(pdev, NULL);
>  }
> =20
> -static int dw_mci_pltfm_remove(struct platform_device *pdev)
> +int dw_mci_pltfm_remove(struct platform_device *pdev)
>  {
>  	struct dw_mci *host =3D platform_get_drvdata(pdev);
> =20
>=20

