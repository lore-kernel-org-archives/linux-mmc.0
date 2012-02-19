From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] ARM: OMAP: hsmmc: add max_freq field
Date: Sun, 19 Feb 2012 11:16:02 -0500
Message-ID: <m2zkce6bp9.fsf@bob.laptop.org>
References: <1329654033-19584-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58138 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138Ab2BSQQO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 19 Feb 2012 11:16:14 -0500
In-Reply-To: <1329654033-19584-1-git-send-email-zonque@gmail.com> (Daniel
	Mack's message of "Sun, 19 Feb 2012 13:20:33 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>

Hi,

On Sun, Feb 19 2012, Daniel Mack wrote:
> External circuitry like level shifters may limit the maximum operation
> speed of the hsmmc controller. Add a field to struct omap2_hsmmc_info
> so boards can adjust the setting on demand.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> ---
>
> This trivial patch is in my queue for some time already, and Tony acked
> on it awhile back. I was told to take Chris Ball in the loop as there
> is currently no OMAP MMC maintainer.
>
> This still applies cleanly to 3.3-rc4. Chris, can you queue this?

Thanks, queued in mmc-next now.  (The arch/arm/mach-omap2/hsmmc.c
change did not apply cleanly, though; I fixed that.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
