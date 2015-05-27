From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 2/7] mmc: mediatek: Add Mediatek MMC driver
Date: Wed, 27 May 2015 19:34:40 +0800
Message-ID: <1432726480.647.16.camel@mhfsdcap03>
References: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
 <1432017411-2996-3-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFo5788uRqAaXUZ-OiS1XF8NPmg4tn2ipZNJdx4dci+KMQ@mail.gmail.com>
 <1432284000.23435.38.camel@mhfsdcap03>
 <CAPDyKFpWCvJXL-W5P83ucBM2-b5cDFEtSLnN6J6WLyR_9CuvWw@mail.gmail.com>
 <1432620991.647.6.camel@mhfsdcap03>
 <CAPDyKFrNQ6E4cU1_gK56ZNYgb=9EzHoJ=vXyraYoKNnRL=Umyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAPDyKFrNQ6E4cU1_gK56ZNYgb=9EzHoJ=vXyraYoKNnRL=Umyg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Bin Zhang =?UTF-8?Q?=28=E7=AB=A0=E6=96=8C=29?= <bin.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kern>
List-Id: linux-mmc@vger.kernel.org

On Tue, 2015-05-26 at 14:33 +0200, Ulf Hansson wrote:
> [...]
> 
> >> >> > +{
> >> >> > +       unsigned long tmo = jiffies + msecs_to_jiffies(20);
> >> >> > +
> >> >> > +       while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY)
> >> >> > +                       && time_before(jiffies, tmo))
> >> >> > +               continue;
> >> >> > +
> >> >> > +       if (readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) {
> >> >> > +               dev_err(host->dev, "CMD bus busy detected\n");
> >> >> > +               host->error |= REQ_CMD_BUSY;
> >> >> > +               msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
> >> >> > +               return false;
> >> >> > +       }
> >> >> > +
> >> >> > +       if (mmc_resp_type(cmd) == MMC_RSP_R1B || cmd->data) {
> >> >> > +               /* R1B or with data, should check SDCBUSY */
> >> >> > +               while (readl(host->base + SDC_STS) & SDC_STS_SDCBUSY)
> >> >> > +                       cpu_relax();
> >> >> > +       }
> >> >>
> >> >> MSDC seems to be handling card busy detection in HW, right?
> >> >>
> >> > Do not have this ability, HW only know if CMD/DAT is low, but do not
> >> > have any interrupt for it,
> >>
> >> I see, but doesn't the above polling mean that msdc will not propagate
> >> the response until the card have stopped signal busy? That's what
> >> MMC_CAP_WAIT_WHILE_BUSY shall be used for.
> >>
> > As you see, we only check the "busy state" BEFORE issue a R1B command or
> > with data command, but do not check if AFTER the request was done, that
> > would do not match the "MMC_CAP_WAIT_WHILE_BUSY"(eg. CMD5 to sleep)
> 
> Okay, fair enough. Still, I don't understand why you want to do that?
> 
Below is the description of these 2 bits:
1	CMDBSY	CMDBUSY	SD Command line busy status
S/W should always read this bit to make sure the command line is not
busy before sending the next command. 
If the command is R1B or data read/write command, S/W should check
SDCBUSY bit too.
Note: When Auto command 12 is enabled, this bit will be asserted
immediately after SDC_CMD is written and de-asserted after auto-command
12 finishes.
1'b0: No transmission is going on CMD line on SD bus
1'b1: There exists transmission going on CMD line on SD bus
0	SDCBSY	SDCBUSY	SD controller busy status
1'b0: SD controller is idle
1'b1: SD controller is busy

> > In addition, about CMD5, I find that the suspend/resume flow of EMMC is
> > stranger in new kernel version, when suspend, it may issue CMD5 to enter
> > sleep mode, then power off MMC, but when resume, it will
> > re-initialization, So that why need do the redundant CMD5 in suspend ?
> 
> Both CMD0 and CMD5 are valid as wakeup commands.
> 
> To be able to use CMD5, the VCCQ regulator must be kept enabled in the
> sleep state. That's when it becomes a bit tricky, due to the range of
> different host drivers and SoCs for how VCCQ is managed.
> 
> To be safe we have chosen to use CMD0, since it works for *all* cases
> no matter if VCCQ get gated or not.
> 
> Moreover, using CMD5 as the wakeup command would require added
> complexity in the code dealing with suspend/resume. I don't think the
> effort is worth it, at least until someone has proven that the resume
> time is greatly decreased by using CMD5.
> 
> >
> >> Perhaps you should remove the above polling, and rely on the MMC core
> >> to poll with CMD13 instead?
> > before any read/write command, core will issue CMD13 to confirm card
> > status, here is just only do double confirm to avoid HW issue.
> 
> What HW issue and why do you need to double confirm? It seems strange.
Some fake SD card, even the CMD13 get card status is in transfer state,
but when we do read/write, the data0 was pull low.

By the way, do you think need do some spinlock protect in our code ?
I cannot find a good reason to use spin lock, it seems no need
it,although there will be many thread(mmcqd, mmcqd/0boot1,) and the irq
handler.
> 
> Kind regards
> Uffe
