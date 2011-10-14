From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: mmci: Do not release spinlock in request_end
Date: Fri, 14 Oct 2011 09:51:44 +0200
Message-ID: <4E97EA10.6040800@stericsson.com>
References: <1318342001-26955-1-git-send-email-ulf.hansson@stericsson.com> <20111013142914.GZ21648@n2100.arm.linux.org.uk> <1318521592.2090.16.camel@linaro1> <4E97E6CF.1000601@stericsson.com> <20111014074224.GQ21648@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:37928 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755546Ab1JNHwJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Oct 2011 03:52:09 -0400
In-Reply-To: <20111014074224.GQ21648@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Jon Medhurst (Tixy)" <jon.medhurst@linaro.org>, Lee Jones <lee.jones@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Russell King - ARM Linux wrote:
> On Fri, Oct 14, 2011 at 09:37:51AM +0200, Ulf Hansson wrote:
>> Jon Medhurst (Tixy) wrote:
>>> On Thu, 2011-10-13 at 15:29 +0100, Russell King - ARM Linux wrote:
>>>> On Tue, Oct 11, 2011 at 04:06:41PM +0200, Ulf Hansson wrote:
>>>>> The patch "mmc: core: move ->request() call from atomic context",
>>>>> is the reason to why this change is possible. This simplifies the
>>>>> error handling code execution path quite a lot and potentially also
>>>>> fixes some error handling hang problems.
>>>>>
>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>>>> This doesn't look right:
>>>>
>>>> void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>>>> {
>>>>         if (err && cmd->retries) {
>>>>                 host->ops->request(host, mrq);
>>>>
>> This is NOT how it looks at mmc-next. You need to test with Adrian  
>> Hunters patch which the commit refers two.
> 
> In that case, how can I take the patch to mmci if it depends on something
> in another tree?
> 

I don't know. But how do you update your tree from next normally? I 
believe the problem is more related to that the mmc-next tree is now on 
a temporary git. If you do not update your tree how shall we be able to 
continue with integration of new patches that depends on mmc patches 
from "next"?

BR
Uffe


