From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] SDHCI: Properly enable SDIO IRQ wakeups
Date: Sun, 7 Nov 2010 21:47:04 +0000
Message-ID: <20101107214704.GC13608@void.printf.net>
References: <20101104222039.93AA69D401B@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41112 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752195Ab0KGVrH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 7 Nov 2010 16:47:07 -0500
Content-Disposition: inline
In-Reply-To: <20101104222039.93AA69D401B@zog.reactivated.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Daniel,

On Thu, Nov 04, 2010 at 10:20:39PM +0000, Daniel Drake wrote:
> A little more work was needed for SDIO IRQ wakeups to be functional.
> 
> Wake-on-WLAN on the SD WiFi adapter in the XO-1.5 laptop is now working.
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>

Thanks, pushed and queued for 2.6.37.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
