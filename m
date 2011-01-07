From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] mmc: mshci: Add support Mobile Storage Host Controller
	Interface
Date: Fri, 7 Jan 2011 12:41:21 +0000
Message-ID: <20110107124121.GJ27131@trinity.fluff.org>
References: <1294399237-5716-1-git-send-email-kgene.kim@samsung.com> <20110107115123.GD32436@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:51736 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899Ab1AGMle (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 7 Jan 2011 07:41:34 -0500
Content-Disposition: inline
In-Reply-To: <20110107115123.GD32436@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org, akpm@linux-foundation.org, cjb@laptop.org, Hyunsung Jang <hs79.jang@samsung.com>, Hyuk Lee <hyuk1.lee@samsung.com>

On Fri, Jan 07, 2011 at 12:51:23PM +0100, Wolfram Sang wrote:
> 
> > The 'mshci.c' is based on 'linux/drivers/mmc/host/sdhci.c' and
> > the role is exactly same with that.
> 
> Can you sum up the differences why you cannot sdhci.c directly, please?

I second that.

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

