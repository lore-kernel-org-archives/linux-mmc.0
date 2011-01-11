From: Chris Ball <cjb@laptop.org>
Subject: Re: [REVIEW 2/2] ENGR0000137838 SDHCI Some eMMC cards can't work
	well in our BSP
Date: Tue, 11 Jan 2011 02:07:44 +0000
Message-ID: <20110111020743.GA9534@void.printf.net>
References: <1294711368-446-1-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45723 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753277Ab1AKCHr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Jan 2011 21:07:47 -0500
Content-Disposition: inline
In-Reply-To: <1294711368-446-1-git-send-email-r65037@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <r65037@freescale.com>
Cc: r58066@freescale.com, root@udp161639uds.ap.freescale.net, lnxrevli@freescale.com, linux-mmc@vger.kernel.org

Hi,

On Tue, Jan 11, 2011 at 10:02:48AM +0800, Richard Zhu wrote:
> Pick up the patch from the community.
> 
> fc8a0985c2846292312556cba10b8a4182f55967
> From: Hanumath Prasad <hanumath.prasad@stericsson.com>
> Date: Tue, 10 Aug 2010 18:01:45 -0700
> Subject: [REVIEW 2/2] mmc: only set blockaddressed for > 2GiB cards
> 
> A non-zero value of SEC_COUNT does not indicate that the card is sector
> addressed. According to the MMC specification, cards
> with a densitygreater than 2GiB are sector addressed.

What's the point of sending this mail to linux-mmc@?

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
