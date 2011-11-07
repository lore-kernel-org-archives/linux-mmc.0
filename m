From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] SD/MMC: fix the issue of SDHC performance regression
Date: Mon, 07 Nov 2011 08:20:10 -0500
Message-ID: <m2ipmw133p.fsf@bob.laptop.org>
References: <1320658589-13143-1-git-send-email-b32616@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57947 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754377Ab1KGNUR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Nov 2011 08:20:17 -0500
In-Reply-To: <1320658589-13143-1-git-send-email-b32616@freescale.com> (Qiang
	Liu's message of "Mon, 7 Nov 2011 17:36:29 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Qiang Liu <b32616@freescale.com>
Cc: linux-mmc@vger.kernel.org, leoli@freescale.com, kumar.gala@freescale.com

Hi,

On Mon, Nov 07 2011, Qiang Liu wrote:
> Low performance of SDHC (half of before) due to its frequency was set to 25MHz,
> but not 50MHz (involved by commit id 013909c4ffd16ded4895528b856fd8782df04dc6,
> add support for query function modes for uhs cards according to Physical Layer
> SPEC V3.01).
>
> Set high speed max frequency according to response status of CMD6, but
> not for SPEC Version. Response of switch command is first consideration
> factor when set SDHC max working frequency. TRAN_SPEED in CSD register
> will be seemed as the second factor.
>
> Signed-off-by: Qiang Liu <qiang.liu@freescale.com>

Have you seen:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=f2815f68dabbb373fd1c9f0fd4a609d486697c2b 
("mmc: sd: Handle SD3.0 cards not supporting UHS-I bus speed mode")

which is already in mainline?  I think your patch is identical.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
