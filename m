From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH] mmc: mediatek: fix request blocked by
 cancel_delayed_work
Date: Wed, 27 Apr 2016 20:06:16 +0800
Message-ID: <1461758776.20837.7.camel@mhfsdcap03>
References: <1460963609-16179-1-git-send-email-chaotian.jing@mediatek.com>
	 <CAPDyKFrXVaq85sSQ+ib-U=rgdxB_k2tif0aHQi_0d8kZ2FZDcA@mail.gmail.com>
	 <1461404630.7081.9.camel@mhfsdcap03>
	 <CAPDyKFpO89QWHST8XoBvRO4Y+Fv4Umt43B35E2vhm-z2WmZXSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([218.249.47.110]:56602 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750826AbcD0MGh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2016 08:06:37 -0400
In-Reply-To: <CAPDyKFpO89QWHST8XoBvRO4Y+Fv4Umt43B35E2vhm-z2WmZXSw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Nicolas Boichat <drinkcat@chromium.org>, Douglas Anderson <dianders@chromium.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>

Hi,
On Wed, 2016-04-27 at 12:02 +0200, Ulf Hansson wrote:
> On 23 April 2016 at 11:43, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> > Hi,
> > On Fri, 2016-04-22 at 14:24 +0200, Ulf Hansson wrote:
> >> On 18 April 2016 at 09:13, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> >> > there are 2 points will cause could not call mmc_request_done()
> >> > and eventually cause the caller thread blocked.
> >> >
> >> > A. if card was busy, cancel_delayed_work() will return false because
> >> > the delay work has not been scheduled, in this case, need put
> >> > mod_delayed_work() in front of msdc_cmd_is_ready()
> >> >
> >> > B. if a request really need more than 5s(Some Sandisk TF card), it will
> >> > use cancel_delayed_work() to cancel itself, and also return false, so use
> >> > in_interrupt() to avoid this case
> >> >
> >> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> >> > ---
> >> >  drivers/mmc/host/mtk-sd.c | 11 ++++++++---
> >> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> >> > index b17f30d..1511b1b 100644
> >> > --- a/drivers/mmc/host/mtk-sd.c
> >> > +++ b/drivers/mmc/host/mtk-sd.c
> >> > @@ -724,7 +724,7 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
> >> >         bool ret;
> >> >
> >> >         ret = cancel_delayed_work(&host->req_timeout);
> >> > -       if (!ret) {
> >> > +       if (!ret && in_interrupt()) {
> >> >                 /* delay work already running */
> >> >                 return;
> >> >         }
> >> > @@ -824,7 +824,12 @@ static inline bool msdc_cmd_is_ready(struct msdc_host *host,
> >> >         }
> >> >
> >> >         if (mmc_resp_type(cmd) == MMC_RSP_R1B || cmd->data) {
> >> > -               tmo = jiffies + msecs_to_jiffies(20);
> >> > +               /*
> >> > +                * 2550ms is from EXT_CSD[248], after switch to hs200,
> >> > +                * using CMD13 to polling card status, it will get response
> >> > +                * of 0x800, but EMMC still pull-low DAT0.
> >> > +                */
> >>
> >> Seems like you are solving a eMMC specific issue on your driver?
> >>
> >> Perhaps we should try to use a card quirk instead?
> >
> > Actually, this is a Bug of __mmc_switch(), Per JEDEC Spec, while switch
> > speed mode, should not use CMD13 to get card status, as it's response
> > cannot reflect that if card was busy now, for this CMD6 switch HS200
> 
> There is a statement applicable to all HS modes, which says it's *not
> recommended* but *if* used, CRC errors shall be ignored.
> 
Yes, but if we ignore the CRC error check, how do we know current
response is correct or incorrect ? if card is still busy but we get the
response of 0x900 caused by latching error, then it still consider that
card has already changed to trans state.
So, it's better to never use CMD13 when change the speed mode.
> That's what we have been doing so far, but perhaps that isn't good
> enough for HS200/400.
> 
> > case, I tried some Samsung/Sandisk/KSI eMMC, issue CMD13 will always get
> > 0x800, even eMMC has already changed to transfer state and DAT0 is high,
> > the response of CMD13 is also 0x800, and will never be 0x900.
> 
> What do you mean by never? I assume it would when you extend the timeout?
> 
> Does your host driver make sure to ignore CRC errors in this case?
> Just to be sure, that isn't the problem.
> 
> > So, in __mmc_switch(), it's a bug to use CMD13 to know that if card has
> > already changed to transfer state.
> 
> Whether it's a bug or not, it seems like we have eMMC cards that we
> have issues to support because of the way we have interpreted the
> spec. So let's try to fix them!
> 
> > But, Our host do not support MMC_CAP_WAIT_WHILE_BUSY, that's why we hit
> > this issue.
> 
> Okay, I see.
> 
> Let's try to change the behaviour in __mmc_switch() to prevent it to
> send CMD13 before the cards stops signal busy on DAT0, when switching
> to HS200/HS400 mode.
> What I have in mind is:
> 
> 1.
> When the host controller doesn't support MMC_CAP_WAIT_WHILE_BUSY, we
> would then to wait for a fixed timeout, before we send CMD13. In this
> case, do you know if the "generic_cmd6_time" is working for your eMMC
> devices that you had issues with?
> 
In general, generic_cmd6_time is enough, unless the card has firmware
issue itself,
> 2.
> In additional to the above solution, we can for those hosts that
> supports the ->card_busy() ops, but not MMC_CAP_WAIT_WHILE_BUSY,
> invoke the ->card_busy() in a polling manner. Of course the above
> timeout should also be considered as we need to stop polling at some
> point.
> 
this is what I want to do it, use the ops->card_busy() to check DAT0
status. if a host do not support MMC_CAP_WAIT_WHILE_BUSY and there is
no ops->card_busy(), then the only way is wait a fixed
timeout(generic_cmd6_time).

> So I noticed the Mediatek mmc host driver supports the ->card_busy()
> ops. So I think you can try 1) first, then extend it to 2).
> 
> Does it makes sense?
> 
> [...]
> 
> Kind regards
> Uffe


