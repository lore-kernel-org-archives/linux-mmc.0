From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 09/24] mmc: mtk-sd: check for valid optional memory
 resource
Date: Mon, 25 Mar 2019 14:26:53 +0100
Message-ID: <CAPDyKFrc4wqawSR4a4Coxj1d+0K3BbOtTcgMCUsnkR2-epjW_g@mail.gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-10-fparent@baylibre.com>
 <1553398466.26628.0.camel@mtksdaap41>
 <CAOwMV_zkHMZv8y_8C9kRCUsPtSbm+vPkJUNzU-_LK5=OhTkiPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAOwMV_zkHMZv8y_8C9kRCUsPtSbm+vPkJUNzU-_LK5=OhTkiPw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

-- trimmed cc-list

On Sun, 24 Mar 2019 at 16:18, Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
>
> On Sun, Mar 24, 2019 at 4:34 AM Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> >
> > On Sat, 2019-03-23 at 22:15 +0100, Fabien Parent wrote:
> > > 'top_base' memory region is optional. Check that the resource is valid
> > > before using it. This avoid getting a "invalid resource" error message
> > > printed by the kernel.
> > >
> > > Signed-off-by: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

For the next version, please post it as a standalone patch and trim
the cc/to list.  Then I can pick it up.

Kind regards
Uffe

> > > ---
> > >  drivers/mmc/host/mtk-sd.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > > index 833ef0590af8..573aa127d00b 100644
> > > --- a/drivers/mmc/host/mtk-sd.c
> > > +++ b/drivers/mmc/host/mtk-sd.c
> > > @@ -2123,9 +2123,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
> > >       }
> > >
> > >       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > > -     host->top_base = devm_ioremap_resource(&pdev->dev, res);
> > > -     if (IS_ERR(host->top_base))
> > > -             host->top_base = NULL;
> > > +     if (ret) {
> >
> > This should be res?
>
> Indeed. Thanks, I will fix it in v2.
>
> > > +             host->top_base = devm_ioremap_resource(&pdev->dev, res);
> > > +             if (IS_ERR(host->top_base))
> > > +                     host->top_base = NULL;
> > > +     }
> > >
> > >       ret = mmc_regulator_get_supply(mmc);
> > >       if (ret)
> >
> >
