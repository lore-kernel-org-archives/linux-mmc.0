From: Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v1] mmc: mediatek: Fixed bug where clock frequency could
 be set wrong
Date: Fri, 24 Feb 2017 17:38:44 +0800
Message-ID: <1487929124.22858.10.camel@mhfsdcap03>
References: <1487924527-22584-1-git-send-email-yong.mao@mediatek.com>
 <1487924527-22584-2-git-send-email-yong.mao@mediatek.com>
 <CAGS+omDuPwXqTJ2CrLbLvSHdp3CL895qop1x6dLT1u7bG7XnVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAGS+omDuPwXqTJ2CrLbLvSHdp3CL895qop1x6dLT1u7bG7XnVw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Chunfeng Yun <chunfeng.yun-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: 	Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
To: 	Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: 	Re: [PATCH v1] mmc: mediatek: Fixed bug where clock frequency
could be set wrong
Date: 	Fri, 24 Feb 2017 17:33:37 +0800


On Fri, 2017-02-24 at 17:52 +0900, Daniel Kurtz wrote:
> On Fri, Feb 24, 2017 at 5:22 PM, Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
wrote:
> >
> > From: yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >
> > This patch can fix two issues:
> >
> > Issue 1:
> > The maximum value of clock divider is 0xff.
> > Because the type of div is u32, div may be larger than max_div.
> > In this case, we should use max_div to set the clock frequency.
> >
> > Issue 2:
> > In previous code, we can not set the correct clock frequency when
> > div equals 0xff.
> >
> > Signed-off-by: Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/mmc/host/mtk-sd.c |   13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index 07f3236..3174445 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -540,6 +540,7 @@ static void msdc_set_mclk(struct msdc_host
*host, unsigned char timing, u32 hz)
> >         u32 mode;
> >         u32 flags;
> >         u32 div;
> > +       u32 max_div;
> 
> There's really no need for this variable.  Just use 0xff below.
For all of our IC, max_div is not a constant.
We will upstream another patch which max_div will get the different
value depending on the IC.
Therefore, we keep the max_div as a variable here.

> 
> >         u32 sclk;
> >
> >         if (!hz) {
> > @@ -590,8 +591,18 @@ static void msdc_set_mclk(struct msdc_host
*host, unsigned char timing, u32 hz)
> >                         sclk = (host->src_clk_freq >> 2) / div;
> >                 }
> >         }
> > +
> > +       /**
> > +        * The maximum value of div is 0xff.
> > +        * Check if the div is larger than max_div.
> > +        */
> > +       max_div = 0xff;
> > +       if (div > max_div) {
> > +               div = max_div;
> > +               sclk = (host->src_clk_freq >> 2) / div;
> > +       }
> >         sdr_set_field(host->base + MSDC_CFG, MSDC_CFG_CKMOD |
MSDC_CFG_CKDIV,
> > -                       (mode << 8) | (div % 0xff));
> > +                     (mode << 8) | div);
> 
> Hmm, I don't know much about this sub-system, but should we even be
> allowing requests to set a frequency that we can't actually achieve
> with the divider?
> 

No. We can not get a frequency that we can't actually achieve with the
divider. This patch is to solve this kind of issue.


> >         sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
> >         while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
> >                 cpu_relax();
> > --
> > 1.7.9.5
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
