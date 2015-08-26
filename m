From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 16/16] mmc: host: omap_hsmmc: use "mmc_of_parse_voltage"
 to get ocr_avail
Date: Wed, 26 Aug 2015 17:51:12 +0530
Message-ID: <55DDAF38.4040502@ti.com>
References: <1438604801-11823-1-git-send-email-kishon@ti.com>	<1438604801-11823-17-git-send-email-kishon@ti.com> <CAPDyKFoctSjBb0aPFNe0cyHe0uoD_DkWooQ-yyTX-P+bGJa_Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoctSjBb0aPFNe0cyHe0uoD_DkWooQ-yyTX-P+bGJa_Vw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Roger Quadros <rogerq@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On Tuesday 25 August 2015 08:20 PM, Ulf Hansson wrote:
> On 3 August 2015 at 14:26, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> From: Roger Quadros <rogerq@ti.com>
>>
>> For platforms that doesn't have explicit regulator control in MMC,
>> populate voltage-ranges in MMC device tree node and use
>> mmc_of_parse_voltage to get ocr_avail
> 
> I don't like this.
> 
> If we are able to fetch the OCR mask via an external regulator, that
> shall be done.
> 
> I think the mmc_of_parse_voltage() API and the corresponding DT
> binding it parses, should be used for those HW when we don't have an
> external regulator to use. For example if the MMC controller itself
> somehow controls the voltage levels. Is that really the case for you?

This was actually added to support Galileo platform which doesn't have
regulators modelled. Indeed it would be better to model external
regulators (even if it is always on) and get OCR from the regulator.

I'll drop this patch and re-send the series re-based to your next branch.

Thanks
Kishon

> 
> Kind regards
> Uffe
> 
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    2 ++
>>  drivers/mmc/host/omap_hsmmc.c                      |    9 ++++++++-
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> index 76bf087..2408e87 100644
>> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> @@ -22,6 +22,8 @@ ti,dual-volt: boolean, supports dual voltage cards
>>  ti,non-removable: non-removable slot (like eMMC)
>>  ti,needs-special-reset: Requires a special softreset sequence
>>  ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
>> +voltage-ranges: Specify the voltage range supported if regulator framework
>> +isn't enabled.
>>  dmas: List of DMA specifiers with the controller specific format
>>  as described in the generic DMA client binding. A tx and rx
>>  specifier is required.
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 15973f1..d884d8f 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -2184,7 +2184,13 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>>                         goto err_irq;
>>         }
>>
>> -       mmc->ocr_avail = mmc_pdata(host)->ocr_mask;
>> +       if (!mmc_pdata(host)->ocr_mask) {
>> +               ret = mmc_of_parse_voltage(pdev->dev.of_node, &mmc->ocr_avail);
>> +               if (ret)
>> +                       goto err_parse_voltage;
>> +       } else {
>> +               mmc->ocr_avail = mmc_pdata(host)->ocr_mask;
>> +       }
>>
>>         omap_hsmmc_disable_irq(host);
>>
>> @@ -2224,6 +2230,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>>
>>  err_slot_name:
>>         mmc_remove_host(mmc);
>> +err_parse_voltage:
>>         omap_hsmmc_reg_put(host);
>>  err_irq:
>>         device_init_wakeup(&pdev->dev, false);
>> --
>> 1.7.9.5
>>
