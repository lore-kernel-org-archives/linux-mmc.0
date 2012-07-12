From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v9] mmc: support BKOPS feature for eMMC
Date: Thu, 12 Jul 2012 09:00:17 +0300
Message-ID: <4FFE67F1.8030306@intel.com>
References: <4FD1821D.4070603@samsung.com> <4FD9EB47.6000905@intel.com> <4FFE5A58.1060807@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:65507 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755291Ab2GLF7f (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 Jul 2012 01:59:35 -0400
In-Reply-To: <4FFE5A58.1060807@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Maya Erez <merez@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>

On 12/07/12 08:02, Jaehoon Chung wrote:
> Hi, Adrian,
> 
> On 06/14/2012 10:46 PM, Adrian Hunter wrote:
> 
>> On 08/06/12 07:39, Jaehoon Chung wrote:
>>> Enable eMMC background operations (BKOPS) feature.
>>>
>>> If URGENT_BKOPS is set after a response, note that BKOPS
>>> are required. After all I/O requests are finished, run
>>> BKOPS if required. Should read/write operations be requested
>>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
>>> and then service the request.
>>> If BKOPS-STATUS is upper than LEVEL2, need to check until clear
>>> the BKOPS-STATUS vaule. 
>>>
>>> If you want to enable this feature, set MMC_CAP2_BKOPS.
>>> And if you want to set the BKOPS_EN bit in ext_csd register,
>>> use the MMC_CAP2_INIT_BKOPS.
>>>
>>> Future considerations
>>>  * Check BKOPS_LEVEL=1 and start BKOPS in a preventive manner.
>>>  * Interrupt ongoing BKOPS before powering off the card.
>>>  * How get BKOPS_STATUS value.(periodically send ext_csd command?)
>>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
>>> Signed-off-by: Maya Erez <merez@codeaurora.org>
>>> ---
>>
>> I would not expect this to work nicely with runtime PM.  I expect that BKOPS
>> would need to be stopped beforehand.  But that would limit the time
>> available for BKOPS since runtime PM would always kick in and stop it.  How
>> is runtime PM to be handled?
> 
> I think that add some function like the mmc_runtime_pm_suspend().
> int mmc_runtime_pm_suspend()
> {
> 	if running bkops {
> 		waiting for limit time..=> (when upper than Level2)
> 		otherwise don't wait
> 		stop-bkops
> 	} else
> 		nothing..
> }
> Almost runtime PM is controlled at host side.
> So it's not very good that add the bkops control code at host side.
> How about this? i want to get your opinion.

Possibly, but ideally it should be controlled through the runtime PM API.
For example, sdhci uses pm_runtime_get / put which must be paired.
