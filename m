From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 1/2 v4] sdhci: add quirk for max len ADMA descriptors
Date: Mon, 3 Jan 2011 15:25:20 +0900
Message-ID: <AANLkTinS=7U6fXrHm8+uz+Etg8Vh6nxRPj4uPZm2jFsU@mail.gmail.com>
References: <1293928339-19373-1-git-send-email-olof@lixom.net>
	<1293928653-20001-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50660 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab1ACGZW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jan 2011 01:25:22 -0500
In-Reply-To: <1293928653-20001-1-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>

It's also valid as SDHCI at Samsung SoCs.

Acked-by: Kyungmin Park <kyungmin.park@samsung.com>



On Sun, Jan 2, 2011 at 9:37 AM, Olof Johansson <olof@lixom.net> wrote:
> Some controllers misparse segment length 0 as being 0, not 65536. Add
> a quirk to deal with it.
>
> Change-Id: I1422c9c605095addc133e844c66fc49f187dc17d
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> =A0drivers/mmc/host/sdhci.c =A0| =A0 10 +++++++---
> =A0include/linux/mmc/sdhci.h | =A0 =A02 ++
> =A02 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a25db426..c0094c1 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1928,10 +1928,14 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 * of bytes. When doing hardware scatter/gather, each =
entry cannot
> =A0 =A0 =A0 =A0 * be larger than 64 KiB though.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (host->flags & SDHCI_USE_ADMA)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_seg_size =3D 65536;
> - =A0 =A0 =A0 else
> + =A0 =A0 =A0 if (host->flags & SDHCI_USE_ADMA) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_BROKEN_A=
DMA_ZEROLEN_DESC)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_seg_size =3D 6=
5535;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_seg_size =3D 6=
5536;
> + =A0 =A0 =A0 } else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_seg_size =3D mmc->max_req_siz=
e;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Maximum block size. This varies from controller to =
controller and
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 1fdc673..dfb2106 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -83,6 +83,8 @@ struct sdhci_host {
> =A0#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 =A0 =A0 =A0 =A0 =A0 =A0=
 (1<<28)
> =A0/* Controller doesn't have HISPD bit field in HI-SPEED SD card */
> =A0#define SDHCI_QUIRK_NO_HISPD_BIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (1<<29)
> +/* Controller treats ADMA descriptors with length 0000h incorrectly =
*/
> +#define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC =A0 =A0 =A0 =A0 =A0 (1<=
<30)
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
