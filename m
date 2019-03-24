From: Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH 09/24] mmc: mtk-sd: check for valid optional memory resource
Date: Sun, 24 Mar 2019 16:18:45 +0100
Message-ID: <CAOwMV_zkHMZv8y_8C9kRCUsPtSbm+vPkJUNzU-_LK5=OhTkiPw@mail.gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-10-fparent@baylibre.com>
 <1553398466.26628.0.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553398466.26628.0.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, ryder.lee@mediatek.com, linux-watchdog@vger.kernel.org, jjian.zhou@mediatek.com, wenzhen.yu@mediatek.com, Stephane Le Provost <stephane.leprovost@mediatek.com>, sean.wang@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, yong.mao@mediatek.com, linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org, hsin-hsiung.wang@mediatek.com, linux-serial@vger.kernel.org, linux-clk@vger.kernel.org, Chaotian Jing <chaotian.jing@mediatek.com>, linux-i2c@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Sun, Mar 24, 2019 at 4:34 AM Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
>
> On Sat, 2019-03-23 at 22:15 +0100, Fabien Parent wrote:
> > 'top_base' memory region is optional. Check that the resource is valid
> > before using it. This avoid getting a "invalid resource" error message
> > printed by the kernel.
> >
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >  drivers/mmc/host/mtk-sd.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index 833ef0590af8..573aa127d00b 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -2123,9 +2123,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
> >       }
> >
> >       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > -     host->top_base = devm_ioremap_resource(&pdev->dev, res);
> > -     if (IS_ERR(host->top_base))
> > -             host->top_base = NULL;
> > +     if (ret) {
>
> This should be res?

Indeed. Thanks, I will fix it in v2.

> > +             host->top_base = devm_ioremap_resource(&pdev->dev, res);
> > +             if (IS_ERR(host->top_base))
> > +                     host->top_base = NULL;
> > +     }
> >
> >       ret = mmc_regulator_get_supply(mmc);
> >       if (ret)
>
>
