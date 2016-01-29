From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 01/15] mmc: sunxi: Document host init sequence
Date: Fri, 29 Jan 2016 12:39:58 +0100
Message-ID: <CAPDyKFq-WX2CqEb+F+BxU0BgU+vLQD-x6ykCtoGc0sE3q60Jmw@mail.gmail.com>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
	<1453354002-28366-2-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35259 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570AbcA2Lj7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 06:39:59 -0500
Received: by mail-yk0-f169.google.com with SMTP id r207so21770593ykd.2
        for <linux-mmc@vger.kernel.org>; Fri, 29 Jan 2016 03:39:59 -0800 (PST)
In-Reply-To: <1453354002-28366-2-git-send-email-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Hans de Goede <hdegoede@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-sunxi@googlegroups.com

On 21 January 2016 at 06:26, Chen-Yu Tsai <wens@csie.org> wrote:
> sunxi_mmc_init_host() originated from Allwinner kernel sources. The
> magic numbers written to various registers was never documented.
>
> Add comments for values found in Allwinner user manuals.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 83de82bceafc..cce5ca540857 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -284,16 +284,28 @@ static int sunxi_mmc_init_host(struct mmc_host *mmc)
>         if (sunxi_mmc_reset_host(host))
>                 return -EIO;
>
> +       /*
> +        * Burst 8 transfers, RX trigger level: 7, TX trigger level: 8
> +        *
> +        * TODO: sun9i has a larger FIFO and supports higher trigger values
> +        */
>         mmc_writel(host, REG_FTRGL, 0x20070008);
> +       /* Maximum timeout value */
>         mmc_writel(host, REG_TMOUT, 0xffffffff);
> +       /* Unmask SDIO interrupt if needed */
>         mmc_writel(host, REG_IMASK, host->sdio_imask);
> +       /* Clear all pending interrupts */
>         mmc_writel(host, REG_RINTR, 0xffffffff);
> +       /* Debug register? undocumented */
>         mmc_writel(host, REG_DBGC, 0xdeb);
> +       /* Enable CEATA support */
>         mmc_writel(host, REG_FUNS, SDXC_CEATA_ON);
> +       /* Set DMA descriptor list base address */
>         mmc_writel(host, REG_DLBA, host->sg_dma);
>
>         rval = mmc_readl(host, REG_GCTRL);
>         rval |= SDXC_INTERRUPT_ENABLE_BIT;
> +       /* Undocumented, but found in Allwinner code */
>         rval &= ~SDXC_ACCESS_DONE_DIRECT;
>         mmc_writel(host, REG_GCTRL, rval);
>
> --
> 2.7.0.rc3
>
