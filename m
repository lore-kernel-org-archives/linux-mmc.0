From: Chun-Hung Wu <chun-hung.wu@mediatek.com>
Subject: Re: [PATCH 3/3] [3/3] dt-bindings: mmc: mediatek: Add document for
 mt6779
Date: Wed, 6 Nov 2019 16:07:52 +0800
Message-ID: <1573027672.2646.1.camel@mtkswgap22>
References: <1572590582-11056-1-git-send-email-chun-hung.wu@mediatek.com>
         <1572590582-11056-3-git-send-email-chun-hung.wu@mediatek.com>
         <20191106041708.GA26489@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191106041708.GA26489@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Pavel Machek <pavel@ucw.cz>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Pan Bian <bianpan2016@163.com>, Thomas Gleixner <tglx@linutronix.de>, Stanley Chu <stanley.chu@mediatek.com>, Kuohong Wang <kuohong.wang@mediatek.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, wsd_upstream@mediatek.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Rob,

  Thanks for the reply.
We will prepare another patch set to remove these tags.


On Tue, 2019-11-05 at 22:17 -0600, Rob Herring wrote:
> On Fri, Nov 01, 2019 at 02:43:02PM +0800, Chun-Hung Wu wrote:
> > Add compatible node for mt6779 mmc
> > 
> > Change-Id: Id36a136a75e892c9360ec95c7f52db06f5b308a4
> > CR-Id:
> > Feature:
> 
> Remove these tags.
> 
> > Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > index 8a532f4..0c9cf6a 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > @@ -12,6 +12,7 @@ Required properties:
> >  	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
> >  	"mediatek,mt8183-mmc": for mmc host ip compatible with mt8183
> >  	"mediatek,mt8516-mmc": for mmc host ip compatible with mt8516
> > +	"mediatek,mt6779-mmc": for mmc host ip compatible with mt6779
> >  	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
> >  	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
> >  	"mediatek,mt7622-mmc": for MT7622 SoC
> > -- 
> > 1.9.1
> > 
