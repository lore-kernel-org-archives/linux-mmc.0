From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mediatek: Fixed bug where clock frequency could be
 set wrong
Date: Thu, 16 Mar 2017 15:45:53 +0100
Message-ID: <CAPDyKFqzj-UT12rorqZ9536608=Zs37s1LhQb=4GpqV95QoNNw@mail.gmail.com>
References: <1488611403-30186-1-git-send-email-yong.mao@mediatek.com> <1488611403-30186-2-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:36722 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753408AbdCPOpz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Mar 2017 10:45:55 -0400
Received: by mail-ua0-f171.google.com with SMTP id 72so27519915uaf.3
        for <linux-mmc@vger.kernel.org>; Thu, 16 Mar 2017 07:45:54 -0700 (PDT)
In-Reply-To: <1488611403-30186-2-git-send-email-yong.mao@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yong Mao <yong.mao@mediatek.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Kurtz <djkurtz@chromium.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 4 March 2017 at 08:10, Yong Mao <yong.mao@mediatek.com> wrote:
> From: yong mao <yong.mao@mediatek.com>
>
> This patch can fix two issues:
>
> Issue 1:
> In previous code, div may be overflow when setting clock frequency
> as f_min. We can use DIV_ROUND_UP to fix this boundary related
> issue.
>
> Issue 2:
> In previous code, we can not set the correct clock frequency when
> div equals 0xff.
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 07f3236..3ad5228 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -591,7 +591,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>                 }
>         }
>         sdr_set_field(host->base + MSDC_CFG, MSDC_CFG_CKMOD | MSDC_CFG_CKDIV,
> -                       (mode << 8) | (div % 0xff));
> +                     (mode << 8) | div);
>         sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
>         while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
>                 cpu_relax();
> @@ -1692,7 +1692,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         host->src_clk_freq = clk_get_rate(host->src_clk);
>         /* Set host parameters to mmc */
>         mmc->ops = &mt_msdc_ops;
> -       mmc->f_min = host->src_clk_freq / (4 * 255);
> +       mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 255);
>
>         mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
>         /* MMC core transfer sizes tunable parameters */
> --
> 1.7.9.5
>

Thanks, applied for fixes!

Kind regards
Uffe
