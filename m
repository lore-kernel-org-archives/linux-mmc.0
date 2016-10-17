From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci: cast unsigned int to unsigned long long to
 avoid unexpeted error
Date: Mon, 17 Oct 2016 15:49:17 +0200
Message-ID: <CAPDyKFr3KrwDKUmuiHyzt7Jyve4is=e-tbGn+NufTcZdvibjXQ@mail.gmail.com>
References: <1476692317-26845-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1476692317-26845-1-git-send-email-haibo.chen@nxp.com>
Sender: stable-owner@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, "# 4.0+" <stable@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 17 October 2016 at 10:18, Haibo Chen <haibo.chen@nxp.com> wrote:
> Potentially overflowing expression 1000000 * data->timeout_clks with
> type unsigned int is evaluated using 32-bit arithmetic, and then used
> in a context that expects an expression of type unsigned long long.
>
> To avoid overflow, cast 1000000U to type unsigned long long.
> Special thanks to Coverity.
>
> Fixes: 7f05538af71c ("mmc: sdhci: fix data timeout (part 2)")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Cc: stable@vger.kernel.org # v3.15+

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 223a91e..71654b9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -687,7 +687,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>                          * host->clock is in Hz.  target_timeout is in us.
>                          * Hence, us = 1000000 * cycles / Hz.  Round up.
>                          */
> -                       val = 1000000 * data->timeout_clks;
> +                       val = 1000000ULL * data->timeout_clks;
>                         if (do_div(val, host->clock))
>                                 target_timeout++;
>                         target_timeout += val;
> --
> 1.9.1
>
