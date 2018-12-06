From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: fix the timeout check window for clock and reset
Date: Thu, 6 Dec 2018 11:26:54 +0100
Message-ID: <CAPDyKFrRm-hxJDE41aU7Rs3RSmz-K5Gvr5hJu5Ph9WmZ35vTSg@mail.gmail.com>
References: <20181206092459.26202-1-alek.du@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181206092459.26202-1-alek.du@intel.com>
Sender: stable-owner@vger.kernel.org
To: alek.du@intel.com
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 6 Dec 2018 at 10:25, <alek.du@intel.com> wrote:
>
> From: Alek Du <alek.du@intel.com>
>
> We observed some premature timeouts on a virtualization platform, the log
> is like this:
>
> case 1:
> [159525.255629] mmc1: Internal clock never stabilised.
> [159525.255818] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> [159525.256049] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
> ...
> [159525.257205] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa03
> From the clock control register dump, we are pretty sure the clock was
> stablized.
>
> case 2:
> [  914.550127] mmc1: Reset 0x2 never completed.
> [  914.550321] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> [  914.550608] mmc1: sdhci: Sys addr:  0x00000010 | Version:  0x00001002
>
> After checking the sdhci code, we found the timeout check actually has a
> little window that the CPU can be scheduled out and when it comes back,
> the original time set or check is not valid.
>
> Fixes: 5a436cc0af62 ("mmc: sdhci: Optimize delay loops")
> Cc: stable@vger.kernel.org      # v4.12+
> Signed-off-by: Alek Du <alek.du@intel.com>

Yes, now it works better!

Applied for fixes and by adding Adrian's ack, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 99bdae53fa2e..451b08a818a9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -216,8 +216,12 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
>         timeout = ktime_add_ms(ktime_get(), 100);
>
>         /* hw clears the bit when it's done */
> -       while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
> -               if (ktime_after(ktime_get(), timeout)) {
> +       while (1) {
> +               bool timedout = ktime_after(ktime_get(), timeout);
> +
> +               if (!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask))
> +                       break;
> +               if (timedout) {
>                         pr_err("%s: Reset 0x%x never completed.\n",
>                                 mmc_hostname(host->mmc), (int)mask);
>                         sdhci_dumpregs(host);
> @@ -1608,9 +1612,13 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>
>         /* Wait max 20 ms */
>         timeout = ktime_add_ms(ktime_get(), 20);
> -       while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> -               & SDHCI_CLOCK_INT_STABLE)) {
> -               if (ktime_after(ktime_get(), timeout)) {
> +       while (1) {
> +               bool timedout = ktime_after(ktime_get(), timeout);
> +
> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +               if (clk & SDHCI_CLOCK_INT_STABLE)
> +                       break;
> +               if (timedout) {
>                         pr_err("%s: Internal clock never stabilised.\n",
>                                mmc_hostname(host->mmc));
>                         sdhci_dumpregs(host);
> --
> 2.17.1
>
