From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: skip mmc_power_up call from start host
Date: Mon, 20 Aug 2012 15:39:19 +0200
Message-ID: <CAPDyKFrteFBMn0WoD=u3aX5zRG=1yqCbWpUX5ijh7gOKQ-sL=g@mail.gmail.com>
References: <1342184235-6912-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1342184235-6912-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Girish,

On 13 July 2012 14:57, Girish K S <girish.shivananjappa@linaro.org> wrote:
> The call to the mmc_power_up during the mmc_start_host breaks the card
> detection in design-ware host controller. This patch removes the call to
> mmc_power_up function during host start.
>
> This fix works fine with sdhci (sdhci compatilble host controller)
> and dw_mmc (design-ware host controller). and has no side effect due to
> this removal.
>
> Tested on : origen-board and smdk-5250 board.
>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/core.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 9503cab..503aefc 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2108,7 +2108,6 @@ void mmc_start_host(struct mmc_host *host)
>  {
>         host->f_init = max(freqs[0], host->f_min);
>         host->rescan_disable = 0;
> -       mmc_power_up(host);

This will introduce a bug (race condition) for host drivers using the
regulator API (from regulator_init_complete) and for eMMC. So please
do not remove this.

>         mmc_detect_change(host, 0);
>  }
>
> --
> 1.7.4.1
>


I suggest you find out more details about why this breaks the card
detection mechanism for your stated boards.

Kind regards
Ulf Hansson
