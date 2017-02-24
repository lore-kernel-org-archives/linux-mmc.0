From: Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 1/3] mmc: dt-bindings: update Mediatek MMC bindings
Date: Fri, 24 Feb 2017 17:59:36 +0800
Message-ID: <1487930376.22858.14.camel@mhfsdcap03>
References: <1484988923-1543-1-git-send-email-yong.mao@mediatek.com>
         <1484988923-1543-2-git-send-email-yong.mao@mediatek.com>
         <CAPDyKFqo7fMTp3YPJwgoa4u3iAie2U884VUfTnMQ_js8neMqTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFqo7fMTp3YPJwgoa4u3iAie2U884VUfTnMQ_js8neMqTQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Chunfeng Yun <chunfeng.yun-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Dear Rob,

Could you please help to make comments for this patch?
Thanks.

On Tue, 2017-01-24 at 09:02 +0100, Ulf Hansson wrote:
> +Rob, devicetree
> 
> On 21 January 2017 at 09:55, Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > From: yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >
> > Add description for mediatek,hs200-cmd-int-delay
> > Add description for mediatek,hs400-cmd-int-delay
> > Add description for mediatek,hs400-cmd-resp-sel-rising
> >
> > Signed-off-by: Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> You need an ack from a DT maintainer for this. I have added Rob and
> the devicetree list on cc.
> 
> Kind regards
> Uffe
> 
> > ---
> >  Documentation/devicetree/bindings/mmc/mtk-sd.txt |   12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > index 0120c7f..4182ea3 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > @@ -21,6 +21,15 @@ Optional properties:
> >  - assigned-clocks: PLL of the source clock
> >  - assigned-clock-parents: parent of source clock, used for HS400 mode to get 400Mhz source clock
> >  - hs400-ds-delay: HS400 DS delay setting
> > +- mediatek,hs200-cmd-int-delay: HS200 command internal delay setting.
> > +                               This field has total 32 stages.
> > +                               The value is an integer from 0 to 31.
> > +- mediatek,hs400-cmd-int-delay: HS400 command internal delay setting
> > +                               This field has total 32 stages.
> > +                               The value is an integer from 0 to 31.
> > +- mediatek,hs400-cmd-resp-sel-rising:  HS400 command response sample selection
> > +                                      If present,HS400 command responses are sampled on rising edges.
> > +                                      If not present,HS400 command responses are sampled on falling edges.
> >
> >  Examples:
> >  mmc0: mmc@11230000 {
> > @@ -38,4 +47,7 @@ mmc0: mmc@11230000 {
> >         assigned-clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>;
> >         assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_D2>;
> >         hs400-ds-delay = <0x14015>;
> > +       mediatek,hs200-cmd-int-delay = <26>;
> > +       mediatek,hs400-cmd-int-delay = <14>;
> > +       mediatek,hs400-cmd-resp-sel-rising;
> >  };
> > --
> > 1.7.9.5
> >


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
