From: Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] mmc: core: Fix CMD6 timeout issue
Date: Thu, 19 Jan 2017 16:58:48 +0800
Message-ID: <1484816328.19281.43.camel@mhfsdcap03>
References: <1483433397-11756-1-git-send-email-yong.mao@mediatek.com>
 <1483433397-11756-2-git-send-email-yong.mao@mediatek.com>
 <CAPDyKFrkehvdnYgau1zFmgcHUniMbcat_NOLkB7bSGWF+b=c9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAPDyKFrkehvdnYgau1zFmgcHUniMbcat_NOLkB7bSGWF+b=c9Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chunfeng Yun <chunfeng.yun-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 2017-01-12 at 16:21 +0100, Ulf Hansson wrote:
> - trimmed cc-list
> 
> On 3 January 2017 at 09:49, Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > From: yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >
> > When initializing EMMC, after switch to HS400,
> > it will issue CMD6 to change ext_csd,
> > if first CMD6 got CRC error,
> > the repeat CMD6 may get timeout,
> > that's because card is not back to transfer state immediately.
> >
> > For resolving this issue, it need check if card is busy
> > before sending repeat CMD6.
> 
> I agree that doing retries in this path might may not be correctly
> done, but currently we do it as best effort.
> 
> We should probably change this to *not* retry the CMD6 command, in
> cases when we have a MMC_RSP_R1B response, because of the reasons you
> describe.
> I get the feeling that these retry attempts for CMD6, may instead hide
> other real issues and making it harder to narrow them down. Don't you
> think?

> This leads to my following question:
> Why do you get a CRC error at the first CMD6 attempt? That shouldn't
> happen, right?
> 
Host needs to ensure that there is no CRC error when sampling the
signal from device. However, in the high frequency mode, it is
inevitable that there will be CRC error.
Because of the presence of CRC error, we have the re-tune mechanism in
the mmc core layer to handle.
But in this case, it will occur CMD timeout error after re-sending the
R1B CMD. Currently, we still do not have mechanism to handle this case
in the mmc core layer.

> Perhaps you can elaborate on what of the CMD6 commands in the HS400
> enabling sequence that fails. It may help us to understand, perhaps
> there may be something in that sequence that should be changed.
> 
Sorry. Maybe I didn't describe this issue clearly.
The CMD6 command issue in my commit message is only a specific example
of this type of issue we actually encounter.

I describe the issue step by step as below:
Step 1: Send a R1B command and then get command CRC error.
Step 2: According to the current logic of mmc core layer code,
        it will resend this R1B command again.
Step 3: Because card may be in the busy state while resending this 
	R1B command, card will not response this R1B command.
	And then this R1B command will fail with the reason 
	of timeout.   

> >
> > Not only CMD6 here has this issue, but also other R1B CMD has
> > the same issue.
> 
> Yes, agree!
> 
> However, can you please try to point out some other commands than CM6
> that you see uses *retries*, has R1B response, and which you believe
> may not be properly managed.
> 
Actually, we just met this CMD6 timeout issue in our project. 
However, according to the analysis, all R1b command may have the same
issue.

> Dealing with R1B responses isn't always straight forward. Therefore I
> am wondering whether we perhaps should just not allow "automatic
> retries" in cases when R1B responses is used.
> 
> The reason why I think that is easier, is because of the complexity we
> have when dealing with R1B responses.
We think "automatic retries" should still be used in this case.
With "automatic retries", it have re-tune mechanism to let host
re-select a better parameters to handle command CRC error. 

> 
> As for example the timeout may differ depending on the command, so
> just guessing that 500 ms might work, isn't good enough. Moreover we
> would need to deal with MMC_CAP_WAIT_WHILE_BUSY, etc. Currently I am
> not saying that we shouldn't do this, but then I first need to
> understand how big of problem this is.
> 
Yes. You are right. We need to deal with MMC_CAP_WAIT_WHILE_BUSY here.
If the host has the capability of MMC_CAP_WAIT_WHILE_BUSY, it does not
need this patch. But the host, like our host, does not have this
capability, it needs this patch. I will add this logic in next version.
According to our experience, 500ms is enough here. 

> >
> > Signed-off-by: Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/mmc/core/core.c |   19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 1076b9d..8674dbb 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -566,6 +566,25 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
> >
> >                 mmc_retune_recheck(host);
> >
> > +               /*
> > +                * If a R1B CMD such as CMD6 occur CRC error,
> > +                * it will retry 3 times here.
> > +                * But before retrying, it must ensure card is in
> > +                * transfer state.
> > +                * Otherwise, the next retried CMD will got TMO error.
> > +                */
> > +               if (mmc_resp_type(cmd) == MMC_RSP_R1B && host->ops->card_busy) {
> > +                       int tries = 500; /* Wait aprox 500ms at maximum */
> > +
> > +                       while (host->ops->card_busy(host) && --tries)
> > +                               mmc_delay(1);
> > +
> > +                       if (tries == 0) {
> > +                               cmd->error = -EBUSY;
> > +                               break;
> > +                       }
> > +               }
> > +
> >                 pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
> >                          mmc_hostname(host), cmd->opcode, cmd->error);
> >                 cmd->retries--;
> > --
> > 1.7.9.5
> >
> 
> Kind regards
> Uffe
