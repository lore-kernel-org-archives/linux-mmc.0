From: Andreas Fenkart <afenkart@gmail.com>
Subject: Re: [PATCH v3 2/3] mmc: omap_hsmmc: Pin remux workaround to support
 SDIO interrupt on AM335x.
Date: Mon, 30 Jun 2014 14:23:42 +0200
Message-ID: <CALtMJEAqmYPy+ALO1FBGGRSvf9_cJx75hWuEB+7SowxVCa2KKg@mail.gmail.com>
References: <1384761240-11005-1-git-send-email-afenkart@gmail.com>
	<1384761240-11005-3-git-send-email-afenkart@gmail.com>
	<CAOf5uw=9KJ312PVzMVEHX-Lj=iYpeZOYFduB8iOu9o+-863CYw@mail.gmail.com>
	<CALtMJEBfeww=ymGMXWtwjtZrpqpFrkRPEOti_uPrE63SBk3Dtw@mail.gmail.com>
	<528A3EB2.1010103@ti.com>
	<20131119154909.GD10317@atomide.com>
	<528B8ADA.6030703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <528B8ADA.6030703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Michael Trimarchi <michael@amarulasolutions.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Daniel Mack <zonque@gmail.com>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

2013-11-19 16:59 GMT+01:00 Balaji T K <balajitk@ti.com>:
> On Tuesday 19 November 2013 09:19 PM, Tony Lindgren wrote:
>>
>> * Balaji T K <balajitk@ti.com> [131118 08:23]:
>>>
>>> On Monday 18 November 2013 05:45 PM, Andreas Fenkart wrote:
>>>>
>>>> 2013/11/18 Michael Trimarchi <michael@amarulasolutions.com>:
>>>>>
>>>>> On Mon, Nov 18, 2013 at 8:53 AM, Andreas Fenkart <afenkart@gmail.com>
>>>>> wrote:
>>>>>>
>>>>>>   static int omap_hsmmc_card_detect(struct device *dev, int slot)
>>>>>>   {
>>>>>>          struct omap_hsmmc_host *host = dev_get_drvdata(dev);
>>>>>> @@ -452,10 +474,25 @@ static int omap_hsmmc_gpio_init(struct
>>>>>> omap_mmc_platform_data *pdata)
>>>>>>          } else
>>>>>>                  pdata->slots[0].gpio_wp = -EINVAL;
>>>>>>
>>>>>> +       if (gpio_is_valid(pdata->slots[0].gpio_cirq)) {
>>>>>> +               pdata->slots[0].sdio_irq =
>>>>>> +
>>>>>> gpio_to_irq(pdata->slots[0].gpio_cirq);
>>>>>
>>>>>
>>>>> What is this? re-assign the platform data?
>>>>
>>>>
>>>> Seems like, I didn't pay attention to this.
>>>> Simply kept in line how the write protection/read only pins are managed.
>>>> I'd rather not change this part, or not changing it as part of adding
>>>> sdio IRQ support it.
>>>>
>>>> Maybe somebody else on the list can explain why the platform data
>>>> contains elements
>>>> that are modified during runtime.
>>>>
>>>> - set_power / get_ro function callbacks
>>>> - ocr_mask.
>>>>
>>> Hi,
>>>
>>> few params were passed via platform data in non-DT case and never cached
>>> in internal data structure, with non-dt support going away soon, I am
>>> planning to cleanup pdata usage in the driver when it gets to DT only
>>> support.
>>

any news on this?

I'd like to reuse generic mmc_of_parse, kind of difficult with the
current driver state
