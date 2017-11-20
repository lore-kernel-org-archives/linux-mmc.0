From: Park Huijin <bbang.huijin.park@gmail.com>
Subject: Re: [PATCH] mmc: card: increase wait time
Date: Mon, 20 Nov 2017 13:50:56 +0900
Message-ID: <CAFwFC8QL4oyz9oDyidjkByRUCqWo_UufHiHgMf1GEho+TMmnpg@mail.gmail.com>
References: <CGME20171114024825eucas1p218873c4ff649c17d4061b6660aa6264f@eucas1p2.samsung.com>
 <1510627683-5209-1-git-send-email-huijin.park@samsung.com> <CAPDyKFo6M+TzrtPmfc2xJzKUaRhbiFp9UR8f+AQf_RgKYu5M9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:40660 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbdKTEu5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Nov 2017 23:50:57 -0500
Received: by mail-io0-f182.google.com with SMTP id 71so14431855ior.7
        for <linux-mmc@vger.kernel.org>; Sun, 19 Nov 2017 20:50:57 -0800 (PST)
In-Reply-To: <CAPDyKFo6M+TzrtPmfc2xJzKUaRhbiFp9UR8f+AQf_RgKYu5M9w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huijin Park <huijin.park@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, js07.lee@gmail.com

2017-11-15 18:13 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
>
> On 14 November 2017 at 03:48, Huijin Park <huijin.park@samsung.com> wrote:
> > Some eMMC products keep busy time a little longer intermittently.
> > (eg. prepare free blocks, garbage collection...)
> > In this case, we recommend to wait a little longer than fail.
>
> Is this an rpmb specific problem, because the code seems only to change that.
>
> Is it write and read or only write?
Yes. It's rpmb specific problem.
RPMB R/W use same flow. but only 'write' case makes the problem(long
busy state) sometimes.
When I test it, the 5~25ms is not enough although there is not max
busy time in the spec.

>
> >
> > Signed-off-by: Huijin Park <huijin.park@samsung.com>
> > ---
> >  drivers/mmc/core/block.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index ea80ff4..b5b0fe6 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -584,7 +584,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
> >                  * Ensure RPMB command has completed by polling CMD13
> >                  * "Send Status".
> >                  */
> > -               err = ioctl_rpmb_card_status_poll(card, &status, 5);
> > +               err = ioctl_rpmb_card_status_poll(card, &status, 50);
>
> First, you are changing "re-tries" not a timeout value, which would
> seem like a better approach.
I will modify it. Thanks.

>
> Second, it seems like we should remove the
> ioctl_rpmb_card_status_poll() function altogether and instead make use
> of the more generic card_busy_detect() function here.
>
> Then if card_busy_detect() needs to be adopted to suite rpmb, then we
> should do that instead.
I agree that. But the two function are different a little.
'ioctl_rpmb_card_status_poll()' has interval(1~5ms) that prevent to
poll too frequently.
So I suggest to improve 'card_busy_detect()' about interval time in
another patch.
Then the 'ioctl_rpmb_card_status_poll()' can replaced by 'card_busy_detect()'

>
> >                 if (err)
> >                         dev_err(mmc_dev(card->host),
> >                                         "%s: Card Status=0x%08X, error %d\n",
> > --
> > 1.9.1
> >
>
> Kind regards
> Uffe
