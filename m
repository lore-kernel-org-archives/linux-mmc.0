From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: assume maintainership
Date: Fri, 16 Mar 2012 08:53:07 +0000
Message-ID: <20120316085307.GC17243@flint.arm.linux.org.uk>
References: <1331821836-14641-1-git-send-email-linus.walleij@stericsson.com> <20120315173047.GB17243@flint.arm.linux.org.uk> <4F62FE47.8020709@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56059 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422635Ab2CPIxk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Mar 2012 04:53:40 -0400
Content-Disposition: inline
In-Reply-To: <4F62FE47.8020709@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Linus WALLEIJ <linus.walleij@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, Pawel Moll <pawel.moll@arm.com>

On Fri, Mar 16, 2012 at 09:48:07AM +0100, Ulf Hansson wrote:
> Although, right know I would vote for having a more active maintainer  
> for MMCI; please no offense Russell, I realize that your are fully  
> occupied with a lot of other cool stuff. I think Linus could play a  
> great role in this; especially since he also will be able to test  
> patches on many different ARM boards.

No, I explained why I haven't applied your other patches, and I explained
at the time my concerns with your patches which zero out and restore the
power and clock registers.  I repeated those concerns several times but
the issue never got resolved.

So that gives me no other option than to slow down applying your patches.
It's not that I'm not being responsive.  It's that I'm purposely being
slow over these changes because comments on the patches don't seem to be
hitting home.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
