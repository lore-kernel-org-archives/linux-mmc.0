From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 2/4] mmc: sdio: Add capability to skip SDIO reset at scan
Date: Mon, 24 Apr 2017 22:33:13 +0200
Message-ID: <CAPDyKFq7qWGgyXStJU3XZnGRcqMXZs_z21nJ2vUnCe0Pn-q19Q@mail.gmail.com>
References: <1492769288-7474-1-git-send-email-adrian.hunter@intel.com> <1492769288-7474-3-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1492769288-7474-3-git-send-email-adrian.hunter@intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-mmc@vger.kernel.org

On 21 April 2017 at 12:08, Adrian Hunter <adrian.hunter@intel.com> wrote:
> The SDIO card state might be being preserved during hibernation, for
> example a SDIO wifi card supporting WOWLAN. That state will be lost if an
> SDIO reset is done. One way to avoid that would be to build mmc core as a
> module and simply not load it until after attempting to restore the
> hibernation image. However that won't work if the hibernation image is
> stored on eMMC which, of course, requires mmc core.

I don't follow here. Are you saying the SDIO card is kept powered in
hibernation, as to be able to support WOWLAN, right?

Then, it feels plain wrong the mmc_rescan() tries to re-initialize it.
That should never happen, unless something is broken of course.

Kind regards
Uffe

>
> It is assumed on such systems that the platform will power cycle the SDIO
> card or not as necessary so that the SDIO reset is not needed. Add a
> capability flag to reflect that and use it to skip the SDIO reset at scan
> time.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/core.c  | 6 +++++-
>  include/linux/mmc/host.h | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 6987976252ad..178e23bf0c30 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2639,8 +2639,12 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
>          * if the card is being re-initialized, just send it.  CMD52
>          * should be ignored by SD/eMMC cards.
>          * Skip it if we already know that we do not support SDIO commands
> +        * Also skip it if we know this host controller has a SDIO card that
> +        * needs to be able to restore from hibernation without losing the card
> +        * state e.g. an SDIO wifi card supporting WOWLAN.
>          */
> -       if (!(host->caps2 & MMC_CAP2_NO_SDIO))
> +       if (!(host->caps2 & MMC_CAP2_NO_SDIO) &&
> +           !(host->caps2 & MMC_CAP2_NO_SDIO_RESET))
>                 sdio_reset(host);
>
>         mmc_go_idle(host);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 78c544e296cd..187a7ba41364 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -281,6 +281,7 @@ struct mmc_host {
>         u32                     caps2;          /* More host capabilities */
>
>  #define MMC_CAP2_BOOTPART_NOACC        (1 << 0)        /* Boot partition no access */
> +#define MMC_CAP2_NO_SDIO_RESET (1 << 1)        /* Do not SDIO reset at scan */
>  #define MMC_CAP2_FULL_PWR_CYCLE        (1 << 2)        /* Can do full power cycle */
>  #define MMC_CAP2_HS200_1_8V_SDR        (1 << 5)        /* can support */
>  #define MMC_CAP2_HS200_1_2V_SDR        (1 << 6)        /* can support */
> --
> 1.9.1
>
