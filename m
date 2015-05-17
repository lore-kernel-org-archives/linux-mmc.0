From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 2/7] mmc: mediatek: Add Mediatek MMC driver
Date: Sun, 17 May 2015 17:40:54 +0800
Message-ID: <1431855654.26820.11.camel@mhfsdcap03>
References: <1430214525-19198-1-git-send-email-chaotian.jing@mediatek.com>
 <1430214525-19198-3-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFq=R9B6ZHHgmDcSg-TNSfqQKAUKc2NjACvpwxFpmk954g@mail.gmail.com>
 <1430895299.15154.9.camel@mhfsdcap03>
 <CAPDyKFr+FTXAzYVn3F41dmw2zW01pSbSHPfGJHXbUFLJfvQ5CA@mail.gmail.com>
 <1430962956.15154.48.camel@mhfsdcap03>
 <CAPDyKFr5N_08HbLuY=4Wfv1BoVQLVR-VW+NKh_umL1hzi_KozA@mail.gmail.com>
 <1431335885.26820.7.camel@mhfsdcap03>
 <CAPDyKFqeAzjpbZsyfcwb_WarC=dzoCsEeLTmxAbtvOo3Y4cYyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAPDyKFqeAzjpbZsyfcwb_WarC=dzoCsEeLTmxAbtvOo3Y4cYyg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Mon, 2015-05-11 at 12:29 +0200, Ulf Hansson wrote:
> On 11 May 2015 at 11:18, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > On Fri, 2015-05-08 at 14:12 +0200, Ulf Hansson wrote:
> >> On 7 May 2015 at 03:42, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> >> > Dear Ulf,
> >> >
> >> > Thanks!
> >> > Below is my comment:
> >> >
> >> > On Wed, 2015-05-06 at 18:31 +0200, Ulf Hansson wrote:
> >> >> On 6 May 2015 at 08:54, chaotian.jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> >> >> > Dear Ulf,
> >> >> >
> >> >> > Thanks for your review.
> >> >> > I must do a explain of our MMC host:
> >> >> > Source clock is source clock of the MMC bus, MMC host has a divider to
> >> >> > get different bus clock frequency. now the runtime suspend is gating
> >> >> > this clock.
> >> >> >
> >> >> > Hclk is the power domain of the MMC host, if Hclk is gated, the MMC host
> >> >> > cannot work(all registers readout is zero). and, all registers would be
> >> >> > reset to default value if Hclk is gated/ungated.
> >> >> > At MT8173, MSDC0 and MSDC2 has independent Hclk, MSDC1 and MSDC3's Hclk
> >> >> > was controlled by "Infra module".
> >> > Sorry for mistake, MSDC0 and MSDC3 has independent Hclk, MSDC1 and
> >> > MSDC2's Hclk was controlled by "Infra module". the Infra module is a
> >> > "power saving module", when the system go to sleep, Infra module will be
> >> > set and MSDC1 & MSDC2's Hclk will be gated automatically.
> >> >>
> >> >> Thanks for clarifying!
> >> >>
> >> >> I don't have enough knowledge about your SoC to understand the detail,
> >> >> but it seems like we are mixing clocks and power domains. I would
> >> >> rather keep this separate - if the HW allows it.
> >> >>
> >> >> I guess the key question I have is the following:
> >> >> 1) Is it hardware wise possible to gate the hclk, but without gating
> >> >> the power domain?
> >> >> 2) At what level is the reference counting done for each device in the
> >> >> power domain? In HW or in sofftware?
> >> >>
> >> >
> >> > Actually, Our MMC host do not have power domain, all the control of the
> >> > host is the Hclk.
> >>
> >> Okay, but I am not sure that fully answered my question.
> >>
> >> You said that hclk will be gated when the power domain gets gated. And
> >> the power domain (infra module, right?) will be gated at system PM
> >> sleep. And when that happens the mmc controller loses register
> >> context.
> >>
> >> But, again, can hclk be gated without gating the power domain?
> >>
> >> No matter what, it seems like a good idea to gate the power domain
> >> when all clients of it are idle. Yes we would need to manage register
> >> save/restore context, but on the other hand allow you to save more
> >> power, right?
> >>
> > For MSDC0 & MSDC3, it has independent HCLK, do not have power domain.
> > For MSDC1 & MSDC2, its HCLK was controlled by Infra module(This is a big
> > power domain for many modules).
> > So, for msdc0 & msdc3, we can control its Hclk, for msdc1 & msdc2, we
> > cannot control it.
> 
> Okay, thanks for the clarification!
> 
> >
> > Yes, I will do gate/ungate HCLK & source clock in PM.
> > In addition, Since the gate/ungate HCLK is done by runtime PM, and all
> > register operation should work at HCLK is on, so the msdc_init_hw() only
> > can be called at set_ios(), because in probe(), the HCLK may have not
> > been enabled.
> 
> I suggest you to enable HCLK in ->probe() and thus you may also call
> msdc_init_hw() from there.
> 
> This should simplify for you, when adding the runtime PM support.

Yes, I will enable HCLK in ->probe(), but still need call msdc_init_hw()
in set_ios(), because SD hot plug need it when inserted.
In addition, it seems that still need sclk_enabled and hclk_enabled to
judge if clock already enabled, because not only the runtime PM will
call it.
> 
> Kind regards
> Uffe
