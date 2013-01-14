From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci: introduce sdhci_update_clock helper to re-enable clock
Date: Mon, 14 Jan 2013 14:45:45 -0500
Message-ID: <87fw23sg46.fsf@laptop.org>
References: <1357569068-9563-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34644 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757040Ab3ANTp7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Jan 2013 14:45:59 -0500
In-Reply-To: <1357569068-9563-1-git-send-email-andriy.shevchenko@linux.intel.com>
	(Andy Shevchenko's message of "Mon, 7 Jan 2013 16:31:08 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Mon, Jan 07 2013, Andy Shevchenko wrote:
> There are three places where same piece of code is used. Let's split it to a
> separate function.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, pushed to mmc-next for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
