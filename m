From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: Replace SDHCI_QUIRK_FORCE_BLK_SZ_2048 with a pklatform hook.
Date: Sat, 28 May 2011 22:27:41 -0400
Message-ID: <m3mxi6p7fm.fsf@pullcord.laptop.org>
References: <m31v3lofm1.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33198 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003Ab1E2C0l (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 28 May 2011 22:26:41 -0400
In-Reply-To: <m31v3lofm1.fsf@pullcord.laptop.org> (Chris Ball's message of
	"Sun, 06 Feb 2011 01:13:10 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>

Hi,

On Sun, Feb 06 2011, Chris Ball wrote:
> Part of a quirk cleanup run.  This quirk was only used by sdhci-esdhc.
> This patch is untested.
>
> Signed-off-by: Chris Ball <cjb@laptop.org>
> Cc: Anton Vorontsov <cbouatmailru@gmail.com>
> Cc: Wolfram Sang <w.sang@pengutronix.de>

I've queued this patch now, since we're out of quirk bits and didn't come
up with any alternative patches.  (Feel free to improve on it later.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
