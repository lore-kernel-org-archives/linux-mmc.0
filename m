From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mmci: assume maintainership
Date: Mon, 09 Apr 2012 18:44:48 -0400
Message-ID: <874nssy17j.fsf@laptop.org>
References: <1331821836-14641-1-git-send-email-linus.walleij@stericsson.com>
	<20120315173047.GB17243@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39221 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507Ab2DIWot (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 Apr 2012 18:44:49 -0400
In-Reply-To: <20120315173047.GB17243@flint.arm.linux.org.uk> (Russell King's
	message of "Thu, 15 Mar 2012 17:30:47 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, Pawel Moll <pawel.moll@arm.com>

Hi Russell,

On Thu, Mar 15 2012, Russell King wrote:
> On Thu, Mar 15, 2012 at 03:30:36PM +0100, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>> 
>> So since this driver is crucial for us (as in ST-Ericsson)
>> to have actively maintained, and since it is marked orphaned
>> I will assume maintainership for it starting with the 3.5
>> integration cycle. The idea is to collect patches and send
>> either patch sets of pull requests to Chris.
>
> Actually, I still want to be involved because I'm far from convinced with
> some of the patches coming from Ulf are correct for ARMs implementation.
> That's why I'm purposely not applying the MMCI patches in the patch system
> in a particularly fast manner - I want there to be a decent amount of
> testing between each set of patches.
> [..]
> So, it's not really unmaintained or orphaned...

Please could you send a MAINTAINERS patch to Linus adding yourself for MMCI?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
