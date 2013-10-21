From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: bfin_sdh: Forgot to write SDH_CFG register in function set_ios.
Date: Sun, 20 Oct 2013 21:29:10 -0400
Message-ID: <878uxn9ztl.fsf@octavius.laptop.org>
References: <1381902125-23597-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56591 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098Ab3JUB3Q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 20 Oct 2013 21:29:16 -0400
In-Reply-To: <1381902125-23597-1-git-send-email-sonic.adi@gmail.com> (Sonic
	Zhang's message of "Wed, 16 Oct 2013 13:42:05 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: linux-mmc@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net, Sonic Zhang <sonic.zhang@analog.com>

Hi Sonic,

On Wed, Oct 16 2013, Sonic Zhang wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
>
> The DMA operation in SDIO CMD53 may fail because the 4 bit SDIO mode
> is not set up correctly on BF548.
> Remove 2 blank lines as well.
>
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>

Thanks, pushed to mmc-next for 3.13.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
