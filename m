From: merez@codeaurora.org
Subject: Re: [PATCH v9] mmc: support BKOPS feature for eMMC
Date: Sun, 8 Jul 2012 03:13:43 -0700 (PDT)
Message-ID: <f7d81e8e689ba8603f1cdcffc4722ebb.squirrel@www.codeaurora.org>
References: <4FD1821D.4070603@samsung.com>
    <874npkx2dq.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:13322 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab2GHKNn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Jul 2012 06:13:43 -0400
In-Reply-To: <874npkx2dq.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Maya Erez <merez@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>


On Fri, July 6, 2012 9:47 am, Chris Ball wrote:
> Hi,
>
> On Fri, Jun 08 2012, Jaehoon Chung wrote:
>> Enable eMMC background operations (BKOPS) feature.
>>
>> If URGENT_BKOPS is set after a response, note that BKOPS
>> are required. After all I/O requests are finished, run
>> BKOPS if required. Should read/write operations be requested
>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
>> and then service the request.
>> If BKOPS-STATUS is upper than LEVEL2, need to check until clear
>> the BKOPS-STATUS vaule.
>>
>> If you want to enable this feature, set MMC_CAP2_BKOPS.
>> And if you want to set the BKOPS_EN bit in ext_csd register,
>> use the MMC_CAP2_INIT_BKOPS.
> [..]
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 0707d22..d23caf2 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -238,6 +238,8 @@ struct mmc_host {
>>  #define MMC_CAP2_BROKEN_VOLTAGE	(1 << 7)	/* Use the broken voltage */
>>  #define MMC_CAP2_DETECT_ON_ERR	(1 << 8)	/* On I/O err check card
>> removal */
>>  #define MMC_CAP2_HC_ERASE_SZ	(1 << 9)	/* High-capacity erase size */
>> +#define MMC_CAP2_INIT_BKOPS	(1 << 10)	/* To enable BKOPS */
>> +#define MMC_CAP2_BKOPS		(1 << 11)	/* BKOPS supported */
>
> Can we have a better explanation of how these capabilities are supposed
> to be used, and why it's necessary to have two of them?  Why would you
> set one but not the other?
>
> Thanks,
>
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
>
I think MMC_CAP2_BKOPS should be removed. If the card BKOPs were already
enabled, the host must support BKOPs. Therefore, in mmc_start_bkops we
should check only if card->ext_csd.bkops_en is set.

Thanks,
Maya


-- 
Sent by consultant of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

