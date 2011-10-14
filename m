From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: mmci: Do not release spinlock in request_end
Date: Fri, 14 Oct 2011 09:37:51 +0200
Message-ID: <4E97E6CF.1000601@stericsson.com>
References: <1318342001-26955-1-git-send-email-ulf.hansson@stericsson.com>	 <20111013142914.GZ21648@n2100.arm.linux.org.uk> <1318521592.2090.16.camel@linaro1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:59993 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753918Ab1JNHiZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Oct 2011 03:38:25 -0400
In-Reply-To: <1318521592.2090.16.camel@linaro1>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Jon Medhurst (Tixy)" <jon.medhurst@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Lee Jones <lee.jones@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Jon Medhurst (Tixy) wrote:
> On Thu, 2011-10-13 at 15:29 +0100, Russell King - ARM Linux wrote:
>> On Tue, Oct 11, 2011 at 04:06:41PM +0200, Ulf Hansson wrote:
>>> The patch "mmc: core: move ->request() call from atomic context",
>>> is the reason to why this change is possible. This simplifies the
>>> error handling code execution path quite a lot and potentially also
>>> fixes some error handling hang problems.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>> This doesn't look right:
>>
>> void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>> {
>>         if (err && cmd->retries) {
>>                 host->ops->request(host, mrq);
>>

This is NOT how it looks at mmc-next. You need to test with Adrian 
Hunters patch which the commit refers two.

Linux next for mmc is available at:

git://dev.laptop.org/users/cjb/mmc mmc-next



>> So, not dropping the spinlock results in calling the request function
>> with the spinlock held - and as the request function then goes on to
>> lock the spinlock, we will deadlock.
> 
> Indeed, deadlock behaviour at this point is what I see with this patch
> on a Versatile Express board running 3.0-rc9.
> 

