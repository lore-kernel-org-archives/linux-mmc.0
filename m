From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 2/7] mmc: mediatek: Add Mediatek MMC driver
Date: Tue, 26 May 2015 14:16:31 +0800
Message-ID: <1432620991.647.6.camel@mhfsdcap03>
References: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
 <1432017411-2996-3-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFo5788uRqAaXUZ-OiS1XF8NPmg4tn2ipZNJdx4dci+KMQ@mail.gmail.com>
 <1432284000.23435.38.camel@mhfsdcap03>
 <CAPDyKFpWCvJXL-W5P83ucBM2-b5cDFEtSLnN6J6WLyR_9CuvWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAPDyKFpWCvJXL-W5P83ucBM2-b5cDFEtSLnN6J6WLyR_9CuvWw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Fri, 2015-05-22 at 14:51 +0200, Ulf Hansson wrote:
> [...]
> 
> >> You are invoking msdc_gate_clock() and msdc_ungate_clock() in a
> >> balanced manner, thus hclk_enabled is redundant. Please remove it.
> >
> > on drv->probe(), already invoke the msdc_ungate_clock(), so, when the
> > runtime pm resume invoke the msdc_ungate_clock(), the hclk already
> > enabled.
> 
> 
> That's why you invoke pm_runtime_set_active() during ->probe() when
> deploying PM support in patch3. It's not an issue then.
OK, then I can remove the hclk_enabled and sclk_enabled.
> 
> [...]
> 
> >> I assume it's possible to gate the clock by updating a MSDC register
> >> instead!? That would be prefereable since then you can leave clock
> >> gating/ungating via the clk API, to be dealt from runtime PM. That
> >> would also make "sclk_enabled" in the struct msdc_host redundant.
> >>
> >> Adopting to above, obviously requires MSDC to be able to ungate the
> >> clock by also updating a MSDC register. I assume that's possible as
> >> well!?
> >>
> > We can set the bit1 of MSDC_CFG, when this bit is 0, the bus clock was
> > gated to 0 if no command or data is transmitted.
> > And, from our designer, when we operate the MSDC register, we need make
> > sure both HCLK and source are enabled, if source clock was disabled,
> > write some MSDC registers will have no effect(eg. send CMD, without
> > source clock, not only cannot send CMD, but also cannot get CMD timeout
> > interrupt.)
> 
> Thanks, that answered my question. As I understand it you should be
> able to adopt to my propsual.
> 
> [...]
> 
> >> > +{
> >> > +       unsigned long tmo = jiffies + msecs_to_jiffies(20);
> >> > +
> >> > +       while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY)
> >> > +                       && time_before(jiffies, tmo))
> >> > +               continue;
> >> > +
> >> > +       if (readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) {
> >> > +               dev_err(host->dev, "CMD bus busy detected\n");
> >> > +               host->error |= REQ_CMD_BUSY;
> >> > +               msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
> >> > +               return false;
> >> > +       }
> >> > +
> >> > +       if (mmc_resp_type(cmd) == MMC_RSP_R1B || cmd->data) {
> >> > +               /* R1B or with data, should check SDCBUSY */
> >> > +               while (readl(host->base + SDC_STS) & SDC_STS_SDCBUSY)
> >> > +                       cpu_relax();
> >> > +       }
> >>
> >> MSDC seems to be handling card busy detection in HW, right?
> >>
> > Do not have this ability, HW only know if CMD/DAT is low, but do not
> > have any interrupt for it,
> 
> I see, but doesn't the above polling mean that msdc will not propagate
> the response until the card have stopped signal busy? That's what
> MMC_CAP_WAIT_WHILE_BUSY shall be used for.
> 
As you see, we only check the "busy state" BEFORE issue a R1B command or
with data command, but do not check if AFTER the request was done, that
would do not match the "MMC_CAP_WAIT_WHILE_BUSY"(eg. CMD5 to sleep)
In addition, about CMD5, I find that the suspend/resume flow of EMMC is
stranger in new kernel version, when suspend, it may issue CMD5 to enter
sleep mode, then power off MMC, but when resume, it will
re-initialization, So that why need do the redundant CMD5 in suspend ?

> Perhaps you should remove the above polling, and rely on the MMC core
> to poll with CMD13 instead?
before any read/write command, core will issue CMD13 to confirm card
status, here is just only do double confirm to avoid HW issue.
> 
> >> If so, you should enable MMC_CAP_WAIT_WHILE_BUSY and set
> >> "max_busy_timeout" to DAT_TIMEOUT to inform the mmc core about it.
> >>
> 
> [...]
> 
> Kind regards
> Uffe
