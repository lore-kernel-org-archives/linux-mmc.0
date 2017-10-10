From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 01/12] mmc: mediatek: add support of mt2701/mt2712
Date: Tue, 10 Oct 2017 10:09:49 +0200
Message-ID: <CAPDyKFppTCdaMizSGTjrfgsbMuHCsNi+knHVf9ibxgrAQ0GD2w@mail.gmail.com>
References: <1507604480-23246-1-git-send-email-chaotian.jing@mediatek.com>
 <1507604480-23246-2-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFrqv5tt8Exq1msUBbMEROam2c+YnStazsf5SPj-NLrGSg@mail.gmail.com> <1507620951.19789.7.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1507620951.19789.7.camel@mhfsdcap03>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Phong LE <ple-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 10 October 2017 at 09:35, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> On Tue, 2017-10-10 at 09:26 +0200, Ulf Hansson wrote:
>> [...]
>>
>> > +
>> > +static const struct of_device_id msdc_of_ids[] = {
>> > +       { .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
>> > +       { .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
>> > +       { .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
>> > +       { .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
>> > +       {}
>> > +};
>> > +MODULE_DEVICE_TABLE(of, msdc_of_ids);
>>
>> As already stated in the other reply. These new compatible changes
>> needs to be discussed and acked before the driver starts using them.
>>
>> In other words, make patch3 to precede this one.
> but, then there will have a probe issue as mentioned in previous mail
> list. that's why I separate the binding file changes to 2 patches.

That sounds seriously wrong. Aren't the bindings backwards compatible?

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
