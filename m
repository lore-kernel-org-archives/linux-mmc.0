From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH] sdhci-s3c: support non-standard clock setting for c210
Date: Thu, 2 Sep 2010 19:32:38 +0900
Message-ID: <AANLkTik7RV8nSxPb4NQ+D3n6C_bO6L=WZvfd==7u3fJO@mail.gmail.com>
References: <4C7CDA39.1020907@samsung.com>
	<005101cb4a88$7283d080$578b7180$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37738 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab0IBKck convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Sep 2010 06:32:40 -0400
Received: by wwj40 with SMTP id 40so626939wwj.1
        for <linux-mmc@vger.kernel.org>; Thu, 02 Sep 2010 03:32:38 -0700 (PDT)
In-Reply-To: <005101cb4a88$7283d080$578b7180$%kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, matt@console-pimps.org, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>

On Thu, Sep 2, 2010 at 7:20 PM, Kukjin Kim <kgene.kim@samsung.com> wrot=
e:
> Jaehoon Chung wrote:
>>
>> This is sdhci-s3c patch for c210.
>> c210 didn't use divider of host controller.
>>
>> Host Controller need other clock setting methods.
>>
>> So I add the callback functions for s5pc210.
>> also I set 400KHz for initial clock.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> =A0Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>
>> ---
>> =A0arch/arm/plat-samsung/include/plat/sdhci.h | =A0 19 ++++++++
>> =A0drivers/mmc/host/sdhci-s3c.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 68
>> ++++++++++++++++++++++++++++
>> =A02 files changed, 87 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/p=
lat-
>> samsung/include/plat/sdhci.h
>> index 30844c2..7c75ee3 100644
>> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
>> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
>> @@ -15,6 +15,8 @@
>> =A0#ifndef __PLAT_S3C_SDHCI_H
>> =A0#define __PLAT_S3C_SDHCI_H __FILE__
>>
>> +#include <plat/devs.h>
>> +
>> =A0struct platform_device;
>> =A0struct mmc_host;
>> =A0struct mmc_card;
>> @@ -288,4 +290,21 @@ static inline void s5pv210_default_sdhci3(void)=
 { }
>>
>> =A0#endif /* CONFIG_S5PV210_SETUP_SDHCI */
>>
>> +/* re-define device name depending on support. */
>> +static inline void s3c_hsmmc_setname(char *name)
>> +{
>> +#ifdef CONFIG_S3C_DEV_HSMMC
>> + =A0 =A0 s3c_device_hsmmc0.name =3D name;
>> +#endif
>> +#ifdef CONFIG_S3C_DEV_HSMMC1
>> + =A0 =A0 s3c_device_hsmmc1.name =3D name;
>> +#endif
>> +#ifdef CONFIG_S3C_DEV_HSMMC2
>> + =A0 =A0 s3c_device_hsmmc2.name =3D name;
>> +#endif
>> +#ifdef CONFIG_S3C_DEV_HSMMC3
>> + =A0 =A0 s3c_device_hsmmc3.name =3D name;
>> +#endif
>> +}
>> +
>> =A0#endif /* __PLAT_S3C_SDHCI_H */
>
> It would be helpful to me if you could separate platform and driver p=
atches.
> And if you want to add s3c_hsmmc_setname(), please send together code=
 that
> it is used.
>
>> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s=
3c.c
>> index 71ad416..3927793 100644
>> --- a/drivers/mmc/host/sdhci-s3c.c
>> +++ b/drivers/mmc/host/sdhci-s3c.c
>> @@ -52,6 +52,11 @@ struct sdhci_s3c {
>> =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clk_bus[MAX_BUS_C=
LK];
>> =A0};
>>
>> +enum soc_type {
>> + =A0 =A0 TYPE_SAMSUNG, =A0 /* S5PC1XX, S3C... */
>> + =A0 =A0 TYPE_S5PC210, =A0 /* S5PC210 */
>> +};
>> +
>> =A0static inline struct sdhci_s3c *to_s3c(struct sdhci_host *host)
>> =A0{
>> =A0 =A0 =A0 return sdhci_priv(host);
>> @@ -232,6 +237,52 @@ static unsigned int sdhci_s3c_get_min_clock(str=
uct
>> sdhci_host *host)
>> =A0 =A0 =A0 return min;
>> =A0}
>>
>> +/**
>> +* sdhci_s3c_get_max_clk - callback to get maximum clock frequency.
>> +*/
>> +static unsigned int sdhci_s5pc210_get_max_clock(struct sdhci_host *=
host)
>> +{
>> + =A0 =A0 struct sdhci_s3c *ourhost =3D to_s3c(host);
>> + =A0 =A0 unsigned int rate;
>> + =A0 =A0 int ptr =3D ourhost->cur_clk;
>> +
>> + =A0 =A0 rate =3D clk_round_rate(ourhost->clk_bus[ptr], UINT_MAX);
>> +
>> + =A0 =A0 return rate;
>> +}
>> +
>> +/**
>> + * sdhci_s3c_get_min_clock - callback to get minimal supported cloc=
k
> value
>> +*/
>> +static unsigned int sdhci_s5pc210_get_min_clock(struct sdhci_host *=
host)
>> +{
>> + =A0 =A0 struct sdhci_s3c *ourhost =3D to_s3c(host);
>> + =A0 =A0 unsigned int rate;
>> + =A0 =A0 int ptr =3D ourhost->cur_clk;
>> +
>> + =A0 =A0 rate =3D clk_round_rate(ourhost->clk_bus[ptr], 400000);
>> +
>> + =A0 =A0 return rate;
>> +}
>> +
>> +/**
>> + * sdhci_s5pc210_set_clock - callback on clock change
>> +*/
>> +static void sdhci_s5pc210_set_clock(struct sdhci_host *host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int clock)
>> +{
>> + =A0 =A0 struct sdhci_s3c *ourhost =3D to_s3c(host);
>> +
>> + =A0 =A0 if (clock =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 sdhci_s3c_set_clock(host, clock);
>> +
>> + =A0 =A0 clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
>> +
>> + =A0 =A0 host->clock =3D clock;
>> +}
>> +
>> =A0static struct sdhci_ops sdhci_s3c_ops =3D {
>> =A0 =A0 =A0 .get_max_clock =A0 =A0 =A0 =A0 =A0=3D sdhci_s3c_get_max_=
clk,
>> =A0 =A0 =A0 .set_clock =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D sdhci_s3c_set_=
clock,
>> @@ -395,6 +446,12 @@ static int __devinit sdhci_s3c_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 host->quirks =3D 0;
>> =A0 =A0 =A0 host->irq =3D irq;
>>
>> + =A0 =A0 if (pdev->id_entry->driver_data =3D=3D TYPE_S5PC210) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_s3c_ops.set_clock =3D sdhci_s5pc210_=
set_clock;
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_s3c_ops.get_min_clock =3D sdhci_s5pc=
210_get_min_clock;
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_s3c_ops.get_max_clock =3D sdhci_s5pc=
210_get_max_clock;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 /* Setup quirks for the controller */
>> =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
>> =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_NO_HISPD_BIT;
>> @@ -520,6 +577,16 @@ static int sdhci_s3c_resume(struct platform_dev=
ice
> *dev)
>> =A0#define sdhci_s3c_resume NULL
>> =A0#endif
>>
>> +static struct platform_device_id sdhci_driver_ids[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "s3c-sdhci",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =A0 =A0=3D TYPE_SAMSUNG,
>> + =A0 =A0 }, {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "s5pc210-sdh=
ci",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =A0 =A0=3D TYPE_S5PC210,
>> + =A0 =A0 }, { },
>> +};
>> +
>> =A0static struct platform_driver sdhci_s3c_driver =3D {
>> =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D sdhci_s3c_probe,
>> =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(sdhci_s3c_remove=
),
>> @@ -529,6 +596,7 @@ static struct platform_driver sdhci_s3c_driver =3D=
 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "s3c-sdhci",
>> =A0 =A0 =A0 },
>> + =A0 =A0 .id_table =A0 =A0 =A0 =3D sdhci_driver_ids,
>> =A0};
>>
>> =A0static int __init sdhci_s3c_init(void)
>> -- 1.6.0.4
>
> How do you think about using quirk to separate S5PV310 case as follow=
ing?
> I think this is more general method in here...And will be submitted s=
oon
> after fixing something.
What's the meaning of "general method"?

and how/where do you set the host->quirks? when board or platform set
the these quirks? who know it uses nonstandard quirk?
In case s5pc210 don't have standard host controller. it's more clear
to use own functions instead of quirks.

>
> From: Hyuk Lee <hyuk1.lee@samsung.com>
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3=
c.c
> index 71ad416..1ac2f36 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -96,6 +96,11 @@ static unsigned int sdhci_s3c_get_max_clk(struct
> sdhci_host *host)
> =A0 =A0 =A0 =A0unsigned int rate, max;
> =A0 =A0 =A0 =A0int clk;
>
> + =A0 =A0 =A0 /* There is only one clock source(sclk) if there is no =
clock divider
> + =A0 =A0 =A0 =A0* in the host controller */
> + =A0 =A0 =A0 if(host->quirks & SDHCI_QUIRK_BROKEN_CLOCK_DIVIDER)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return clk_round_rate(ourhost->clk_bus[=
ourhost->cur_clk],
> UINT_MAX);
> +
> =A0 =A0 =A0 =A0/* note, a reset will reset the clock source */
>
> =A0 =A0 =A0 =A0sdhci_s3c_check_sclk(host);
> @@ -130,6 +135,11 @@ static unsigned int sdhci_s3c_consider_clock(str=
uct
> sdhci_s3c *ourhost,
> =A0 =A0 =A0 =A0if (!clksrc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return UINT_MAX;
>
> + =A0 =A0 =A0 if(ourhost->host->quirks & SDHCI_QUIRK_BROKEN_CLOCK_DIV=
IDER) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rate =3D clk_round_rate(clksrc,wanted);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return (wanted - rate);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0rate =3D clk_get_rate(clksrc);
>
> =A0 =A0 =A0 =A0for (div =3D 1; div < 256; div *=3D 2) {
> @@ -159,6 +169,7 @@ static void sdhci_s3c_set_clock(struct sdhci_host=
 *host,
> unsigned int clock)
> =A0 =A0 =A0 =A0int best_src =3D 0;
> =A0 =A0 =A0 =A0int src;
> =A0 =A0 =A0 =A0u32 ctrl;
> + =A0 =A0 =A0 unsigned int timeout;
>
> =A0 =A0 =A0 =A0/* don't bother if the clock is going off. */
> =A0 =A0 =A0 =A0if (clock =3D=3D 0)
> @@ -204,6 +215,31 @@ static void sdhci_s3c_set_clock(struct sdhci_hos=
t
> *host, unsigned int clock)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(ourhost->pdata->cfg_c=
ard)(ourhost->pdev,
> host->ioaddr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &ios, NULL);
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 if(host->quirks & SDHCI_QUIRK_BROKEN_CLOCK_DIVIDER) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(0, host->ioaddr + SDHCI_CLOCK_CO=
NTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_set_rate(ourhost->clk_bus[ourhost->=
cur_clk], clock);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(SDHCI_CLOCK_INT_EN, host->ioaddr=
 +
> SDHCI_CLOCK_CONTROL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Wait max 20 ms */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D 20;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!((sdhci_readw(host, SDHCI_CLOCK=
_CONTROL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & SDHCI_CLOCK_INT_STABL=
E)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (timeout =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(=
KERN_ERR "%s: Internal clock never "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "stabilised.\n",
> mmc_hostname(host->mmc));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(SDHCI_CLOCK_INT_EN | SDHCI_CLOCK=
_CARD_EN,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->i=
oaddr + SDHCI_CLOCK_CONTROL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->clock =3D clock;
> + =A0 =A0 =A0 }
> =A0}
>
> =A0/**
> @@ -221,6 +257,11 @@ static unsigned int sdhci_s3c_get_min_clock(stru=
ct
> sdhci_host *host)
> =A0 =A0 =A0 =A0unsigned int delta, min =3D UINT_MAX;
> =A0 =A0 =A0 =A0int src;
>
> + =A0 =A0 =A0 /* There is only one clock source(sclk) if there is no =
clock divider
> + =A0 =A0 =A0 =A0* in the host controller */
> + =A0 =A0 =A0 if(host->quirks & SDHCI_QUIRK_BROKEN_CLOCK_DIVIDER)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return clk_round_rate(ourhost->clk_bus[=
2], 400000);
what's the clk_bus[2]?

Thank you,
Kyungmin Park
> +
> =A0 =A0 =A0 =A0for (src =3D 0; src < MAX_BUS_CLK; src++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0delta =3D sdhci_s3c_consider_clock(our=
host, src, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (delta =3D=3D UINT_MAX)
>
> ...
>
>
> Thanks.
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
