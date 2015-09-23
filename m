From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mediatek: Add MMC_CAP_RUNTIME_RESUME support
Date: Wed, 23 Sep 2015 23:42:42 +0200
Message-ID: <CAPDyKFo6heebOuQeodYNFcurr21SdQ-_m-9FvnpobZsZ8-mLAQ@mail.gmail.com>
References: <1442901644-7587-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442901644-7587-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Kurtz <djkurtz@chromium.org>, srv_heupstream <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On 22 September 2015 at 08:00, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> Add MMC_CAP_RUNTIME_RESUME support to save resume time
> Drop unnecessary SDC_ARG write
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mtk-sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 7153500..b2e89d3 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -729,7 +729,6 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
>                         MSDC_INTEN_RSPCRCERR | MSDC_INTEN_CMDTMO |
>                         MSDC_INTEN_ACMDRDY | MSDC_INTEN_ACMDCRCERR |
>                         MSDC_INTEN_ACMDTMO);
> -       writel(cmd->arg, host->base + SDC_ARG);
>
>         if (cmd->flags & MMC_RSP_PRESENT) {
>                 if (cmd->flags & MMC_RSP_136) {
> @@ -1302,6 +1301,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         mmc->f_min = host->src_clk_freq / (4 * 255);
>
>         mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
> +       mmc->caps |= MMC_CAP_RUNTIME_RESUME;
>         /* MMC core transfer sizes tunable parameters */
>         mmc->max_segs = MAX_BD_NUM;
>         mmc->max_seg_size = BDMA_DESC_BUFLEN;
> --
> 1.8.1.1.dirty
>
