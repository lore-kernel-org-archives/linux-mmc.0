From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] mmc: mediatek: Fixed bug where clock frequency could be
 set wrong
Date: Mon, 6 Mar 2017 15:06:37 +0800
Message-ID: <CAGS+omCf1JH0EcuKp_GFKUaeQc1TJw8LDBgmxsuTtyzg9vBqLA@mail.gmail.com>
References: <1488611403-30186-1-git-send-email-yong.mao@mediatek.com>
 <1488611403-30186-2-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488611403-30186-2-git-send-email-yong.mao@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yong Mao <yong.mao@mediatek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, srv_heupstream <srv_heupstream@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Eddie Huang <eddie.huang@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

Hi Yong,

On Sat, Mar 4, 2017 at 3:10 PM, Yong Mao <yong.mao@mediatek.com> wrote:
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

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

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
