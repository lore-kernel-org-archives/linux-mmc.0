From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] mmc: fix mmc dma operation
Date: Mon, 21 Oct 2019 09:57:55 +0200
Message-ID: <fc1f61e1-b156-11e6-3f21-c498d2f0a8c6@baylibre.com>
References: <1571637541-119016-1-git-send-email-jianxin.pan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1571637541-119016-1-git-send-email-jianxin.pan@amlogic.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Nan Li <nan.li@amlogic.com>, Jerome Brunet <jbrunet@baylibre.com>, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Victor Wan <victor.wan@amlogic.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

Thanks for the fix.

First, you should add "mmc: meson-gx:" in the subject.

On 21/10/2019 07:59, Jianxin Pan wrote:
> From: Nan Li <nan.li@amlogic.com>
> 
> In MMC dma transfer, the region requested by dma_map_sg() may be released
> by dma_unmap_sg() before the transfer is completed.
> 
> Put the unmap operation in front of mmc_request_done() to avoid this.


You should add a "Fixes:" tag so it can be backported on stable kernels.

> 
> Signed-off-by: Nan Li <nan.li@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index e712315..7667e8a 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -173,6 +173,7 @@ struct meson_host {
>  	int irq;
>  
>  	bool vqmmc_enabled;
> +	bool needs_pre_post_req;
>  };
>  
>  #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
> @@ -654,6 +655,8 @@ static void meson_mmc_request_done(struct mmc_host *mmc,
>  	struct meson_host *host = mmc_priv(mmc);
>  
>  	host->cmd = NULL;
> +	if (host->needs_pre_post_req)
> +		meson_mmc_post_req(mmc, mrq, 0);
>  	mmc_request_done(host->mmc, mrq);
>  }
>  
> @@ -803,25 +806,23 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>  static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>  	struct meson_host *host = mmc_priv(mmc);
> -	bool needs_pre_post_req = mrq->data &&
> +
> +	host->needs_pre_post_req = mrq->data &&
>  			!(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
>  
> -	if (needs_pre_post_req) {
> +	if (host->needs_pre_post_req) {
>  		meson_mmc_get_transfer_mode(mmc, mrq);
>  		if (!meson_mmc_desc_chain_mode(mrq->data))
> -			needs_pre_post_req = false;
> +			host->needs_pre_post_req = false;
>  	}
>  
> -	if (needs_pre_post_req)
> +	if (host->needs_pre_post_req)
>  		meson_mmc_pre_req(mmc, mrq);
>  
>  	/* Stop execution */
>  	writel(0, host->regs + SD_EMMC_START);
>  
>  	meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
> -
> -	if (needs_pre_post_req)
> -		meson_mmc_post_req(mmc, mrq, 0);
>  }
>  
>  static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
>
Neil
