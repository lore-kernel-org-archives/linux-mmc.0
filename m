From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH v5 2/2] OMAP4 HSMMC: Adding card detect support for MMC1
 	Controller
Date: Tue, 29 Jun 2010 10:30:31 +0300
Message-ID: <4C29A117.50707@nokia.com>
References: <43584.10.24.255.17.1276788439.squirrel@dbdmail.itg.ti.com>	<4C1FB2A0.6000503@nokia.com> <AANLkTimVB7N0Oa9bDbYfSfcivy6afhvHW5Bdt-8dWVxD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <AANLkTimVB7N0Oa9bDbYfSfcivy6afhvHW5Bdt-8dWVxD@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: kishore kadiyala <kishorek.kadiyala@gmail.com>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "madhu.cr@ti.com" <madhu.cr@ti.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org

ext kishore kadiyala wrote:
> Adrian ,
> 
> Sorry for the late response
> 
> <snip>
>> As per my email 5/5/10, I would suggest the only change to omap_hsmmc is:
> 
> Agreed  and followed the changes mostly but made some more changes on top of it.
> 
> <snip>
>> And that the late init function is used to do the rest e.g.
>> find a home for these 3 functions:
> 
> I agree just having the 3 functions makes it work.
> 
>> static int omap4_twl6030_hsmmc_late_init(struct device *dev)
>> {
>>        int ret = 0;
>>        struct platform_device *pdev = container_of(dev,
>>                                        struct platform_device, dev);
>>        struct omap_mmc_platform_data *pdata = dev->platform_data;
>>
>>        /* MMC1 Card detect Configuration */
>>        if (pdev->id == 0) {
>>                ret = omap4_hsmmc1_card_detect_config();
>>                if (ret < 0)
>>                        pr_err("Unable to configure Card detect for MMC1\n");
>>                pdata->slots[0].card_detect = twl6030_mmc_card_detect;
>>                pdata->slots[0].card_detect_irq = TWL6030_IRQ_BASE +
>>                                                  MMCDETECT_INTR_OFFSET;
>>        }
>>        return ret;
> 
> <snip>
> 
> Few Comments below:
> 
> 1) In the above function, initializing "card_detect"  in the driver as
> done in omap_hsmmc_gpio_init might be more readable and this has been
> done in nongpio_init instead.
> Even having initialization of  "card_detect_irq" inside nongpio_init is fine.

The problem is that referencing twl6030 from omap_hsmmc.c is not ok.
The driver must work with any platform and that is the reason that
platform data provides callbacks.

> 
> 2)Also calling omap_hsmmc_gpio_init in case of a card detect line
> which is not GPIO
> doesn't make sense though it assigns -EINVAL to switch_pin in case of
> invalid GPIO
> which is intended for a non-removable card .
> 
> 3) And also having some thing like GPIO and NON_GPIO flag to
> distinguish might make sense.
> 
> Regards,
> Kishore
> 

