From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v7] mmc: support BKOPS feature for eMMC
Date: Thu, 23 Feb 2012 11:05:16 +0200
Message-ID: <4F46014C.6040303@intel.com>
References: <4F190E26.4040909@samsung.com> <4F44F792.2000304@intel.com> <4F45A293.6060608@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6038 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779Ab2BWJFN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Feb 2012 04:05:13 -0500
In-Reply-To: <4F45A293.6060608@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Konstantin Dorfman <kdorfman@codeaurora.org>

On 23/02/12 04:21, Jaehoon Chung wrote:
> On 02/22/2012 11:11 PM, Adrian Hunter wrote:
> 
>> On 20/01/12 08:48, Jaehoon Chung wrote:
>>> Enable eMMC background operations (BKOPS) feature.
>>>
>>> If URGENT_BKOPS is set after a response, note that BKOPS
>>> are required. After all I/O requests are finished, run
>>> BKOPS if required. Should read/write operations be requested
>>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
>>> and then service the request.
>>
>> You are leaving bkops running and releasing the host.  Won't
>> that cause problems for other entry points to mmc services
>> e.g. system suspend (cache control, sleep etc), ioctl, sysfs,
>> etc
> 
> I see. i will complement for your review.

Please cc me.

> Didn't you have the other comment?

Well, yes.  I also suggest:
	- don't use host->lock spin lock at all
	- claim the host in the caller not in
	mmc_start_bkops()

But the main issues are design issues not implementation.
i.e.
	- always run bkops at level 3 before doing any
	other requests - that requirement should probably
	be implemented in core rather than the block driver
	- do not release the host while bkops are running

And a new one:
	- how do you know that trim/discard/sanitize will not
	result in a need for bkops?

