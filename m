From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 5/5] OMAP: adapt hsmmc to hwmod framework
Date: Thu, 24 Feb 2011 15:33:20 +0100
Message-ID: <4D666C30.2000907@ti.com>
References: <1298483231-29622-1-git-send-email-kishore.kadiyala@ti.com> <1298483231-29622-6-git-send-email-kishore.kadiyala@ti.com> <4D6645AE.5080506@ti.com> <AANLkTimKG_B7LxAf4Ci8mTh8-guYqBfgD2nDN0gA3EQE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51223 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868Ab1BXOd0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Feb 2011 09:33:26 -0500
In-Reply-To: <AANLkTimKG_B7LxAf4Ci8mTh8-guYqBfgD2nDN0gA3EQE@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "cjb@laptop.org" <cjb@laptop.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>

On 2/24/2011 2:55 PM, Kadiyala, Kishore wrote:
> On Thu, Feb 24, 2011 at 5:19 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> On 2/23/2011 6:47 PM, Kadiyala, Kishore wrote:

[...]

>>>   static struct hsmmc_controller {
>>>          char                            name[HSMMC_NAME_LEN + 1];
>>> -} hsmmc[OMAP34XX_NR_MMC];
>>> +} hsmmc[OMAP44XX_NR_MMC];
>>
>> I do not know the details of that driver, so this comment might be
>> completely irrelevant, but in theory, such static table should not be
>> necessary since the driver core already maintain a list of all instances
>> bound to it.
>
> I agree, but this is used in slot data for the controller and is used
> in the driver
> to create a /sys entry.

I guess the sysfs should be able to use only the device instance.

> I will try to avoid the "OMAP44XX_NR_MMC" dependency.

[...]

>>> +static struct omap_mmc_platform_data *hsmmc_data[OMAP44XX_NR_MMC]
>>> __initdata;
>>
>> Same concern than for hsmmc, why do you need static table here?
>
> Agree, will remove static declaration.
>
>> And why do you need another structure? The omap2_hsmmc_info should already
>> be in a pdata kind of structure.
>> The board file should just populate a table of pdata that you will use
>> during init.
>
> No, omap2_hsmmc_info is intermediate structure used by the boards
> files to update
> some basic info of the controller, based on which the pdata is
> populated in hsmmc.c.

This is the point, I guess you can potentially directly fill partially a 
pdata with controller information in the board file to avoid that 
intermediate structure.

[...]

>>> +       name = "mmci-omap-hs";
>>
>> Could you please rename the device to have something in the form: omap_XXXX?
>> In that case "omap_mmc" should be good. The "hs" is just a indication of one
>> of the mmc instance capability and does not have to be in the device name
>> since there is no none-hs instance.
>
> I understood your concern but omap1,omap2420 uses mmc driver while
> omap2430, omap3 , omap4 has hsmmc driver.

OK, it makes sense then.

> omap1, omap2420 boards have device name as "mmci-omap" currently, but
> if they undergo
> the similar change as proposed above then it looks like "omap_mmc"
>
> Therefore for hsmmc driver, I will be happy to have something like "omap_hsmmc"
>
> please let me know if this is fine.

Excellent, that's fine for me.

Thanks,
Benoit
