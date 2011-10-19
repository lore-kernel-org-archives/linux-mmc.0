From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH] mmc: core: Prevent too long response times for suspend
Date: Wed, 19 Oct 2011 22:55:07 +0530
Message-ID: <4E9F07F3.2050103@codeaurora.org>
References: <1318514638-32452-1-git-send-email-ulf.hansson@stericsson.com> <4f62290baad48cd8655f3f82f7b162b9.squirrel@www.codeaurora.org> <4E9BFA84.1040709@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:11824 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab1JSRZO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2011 13:25:14 -0400
In-Reply-To: <4E9BFA84.1040709@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On 10/17/2011 3:21 PM, Ulf Hansson wrote:
>>
>> Why would there be pending requests while host is suspending? Is the
>> kernel framework not handling sync before going to suspend? However, the
>> mmc_blk_suspend() would be called before the host driver suspends (as all
>> the driver suspend routines are serialized) which means it stops block
>> layer to queue more I/O requests well before the host driver start
>> suspend. Does this sequence break in your case?
>
> I have observed this issue for different cases (one case was logging to
> eMMC). The idea is simply that we would like to be sure that we do not
> wait "forever", no matter if the "upper layers" misbehaved in the
> suspend sequence.
>
Agree. I was just curious to know why would there be a pending requests. 
If the issue is seen while logging to eMMC then there may be something 
wrong, probably, we may see issue while running mmc_test and initiating 
suspend. Your patch looks good to me though.

Reviewed-by: Sujit Reddy Thumma <sthumma@codeaurora.org>

>>
>> Your concern seems to be valid for SDIO case, but again the function
>> driver must be intelligent enough to return -EBUSY as it knows that it
>> had
>> posted a request to MMC.
>>
>
> For SDIO, should we really assume that function driver has implemented a
> suspend function and moreover that it actually always behaves as we expect?
I hope so, but yes, in some cases that may be broken. I agree with you.
>
> Br
> Ulf Hansson

-- 
Thanks & Regards,
Sujit Reddy Thumma
