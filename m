From: "Konstantin Dorfman" <kdorfman@codeaurora.org>
Subject: Re: [PATCH v9] mmc: support BKOPS feature for eMMC
Date: Thu, 14 Jun 2012 17:58:50 +0300 (IDT)
Message-ID: <fbe39ac33590ae06606fc19ed96fdb97.squirrel@www.codeaurora.org>
References: <4FD1821D.4070603@samsung.com> <4FD9EB47.6000905@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:64103 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017Ab2FNO6u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jun 2012 10:58:50 -0400
In-Reply-To: <4FD9EB47.6000905@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Maya Erez <merez@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>

Hello Adrian,

On Thu, June 14, 2012 4:46 pm, Adrian Hunter wrote:
> On 08/06/12 07:39, Jaehoon Chung wrote:
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
>>
>> Future considerations
>>  * Check BKOPS_LEVEL=1 and start BKOPS in a preventive manner.
>>  * Interrupt ongoing BKOPS before powering off the card.
>>  * How get BKOPS_STATUS value.(periodically send ext_csd command?)
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
>> Signed-off-by: Maya Erez <merez@codeaurora.org>
>> ---
>
> I would not expect this to work nicely with runtime PM.  I expect that
> BKOPS
> would need to be stopped beforehand.  But that would limit the time
> available for BKOPS since runtime PM would always kick in and stop it.
> How
> is runtime PM to be handled?
>
Indeed, it is handled in mmc_suspend_host(), HPI issued before CMD5, when
background BKOPS in progress.
We expect to start BKOPS when idle period starts (no block requests
incoming). Then we have 2 cases:
 1) URGENT level reached => BKOPS started synchronously and host will wait
    till no more BKOPS needed
 2) BKOPS level is not URGENT, there is host controller driver defined
    timeout after last host command, before runtime suspend flow triggerred.
    For example for msm_sdcc it is 5 second.

This implementation was tested and we did not see URGENT levels and
performance degradation.
-- 
Kostya Dorfman,
Consultant for Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


