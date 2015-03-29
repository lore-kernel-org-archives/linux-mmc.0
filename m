From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH] mmc: core: Enable runtime PM management of host devices
Date: Sun, 29 Mar 2015 13:53:53 +0300
Message-ID: <5517D9C1.5080302@codeaurora.org>
References: <1427454915-12893-1-git-send-email-ulf.hansson@linaro.org> <20150328085242.5e1e1acc@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55536 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbbC2Kx6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Mar 2015 06:53:58 -0400
In-Reply-To: <20150328085242.5e1e1acc@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NeilBrown <neilb@suse.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>



On 03/28/2015 12:52 AM, NeilBrown wrote:
> On Fri, 27 Mar 2015 12:15:15 +0100 Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> Currently those host drivers which have deployed runtime PM, deals with
>> the runtime PM reference counting entirely by themselves.
>>
>> Since host drivers don't know when the core will send the next request
>> through some of the host_ops callbacks, they need to handle runtime PM
>> get/put between each an every request.
>>
>> In quite many cases this has some negative effects, since it leads to a
>> high frequency of scheduled runtime PM suspend operations. That due to
>> the runtime PM reference count will normally reach zero in-between
>> every request.

It would be nice to have some numbers about this suspend/resume jitter 
of platform device pm due to time between consecutive requests within 
burst of requests.

Probably we can tune autosuspend timer of specific platform device to 
avoid this.

Implementing the patch in a way that you are suggesting will imply that 
the mmc core will always use double buffering request polling scheme and 
the existing mechanism of "request burst" definition.

Thanks,
Kostya

-- 
Qualcomm Israel, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
