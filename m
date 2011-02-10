From: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Subject: Re: [PATCH 1/5] OMAP2420: hwmod data: Add HSMMC
Date: Thu, 10 Feb 2011 22:32:47 +0530
Message-ID: <AANLkTin=ogAgrt-bGudMhJhyr_VXOsW-0V8qmhgyWHtz@mail.gmail.com>
References: <1296660462-28489-1-git-send-email-kishore.kadiyala@ti.com>
 <1296660462-28489-2-git-send-email-kishore.kadiyala@ti.com> <877hdajgqc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:60674 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756609Ab1BJRDQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 12:03:16 -0500
In-Reply-To: <877hdajgqc.fsf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, paul@pwsan.com

On Wed, Feb 9, 2011 at 4:06 AM, Kevin Hilman <khilman@ti.com> wrote:
> Kishore Kadiyala <kishore.kadiyala@ti.com> writes:
>
>> Update the omap2420 hwmod data with the HSMMC info.
>> Add a device attribute structure which will be used
>> by the host driver to find whether the HSMMC controller
>> supports DUAL VOLT cards.
>>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>
> [...]
>
>> --- a/arch/arm/plat-omap/include/plat/mmc.h
>> +++ b/arch/arm/plat-omap/include/plat/mmc.h
>> @@ -43,6 +43,13 @@
>>
>> =A0#define OMAP_MMC_MAX_SLOTS =A0 2
>>
>> +/* omap_hwmod integration data */
>> +#define OMAP_HSMMC_SUPPORTS_DUAL_VOLT =A0 =A0 =A0 =A0BIT(1)
>> +
>> +struct mmc_dev_attr {
>> + =A0 =A0 u8 flags;
>> +};
>> +
>> =A0struct omap_mmc_platform_data {
>> =A0 =A0 =A0 /* back-link to device */
>> =A0 =A0 =A0 struct device *dev;
>
> This part should be broken out as a separate patch.

Ok , will split into a separate patch

Regards,
Kishore

>
> Kevin
>
>
