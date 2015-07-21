From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Update driver to support without regulators
Date: Tue, 21 Jul 2015 15:11:21 -0500
Message-ID: <55AEA769.9080300@ti.com>
References: <1436902186-6542-1-git-send-email-fcooper@ti.com> <20150721195749.GM25385@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60896 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbbGUULZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2015 16:11:25 -0400
In-Reply-To: <20150721195749.GM25385@saruman.tx.rr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, rogerq@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, Murali Karicheri <m-karicheri2@ti.com>



On 07/21/2015 02:57 PM, Felipe Balbi wrote:
> On Tue, Jul 14, 2015 at 02:29:46PM -0500, Franklin S Cooper Jr wrote:
>> From: Roger Quadros <rogerq@ti.com>
>>
>> Update driver to support without regulators.
>>
>> Without this patch boards that do not enable regulator config options will
>> fail to boot with a kernel panic.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt |  2 ++
>>  drivers/mmc/host/omap_hsmmc.c                           | 14 ++++++++++----
>>  2 files changed, 12 insertions(+), 4 deletions(-)
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
>> index b2b411d..16c870f 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -1551,10 +1551,13 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>  	if (ios->power_mode != host->power_mode) {
>>  		switch (ios->power_mode) {
>>  		case MMC_POWER_OFF:
>> -			mmc_pdata(host)->set_power(host->dev, 0, 0);
>> +			if (host->use_reg)
>> +				mmc_pdata(host)->set_power(host->dev, 0, 0);
> looks like this driver should just be use regulator_get_optional(), then
> ->set_power() would still work, no ?
Wouldn't there still be a dependency on the regulator framework to get that to work?

I guess my intention was to fix not having the regulator framework. But I'm sure there are
other ways to support not having a regulator defined as long as CONFIG_REGULATOR is enabled.
For example dummy regulator worked fine when I tried it.
>

