From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/3] mmc: dw_mmc: cancel the CTO timer after a voltage
 switch
Date: Mon, 9 Oct 2017 14:57:17 +0800
Message-ID: <b7dd1ad3-cae6-e2b5-2bcf-ceacaf022417@rock-chips.com>
References: <20170927205631.31559-1-dianders@chromium.org>
 <20170927205631.31559-2-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170927205631.31559-2-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: jh80.chung@samsung.com, ulf.hansson@linaro.org, shawn.lin@rock-chips.com, briannorris@chromium.org, amstan@chromium.org, xzy.xu@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


On 2017/9/28 4:56, Douglas Anderson wrote:
> When running with the commit 03de19212ea3 ("mmc: dw_mmc: introduce
> timer for broken command transfer over scheme") I found this message
> in the log:
>    Unexpected command timeout, state 7
> 
> It turns out that we weren't properly cancelling the new CTO timer in
> the case that a voltage switch was done.  Let's promote the cancel
> into the dw_mci_cmd_interrupt() function to fix this.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Fixes: 03de19212ea3 ("mmc: dw_mmc: introduce timer for broken command transfer over scheme")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   drivers/mmc/host/dw_mmc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 860313bd952a..f5b2bb4b4d98 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2570,6 +2570,8 @@ static void dw_mci_write_data_pio(struct dw_mci *host)
>   
>   static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
>   {
> +	del_timer(&host->cto_timer);
> +
>   	if (!host->cmd_status)
>   		host->cmd_status = status;
>   
> @@ -2662,7 +2664,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>   		}
>   
>   		if (pending & SDMMC_INT_CMD_DONE) {
> -			del_timer(&host->cto_timer);
>   			mci_writel(host, RINTSTS, SDMMC_INT_CMD_DONE);
>   			dw_mci_cmd_interrupt(host, pending);
>   		}
> 
