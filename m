From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Tue, 22 Feb 2011 15:26:53 +0000
Message-ID: <20110222152653.GA6563@void.printf.net>
References: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48670 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754083Ab1BVP0z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 22 Feb 2011 10:26:55 -0500
Content-Disposition: inline
In-Reply-To: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arnd@arndb.de, w.sang@pengutronix.de, linux@arm.linux.org.uk

Hi Shawn,

On Mon, Feb 21, 2011 at 06:35:28PM +0800, Shawn Guo wrote:
> This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> The driver calls into mxs-dma via generic dmaengine api for both pio
> and data transfer.

Thanks very much, pushed to mmc-next for .39.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
