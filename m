From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 1/6] mmc: omap_hsmmc: start using generic non-removable
 DT binding
Date: Thu, 17 Oct 2013 16:23:48 +0530
Message-ID: <525FC1BC.9080207@ti.com>
References: <1381936707-10336-1-git-send-email-balajitk@ti.com> <1381936707-10336-2-git-send-email-balajitk@ti.com> <20131017083856.GA24056@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20131017083856.GA24056@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "bcousson@baylibre.com" <bcousson@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "uri.y@variscite.com" <uri.y@variscite.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Thursday 17 October 2013 02:08 PM, Mark Rutland wrote:
> On Wed, Oct 16, 2013 at 04:18:22PM +0100, Balaji T K wrote:
>> From: Sekhar Nori <nsekhar@ti.com>
>>
>> add generic "non-removable" binding support for omap_hsmmc
>>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>> ---
>>   .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    2 +-
>>   drivers/mmc/host/omap_hsmmc.c                      |    3 +++
>>   2 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> index 8c8908a..3b95719 100644
>> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> @@ -17,7 +17,7 @@ Optional properties:
>>   ti,dual-volt: boolean, supports dual voltage cards
>>   <supply-name>-supply: phandle to the regulator device tree node
>>   "supply-name" examples are "vmmc", "vmmc_aux" etc
>> -ti,non-removable: non-removable slot (like eMMC)
>> +ti,non-removable: non-removable eMMC with always on vccq and configurable vcc
>
> Why this change?
>
Hi,

earlier ti,non-removable was used for all eMMC and SDIO card, now it will
be used only for eMMC with always on vccq and configurable vcc.

> What do "vccq" and "vcc" correspond to? The regulators are called "vmmc"
> and "vmmc_aux"...
>

vccq and vcc are supply names of eMMC part

> Why is no mention of "non-removable" added, given that it's added to the
> code?

Because this file makes a reference to mmc.txt and the core properties described
by mmc.txt are not added in ti-omap-hsmmc.txt

>
> Is one preferred over the other? That should be noted.
>
>>   ti,needs-special-reset: Requires a special softreset sequence
>>   ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
>>   dmas: List of DMA specifiers with the controller specific format
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 6ac63df..5992048 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -1738,6 +1738,9 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
>>   	pdata->slots[0].switch_pin = cd_gpio;
>>   	pdata->slots[0].gpio_wp = wp_gpio;
>>
>> +	if (of_find_property(np, "non-removable", NULL)) {
>> +		pdata->slots[0].nonremovable = true;
>> +	}
>
> This wasn't mentioned in the binding, and it seems to have different
> semantics to "ti,non-removable". Why is it different?
>

When ti,non-removable was added, Only OMAP platform that had eMMC was that on OMAP4
where power to eMMC cannot be switched off without sending CMD5 sleep command,
so no_regulator_off_init was needed to get it detected during boot.

Now start using generic non-removable for all removable cards which do not
have such limitation.

>>   	if (of_find_property(np, "ti,non-removable", NULL)) {
>>   		pdata->slots[0].nonremovable = true;
>>   		pdata->slots[0].no_regulator_off_init = true;
>
> Cheers,
> Mark.
>
