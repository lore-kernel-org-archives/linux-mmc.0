From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v9] mmc: support BKOPS feature for eMMC
Date: Mon, 09 Jul 2012 13:14:04 +0900
Message-ID: <4FFA5A8C.7050005@samsung.com>
References: <4FD1821D.4070603@samsung.com> <874npkx2dq.fsf@octavius.laptop.org>
 <f7d81e8e689ba8603f1cdcffc4722ebb.squirrel@www.codeaurora.org>
 <4FFA4334.7010904@samsung.com> <87vchxvecp.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:62922 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab2GIEOH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jul 2012 00:14:07 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M6V0097HL316AH0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 09 Jul 2012 13:14:05 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M6V0032RL3G9N10@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 09 Jul 2012 13:14:05 +0900 (KST)
In-reply-to: <87vchxvecp.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, merez@codeaurora.org, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@stericsson.com>

On 07/09/2012 11:48 AM, Chris Ball wrote:

> Hi,
> 
> On Sun, Jul 08 2012, Jaehoon Chung wrote:
>>> I think MMC_CAP2_BKOPS should be removed. If the card BKOPs were already
>>> enabled, the host must support BKOPs. Therefore, in mmc_start_bkops we
>>> should check only if card->ext_csd.bkops_en is set.
>>
>> If bkops bit is set, it means that use the bkops by default.
>> If somebody didn't want to use the bkops, then just didn't set the MMC_CAP2_BKOPS.
>> And eMMC card's BKOPS bit should not be set,
>> then we can set the BKOPS support with switch command.
>> For this, MMC_CAP2_INIT_BKOPS is added.
>> In my case, didn't set the bkops enable bit at first time.
>> So need to set bkops enable bit with switch command.
>>
>> As Maya's mentioned, if we use the bkops by default, we can remove the MMC_CAP2_BKOPS2.
> 
> I'm not sure I understand.  If someone has advertised MMC_CAP2_BKOPS on
> their host, why do we also need to check for MMC_CAP2_INIT_BKOPS before
> we enable it in the ext_csd?

Actually, it didn't need to check the MMC_CAP2_INIT_BKOPS.
Because, if MMC_CAP2_BKOPS is set, it means we want to use the bkops.
Then we could enable in ext_csd by default.
In the initial version, didn't add the MMC_CAP2_INIT_BKOPS.
But some people asked me that card didn't set bkops enable bit in ext_csd why set enable bkops by default?
Also others suggested the bkops enable bit should be set at user space.
I think host didn't consider whether enable bkops or not.
But some people want to enable bkops bit, some people didn't want to enable bkops bit by default.
So i added the MMC_CAP2_INIT_BKOPS.
If you can decide, i will confirm yours.

Best Regards,
Jaehoon Chung

> 
> Why shouldn't we just use one (MMC_CAP2_BKOPS) capability to mean
> "enable bkops if supported, by writing 1 (if it wasn't already set)
> to ext_csd[163] to tell the card that we're going to be using bkops"?
> Are there any disadvantages to doing this?
> 
> Thanks,
> 
> - Chris.


