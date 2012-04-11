From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V4]mmc: remove MMC bus legacy suspend/resume method
Date: Wed, 11 Apr 2012 10:44:47 -0400
Message-ID: <87y5q2s4yo.fsf@laptop.org>
References: <20120411115438.GA303@intel.com> <4F858A25.20302@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49901 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752363Ab2DKOpE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Apr 2012 10:45:04 -0400
In-Reply-To: <4F858A25.20302@stericsson.com> (Ulf Hansson's message of "Wed,
	11 Apr 2012 15:41:57 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Chuanxiao Dong <chuanxiao.dong@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>

Hi,

On Wed, Apr 11 2012, Ulf Hansson wrote:
> On 04/11/2012 01:54 PM, Chuanxiao Dong wrote:
>> MMC bus is using legacy suspend/resume method, which is not compatible if
>> runtime pm callbacks are used. In this scenario, MMC bus suspend/resume
>> callbacks cannot be called when system entering S3. So change to use the new
>> defined dev_pm_ops for system sleeping mode
>>
>> Signed-off-by: Chuanxiao Dong<chuanxiao.dong@intel.com>
>> ---
>> Changes in v2:
>> 	use SET_SYSTEM_SLEEP_PM_OPS to define sleep callbacks as Rafael
>> 	suggested
>>
>> Changes in v3:
>> 	remove NULL pointer define for runtime callbacks when PM_RUNTIME is not
>> 	selected, as Ulf Hansson suggested
>>
>> Changes in v4:
>> 	fix the warning when disable CONFIG_PM_RUNTIME
>>
>
> Looks good to me! Acked-by: Ulf Hansson <ulf.hansson@stericsson.com>

Thanks!  Pushed to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
