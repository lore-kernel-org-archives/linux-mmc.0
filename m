From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: mediatek: enable SDIO IRQ low level trigger function
Date: Thu, 29 Aug 2019 15:36:28 +0200
Message-ID: <CAPDyKFqgO7fwybn1nYcf14jiHswM+T7fqY1BuSvx5AubYA6F=A@mail.gmail.com>
References: <1566985524-22749-1-git-send-email-yong.mao@mediatek.com> <1566985524-22749-2-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1566985524-22749-2-git-send-email-yong.mao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Mao <yong.mao@mediatek.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 28 Aug 2019 at 11:45, Yong Mao <yong.mao@mediatek.com> wrote:
>
> From: yong mao <yong.mao@mediatek.com>
>
> SDIO IRQ is not defaultly triggered by low level,
> but by falling edge. It needs to set related register
> to enable SDIO IRQ low level trigger function.
> Otherwise the SDIO IRQ may be lost in some specail condition.
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mtk-sd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 33f4b63..585f0c7 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -192,6 +192,7 @@
>  #define SDC_STS_CMDBUSY         (0x1 << 1)     /* RW */
>  #define SDC_STS_SWR_COMPL       (0x1 << 31)    /* RW */
>
> +#define SDC_DAT1_IRQ_TRIGGER   (0x1 << 19)     /* RW */
>  /* SDC_ADV_CFG0 mask */
>  #define SDC_RX_ENHANCE_EN      (0x1 << 20)     /* RW */
>
> @@ -1568,6 +1569,7 @@ static void msdc_init_hw(struct msdc_host *host)
>
>         /* Config SDIO device detect interrupt function */
>         sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +       sdr_set_bits(host->base + SDC_ADV_CFG0, SDC_DAT1_IRQ_TRIGGER);
>
>         /* Configure to default data timeout */
>         sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
> --
> 1.9.1
>
