From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: Do not release spinlock in request_end
Date: Fri, 14 Oct 2011 08:42:24 +0100
Message-ID: <20111014074224.GQ21648@n2100.arm.linux.org.uk>
References: <1318342001-26955-1-git-send-email-ulf.hansson@stericsson.com> <20111013142914.GZ21648@n2100.arm.linux.org.uk> <1318521592.2090.16.camel@linaro1> <4E97E6CF.1000601@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52777 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932327Ab1JNHme (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Oct 2011 03:42:34 -0400
Content-Disposition: inline
In-Reply-To: <4E97E6CF.1000601@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "Jon Medhurst (Tixy)" <jon.medhurst@linaro.org>, Lee Jones <lee.jones@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Oct 14, 2011 at 09:37:51AM +0200, Ulf Hansson wrote:
> Jon Medhurst (Tixy) wrote:
>> On Thu, 2011-10-13 at 15:29 +0100, Russell King - ARM Linux wrote:
>>> On Tue, Oct 11, 2011 at 04:06:41PM +0200, Ulf Hansson wrote:
>>>> The patch "mmc: core: move ->request() call from atomic context",
>>>> is the reason to why this change is possible. This simplifies the
>>>> error handling code execution path quite a lot and potentially also
>>>> fixes some error handling hang problems.
>>>>
>>>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>>> This doesn't look right:
>>>
>>> void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>>> {
>>>         if (err && cmd->retries) {
>>>                 host->ops->request(host, mrq);
>>>
>
> This is NOT how it looks at mmc-next. You need to test with Adrian  
> Hunters patch which the commit refers two.

In that case, how can I take the patch to mmci if it depends on something
in another tree?
