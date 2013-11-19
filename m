From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v3 2/3] mmc: omap_hsmmc: Pin remux workaround to support
 SDIO interrupt on AM335x.
Date: Tue, 19 Nov 2013 21:29:22 +0530
Message-ID: <528B8ADA.6030703@ti.com>
References: <1384761240-11005-1-git-send-email-afenkart@gmail.com> <1384761240-11005-3-git-send-email-afenkart@gmail.com> <CAOf5uw=9KJ312PVzMVEHX-Lj=iYpeZOYFduB8iOu9o+-863CYw@mail.gmail.com> <CALtMJEBfeww=ymGMXWtwjtZrpqpFrkRPEOti_uPrE63SBk3Dtw@mail.gmail.com> <528A3EB2.1010103@ti.com> <20131119154909.GD10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20131119154909.GD10317@atomide.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Michael Trimarchi <michael@amarulasolutions.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Daniel Mack <zonque@gmail.com>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tuesday 19 November 2013 09:19 PM, Tony Lindgren wrote:
> * Balaji T K <balajitk@ti.com> [131118 08:23]:
>> On Monday 18 November 2013 05:45 PM, Andreas Fenkart wrote:
>>> 2013/11/18 Michael Trimarchi <michael@amarulasolutions.com>:
>>>> On Mon, Nov 18, 2013 at 8:53 AM, Andreas Fenkart <afenkart@gmail.com> wrote:
>>>>>   static int omap_hsmmc_card_detect(struct device *dev, int slot)
>>>>>   {
>>>>>          struct omap_hsmmc_host *host = dev_get_drvdata(dev);
>>>>> @@ -452,10 +474,25 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
>>>>>          } else
>>>>>                  pdata->slots[0].gpio_wp = -EINVAL;
>>>>>
>>>>> +       if (gpio_is_valid(pdata->slots[0].gpio_cirq)) {
>>>>> +               pdata->slots[0].sdio_irq =
>>>>> +                               gpio_to_irq(pdata->slots[0].gpio_cirq);
>>>>
>>>> What is this? re-assign the platform data?
>>>
>>> Seems like, I didn't pay attention to this.
>>> Simply kept in line how the write protection/read only pins are managed.
>>> I'd rather not change this part, or not changing it as part of adding
>>> sdio IRQ support it.
>>>
>>> Maybe somebody else on the list can explain why the platform data
>>> contains elements
>>> that are modified during runtime.
>>>
>>> - set_power / get_ro function callbacks
>>> - ocr_mask.
>>>
>> Hi,
>>
>> few params were passed via platform data in non-DT case and never cached
>> in internal data structure, with non-dt support going away soon, I am
>> planning to cleanup pdata usage in the driver when it gets to DT only support.
>
> The issue of pdata tinkering needs to be fixed first as it will cause nasty
> issues when the module is reprobed.

Agree that pdata usage needs to be fixed, but currently module
reprobe is working fine.

>
> Note that it's still possible to pass platform data in the device tree case
> as auxdata. And we probably need to do that for the pbias register handling
> until we have a driver for that.
>
> Talking of the pbias driver, any news on it?

Almost there, will post the patches soon.
Do you have a branch with updated board files, for me to base pbias patches on
else I can base the patches on rc1 too.

>
> To recap, we basically we need a minimal separate driver that exposes the
> control module pbias register as a regulator to the hsmmc driver. I don't see
> that we can remove the platform data from the driver before that's done.
>
> Regards,
>
> Tony
>
