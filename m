From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v1] mmc: mediatek: Fixed bug where clock frequency could
 be set wrong
Date: Fri, 24 Feb 2017 17:52:06 +0900
Message-ID: <CAGS+omDuPwXqTJ2CrLbLvSHdp3CL895qop1x6dLT1u7bG7XnVw@mail.gmail.com>
References: <1487924527-22584-1-git-send-email-yong.mao@mediatek.com> <1487924527-22584-2-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487924527-22584-2-git-send-email-yong.mao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Mao <yong.mao@mediatek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, srv_heupstream <srv_heupstream@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Feb 24, 2017 at 5:22 PM, Yong Mao <yong.mao@mediatek.com> wrote:
>
> From: yong mao <yong.mao@mediatek.com>
>
> This patch can fix two issues:
>
> Issue 1:
> The maximum value of clock divider is 0xff.
> Because the type of div is u32, div may be larger than max_div.
> In this case, we should use max_div to set the clock frequency.
>
> Issue 2:
> In previous code, we can not set the correct clock frequency when
> div equals 0xff.
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 07f3236..3174445 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -540,6 +540,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>         u32 mode;
>         u32 flags;
>         u32 div;
> +       u32 max_div;

There's really no need for this variable.  Just use 0xff below.

>         u32 sclk;
>
>         if (!hz) {
> @@ -590,8 +591,18 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>                         sclk = (host->src_clk_freq >> 2) / div;
>                 }
>         }
> +
> +       /**
> +        * The maximum value of div is 0xff.
> +        * Check if the div is larger than max_div.
> +        */
> +       max_div = 0xff;
> +       if (div > max_div) {
> +               div = max_div;
> +               sclk = (host->src_clk_freq >> 2) / div;
> +       }
>         sdr_set_field(host->base + MSDC_CFG, MSDC_CFG_CKMOD | MSDC_CFG_CKDIV,
> -                       (mode << 8) | (div % 0xff));
> +                     (mode << 8) | div);

Hmm, I don't know much about this sub-system, but should we even be
allowing requests to set a frequency that we can't actually achieve
with the divider?

>         sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
>         while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
>                 cpu_relax();
> --
> 1.7.9.5
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
