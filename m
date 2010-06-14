From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 2/2 RE-SEND] ARM: S5PV210: Add support HSMMC on Samsung
	SMDKV210
Date: Mon, 14 Jun 2010 16:58:51 +0900
Message-ID: <009c01cb0b97$7265ea00$5731be00$%kim@samsung.com>
References: <1276499983-19463-1-git-send-email-kgene.kim@samsung.com>
 <AANLkTin-IvzeY3QDMskm-G6QWFqddppdYrrkEBldGGsN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <AANLkTin-IvzeY3QDMskm-G6QWFqddppdYrrkEBldGGsN@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Kyungmin Park' <kmpark@infradead.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, 'Lee Hyuk' <hyuk1.lee@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Kyungmin Park wrote:
> 
> Hi
> 
Hi, :-)

> On Mon, Jun 14, 2010 at 4:19 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > From: Lee Hyuk <hyuk1.lee@samsung.com>
> >
> > This patch adds support HSMMC on Samsung SMDKV210, and gpio
> configuration for
> > S5PV210 hsmmc3.
> >
> > Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> >
> > Changes since previous patch:
> >
> > - Adding missed call s5pv210_default_sdhci3() in s5pv210_map_io()
> >
> >  arch/arm/mach-s5pv210/Kconfig            |    5 +++++
> >  arch/arm/mach-s5pv210/cpu.c              |    1 +
> >  arch/arm/mach-s5pv210/include/mach/map.h |    1 +
> >  arch/arm/mach-s5pv210/mach-smdkv210.c    |    4 ++++
> >  arch/arm/mach-s5pv210/setup-sdhci-gpio.c |   20 ++++++++++++++++++++
> >  5 files changed, 31 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-s5pv210/Kconfig
b/arch/arm/mach-s5pv210/Kconfig
> > index 0761eac..6aee967 100644
> > --- a/arch/arm/mach-s5pv210/Kconfig
> > +++ b/arch/arm/mach-s5pv210/Kconfig
> > @@ -72,9 +72,14 @@ config MACH_SMDKV210
> >        select CPU_S5PV210
> >        select ARCH_SPARSEMEM_ENABLE
> >        select SAMSUNG_DEV_ADC
> > +       select S3C_DEV_HSMMC
> > +       select S3C_DEV_HSMMC1
> > +       select S3C_DEV_HSMMC2
> > +       select S3C_DEV_HSMMC3
> >        select SAMSUNG_DEV_TS
> >        select S3C_DEV_WDT
> >        select HAVE_S3C2410_WATCHDOG
> > +       select S5PV210_SETUP_SDHCI
> >        help
> >          Machine support for Samsung SMDKV210
> >
> > diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
> > index 411a4a9..765034e 100644
> > --- a/arch/arm/mach-s5pv210/cpu.c
> > +++ b/arch/arm/mach-s5pv210/cpu.c
> > @@ -86,6 +86,7 @@ void __init s5pv210_map_io(void)
> >        s5pv210_default_sdhci0();
> >        s5pv210_default_sdhci1();
> >        s5pv210_default_sdhci2();
> > +       s5pv210_default_sdhci3();
> >
> >        /* the i2c devices are directly compatible with s3c2440 */
> >        s3c_i2c0_setname("s3c2440-i2c");
> > diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-
> s5pv210/include/mach/map.h
> > index 34eb168..fa9d7c2 100644
> > --- a/arch/arm/mach-s5pv210/include/mach/map.h
> > +++ b/arch/arm/mach-s5pv210/include/mach/map.h
> > @@ -97,6 +97,7 @@
> >  #define S3C_PA_HSMMC0          S5PV210_PA_HSMMC(0)
> >  #define S3C_PA_HSMMC1          S5PV210_PA_HSMMC(1)
> >  #define S3C_PA_HSMMC2          S5PV210_PA_HSMMC(2)
> > +#define S3C_PA_HSMMC3          S5PV210_PA_HSMMC(3)
> >  #define S3C_PA_IIC             S5PV210_PA_IIC0
> >  #define S3C_PA_IIC1            S5PV210_PA_IIC1
> >  #define S3C_PA_IIC2            S5PV210_PA_IIC2
> > diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-
> s5pv210/mach-smdkv210.c
> > index 0d46279..b08f376 100644
> > --- a/arch/arm/mach-s5pv210/mach-smdkv210.c
> > +++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
> > @@ -77,6 +77,10 @@ static struct platform_device *smdkv210_devices[]
> __initdata = {
> >        &s5pv210_device_iis0,
> >        &s5pv210_device_ac97,
> >        &s3c_device_adc,
> > +       &s3c_device_hsmmc0,
> > +       &s3c_device_hsmmc1,
> > +       &s3c_device_hsmmc2,
> > +       &s3c_device_hsmmc3,
> >        &s3c_device_ts,
> >        &s3c_device_wdt,
> >  };
> > diff --git a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c b/arch/arm/mach-
> s5pv210/setup-sdhci-gpio.c
> > index fe7d86d..415f62c 100644
> > --- a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
> > +++ b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
> > @@ -102,3 +102,23 @@ void s5pv210_setup_sdhci2_cfg_gpio(struct
> platform_device *dev, int width)
> >        s3c_gpio_setpull(S5PV210_GPG2(2), S3C_GPIO_PULL_UP);
> >        s3c_gpio_cfgpin(S5PV210_GPG2(2), S3C_GPIO_SFN(2));
> >  }
> > +
> > +void s5pv210_setup_sdhci3_cfg_gpio(struct platform_device *dev, int
width)
> > +{
> > +       unsigned int gpio;
> > +
> > +       /* Set all the necessary GPG1[0:2] pins to special-function 2 */
> 
> Wrong pin name, GPG3?
> 
OK.

> > +       for (gpio = S5PV210_GPG3(0); gpio < S5PV210_GPG3(2); gpio++) {
> > +               s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> > +               s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> > +       }
> > +
> > +       /* Data pin GPG1[3:6] to special-function 2 */
> ditto

OK.

> > +       for (gpio = S5PV210_GPG3(3); gpio <= S5PV210_GPG3(6); gpio++) {
> > +               s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> > +               s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> > +       }
> > +
> > +       s3c_gpio_setpull(S5PV210_GPG3(2), S3C_GPIO_PULL_UP);
> > +       s3c_gpio_cfgpin(S5PV210_GPG3(2), S3C_GPIO_SFN(2));
> 
> In case of this, how about to use one loop like this.
> 
> for (gpio = GPG3(0); gpio <= GPG3(7); gpio++)
>     s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> 
> since all pins use special function 2.
> 
> or others methods are welcome.
> 

Yeah, you're right.
But used same method of s5pv210_sdhci0_cfg_gpio(), sdhci1_xxx(), and
sdhci2_xxx() from Marek.

If necessary, will modify later with others.

> To Ben,
> When do you apply previous gpio helper functions?
> 
What's the previous gpio helper functions for?


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
