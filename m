From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Wed, 13 Jul 2011 07:59:54 -0700
Message-ID: <87sjqaql91.fsf@ti.com>
References: <1309538376-23260-1-git-send-email-balajitk@ti.com>
	<1309538376-23260-3-git-send-email-balajitk@ti.com>
	<8739ig8wby.fsf@ti.com>
	<5D8008F58939784290FAB48F5497519846C4113396@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:57420 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754809Ab1GMPAB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2011 11:00:01 -0400
In-Reply-To: <5D8008F58939784290FAB48F5497519846C4113396@shsmsx502.ccr.corp.intel.com>
	(Chuanxiao Dong's message of "Wed, 13 Jul 2011 17:09:08 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: Balaji T K <balajitk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "tony@atomide.com" <tony@atomide.com>, "madhu.cr@ti.com" <madhu.cr@ti.com>, "b-cousson@ti.com" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "kishore.kadiyala@ti.com" <kishore.kadiyala@ti.com>

"Dong, Chuanxiao" <chuanxiao.dong@intel.com> writes:

[...]

>> 
>> Basially, the question is: can the driver be reworked such that a system
>> suspend does not need to runtime resume the device?  For most devices,
>> we kind of expect that if the device is runtime suspended, a system
>> suspend will have nothing extra to do, but this driver runtime resumes
>> the device during system suspend in order to do "stuff", which I
>> admitedly don't fully undestand.
>> 
>> Ideally, the "stuff" needed for runtime suspend and system suspend could
>> be made to be common such that a system suspend of a runtime suspended
>> device would be a noop.
>> 
>> Is this possible?
>> 
>> Kevin
>
> During system suspended patch, a callback named .prepare will be first
> done before .suspend is called, and .complete callback will be called
> after .resume is called. These two callbacks are in pair. If driver
> can implement the .prepare and hold the usage count in this callback,
> then runtime pm suspend/resume will not happen during device
> suspending. So there will be no need to add pm_runtime_get* and
> pm_runtime_put* in .suspend/.resume.

That doesn't avoid the problem, since the device is still runtime
resumed and then re-suspended during system suspend.

My basic question is this: why does this device need to be runtime
resumed during system suspend?  Why can't it just stay runtime
suspended?

Kevin
