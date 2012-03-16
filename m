From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: mmci: assume maintainership
Date: Fri, 16 Mar 2012 10:24:44 +0100
Message-ID: <4F6306DC.5090601@stericsson.com>
References: <1331821836-14641-1-git-send-email-linus.walleij@stericsson.com> <20120315173047.GB17243@flint.arm.linux.org.uk> <4F62FE47.8020709@stericsson.com> <20120316085307.GC17243@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:44839 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759772Ab2CPJZK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Mar 2012 05:25:10 -0400
In-Reply-To: <20120316085307.GC17243@flint.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus WALLEIJ <linus.walleij@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, Pawel Moll <pawel.moll@arm.com>

On 03/16/2012 09:53 AM, Russell King wrote:
> On Fri, Mar 16, 2012 at 09:48:07AM +0100, Ulf Hansson wrote:
>> Although, right know I would vote for having a more active maintainer
>> for MMCI; please no offense Russell, I realize that your are fully
>> occupied with a lot of other cool stuff. I think Linus could play a
>> great role in this; especially since he also will be able to test
>> patches on many different ARM boards.
>
> No, I explained why I haven't applied your other patches, and I explained
> at the time my concerns with your patches which zero out and restore the
> power and clock registers.  I repeated those concerns several times but
> the issue never got resolved.
>
> So that gives me no other option than to slow down applying your patches.
> It's not that I'm not being responsive.  It's that I'm purposely being
> slow over these changes because comments on the patches don't seem to be
> hitting home.
>

Then I totally misunderstood you. I did send you an explanation to why 
the registers could be zeroed out, which you did not respond to.

Moreover, I did not receive any comments/acks on the other patches. Are 
you only looking at the first one in a patch series or do you mean that 
the other onces looks OK? If so, I can definitely try to rebase the 
series and move the power management patches later in serie... Just tell 
me and I will do it!


Br
Ulf Hansson


