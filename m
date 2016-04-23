From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH] mmc: mediatek: fix request blocked by
 cancel_delayed_work
Date: Sat, 23 Apr 2016 17:43:50 +0800
Message-ID: <1461404630.7081.9.camel@mhfsdcap03>
References: <1460963609-16179-1-git-send-email-chaotian.jing@mediatek.com>
	 <CAPDyKFrXVaq85sSQ+ib-U=rgdxB_k2tif0aHQi_0d8kZ2FZDcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrXVaq85sSQ+ib-U=rgdxB_k2tif0aHQi_0d8kZ2FZDcA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Nicolas Boichat <drinkcat@chromium.org>, Douglas Anderson <dianders@chromium.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

Hi,
On Fri, 2016-04-22 at 14:24 +0200, Ulf Hansson wrote:
> On 18 April 2016 at 09:13, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> > there are 2 points will cause could not call mmc_request_done()
> > and eventually cause the caller thread blocked.
> >
> > A. if card was busy, cancel_delayed_work() will return false because
> > the delay work has not been scheduled, in this case, need put
> > mod_delayed_work() in front of msdc_cmd_is_ready()
> >
> > B. if a request really need more than 5s(Some Sandisk TF card), it will
> > use cancel_delayed_work() to cancel itself, and also return false, so use
> > in_interrupt() to avoid this case
> >
> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > ---
> >  drivers/mmc/host/mtk-sd.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index b17f30d..1511b1b 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -724,7 +724,7 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
> >         bool ret;
> >
> >         ret = cancel_delayed_work(&host->req_timeout);
> > -       if (!ret) {
> > +       if (!ret && in_interrupt()) {
> >                 /* delay work already running */
> >                 return;
> >         }
> > @@ -824,7 +824,12 @@ static inline bool msdc_cmd_is_ready(struct msdc_host *host,
> >         }
> >
> >         if (mmc_resp_type(cmd) == MMC_RSP_R1B || cmd->data) {
> > -               tmo = jiffies + msecs_to_jiffies(20);
> > +               /*
> > +                * 2550ms is from EXT_CSD[248], after switch to hs200,
> > +                * using CMD13 to polling card status, it will get response
> > +                * of 0x800, but EMMC still pull-low DAT0.
> > +                */
> 
> Seems like you are solving a eMMC specific issue on your driver?
> 
> Perhaps we should try to use a card quirk instead?

Actually, this is a Bug of __mmc_switch(), Per JEDEC Spec, while switch
speed mode, should not use CMD13 to get card status, as it's response
cannot reflect that if card was busy now, for this CMD6 switch HS200
case, I tried some Samsung/Sandisk/KSI eMMC, issue CMD13 will always get
0x800, even eMMC has already changed to transfer state and DAT0 is high,
the response of CMD13 is also 0x800, and will never be 0x900.
So, in __mmc_switch(), it's a bug to use CMD13 to know that if card has
already changed to transfer state.
But, Our host do not support MMC_CAP_WAIT_WHILE_BUSY, that's why we hit
this issue.

May you give some advice for this ?
Thx!
> 
> 
> > +               tmo = jiffies + msecs_to_jiffies(2550);
> >                 /* R1B or with data, should check SDCBUSY */
> >                 while ((readl(host->base + SDC_STS) & SDC_STS_SDCBUSY) &&
> >                                 time_before(jiffies, tmo))
> > @@ -847,6 +852,7 @@ static void msdc_start_command(struct msdc_host *host,
> >         WARN_ON(host->cmd);
> >         host->cmd = cmd;
> >
> > +       mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
> >         if (!msdc_cmd_is_ready(host, mrq, cmd))
> >                 return;
> >
> > @@ -858,7 +864,6 @@ static void msdc_start_command(struct msdc_host *host,
> >
> >         cmd->error = 0;
> >         rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);
> > -       mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
> >
> >         sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
> >         writel(cmd->arg, host->base + SDC_ARG);
> > --
> > 1.8.1.1.dirty
> >
> 
> Kind regards
> Uffe
