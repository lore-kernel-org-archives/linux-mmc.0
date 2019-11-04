From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2] mmc: meson-gx: fix mmc dma operation
Date: Mon, 04 Nov 2019 17:46:29 +0100
Message-ID: <1ja79b4mje.fsf@starbuckisacylon.baylibre.com>
References: <1572868495-84816-1-git-send-email-jianxin.pan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1572868495-84816-1-git-send-email-jianxin.pan@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Nan Li <nan.li@amlogic.com>, Neil Armstrong <narmstrong@baylibre.com>, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Victor Wan <victor.wan@amlogic.com>
List-Id: linux-mmc@vger.kernel.org


On Mon 04 Nov 2019 at 12:54, Jianxin Pan <jianxin.pan@amlogic.com> wrote:

> From: Nan Li <nan.li@amlogic.com>
>
> In MMC dma transfer, the region requested by dma_map_sg() may be released
> by dma_unmap_sg() before the transfer is completed.
>
> Put the unmap operation in front of mmc_request_done() to avoid this.

In the previous thread, you have described what was the issue you found.
It would be nice to have this information here

>
> Fixes: 79ed05e329c3 ("mmc: meson-gx: add support for descriptor chain mode")
> Signed-off-by: Nan Li <nan.li@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Based on Uffe comment I tried something else.

Basically, it enables chained mode in the driver only when the framework
calls pre/post_req callback. As far as understood, the framework calls
this when there is more than one request pending ... which seems to be
when chained mode actually make sense

----8<-----
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index e712315c7e8d..399604b4124d 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -126,8 +126,7 @@
 #define SD_EMMC_CFG_CMD_GAP 16 /* in clock cycles */
 #define SD_EMMC_DESC_BUF_LEN PAGE_SIZE
 
-#define SD_EMMC_PRE_REQ_DONE BIT(0)
-#define SD_EMMC_DESC_CHAIN_MODE BIT(1)
+#define SD_EMMC_DESC_CHAIN_MODE BIT(0)
 
 #define MUX_CLK_NUM_PARENTS 2
 
@@ -228,7 +227,6 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
 	struct mmc_data *data = mrq->data;
 	struct scatterlist *sg;
 	int i;
-	bool use_desc_chain_mode = true;
 
 	/*
 	 * When Controller DMA cannot directly access DDR memory, disable
@@ -251,12 +249,11 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
 		/* check for 8 byte alignment */
 		if (sg->offset & 7) {
 			WARN_ONCE(1, "unaligned scatterlist buffer\n");
-			use_desc_chain_mode = false;
-			break;
+			return;
 		}
 
-	if (use_desc_chain_mode)
-		data->host_cookie |= SD_EMMC_DESC_CHAIN_MODE;
+	/* The planets are aligned, let's chain them up */
+	data->host_cookie |= SD_EMMC_DESC_CHAIN_MODE;
 }
 
 static inline bool meson_mmc_desc_chain_mode(const struct mmc_data *data)
@@ -278,7 +275,6 @@ static void meson_mmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 
 	meson_mmc_get_transfer_mode(mmc, mrq);
-	data->host_cookie |= SD_EMMC_PRE_REQ_DONE;
 
 	if (!meson_mmc_desc_chain_mode(data))
 		return;
@@ -803,25 +799,11 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct meson_host *host = mmc_priv(mmc);
-	bool needs_pre_post_req = mrq->data &&
-			!(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
-
-	if (needs_pre_post_req) {
-		meson_mmc_get_transfer_mode(mmc, mrq);
-		if (!meson_mmc_desc_chain_mode(mrq->data))
-			needs_pre_post_req = false;
-	}
-
-	if (needs_pre_post_req)
-		meson_mmc_pre_req(mmc, mrq);
 
 	/* Stop execution */
 	writel(0, host->regs + SD_EMMC_START);
 
 	meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
-
-	if (needs_pre_post_req)
-		meson_mmc_post_req(mmc, mrq, 0);
 }
 
 static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
---->8-----

No performance hit AFAICT.
>From your description, it should address your problem too.

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
