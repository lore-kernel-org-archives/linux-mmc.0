From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 1/6] mmc: omap_hsmmc: start using generic non-removable
 DT binding
Date: Fri, 18 Oct 2013 17:03:44 +0530
Message-ID: <52611C98.8050109@ti.com>
References: <1381936707-10336-1-git-send-email-balajitk@ti.com> <1381936707-10336-2-git-send-email-balajitk@ti.com> <20131017083856.GA24056@e106331-lin.cambridge.arm.com> <525FC1BC.9080207@ti.com> <20131017152553.GI24056@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37524 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951Ab3JRLdx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 18 Oct 2013 07:33:53 -0400
In-Reply-To: <20131017152553.GI24056@e106331-lin.cambridge.arm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "bcousson@baylibre.com" <bcousson@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "uri.y@variscite.com" <uri.y@variscite.com>, Sekhar Nori <nsekhar@ti.com>

On Thursday 17 October 2013 08:55 PM, Mark Rutland wrote:
> On Thu, Oct 17, 2013 at 11:53:48AM +0100, Balaji T K wrote:
>> On Thursday 17 October 2013 02:08 PM, Mark Rutland wrote:
>>> On Wed, Oct 16, 2013 at 04:18:22PM +0100, Balaji T K wrote:
>>>> From: Sekhar Nori <nsekhar@ti.com>
>>>>
>>>> add generic "non-removable" binding support for omap_hsmmc
>>>>
>>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>>> Signed-off-by: Balaji T K <balajitk@ti.com>
>>>> ---
>>>>    .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    2 +-
>>>>    drivers/mmc/host/omap_hsmmc.c                      |    3 +++
>>>>    2 files changed, 4 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>>> index 8c8908a..3b95719 100644
>>>> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>>> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>>> @@ -17,7 +17,7 @@ Optional properties:
>>>>    ti,dual-volt: boolean, supports dual voltage cards
>>>>    <supply-name>-supply: phandle to the regulator device tree node
>>>>    "supply-name" examples are "vmmc", "vmmc_aux" etc
>>>> -ti,non-removable: non-removable slot (like eMMC)
>>>> +ti,non-removable: non-removable eMMC with always on vccq and configurable vcc
>>>
>>> Why this change?
>>>
>> Hi,
>>
>> earlier ti,non-removable was used for all eMMC and SDIO card, now it will
>> be used only for eMMC with always on vccq and configurable vcc.
>
> Please expand the commit message to mention this. It wasn't clear why
> adding support for a property meant modifying the description of
> another.
>
Hi,

Ok

>>
>>> What do "vccq" and "vcc" correspond to? The regulators are called "vmmc"
>>> and "vmmc_aux"...
>>>
>>
>> vccq and vcc are supply names of eMMC part
>
> The binding has vmmc-supply and vmmc_aux-supply. How do {vmmc,vmmc_aux}
> and {vcc,vccq} relate? That should be clarified in the binding document,
> something like:
>
> - vmmc-supply: phandle of the regulator for the VCC input
> - vmmc_aux-supply: phandle of the regulator for the VCCQ input
>

It can be different for SD card, so will add vcc to vmmc mapping to ti,non-removable
description.

>>
>>> Why is no mention of "non-removable" added, given that it's added to the
>>> code?
>>
>> Because this file makes a reference to mmc.txt and the core properties described
>> by mmc.txt are not added in ti-omap-hsmmc.txt
>
> There is room for confusion here. While "non-removable" is a generic
> property, it would be good to contrast "non-removable" and
> "ti,non-removable" in the binding as they imply different things.
>
>>
>>>
>>> Is one preferred over the other? That should be noted.
>>>
>>>>    ti,needs-special-reset: Requires a special softreset sequence
>>>>    ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
>>>>    dmas: List of DMA specifiers with the controller specific format
>>>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>>>> index 6ac63df..5992048 100644
>>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>>> @@ -1738,6 +1738,9 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
>>>>    	pdata->slots[0].switch_pin = cd_gpio;
>>>>    	pdata->slots[0].gpio_wp = wp_gpio;
>>>>
>>>> +	if (of_find_property(np, "non-removable", NULL)) {
>>>> +		pdata->slots[0].nonremovable = true;
>>>> +	}
>>>
>>> This wasn't mentioned in the binding, and it seems to have different
>>> semantics to "ti,non-removable". Why is it different?
>>>
>>
>> When ti,non-removable was added, Only OMAP platform that had eMMC was that on OMAP4
>> where power to eMMC cannot be switched off without sending CMD5 sleep command,
>> so no_regulator_off_init was needed to get it detected during boot.
>>
>> Now start using generic non-removable for all removable cards which do not
>> have such limitation.
>
> OK. I think this would be much clearer with something in the binding
> contrasting the two properties.

Thanks for comments, will add those info.

>
> Thanks,
> Mark.
>

