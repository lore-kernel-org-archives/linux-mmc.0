From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH/RFC] mmc: add a device PM QoS constraint when a host is
 first claimed
Date: Wed, 14 Dec 2011 12:12:29 +0100
Message-ID: <4EE8849D.1010401@stericsson.com>
References: <Pine.LNX.4.64.1112121642080.10378@axis700.grange> <Pine.LNX.4.64.1112131658330.20293@axis700.grange> <4EE865CA.8000407@stericsson.com> <201112141115.00945.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:57334 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754531Ab1LNLNE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Dec 2011 06:13:04 -0500
In-Reply-To: <201112141115.00945.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>


>> You have a point. But I am not convinced. :-)
>>
>> Some host drivers already make use of autosuspend. I think this is most 
>> straightforward solution to this problem right now.
> 
> The problem is not about _when_ to suspend (which autosuspend is about),
> but _what_ _state_ to go when suspended.  That's quite a different issue.

I was kind of taking a more simple approach, I were considering 
runtime_suspend as _one_ state. Right now there is no host driver having 
different levels of runtime_suspend state, if I am correct. But ofcourse 
that could be the future.

Moreover, I definitely do not think that a fixed timeout of 100us is 
applicable for all use cases, this must at least be configurable.

> 
>> However, we could also do pm_runtime_get_sync of the host device in 
>> claim host and vice verse in release host, thus preventing the host 
>> driver from triggering runtime_suspend|resume for every request. Though, 
>> I am not 100% sure this is really what you want either.
> 
> No, I don't want that.  I want the device to be suspended when possible,
> but I don't want that to cause the system to go into an overly deep power
> state as a result.

Before just skipping my proposal, I think you should know some more 
background to why I suggested this:

1.
mmc_claim_host is using mmc_host_enable, which kind of mean the same 
thing for a host driver as doing get_sync. Vice verse for mmc_release_host.

2.
When executing mmc/sd commands/requests the host must always be claimed 
(and thus the host is always enabled). But more important some mmc/sd 
commands must be executed as a sequence, without the host being disabled 
in between the commands (since a disable might mean that the clock to 
card gets disabled). To solve this, the mmc_claim_host is used, to make 
sure the host is enabled during the complete command sequence.

I happily continue this discussion, to see if someone more can break the 
idea about having get_sync in mmc_host_enable. :-)

> 
>> Using PM QoS as you propose, might prevent some hosts from doing 
>> runtime_suspend|resume completely and thus those might not fulfill power 
>> consumption requirements instead.
> 
> I'm not sure what scenario you have in mind.  Care to elaborate?

Well, suppose a the host drivers start considering the PM QoS 
requirement, but never can fulfill the requirement of 100us for it's 
runtime_suspend callback function...

> 
>> I do not think we can take this decision at this level. Is performance more
>> important than power save, that is kind of the question.
> 
> Yes, it is.  Also, the number used here is somewhat arbitrary.

For you maybe power management is less important, but I doubt everybody 
else agree to that. It is a more complex balance I believe.

> 
> However, since no one except for SH7372 is now using device PM QoS, no one
> else will be affected by this change at the moment.

True, but that is not a good reason for adding more stuff to the mmc core.

> 
> Thanks,
> Rafael
> 

By the way, I like to discuss with you so please take no offense from my 
comments. :-)


BR
Ulf Hansson
