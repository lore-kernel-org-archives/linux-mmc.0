From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] mmc: mediatek: Fix CMD6 timeout issue
Date: Thu, 1 Dec 2016 10:51:36 +0100
Message-ID: <CAPDyKFosQkxaFAKo0dm0TajgXqKG7XqRM1tTqR2vTsHzVrocfQ@mail.gmail.com>
References: <1478585341-6749-1-git-send-email-yong.mao@mediatek.com>
 <1478585341-6749-2-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1478585341-6749-2-git-send-email-yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chunfeng Yun <chunfeng.yun-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Chaotian Jing <chaot>
List-Id: linux-mmc@vger.kernel.org

On 8 November 2016 at 07:08, Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> From: yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>
> When initializing EMMC, after switch to HS400,
> it will issue CMD6 to change ext_csd, if first CMD6 got CRC
> error, the repeat CMD6 may get timeout, that's
> because SDCBSY was cleared by msdc_reset_hw()

Sorry for the delay!

We have recently been re-working the sequence for how to deal more
properly with CMD6 in the mmc core.

The changes done so far should mostly concern switches to HS and HS
DDR, but I think you should run a re-test to make sure you still hit
the same problems.

>
> Signed-off-by: Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/mmc/host/mtk-sd.c |   77 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 51 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 84e9afc..b29683b 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -826,6 +826,15 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
>         return true;
>  }
>
> +static int msdc_card_busy(struct mmc_host *mmc)
> +{
> +       struct msdc_host *host = mmc_priv(mmc);
> +       u32 status = readl(host->base + MSDC_PS);
> +
> +       /* check if data0 is low */
> +       return !(status & BIT(16));
> +}
> +
>  /* It is the core layer's responsibility to ensure card status
>   * is correct before issue a request. but host design do below
>   * checks recommended.

Hmm. Why?

I think you should rely on the mmc core to invoke the ->card_busy()
ops instead. The core knows better when it's needed.

Perhaps that may also resolve some of these issues for you!?

> @@ -835,10 +844,20 @@ static inline bool msdc_cmd_is_ready(struct msdc_host *host,
>  {
>         /* The max busy time we can endure is 20ms */
>         unsigned long tmo = jiffies + msecs_to_jiffies(20);
> +       u32 count = 0;
> +
> +       if (in_interrupt()) {
> +               while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) &&
> +                      (count < 1000)) {
> +                       udelay(1);
> +                       count++;

This seems like a bad idea, "busy-wait" in irq context is never a good idea.

> +               }
> +       } else {
> +               while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) &&
> +                      time_before(jiffies, tmo))
> +                       cpu_relax();
> +       }
>
> -       while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) &&
> -                       time_before(jiffies, tmo))
> -               cpu_relax();
>         if (readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) {
>                 dev_err(host->dev, "CMD bus busy detected\n");
>                 host->error |= REQ_CMD_BUSY;
> @@ -846,17 +865,35 @@ static inline bool msdc_cmd_is_ready(struct msdc_host *host,
>                 return false;
>         }
>
> -       if (mmc_resp_type(cmd) == MMC_RSP_R1B || cmd->data) {
> -               tmo = jiffies + msecs_to_jiffies(20);
> -               /* R1B or with data, should check SDCBUSY */
> -               while ((readl(host->base + SDC_STS) & SDC_STS_SDCBUSY) &&
> -                               time_before(jiffies, tmo))
> -                       cpu_relax();
> -               if (readl(host->base + SDC_STS) & SDC_STS_SDCBUSY) {
> -                       dev_err(host->dev, "Controller busy detected\n");
> -                       host->error |= REQ_CMD_BUSY;
> -                       msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
> -                       return false;
> +       if (cmd->opcode != MMC_SEND_STATUS) {
> +               count = 0;
> +               /* Consider that CMD6 crc error before card was init done,
> +                * mmc_retune() will return directly as host->card is null.
> +                * and CMD6 will retry 3 times, must ensure card is in transfer
> +                * state when retry.
> +                */
> +               tmo = jiffies + msecs_to_jiffies(60 * 1000);
> +               while (1) {
> +                       if (msdc_card_busy(host->mmc)) {
> +                               if (in_interrupt()) {
> +                                       udelay(1);
> +                                       count++;
> +                               } else {
> +                                       msleep_interruptible(10);
> +                               }
> +                       } else {
> +                               break;
> +                       }
> +                       /* Timeout if the device never
> +                        * leaves the program state.
> +                        */
> +                       if (count > 1000 || time_after(jiffies, tmo)) {
> +                               pr_err("%s: Card stuck in programming state! %s\n",
> +                                      mmc_hostname(host->mmc), __func__);
> +                               host->error |= REQ_CMD_BUSY;
> +                               msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
> +                               return false;
> +                       }

This hole new code is a hack, that shouldn't be needed in the host driver.

I think we need to investigate and fix the issue in the mmc core
layer, to make this work for your host driver. That instead of doing a
work around in the host.

>                 }
>         }
>         return true;
> @@ -1070,18 +1107,6 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
>         return ret;
>  }
>
> -static int msdc_card_busy(struct mmc_host *mmc)
> -{
> -       struct msdc_host *host = mmc_priv(mmc);
> -       u32 status = readl(host->base + MSDC_PS);
> -
> -       /* check if any pin between dat[0:3] is low */
> -       if (((status >> 16) & 0xf) != 0xf)
> -               return 1;
> -
> -       return 0;
> -}
> -
>  static void msdc_request_timeout(struct work_struct *work)
>  {
>         struct msdc_host *host = container_of(work, struct msdc_host,
> --
> 1.7.9.5
>

Kind regards
Uffe
