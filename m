From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Add support for Erratum 2.1.1.128 in
 device tree boot
Date: Wed, 5 Feb 2014 19:40:34 +0530
Message-ID: <52F2465A.6060804@ti.com>
References: <1390260542-22213-1-git-send-email-nm@ti.com> <52F0E098.3050404@ti.com> <52F104B7.6040606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44345 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbaBEOLZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 Feb 2014 09:11:25 -0500
In-Reply-To: <52F104B7.6040606@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Chris Ball <chris@printf.net>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 04 February 2014 08:48 PM, Nishanth Menon wrote:
> On 02/04/2014 06:44 AM, Balaji T K wrote:
>> On Tuesday 21 January 2014 04:59 AM, Nishanth Menon wrote:
>>> When device is booted using devicetree, platforms impacted by
>>> Erratum 2.1.1.128 is not detected easily in the mmc driver. This erratum
>>> indicates that the module cannot do multi-block transfers.
>>>
>>> Handle this by providing a boolean flag to indicate to driver that it is
>>> working on a hardware with mentioned limitation.
>>>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> ---
>>>
>>> This explains the logs I see:
>>> OMAP3430 LDP (ES2.2):
>>> 	uImage only boot:  http://slexy.org/raw/s2YrbMAi7c
>>> 	uImage+dtb concatenated boot: http://slexy.org/raw/s20qVg17T0
>>>
>>> With the following flag set, device is now able to consistently boot with
>>> device tree supported uImage+dtb concat boot.
>>>
>>>    .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    2 ++
>>>    drivers/mmc/host/omap_hsmmc.c                      |    3 +++
>>>    2 files changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>> index 8c8908a..ab36f8b 100644
>>> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>> @@ -26,6 +26,8 @@ specifier is required.
>>>    dma-names: List of DMA request names. These strings correspond
>>>    1:1 with the DMA specifiers listed in dmas. The string naming is
>>>    to be "rx" and "tx" for RX and TX DMA requests, respectively.
>>> +ti,erratum-2.1.1.128: boolean, for OMAP3430/OMAP35xx platforms with broken
>>> +multiblock reads
>>
>> Rather than ti,errata.. specific property, something like
>> caps no/disable multiblock read is more readable in my opinion, Otherwise
>
> Is'nt the better definition to state i have quirk X and allow the
> driver to do the necessary thing/things needed to handle quirk X? in
> this case, there is just one thing to do: broken multi_block_read, in
> the case of other quirks, there might be more than 1 thing to do.. let
> driver figure that out, dts just states the h/w capabilty or in this
> case, the quirk capability.
>

But in this case there is only one. disable multi block read is more readable
than the errata reference, No strong feelings though.

>>
>> Acked-by: Balaji T K <balajitk@ti.com>
>>
>>>
>>>    Examples:
>>>
>>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>>> index 014bfe5..f2d5940 100644
>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>> @@ -1730,6 +1730,9 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
>>>    	if (of_find_property(np, "ti,dual-volt", NULL))
>>>    		pdata->controller_flags |= OMAP_HSMMC_SUPPORTS_DUAL_VOLT;
>>>
>>> +	if (of_find_property(np, "ti,erratum-2.1.1.128", NULL))
>>> +		pdata->controller_flags |= OMAP_HSMMC_BROKEN_MULTIBLOCK_READ;
>>> +
>>>    	/* This driver only supports 1 slot */
>>>    	pdata->nr_slots = 1;
>>>    	pdata->slots[0].switch_pin = cd_gpio;
>>>
>>
>
>

