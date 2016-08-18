From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: need retune if error value is -EIO
Date: Thu, 18 Aug 2016 10:19:22 +0300
Message-ID: <a9e28ac9-9db6-18d0-d4a6-9a283ec4dc80@intel.com>
References: <1470299459-8478-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470299459-8478-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 04/08/16 11:30, Shawn Lin wrote:
> We need to do retune if receiving -EIO, otherwise we
> could see debug dump like:
> 
> [ 89.057226] bcmsdh_sdmmc: Failed to Read byte F1:@0x1001f=ff, Err: -5
> [ 89.058811] bcmsdh_sdmmc: Failed to Read byte F1:@0x1001f=ff, Err: -5
> [ 89.059415] bcmsdh_sdmmc: Failed to Read byte F1:@0x1000e=ff, Err: -84
> [ 89.254248] dwmmc_rockchip fe310000.dwmmc: Successfully tuned phase to 199
> [ 89.273912] dhd_set_suspend: Remove extra suspend setting
> [ 89.274478] dhd_enable_packet_filter: enter, value = 0
> 64 bytes from 112.90.83.112: icmp_seq=24 ttl=53 time=1321 ms
> 64 bytes from 112.90.83.112: icmp_seq=25 ttl=53 time=319 ms
> 64 bytes from 112.90.83.112: icmp_seq=26 ttl=53 time=69.8 ms
> 64 bytes from 112.90.83.112: icmp_seq=27 ttl=53 time=37.5 ms
> ...
> 
> In this case we see dw_mmc finally enter retune process, but
> if this patch is applied, we could save more time to make it
> work. Also many host drivers will generate -EIO, so this patch
> can also prevent them from failing to enter retune process.

The current logic is re-tune on CRC errors.  -EIO isn't informative
and drivers can use it for cases that clearly are not related to tuning.

A driver can call mmc_retune_needed() itself in other cases.

> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/mmc/core/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index e55cde6..18d0af5 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -133,7 +133,8 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>  	/* Flag re-tuning needed on CRC errors */
>  	if ((cmd->opcode != MMC_SEND_TUNING_BLOCK &&
>  	    cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
> -	    (err == -EILSEQ || (mrq->sbc && mrq->sbc->error == -EILSEQ) ||
> +	    (err == -EILSEQ || err == -EIO ||
> +	    (mrq->sbc && mrq->sbc->error == -EILSEQ) ||
>  	    (mrq->data && mrq->data->error == -EILSEQ) ||
>  	    (mrq->stop && mrq->stop->error == -EILSEQ)))
>  		mmc_retune_needed(host);
> 
