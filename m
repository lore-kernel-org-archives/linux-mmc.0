From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH] sdhci-s3c: support non-standard clock setting for c210
Date: Thu, 2 Sep 2010 20:01:06 +0900
Message-ID: <AANLkTikqs9KV60EBUJr_4Cqn38m7gQw25ATXt8c7=2GY@mail.gmail.com>
References: <4C7CDA39.1020907@samsung.com>
	<005101cb4a88$7283d080$578b7180$%kim@samsung.com>
	<AANLkTik7RV8nSxPb4NQ+D3n6C_bO6L=WZvfd==7u3fJO@mail.gmail.com>
	<005301cb4a8c$38844320$a98cc960$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57155 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900Ab0IBLBH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Sep 2010 07:01:07 -0400
Received: by wyb35 with SMTP id 35so124380wyb.19
        for <linux-mmc@vger.kernel.org>; Thu, 02 Sep 2010 04:01:06 -0700 (PDT)
In-Reply-To: <005301cb4a8c$38844320$a98cc960$%kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, matt@console-pimps.org, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org

On Thu, Sep 2, 2010 at 7:47 PM, Kukjin Kim <kgene.kim@samsung.com> wrot=
e:
> Kyungmin Park wrote:
>>
>> On Thu, Sep 2, 2010 at 7:20 PM, Kukjin Kim <kgene.kim@samsung.com> w=
rote:
>> > Jaehoon Chung wrote:
>> >>
>> >> This is sdhci-s3c patch for c210.
>> >> c210 didn't use divider of host controller.
>> >>
>> >> Host Controller need other clock setting methods.
>> >>
>> >> So I add the callback functions for s5pc210.
>> >> also I set 400KHz for initial clock.
>> >>
>> >> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> >> =A0Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> =A0 ^^^
> Unnecessary whitespace
>
> If your patch includes arch/arm stuff, please add Linux-arm-kernel
> maillinglist.
> (Cc'ed that)
>
>> >>
>> >> ---
>> >> =A0arch/arm/plat-samsung/include/plat/sdhci.h | =A0 19 ++++++++
>> >> =A0drivers/mmc/host/sdhci-s3c.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 68
>> >> ++++++++++++++++++++++++++++
>> >> =A02 files changed, 87 insertions(+), 0 deletions(-)
>> >>
>> >> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h
> b/arch/arm/plat-
>> >> samsung/include/plat/sdhci.h
>> >> index 30844c2..7c75ee3 100644
>> >> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
>> >> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
>> >> @@ -15,6 +15,8 @@
>> >> =A0#ifndef __PLAT_S3C_SDHCI_H
>> >> =A0#define __PLAT_S3C_SDHCI_H __FILE__
>> >>
>> >> +#include <plat/devs.h>
>> >> +
>> >> =A0struct platform_device;
>> >> =A0struct mmc_host;
>> >> =A0struct mmc_card;
>> >> @@ -288,4 +290,21 @@ static inline void s5pv210_default_sdhci3(vo=
id) {
> }
>> >>
>> >> =A0#endif /* CONFIG_S5PV210_SETUP_SDHCI */
>> >>
>> >> +/* re-define device name depending on support. */
>> >> +static inline void s3c_hsmmc_setname(char *name)
>> >> +{
>> >> +#ifdef CONFIG_S3C_DEV_HSMMC
>> >> + =A0 =A0 s3c_device_hsmmc0.name =3D name;
>> >> +#endif
>> >> +#ifdef CONFIG_S3C_DEV_HSMMC1
>> >> + =A0 =A0 s3c_device_hsmmc1.name =3D name;
>> >> +#endif
>> >> +#ifdef CONFIG_S3C_DEV_HSMMC2
>> >> + =A0 =A0 s3c_device_hsmmc2.name =3D name;
>> >> +#endif
>> >> +#ifdef CONFIG_S3C_DEV_HSMMC3
>> >> + =A0 =A0 s3c_device_hsmmc3.name =3D name;
>> >> +#endif
>> >> +}
>> >> +
>> >> =A0#endif /* __PLAT_S3C_SDHCI_H */
>> >
>> > It would be helpful to me if you could separate platform and drive=
r
> patches.
>> > And if you want to add s3c_hsmmc_setname(), please send together c=
ode
> that
>> > it is used.
>> >
>> >> diff --git a/drivers/mmc/host/sdhci-s3c.c
> b/drivers/mmc/host/sdhci-s3c.c
>> >> index 71ad416..3927793 100644
>> >> --- a/drivers/mmc/host/sdhci-s3c.c
>> >> +++ b/drivers/mmc/host/sdhci-s3c.c
>
> (snip)
>
>> >
>> > How do you think about using quirk to separate S5PV310 case as
> following?
>> > I think this is more general method in here...And will be submitte=
d soon
>> > after fixing something.
>> What's the meaning of "general method"?
>>
> I'd like to ask you why there is quirk in sdmmc driver.
>
>> and how/where do you set the host->quirks? when board or platform se=
t
>> the these quirks? who know it uses nonstandard quirk?
>
> How about following?
>
> static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
> ...
> + =A0 =A0 =A0 if (pdev->id_entry->driver_data =3D=3D TYPE_S5PV310)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_BROKEN_CL=
OCK_DIVIDER;

What's the difference override the functions?

> ...
>
>> In case s5pc210 don't have standard host controller. it's more clear
>> to use own functions instead of quirks.
>>
> Why do we add another callback function?

It's override functions. See the patch posted.

Usually you insist use your code. then send it early to mailing list
and get the feedback.

Thank you,
Kyungmin Park

>
>> >
>> > From: Hyuk Lee <hyuk1.lee@samsung.com>
>> >
>> > diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci=
-s3c.c
>> > index 71ad416..1ac2f36 100644
>> > --- a/drivers/mmc/host/sdhci-s3c.c
>> > +++ b/drivers/mmc/host/sdhci-s3c.c
>
> (snip)
>
>> > @@ -221,6 +257,11 @@ static unsigned int sdhci_s3c_get_min_clock(s=
truct
>> > sdhci_host *host)
>> > =A0 =A0 =A0 =A0unsigned int delta, min =3D UINT_MAX;
>> > =A0 =A0 =A0 =A0int src;
>> >
>> > + =A0 =A0 =A0 /* There is only one clock source(sclk) if there is =
no clock
> divider
>> > + =A0 =A0 =A0 =A0* in the host controller */
>> > + =A0 =A0 =A0 if(host->quirks & SDHCI_QUIRK_BROKEN_CLOCK_DIVIDER)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return clk_round_rate(ourhost->clk_b=
us[2], 400000);
>> what's the clk_bus[2]?
>>
> Should be clk_bus[ourhost->cur_clk]
>
> (snip)
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
