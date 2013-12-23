From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v7 4/7] mmc: omap_hsmmc: adapt hsmmc to use pbias regulator
Date: Mon, 23 Dec 2013 19:12:48 +0530
Message-ID: <52B83DD8.1060402@ti.com>
References: <1387560955-6547-1-git-send-email-balajitk@ti.com> <1387560955-6547-5-git-send-email-balajitk@ti.com> <CAOf5uw=QO9ePDxQfZYpJPd9Fa4Cud54+NL2CtkJvsF5dz3MXvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45082 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138Ab3LWNm6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 23 Dec 2013 08:42:58 -0500
In-Reply-To: <CAOf5uw=QO9ePDxQfZYpJPd9Fa4Cud54+NL2CtkJvsF5dz3MXvA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>

On Friday 20 December 2013 11:45 PM, Michael Trimarchi wrote:
> Hi
>
> On Fri, Dec 20, 2013 at 6:35 PM, Balaji T K <balajitk@ti.com> wrote:
>> In DT case, PBAIS registers are programmed via regulator,
>> use regulator APIs to control PBIAS.
>>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>> ---
>>   drivers/mmc/host/omap_hsmmc.c |   39 +++++++++++++++++++++++++++++++++++++++
>>   1 files changed, 39 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 342be25..0a390f8 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -126,6 +126,10 @@
>>   #define OMAP_MMC_MAX_CLOCK     52000000
>>   #define DRIVER_NAME            "omap_hsmmc"
>>
>> +#define VDD_1V8                        1800000         /* 180000 uV */
>> +#define VDD_3V0                        3000000         /* 300000 uV */
>> +#define VDD_165_195            (ffs(MMC_VDD_165_195) - 1)
>> +
>>   /*
>>    * One controller can have multiple slots, like on some omap boards using
>>    * omap.c controller driver. Luckily this is not currently done on any known
>> @@ -164,6 +168,8 @@ struct omap_hsmmc_host {
>>           */
>>          struct  regulator       *vcc;
>>          struct  regulator       *vcc_aux;
>> +       struct  regulator       *pbias;
>> +       bool                    pbias_enabled;
>>          int                     pbias_disable;
>>          void    __iomem         *base;
>>          resource_size_t         mapbase;
>> @@ -272,6 +278,15 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
>>          if (mmc_slot(host).before_set_reg)
>>                  mmc_slot(host).before_set_reg(dev, slot, power_on, vdd);
>>
>> +       if (host->pbias) {
>> +               if (host->pbias_enabled == 1) {
>> +                       ret = regulator_disable(host->pbias);
>> +                       if (!ret)
>> +                               host->pbias_enabled = 0;
>
> you should return error?
>
>> +               }
>> +               regulator_set_voltage(host->pbias, VDD_3V0, VDD_3V0);
>> +       }
>> +
>>          /*
>>           * Assume Vcc regulator is used only to power the card ... OMAP
>>           * VDDS is used to power the pins, optionally with a transceiver to
>> @@ -306,9 +321,29 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
>>                  }
>>          }
>>
>> +       if (host->pbias) {
>> +               if (vdd <= VDD_165_195)
>> +                       ret = regulator_set_voltage(host->pbias, VDD_1V8,
>> +                                                               VDD_1V8);
>> +               else
>> +                       ret = regulator_set_voltage(host->pbias, VDD_3V0,
>> +                                                               VDD_3V0);
>> +               if (ret < 0)
>> +                       goto error_set_power;
>> +
>> +               if (host->pbias_enabled == 0) {
>> +                       ret = regulator_enable(host->pbias);
>> +                       if (!ret) {
>> +                               host->pbias_enabled = 1;
>> +                               goto error_set_power;
>
> Is this an error condition? Do you need this flag?
>
Hi,

pbias_enabled flag is used to balance regulator_enable/regulator_disable, otherwise
regulator might be kept enabled base on to use count.
