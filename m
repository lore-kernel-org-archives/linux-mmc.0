From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 03/13] mmc: dt-bindings: make compatible explicit
Date: Sat, 14 Oct 2017 10:11:55 +0800
Message-ID: <1507947115.19789.16.camel@mhfsdcap03>
References: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
         <1507548926-9555-4-git-send-email-chaotian.jing@mediatek.com>
         <20171013201412.ces7ttqfwfuj4mnn@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171013201412.ces7ttqfwfuj4mnn@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Phong LE <ple-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Fri, 2017-10-13 at 15:14 -0500, Rob Herring wrote:
> On Mon, Oct 09, 2017 at 07:35:16PM +0800, Chaotian Jing wrote:
> > the driver has updated to have an explicit compatible, so update
> > binding file according to the driver change.
> 
> Normally, that's not a reason for a binding change. An old kernel 
> without the driver change is still valid.
> 
> > 
> > Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > index 3e0a97c..2bb585b 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > @@ -8,8 +8,8 @@ and the properties used by the msdc driver.
> >  
> >  Required properties:
> >  - compatible: value should be either of the following.
> > -	"mediatek,mt8173-mmc","mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
> 
> Except this one didn't really make sense. "mediatek,mt8135-mmc" should 
> be the most specific compatible on a MT8135.
> 
> > -	"mediatek,mt8173-mmc","mediatek,mt8135-mmc": for mmc host ip compatible with mt8173
> 
> Why is the version in MT8173 no longer compatible with a driver that 
> supports "mediatek,mt8135-mmc"? Your commit msg needs to answer that 
> question.

OK, will answer it in commit msg at next version.
> 
> > +	"mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
> > +	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
> >  	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
> >  	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
> >  - reg: physical base address of the controller and length
> > -- 
> > 1.8.1.1.dirty
> > 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
