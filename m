From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 2/2] mmc: meson-gx: add device reset
Date: Wed, 30 May 2018 11:47:34 +0200
Message-ID: <1527673654.10642.18.camel@baylibre.com>
References: <20180515095748.6794-1-jbrunet@baylibre.com>
         <20180515095748.6794-3-jbrunet@baylibre.com>
         <CAPDyKFo1ui3XyjXJt0JKrQZd52zEQfsY65LbK_exFqJ6jVDmCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFo1ui3XyjXJt0JKrQZd52zEQfsY65LbK_exFqJ6jVDmCQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 2018-05-30 at 09:27 +0200, Ulf Hansson wrote:
> Jerome,
> 
> On 15 May 2018 at 11:57, Jerome Brunet <jbrunet@baylibre.com> wrote:
> > Trigger the reset line of the mmc controller while probing, if available.
> > The reset should be optional for now, at least until all related DT nodes
> > have the reset property.
> > 
> > Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> 
> I got a regression boot report from kernelci. The bisect doesn't point
> to a certain commit, but I found $subject patch a possible cause. Is
> it something you can have a look at and see if it's a valid problem?
> https://kernelci.org/boot/id/5b0d68a859b514726179a899/

Hi Ulf,

Looking at the log, there is an "un-explained" power reset in the middle of the
boot sequence.  With the maintainer of this lab, we have been over the logs of
this board and we have seen several other power reset at different stages. There
is no trace, error or warning, the board just resets. A few other boards show
the same issue in this lab ATM.

There has been some work done in this lab lately and we suspect a problem with
the relays controlling the power supplies. We have taken this board offline
until the problem is solved.

Thanks for reporting the problem.

Regards
Jerome


> 
> Kind regards
> Uffe
> 
> > ---
> >  drivers/mmc/host/meson-gx-mmc.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> > index 4f972b879fe6..9bca359f7936 100644
> > --- a/drivers/mmc/host/meson-gx-mmc.c
> > +++ b/drivers/mmc/host/meson-gx-mmc.c
> > @@ -35,6 +35,7 @@
> >  #include <linux/clk.h>
> >  #include <linux/clk-provider.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/reset.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/pinctrl/consumer.h>
> > @@ -1184,6 +1185,14 @@ static int meson_mmc_probe(struct platform_device *pdev)
> >                 goto free_host;
> >         }
> > 
> > +       ret = device_reset_optional(&pdev->dev);
> > +       if (ret) {
> > +               if (ret != -EPROBE_DEFER)
> > +                       dev_err(&pdev->dev, "device reset failed: %d\n", ret);
> > +
> > +               return ret;
> > +       }
> > +
> >         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >         host->regs = devm_ioremap_resource(&pdev->dev, res);
> >         if (IS_ERR(host->regs)) {
> > --
> > 2.14.3
> > 
