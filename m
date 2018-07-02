From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix errors to use card read/write threshold
 for HS400 mode
Date: Mon, 2 Jul 2018 16:37:42 +0200
Message-ID: <CAPDyKFpi5tN__ue+j+QREp-KFEE_X6ib2MQY5oVm8q6m+sDwkA@mail.gmail.com>
References: <1530280769-14114-1-git-send-email-kehuanlin@pinecone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530280769-14114-1-git-send-email-kehuanlin@pinecone.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Huanlin.Ke" <chgokhl@gmail.com>
Cc: kehuanlin@pinecone.net, zhangbo_a <zhangbo_a@xiaomi.com>, Jaehoon Chung <jh80.chung@samsung.com>, "open list:SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER" <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Qing Xia <xiaqing17@hisilicon.com>
List-Id: linux-mmc@vger.kernel.org

On 29 June 2018 at 15:59, Huanlin.Ke <chgokhl@gmail.com> wrote:
> The card write threshold is applicable for HS400 mode only, so it should
> return back except HS400 timing mode.
>
> The card read threshold is also required for HS400 mode as the host
> controller incorrectly samples the data if the card clock stops within
> a block transfer.
>
> Signed-off-by: Huanlin.Ke <kehuanlin@pinecone.net>
> Signed-off-by: zhangbo_a <zhangbo_a@xiaomi.com>

Thanks for your patch!

I have just applied an earlier version of the patch, posted by Qing
Xia from Hisilicon.
https://patchwork.kernel.org/patch/10434913/

If it works for you as well, I can add your tested by tags for it.

Also, can you perhaps point me to a commit which introduced the problem?

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 623f4d2..d4e6983 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1065,7 +1065,7 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
>          * It's used when HS400 mode is enabled.
>          */
>         if (data->flags & MMC_DATA_WRITE &&
> -               !(host->timing != MMC_TIMING_MMC_HS400))
> +               (host->timing != MMC_TIMING_MMC_HS400))
>                 return;
>
>         if (data->flags & MMC_DATA_WRITE)
> @@ -1074,6 +1074,7 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
>                 enable = SDMMC_CARD_RD_THR_EN;
>
>         if (host->timing != MMC_TIMING_MMC_HS200 &&
> +           host->timing != MMC_TIMING_MMC_HS400 &&
>             host->timing != MMC_TIMING_UHS_SDR104)
>                 goto disable;
>
> --
> 2.7.4
>
