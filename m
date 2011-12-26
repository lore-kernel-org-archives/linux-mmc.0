From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/4 v3] mmc: sh_mmcif: process requests asynchronously
Date: Sun, 25 Dec 2011 20:48:53 -0500
Message-ID: <m2y5u0w1a2.fsf@bob.laptop.org>
References: <Pine.LNX.4.64.1111301553330.22197@axis700.grange>
	<1323887514-12650-4-git-send-email-g.liakhovetski@gmx.de>
	<m2boqxz91n.fsf@bob.laptop.org>
	<Pine.LNX.4.64.1112252105340.22951@axis700.grange>
	<m2aa6gxog7.fsf@bob.laptop.org>
	<Pine.LNX.4.64.1112252358050.22951@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45395 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753538Ab1LZBtC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Dec 2011 20:49:02 -0500
In-Reply-To: <Pine.LNX.4.64.1112252358050.22951@axis700.grange> (Guennadi
	Liakhovetski's message of "Mon, 26 Dec 2011 00:00:16 +0100 (CET)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi,

On Sun, Dec 25 2011, Guennadi Liakhovetski wrote:
> Hmmm, that's very weird - I rebased my patch series on top of your 
> mmc-next from a couple of hours ago. Sorry for asking, but you've also 
> applied the leading two patches from this series, right? This is what my 
> log of this driver looks like now:

Oops, that's it, thanks.

Now I have:

13cb975 (HEAD, mmc-next) mmc: sh_mmcif: cosmetic clean up
9e66e1c mmc: sh_mmcif: process error interrupts first
9092a17 mmc: convert drivers/mmc/host/* to use module_platform_driver()
2736566 mmc: sh_mmcif: simplify clock divisor calculation
58f1934 mmc: sh_mmcif: fix clock gating on platforms with a .down_pwr() method
88b4767 mmc: Add module.h to drivers/mmc users assuming implicit presence.
714c4a6 mmc: sh_mmcif: simplify platform data
c9b0cef mmc: sh_mmcif: maximize power saving

But 4/4 ("mmc: sh_mmcif: remove now superfluous sh_mmcif_host::data
member") isn't applying without fuzz (offset 13 lines).  Any ideas/want
to resend it?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
