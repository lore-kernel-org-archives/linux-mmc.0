From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: host: don't access at boot partition when mode is
 HS200/HS400.
Date: Wed, 13 Aug 2014 22:36:09 +0900
Message-ID: <53EB69C9.8040104@samsung.com>
References: <1407905176-6847-1-git-send-email-jh80.chung@samsung.com>
 <282CEDFCBC30114F83C499CB8F2ED5333AE6E2E8@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:64146 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbaHMNgM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Aug 2014 09:36:12 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NA800HU3Z4A7L30@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 13 Aug 2014 22:36:10 +0900 (KST)
In-reply-to: <282CEDFCBC30114F83C499CB8F2ED5333AE6E2E8@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

Hi, Alex.

On 08/13/2014 10:27 PM, Alex Lemberg wrote:
> Hi,
> 
> HS200 & HS400 mode is not supported during boot operation, but I think this specific change 
> will prevent any boot operation or access to boot partition on all hosts with HS200 & HS400 capabilities in general,
> even in case then the eMMC card is DDR52 type.
Right, even if host capabilities is supported HS200 & HS400, card couldn't support them.
then maybe work the DDR50 or other mode.

> The actual bus clock speed need to be checked in order to prevent/allow boot operation, but not the host capabilities.

Exactly right. :)
As you mentioned, this patch is not perfect. but boot_part_access() called before set to final busmode.
I will consider it, but i think good that don't access at boot partition when mode is hs200/hs400 mode.

> 
> As for regular R/W access to boot partition, as far as I see from the JEDEC spec - it can work in HS200 & HS400 modes, so no change is required.

Well, it can work HS200 & HS400 mode at boot partition? i didn't think so.

> Please correct me if I wrong.

Thanks for comments.

Best Regards,
Jaehoon Chung

> 
> Thanks,
> Alex
> 
> 
> 
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Jaehoon Chung
>> Sent: Wednesday, August 13, 2014 7:46 AM
>> To: linux-mmc
>> Cc: Chris Ball; Ulf Hansson; Jaehoon Chung
>> Subject: [PATCH] mmc: host: don't access at boot partition when mode is
>> HS200/HS400.
>>
>> HS200/HS400 mode is not supported during boot operation.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  include/linux/mmc/host.h |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h index
>> 7960424..ce5db96 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -445,6 +445,10 @@ static inline int mmc_host_cmd23(struct mmc_host
>> *host)
>>
>>  static inline int mmc_boot_partition_access(struct mmc_host *host)  {
>> +	/* HS200 & HS400 mode is not supported during boot operation */
>> +	if (host->caps2 & (MMC_CAP2_HS200 | MMC_CAP2_HS400))
>> +		return 0;
>> +
>>  	return !(host->caps2 & MMC_CAP2_BOOTPART_NOACC);  }
>>
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the
>> body of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
> 

