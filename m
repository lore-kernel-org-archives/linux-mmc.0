From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2] mmc: meson-gx: fix mmc dma operation
Date: Tue, 05 Nov 2019 09:54:36 +0100
Message-ID: <1j7e4e4sab.fsf@starbuckisacylon.baylibre.com>
References: <1572868495-84816-1-git-send-email-jianxin.pan@amlogic.com> <1ja79b4mje.fsf@starbuckisacylon.baylibre.com> <e80cb817-e58a-68ce-a3c6-d82636aaf7d3@amlogic.com> <1j8sou4u1g.fsf@starbuckisacylon.baylibre.com> <7ec2e682-cfec-395e-cf38-58f050440c40@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <7ec2e682-cfec-395e-cf38-58f050440c40@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nan Li <Nan.Li@amlogic.com>, Jianxin Pan <Jianxin.Pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Victor Wan <victor.wan@amlogic.com>
List-Id: linux-mmc@vger.kernel.org


On Tue 05 Nov 2019 at 09:30, Nan Li <Nan.Li@amlogic.com> wrote:


>
> Based on Uffe comment I tried something else.
>
> Basically, it enables chained mode in the driver only when the framework
> calls pre/post_req callback. As far as understood, the framework calls
> this when there is more than one request pending ... which seems to be
> when chained mode actually make sense
>
> Jerome, what you are talking about is the system framework problem when you call pre/post_req,
>
> which is not related to the patch I submitted.
>
>
>
> I strongly disagree.
> As far as I understand from your description, the problem was with the
> life cycle of the dma mapping. This is tighly related with pre/post req.
> Just the variable names you have picked clearly show that.
>
>
>
> As you said, pre/post_req is called only when there is data to implement the chained mode,
>
> but it is also possible to cause memory consistency problems,
> resulting in incorrect data.
>
>
>
> The life cycle of the mapping is also taken care of with patch,
> since dma mapping is no longer handled in .request(). IOW the mapping,
> if any, will be released after the request is done using .post_req()
>
> If you think otherwise, please elaborate.
>
>
> I see what you mean. You want to pull the pre/post_req operation out of the request interface and invoke it at the top.
>
> I didn't notice the following modification of patch in your last email and reply in time. I'm really sorry.
>
> The following patch removes all pre/post_req operations,

No it does not. Callbacks are still provided to the MMC framework.

> but you do not send out the operation patch added to the upper layer
> together.

There is no modification needed in the upper layer

>
> Then the patch is incomplete, which will affect the dma data transfer function in start_cmd function and affect the multi-block write operation.
>

No it is not incomplete. pre and post request are correctly called. You
can check that with ftrace if you want.

Maybe you could try it ?

> Please send your complete patch, including core layer modification,
> thank you.
>
>
>
>
>
> Therefore, this patch is added to make memory consistent and obtain real effective information.
>
>
>
> ----8<-----
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index e712315c7e8d..399604b4124d 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -126,8 +126,7 @@
>  #define SD_EMMC_CFG_CMD_GAP 16 /* in clock cycles */
>  #define SD_EMMC_DESC_BUF_LEN PAGE_SIZE
>
> -#define SD_EMMC_PRE_REQ_DONE BIT(0)
> -#define SD_EMMC_DESC_CHAIN_MODE BIT(1)
> +#define SD_EMMC_DESC_CHAIN_MODE BIT(0)
>
>  #define MUX_CLK_NUM_PARENTS 2
>
> @@ -228,7 +227,6 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>         struct mmc_data *data = mrq->data;
>         struct scatterlist *sg;
>         int i;
> -       bool use_desc_chain_mode = true;
>
>         /*
>          * When Controller DMA cannot directly access DDR memory, disable
> @@ -251,12 +249,11 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>                 /* check for 8 byte alignment */
>                 if (sg->offset & 7) {
>                         WARN_ONCE(1, "unaligned scatterlist buffer\n");
> -                       use_desc_chain_mode = false;
> -                       break;
> +                       return;
>                 }
>
> -       if (use_desc_chain_mode)
> -               data->host_cookie |= SD_EMMC_DESC_CHAIN_MODE;
> +       /* The planets are aligned, let's chain them up */
> +       data->host_cookie |= SD_EMMC_DESC_CHAIN_MODE;
>  }
>
>  static inline bool meson_mmc_desc_chain_mode(const struct mmc_data *data)
> @@ -278,7 +275,6 @@ static void meson_mmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
>                 return;
>
>         meson_mmc_get_transfer_mode(mmc, mrq);
> -       data->host_cookie |= SD_EMMC_PRE_REQ_DONE;
>
>         if (!meson_mmc_desc_chain_mode(data))
>                 return;
> @@ -803,25 +799,11 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>  static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>         struct meson_host *host = mmc_priv(mmc);
> -       bool needs_pre_post_req = mrq->data &&
> -                       !(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
> -
> -       if (needs_pre_post_req) {
> -               meson_mmc_get_transfer_mode(mmc, mrq);
> -               if (!meson_mmc_desc_chain_mode(mrq->data))
> -                       needs_pre_post_req = false;
> -       }
> -
> -       if (needs_pre_post_req)
> -               meson_mmc_pre_req(mmc, mrq);
>
>         /* Stop execution */
>         writel(0, host->regs + SD_EMMC_START);
>
>         meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
> -
> -       if (needs_pre_post_req)
> -               meson_mmc_post_req(mmc, mrq, 0);
>  }
>
>  static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
> ---->8-----
>
> No performance hit AFAICT.
> From your description, it should address your problem too.
>
>
>
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index e712315..7667e8a 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -173,6 +173,7 @@ struct meson_host {
>         int irq;
>
>         bool vqmmc_enabled;
> +       bool needs_pre_post_req;
>  };
>
>  #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
> @@ -654,6 +655,8 @@ static void meson_mmc_request_done(struct mmc_host *mmc,
>         struct meson_host *host = mmc_priv(mmc);
>
>         host->cmd = NULL;
> +       if (host->needs_pre_post_req)
> +               meson_mmc_post_req(mmc, mrq, 0);
>         mmc_request_done(host->mmc, mrq);
>  }
>
> @@ -803,25 +806,23 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>  static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>         struct meson_host *host = mmc_priv(mmc);
> -       bool needs_pre_post_req = mrq->data &&
> +
> +       host->needs_pre_post_req = mrq->data &&
>                         !(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
>
> -       if (needs_pre_post_req) {
> +       if (host->needs_pre_post_req) {
>                 meson_mmc_get_transfer_mode(mmc, mrq);
>                 if (!meson_mmc_desc_chain_mode(mrq->data))
> -                       needs_pre_post_req = false;
> +                       host->needs_pre_post_req = false;
>         }
>
> -       if (needs_pre_post_req)
> +       if (host->needs_pre_post_req)
>                 meson_mmc_pre_req(mmc, mrq);
>
>         /* Stop execution */
>         writel(0, host->regs + SD_EMMC_START);
>
>         meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
> -
> -       if (needs_pre_post_req)
> -               meson_mmc_post_req(mmc, mrq, 0);
>  }
>
>  static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
