From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/3] mmc: sdio: don't power up cards on system suspend
Date: Fri, 17 Dec 2010 01:00:27 +0000
Message-ID: <20101217010026.GF17239@void.printf.net>
References: <1290921690-6133-1-git-send-email-ohad@wizery.com> <1290921690-6133-4-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46084 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753542Ab0LQBA2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Dec 2010 20:00:28 -0500
Content-Disposition: inline
In-Reply-To: <1290921690-6133-4-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi Ohad,

On Sun, Nov 28, 2010 at 07:21:30AM +0200, Ohad Ben-Cohen wrote:
> Initial SDIO runtime PM implementation took a conservative approach
> of powering up cards (and fully reinitializing them) on system suspend,
> just before the suspend handlers of the relevant drivers were executed.
> 
> To avoid redundant power and reinitialization cycles, this patch removes
> this behavior: if a card is already powered off when system suspend kicks
> in, it is left at that state.
> 
> If a card is active when a system sleep starts, everything is
> straightforward and works exactly like before. But if the card was
> already suspended before the sleep began, then when MMC core power it up
> back on resume, its run-time PM status has to be updated to reflect the
> actual post-system sleep status.
> 
> The technique to do that is borrowed from the I2C runtime PM
> implementation (for more info also see Documentation/power/runtime_pm.txt).
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

Thanks, pushed to mmc-next.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
