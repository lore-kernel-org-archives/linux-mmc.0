From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] mmc: sdhi: Enable the driver on all ARM platforms
Date: Thu, 31 Oct 2013 17:26:30 +0900
Message-ID: <CANqRtoR3Aj-j00=riDuDdWW2+AZD4jrjL2xHLt88ri2kdUB=Eg@mail.gmail.com>
References: <1383086274-11049-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1383132190-5285-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1383132190-5285-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Oct 30, 2013 at 8:23 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Renesas ARM platforms are transitioning from single-platform to
> multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> and ARCH_SHMOBILE_MULTI and increase build testing coverage.
>
> Don't enable COMPILE_TEST support as the driver doesn't compile on x86
> due (possibly among others) to missing readsw/writesw I/O accessors.
>
> Whether the CTL_DMA_ENABLE register is part of the standard TMIO
> controller or is Renesas-specific is unknown and impossible to test as
> we have no current or planned TMIO DMA users other than SUPERH and
> ARCH_SHMOBILE. Writing to the register is thus conditionally compiled
> for SUPERH and ARCH_SHMOBILE only. Adding ARCH_SHMOBILE_MULTI to the
> list would extend this to multiarch kernels, but would break the driver
> for non-shmobile platforms if the register is Renesas-specific. We can
> thus get rid of the conditional compilation completely without
> introducing any further issue, and let future non-Renesas users deal
> with the situation if it turns out to be a the problem.
>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Ian Molton <ian@mnementh.co.uk>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/mmc/host/Kconfig        | 2 +-
>  drivers/mmc/host/tmio_mmc_dma.c | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 7fc5099..51957d4 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -479,7 +479,7 @@ config MMC_TMIO
>
>  config MMC_SDHI
>         tristate "SH-Mobile SDHI SD/SDIO controller support"
> -       depends on SUPERH || ARCH_SHMOBILE
> +       depends on SUPERH || ARM
>         select MMC_TMIO_CORE
>         help
>           This provides support for the SDHI SD/SDIO controller found in
> diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
> index 65edb4a..8a4fd2d 100644
> --- a/drivers/mmc/host/tmio_mmc_dma.c
> +++ b/drivers/mmc/host/tmio_mmc_dma.c
> @@ -28,10 +28,8 @@ void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
>         if (!host->chan_tx || !host->chan_rx)
>                 return;
>
> -#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
> -       /* Switch DMA mode on or off - SuperH specific? */
> +       /* Switch DMA mode on or off. This might be Renesas-specific. */
>         sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? 2 : 0);
> -#endif

Hi Laurent,

Thanks for your efforts. Hate to slow things down, but this last hunk
looks wrong to me. I believe the reason for the #ifdef is that
non-Renesas IP may be using the tmio_mmc driver, at least they used
to. Not sure if anyone is using DMA Engine though. If I were you I
would play it safe and simply update the #ifdef with same kind of
dependencies that the Kconfig bits have.

Also, it would of course be nice to clean up the driver, perhaps with
a feature flag for this special register or why not simply move the
code to the sdhi file. But that's not really related to your
multiplatform kconfig change, is it? =)

/ magnus
