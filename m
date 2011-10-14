From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: Do not release spinlock in request_end
Date: Fri, 14 Oct 2011 09:03:18 +0100
Message-ID: <20111014080318.GR21648@n2100.arm.linux.org.uk>
References: <1318342001-26955-1-git-send-email-ulf.hansson@stericsson.com> <20111013142914.GZ21648@n2100.arm.linux.org.uk> <1318521592.2090.16.camel@linaro1> <4E97E6CF.1000601@stericsson.com> <20111014074224.GQ21648@n2100.arm.linux.org.uk> <4E97EA10.6040800@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55379 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab1JNID2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Oct 2011 04:03:28 -0400
Content-Disposition: inline
In-Reply-To: <4E97EA10.6040800@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "Jon Medhurst (Tixy)" <jon.medhurst@linaro.org>, Lee Jones <lee.jones@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Oct 14, 2011 at 09:51:44AM +0200, Ulf Hansson wrote:
> Russell King - ARM Linux wrote:
>> In that case, how can I take the patch to mmci if it depends on something
>> in another tree?
>>
>
> I don't know. But how do you update your tree from next normally?

I don't - no one in their right mind does.  linux-next is not a tree
which should ever be pulled into any other git tree to base work upon
- it's completely unstable and you can't rely on any commit in there
remaining.  The merge commits between each tree are also specific to
linux-next only.

Linus will also refuse to pull any tree which has linux-next merged
into it.

> I believe the problem is more related to that the mmc-next tree is now on  
> a temporary git.

Where a tree is hosted has no influence on whether its 'temporary' or
not.

> If you do not update your tree how shall we be able to  
> continue with integration of new patches that depends on mmc patches  
> from "next"?

That's what I'm saying - I can't take the patch as it introduces bugs
if I do.  It's better to either wait until after the next merge window,
or we have to sort out merging it via the mmc tree instead.
