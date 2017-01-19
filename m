From: Yong Mao <yong.mao@mediatek.com>
Subject: Re: [PATCH v2 1/2] mmc: core: Fix CMD6 timeout issue
Date: Thu, 19 Jan 2017 17:06:55 +0800
Message-ID: <1484816815.19281.49.camel@mhfsdcap03>
References: <1483433397-11756-1-git-send-email-yong.mao@mediatek.com>
         <1483433397-11756-2-git-send-email-yong.mao@mediatek.com>
         <CAPDyKFrkehvdnYgau1zFmgcHUniMbcat_NOLkB7bSGWF+b=c9Q@mail.gmail.com>
         <b6efb075-226a-c7c8-2c6d-7d61d78eced1@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([218.249.47.111]:33609 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751199AbdASJHO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2017 04:07:14 -0500
In-Reply-To: <b6efb075-226a-c7c8-2c6d-7d61d78eced1@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-mediatek@lists.infradead.org

On Fri, 2017-01-13 at 11:35 +0800, Shawn Lin wrote:
> On 2017/1/12 23:21, Ulf Hansson wrote:
> > - trimmed cc-list
> >
> > On 3 January 2017 at 09:49, Yong Mao <yong.mao@mediatek.com> wrote:
> >> From: yong mao <yong.mao@mediatek.com>
> >>
> >> When initializing EMMC, after switch to HS400,
> >> it will issue CMD6 to change ext_csd,
> >> if first CMD6 got CRC error,
> >> the repeat CMD6 may get timeout,
> >> that's because card is not back to transfer state immediately.
> >>
> >> For resolving this issue, it need check if card is busy
> >> before sending repeat CMD6.
> >
> > I agree that doing retries in this path might may not be correctly
> > done, but currently we do it as best effort.
> >
> > We should probably change this to *not* retry the CMD6 command, in
> > cases when we have a MMC_RSP_R1B response, because of the reasons you
> > describe.
> > I get the feeling that these retry attempts for CMD6, may instead hide
> > other real issues and making it harder to narrow them down. Don't you
> > think?
> >
> > This leads to my following question:
> > Why do you get a CRC error at the first CMD6 attempt? That shouldn't
> > happen, right?
> >
> > Perhaps you can elaborate on what of the CMD6 commands in the HS400
> > enabling sequence that fails. It may help us to understand, perhaps
> > there may be something in that sequence that should be changed.
> >
> >>
> >> Not only CMD6 here has this issue, but also other R1B CMD has
> >> the same issue.
> >
> > Yes, agree!
> >
> > However, can you please try to point out some other commands than CM6
> > that you see uses *retries*, has R1B response, and which you believe
> > may not be properly managed.
> >
> > Dealing with R1B responses isn't always straight forward. Therefore I
> > am wondering whether we perhaps should just not allow "automatic
> > retries" in cases when R1B responses is used.
> >
> > The reason why I think that is easier, is because of the complexity we
> > have when dealing with R1B responses.
> >
> 
> I'm just thinking a interesting question: What will happen if someone
> uses a userspace tool to switch the partition to RPMB when we are in
> command queue mode? It will fails to finish CMD6 and the emmc should be
> busy for a while. So now we shouldn't retry CMD6 but need to send a
> CMD13 to make sure it's back to transfer state OR a HPI to break it. We
> should be able to cover these cases not only from kernel context but
> also the interaction between user and kernel.
> 
Specification can ensure that your question will not occur.
"NOTE if hosts need to access RPMB partition, the host should disable
the Command Queue mechanism and access RPMB partition not through the
command queue."
"General Purpose partitions may be accessed when command queuing is
enabled.The queue must be empty when CMD6 is sent(to switch partitions
or to disable command queuing). Sending CMD6 while the queue is not
empty shall be regarded as illegal command(see 6.6.39.9, Supported
Commands)."

> > As for example the timeout may differ depending on the command, so
> > just guessing that 500 ms might work, isn't good enough. Moreover we
> > would need to deal with MMC_CAP_WAIT_WHILE_BUSY, etc. Currently I am
> > not saying that we shouldn't do this, but then I first need to
> > understand how big of problem this is.
> >
> >>
> >> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> >> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> >> ---
> >>  drivers/mmc/core/core.c |   19 +++++++++++++++++++
> >>  1 file changed, 19 insertions(+)
> >>
> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >> index 1076b9d..8674dbb 100644
> >> --- a/drivers/mmc/core/core.c
> >> +++ b/drivers/mmc/core/core.c
> >> @@ -566,6 +566,25 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
> >>
> >>                 mmc_retune_recheck(host);
> >>
> >> +               /*
> >> +                * If a R1B CMD such as CMD6 occur CRC error,
> >> +                * it will retry 3 times here.
> >> +                * But before retrying, it must ensure card is in
> >> +                * transfer state.
> >> +                * Otherwise, the next retried CMD will got TMO error.
> >> +                */
> >> +               if (mmc_resp_type(cmd) == MMC_RSP_R1B && host->ops->card_busy) {
> >> +                       int tries = 500; /* Wait aprox 500ms at maximum */
> >> +
> >> +                       while (host->ops->card_busy(host) && --tries)
> >> +                               mmc_delay(1);
> >> +
> >> +                       if (tries == 0) {
> >> +                               cmd->error = -EBUSY;
> >> +                               break;
> >> +                       }
> >> +               }
> >> +
> >>                 pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
> >>                          mmc_hostname(host), cmd->opcode, cmd->error);
> >>                 cmd->retries--;
> >> --
> >> 1.7.9.5
> >>
> >
> > Kind regards
> > Uffe
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 


