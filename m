From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/8] mmc: omap: Fix I2C dependency and make driver usable with device tree
Date: Tue, 26 Nov 2013 18:34:42 -0500
Message-ID: <87eh62enzh.fsf@octavius.laptop.org>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
	<1384396537-3486-4-git-send-email-tony@atomide.com>
	<20131114110533.GD16396@e106331-lin.cambridge.arm.com>
	<20131114172527.GD10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35755 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755547Ab3KZXev (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Nov 2013 18:34:51 -0500
In-Reply-To: <20131114172527.GD10317@atomide.com> (Tony Lindgren's message of
	"Thu, 14 Nov 2013 09:25:27 -0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Tony,

On Thu, Nov 14 2013, Tony Lindgren wrote:
> Some features can be configured by the companion I2C chips,
> which may not be available at the probe time. Fix the issue
> by returning -EPROBE_DEFER when the MMC controller slots
> are not configured.
>
> While at it, let's also add minimal device tree support so
> omap24xx platforms can use this driver without legacy mode
> since we claim to support device tree for mach-omap2 based
> systems.
>
> Although adding the minimal device tree support is not strictly
> a fix, it does remove one of the last blockers for dropping a
> bunch of legacy platform data for mach-omap2.
>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Feel free to merge via your tree:

Acked-by: Chris Ball <cjb@laptop.org>

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
