From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] sdhci-s3c: Add SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK quirk
	for Samsung SoC
Date: Fri, 11 Jun 2010 12:32:46 +0900
Message-ID: <AANLkTim2LzIh7dadCAWCo6jltS4CYA8gLKaiQne_VzqK@mail.gmail.com>
References: <1276169991-16396-1-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56535 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301Ab0FKDcr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jun 2010 23:32:47 -0400
In-Reply-To: <1276169991-16396-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, Lee Hyuk <hyuk1.lee@samsung.com>

Hi,

On Thu, Jun 10, 2010 at 8:39 PM, Kukjin Kim <kgene.kim@samsung.com> wro=
te:
> From: Lee Hyuk <hyuk1.lee@samsung.com>
>
> On Samsung's SDMMC hosts the timeout clock is derivied from the SD
> Clock, which is set dynamically.
> So, checked 'SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK' quirk and removed
> 'sdhci_s3c_get_timeout_clk' callback which doesn't need any more.
>
> Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> =A0drivers/mmc/host/sdhci-s3c.c | =A0 10 +++-------
> =A01 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3=
c.c
> index af21792..ca09382 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -110,11 +110,6 @@ static unsigned int sdhci_s3c_get_max_clk(struct=
 sdhci_host *host)
> =A0 =A0 =A0 =A0return max;
> =A0}
>
> -static unsigned int sdhci_s3c_get_timeout_clk(struct sdhci_host *hos=
t)
> -{
> - =A0 =A0 =A0 return sdhci_s3c_get_max_clk(host) / 1000000;
> -}
> -
> =A0/**
> =A0* sdhci_s3c_consider_clock - consider one the bus clocks for curre=
nt setting
> =A0* @ourhost: Our SDHCI instance.
> @@ -188,7 +183,6 @@ static void sdhci_s3c_set_clock(struct sdhci_host=
 *host, unsigned int clock)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ourhost->cur_clk =3D best_src;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->max_clk =3D clk_get_rate(clk);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->timeout_clk =3D sdhci_s3c_get_tim=
eout_clk(host);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl =3D readl(host->ioaddr + S3C_SDHC=
I_CONTROL2);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl &=3D ~S3C_SDHCI_CTRL2_SELBASECLK_=
MASK;
> @@ -211,7 +205,6 @@ static void sdhci_s3c_set_clock(struct sdhci_host=
 *host, unsigned int clock)
>
> =A0static struct sdhci_ops sdhci_s3c_ops =3D {
> =A0 =A0 =A0 =A0.get_max_clock =A0 =A0 =A0 =A0 =A0=3D sdhci_s3c_get_ma=
x_clk,
> - =A0 =A0 =A0 .get_timeout_clock =A0 =A0 =A0=3D sdhci_s3c_get_timeout=
_clk,
> =A0 =A0 =A0 =A0.set_clock =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D sdhci_s3c_se=
t_clock,
> =A0};
>
> @@ -335,6 +328,9 @@ static int __devinit sdhci_s3c_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0host->quirks |=3D (SDHCI_QUIRK_32BIT_DMA_ADDR |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_32BIT_DMA=
_SIZE);
>
> + =A0 =A0 =A0 /* HSMMC on Samsung SoCs uses SDCLK as timeout clock. *=
/
> + =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK;

How do you know Samsung SoCs use SDCLK in the spec?

Is it also true at s3c64xx series?

Thank you,
Kyungmin Park

> +
> =A0 =A0 =A0 =A0ret =3D sdhci_add_host(host);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "sdhci_add_host() failed\=
n");
> --
> 1.6.2.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
