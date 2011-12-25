From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V3] mmc: core: Add option to prevent eMMC sleep command
Date: Sat, 24 Dec 2011 21:31:31 -0500
Message-ID: <m2y5u1xtz0.fsf@bob.laptop.org>
References: <1324308259-6770-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55709 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754186Ab1LYCbl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Dec 2011 21:31:41 -0500
In-Reply-To: <1324308259-6770-1-git-send-email-ulf.hansson@stericsson.com>
	(Ulf Hansson's message of "Mon, 19 Dec 2011 16:24:19 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Hi Ulf,

On Mon, Dec 19 2011, Ulf Hansson wrote:
> Host may now use MMC_CAP2_NO_SLEEP_CMD to disable the use
> of eMMC sleep/awake command.
>
> This option can be used when you platform have a buggy
> kernel crash dump software, which is supposed to store
> the dump on the eMMC, but is not able to wake up the eMMC
> from sleep state.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> Reviewed-by: Hanumath Prasad <hanumath.prasad@stericsson.com>
> Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Acked-by: Subhash Jadavani <subhashj@codeaurora.org>

Sorry for stepping in late, but we don't normally modify the kernel to
make life easier for buggy proprietary software -- if this patch is to
be merged, it has to make sense on its own merits.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
