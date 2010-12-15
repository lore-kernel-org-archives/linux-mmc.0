From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 2/4] sdhci: add quirk for broken sdio irq
Date: Wed, 15 Dec 2010 05:42:14 -0500
Message-ID: <AANLkTint+ObCy3Mak4E1Cj+2TS_4vbpZm57tXK_-CJ+K@mail.gmail.com>
References: <1292388576-25600-1-git-send-email-olof@lixom.net>
	<1292388576-25600-3-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:43281 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538Ab0LOKnB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Dec 2010 05:43:01 -0500
In-Reply-To: <1292388576-25600-3-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

On Tue, Dec 14, 2010 at 11:49 PM, Olof Johansson <olof@lixom.net> wrote=
:
> Some controllers can't handle SDIO IRQ properly. Give a way to
> disable it.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> =A0drivers/mmc/host/sdhci.c =A0| =A0 =A06 +++++-
> =A0include/linux/mmc/sdhci.h | =A0 =A02 ++
> =A02 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c0094c1..98f3d3d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1871,7 +1871,10 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->f_min =3D host->max_clk / SDHCI_M=
AX_DIV_SPEC_200;
>
> =A0 =A0 =A0 =A0mmc->f_max =3D host->max_clk;
> - =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SDIO_IRQ;
> + =A0 =A0 =A0 mmc->caps =3D 0;
> +
> + =A0 =A0 =A0 if (!(host->quirks & SDHCI_QUIRK_NO_SDIO_IRQ))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SDIO_IRQ;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * A controller may support 8-bit width, but the board=
 itself
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index dfb2106..97d547e 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -85,6 +85,8 @@ struct sdhci_host {
> =A0#define SDHCI_QUIRK_NO_HISPD_BIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (1<<29)
> =A0/* Controller treats ADMA descriptors with length 0000h incorrectl=
y */
> =A0#define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC =A0 =A0 =A0 =A0 =A0 (=
1<<30)
> +/* Controller should not use SDIO IRQ */
> +#define SDHCI_QUIRK_NO_SDIO_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<31)

Just wander can we use another way instead of using the last two
quirk, otherwise, no quirk can be used any more.
If this is only tegra specific issue, any possibility to modify vector
after add_host in sdhci-tegra.c.
for example
sdhci_add_host(host);
host->mmc->max_seg_size =3D 65535;
host->mmc->caps |=3D MMC_CAP_SDIO_IRQ;

Really appreciate if not using the valuable quirk resource, which is u3=
2.

>
> =A0 =A0 =A0 =A0int irq; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Device IRQ =
*/
> =A0 =A0 =A0 =A0void __iomem *ioaddr; =A0 /* Mapped address */
> --
> 1.7.3.GIT
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
