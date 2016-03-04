From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH 1/4] mmc: core: add cap-enhanced-strobe support
Date: Fri, 4 Mar 2016 09:39:23 +0800
Message-ID: <56D8E74B.3010603@rock-chips.com>
References: <1456972557-7994-1-git-send-email-shawn.lin@rock-chips.com>
 <1456972585-8036-1-git-send-email-shawn.lin@rock-chips.com>
 <56D82934.3040205@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:33654 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbcCDBjw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2016 20:39:52 -0500
In-Reply-To: <56D82934.3040205@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jaehoon,

On 2016/3/3 20:08, Jaehoon Chung wrote:
> Hi Shawn,
>
> On 03/03/2016 11:36 AM, Shawn Lin wrote:
>> This patch introduce cap-enhanced-strobe for platforms which
>> want to enable enhanced strobe function from DT if the mmc host
>> controller claims to support enhanced strobe.
>
> I don't know why need to add the capability and property.
>

 From my point, HS400-ES is a optional feature, so we should leave it
for people to decide whether to use it. Just as my controller supports 
hs400, but I can't force all the people using my platform to use hs400?
That's why we add mmc-hs400-* in DT.

But maybe I can change the name to mmc-hs400es-* ?


[...]

>>   #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
>>   #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
>>   #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
>> +#define MMC_CAP_ENHANCED_STROBE	(1 << 20)	/* Host supports enhanced strobe */
>
> Need to fix ordering.

yeah~~ good catch!

>
>>   #define MMC_CAP_CMD23		(1 << 30)	/* CMD23 supported. */
>>   #define MMC_CAP_HW_RESET	(1 << 31)	/* Hardware reset */
>>
>> @@ -469,6 +470,11 @@ static inline int mmc_host_uhs(struct mmc_host *host)
>>   		 MMC_CAP_UHS_DDR50);
>>   }
>>
>> +static inline int mmc_host_enhanced_strobe(struct mmc_host *host)
>> +{
>> +	return host->caps & MMC_CAP_ENHANCED_STROBE;
>> +}
>> +
>>   static inline int mmc_host_packed_wr(struct mmc_host *host)
>>   {
>>   	return host->caps2 & MMC_CAP2_PACKED_WR;
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin

