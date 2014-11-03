From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 3/4] mmc: core: make hw_reset generic
Date: Mon, 03 Nov 2014 12:56:04 +0200
Message-ID: <54575F44.1000503@intel.com>
References: <1414154790-20893-1-git-send-email-johanru@axis.com>	<1414154790-20893-4-git-send-email-johanru@axis.com>	<545748F7.8020707@intel.com> <CA+20K0A6qKkEb=pGgFUn=Z07_YmqW1ot=LjPswDx6MzBpwP9ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38663 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864AbaKCK56 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Nov 2014 05:57:58 -0500
In-Reply-To: <CA+20K0A6qKkEb=pGgFUn=Z07_YmqW1ot=LjPswDx6MzBpwP9ZQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@axis.com>
Cc: Johan Rudholm <johanru@axis.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?B?RGF2aWQgTGFuemVuZMO2cmZlcg==?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>

On 03/11/14 12:19, Johan Rudholm wrote:
> 2014-11-03 10:20 GMT+01:00 Adrian Hunter <adrian.hunter@intel.com>:
>> On 24/10/14 15:46, Johan Rudholm wrote:
>>> Move the (e)MMC specific hw_reset code from core.c into mmc.c and call
>>> it from the new bus_ops member power_reset. This also lets us add code
>>
>> power_reset is not a good name because it does not necessarily have
>> anything to do with power.  I am not sure why you don't stick with
>> hw_reset.
>>
>>> for reseting SD cards as well.
>>>
>>> Rename the mmc_hw_reset* functions into mmc_reset*, since what they
>>> now actually do depends on the device type (and it may be something else
>>> than doing a hw_reset).
>>
>> I don't follow your reasoning about the rename.  Cycling the power is
>> a kind of hardware reset isn't it.
> 
> Since we finalize the reset by calling bus_ops->power_restore, I was
> looking for something symmetrical. Ulf mentioned perhaps extending
> bus_ops->power_save, but I couldn't find a reasonable way of doing
> this. Do you propose simply calling it bus_ops->hw_reset ?

Yes


