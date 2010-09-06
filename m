From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v5 3/7] wireless: wl12xx: add platform data passing support
Date: Mon, 6 Sep 2010 14:55:55 +0300
Message-ID: <AANLkTim91620+bmHWewucX5tP8Z-NUkrW2cJYJ+jpMoD@mail.gmail.com>
References: <1283376410-9999-1-git-send-email-ohad@wizery.com>
 <1283376410-9999-4-git-send-email-ohad@wizery.com> <AANLkTi=goLEUqM1XQ__PrGu4=Erw2utaNP4qFmSgRta2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=goLEUqM1XQ__PrGu4=Erw2utaNP4qFmSgRta2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Kalle Valo <kalle.valo@iki.fi>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Roger Quadros <roger.quadros@nokia.com>, Ido Yariv <ido@wizery.com>, San Mehat <san@google.com>, Chikkature Rajashekar Madhusudhan <madhu.cr@ti.com>, Luciano Coelho <luciano.coelho@nokia.com>, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

2010/9/4 Micha=B3 Miros=B3aw <mirqus@gmail.com>:
> 2010/9/1 Ohad Ben-Cohen <ohad@wizery.com>:
>> Add a simple mechanism to pass platform data to the
>> SDIO instances of wl12xx.
>>
>> This way there is no confusion over who owns the 'embedded data',
>> typechecking is preserved, and no possibility for the wrong driver t=
o
>> pick up the data.
>>
>> Originally proposed by Russell King.
>>
>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> ---
>> =A0drivers/net/wireless/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A02 +
>> =A0drivers/net/wireless/wl12xx/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A05 ++-
>> =A0drivers/net/wireless/wl12xx/wl12xx_platform_data.c | =A0 31 +++++=
+++++++++++++++
>> =A0include/linux/wl12xx.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 =A03 ++
>> =A04 files changed, 40 insertions(+), 1 deletions(-)
>> =A0create mode 100644 drivers/net/wireless/wl12xx/wl12xx_platform_da=
ta.c
>>
>> diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Ma=
kefile
>> index 5d4ce4d..85af697 100644
>> --- a/drivers/net/wireless/Makefile
>> +++ b/drivers/net/wireless/Makefile
>> @@ -50,5 +50,7 @@ obj-$(CONFIG_ATH_COMMON) =A0 =A0 =A0+=3D ath/
>> =A0obj-$(CONFIG_MAC80211_HWSIM) =A0 +=3D mac80211_hwsim.o
>>
>> =A0obj-$(CONFIG_WL12XX) =A0 +=3D wl12xx/
>> +# small builtin driver bit
>> +obj-$(CONFIG_WL12XX_PLATFORM_DATA) =A0 =A0 +=3D wl12xx/wl12xx_platf=
orm_data.o
>>
>> =A0obj-$(CONFIG_IWM) =A0 =A0 =A0+=3D iwmc3200wifi/
>> diff --git a/drivers/net/wireless/wl12xx/Kconfig b/drivers/net/wirel=
ess/wl12xx/Kconfig
>> index 2f98058..4a8bb25 100644
>> --- a/drivers/net/wireless/wl12xx/Kconfig
>> +++ b/drivers/net/wireless/wl12xx/Kconfig
>> @@ -74,4 +74,7 @@ config WL1271_SDIO
>> =A0 =A0 =A0 =A0 =A0If you choose to build a module, it'll be called
>> =A0 =A0 =A0 =A0 =A0wl1271_sdio. Say N if unsure.
>>
>> -
>> +config WL12XX_PLATFORM_DATA
>> + =A0 =A0 =A0 bool
>> + =A0 =A0 =A0 depends on WL1271_SDIO !=3D n
>> + =A0 =A0 =A0 default y
>> diff --git a/drivers/net/wireless/wl12xx/wl12xx_platform_data.c b/dr=
ivers/net/wireless/wl12xx/wl12xx_platform_data.c
>> new file mode 100644
>> index 0000000..e00973b
>> --- /dev/null
>> +++ b/drivers/net/wireless/wl12xx/wl12xx_platform_data.c
>> @@ -0,0 +1,31 @@
>> +#include <linux/module.h>
>> +#include <linux/wl12xx.h>
>> +
>> +static struct wl12xx_platform_data *platform_data;
>> +
>> +int __init wl12xx_set_platform_data(const struct wl12xx_platform_da=
ta *data)
>> +{
>> + =A0 =A0 =A0 if (platform_data)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> + =A0 =A0 =A0 if (!data)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 platform_data =3D kmemdup(data, sizeof(*data), GFP_KER=
NEL);
>> + =A0 =A0 =A0 if (!platform_data)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +int wl12xx_get_platform_data(struct wl12xx_platform_data *data)
>> +{
>> + =A0 =A0 =A0 if (!platform_data)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 =A0 if (!data)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 memcpy(data, platform_data, sizeof(*data));
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL(wl12xx_get_platform_data);
>> diff --git a/include/linux/wl12xx.h b/include/linux/wl12xx.h
>> index 137ac89..3e33ae1 100644
>> --- a/include/linux/wl12xx.h
>> +++ b/include/linux/wl12xx.h
>> @@ -31,4 +31,7 @@ struct wl12xx_platform_data {
>> =A0 =A0 =A0 =A0bool use_eeprom;
>> =A0};
>>
>> +int wl12xx_set_platform_data(const struct wl12xx_platform_data *dat=
a);
>> +int wl12xx_get_platform_data(struct wl12xx_platform_data *data);
>> +
>> =A0#endif
>
> Why do you need all that copying? Isn't the data constant?

That was the original proposal from Russell;

AFAICT it's very similar to how platform device resources are handled
- it allows marking the original definition of the data as __initdata
(need to add that) thus freeing up its space after the initialization
phase completes. Later, in some scenarios, it might also allow to free
up the copied data (not done now, but the copying happen only once in
the lifetime of the driver so I'm fine with it).

>
> Best Regards,
> Micha=B3 Miros=B3aw
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
