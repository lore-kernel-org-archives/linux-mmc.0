From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH] mmc: sdhci: add quirk for broken write protect detection
Date: Mon, 24 Feb 2014 00:12:45 +0000
Message-ID: <86r46ts70i.fsf@void.printf.net>
References: <1393198345-8365-1-git-send-email-eli.billauer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50793 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976AbaBXAMx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 23 Feb 2014 19:12:53 -0500
In-Reply-To: <1393198345-8365-1-git-send-email-eli.billauer@gmail.com> (Eli
	Billauer's message of "Mon, 24 Feb 2014 01:32:25 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eli Billauer <eli.billauer@gmail.com>
Cc: michal.simek@xilinx.com, linux-mmc@vger.kernel.org

Hi Eli,

On Sun, Feb 23 2014, Eli Billauer wrote:
> The write protection signal is absent on a board based upon Xilinx' Zynq
> processor ("ZyBo"). This leads the kernel to think that the MicroSD card is
> write protected, and causes a kernel panic during boot, as root fails to
> mount RW.
>
> This patch adds a quirk and an optional OF property, sdhci,wp-broken to
> work around this issue.

Just to confirm your motivation for the patch:  wp-inverted would solve
this problem for you, but you'd rather add a new property that more
accurately describes the hardware?

(We'd probably use broken-wp, for symmetry with the existing broken-cd.)

Thanks,

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
