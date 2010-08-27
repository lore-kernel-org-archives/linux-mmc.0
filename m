From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: pxamci: call pdata->setpower even when regulator
	is used
Date: Fri, 27 Aug 2010 20:00:34 +0100
Message-ID: <20100827190034.GA20407@void.printf.net>
References: <1259233813-2724-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59312 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793Ab0H0TAj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 15:00:39 -0400
Content-Disposition: inline
In-Reply-To: <1259233813-2724-1-git-send-email-daniel@caiaq.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-arm-kernel@lists.infradead.org, Pierre Ossman <pierre@ossman.eu>, Eric Miao <eric.y.miao@gmail.com>, linux-mmc@vger.kernel.org

Hi,

On Thu, Nov 26, 2009 at 12:10:13PM +0100, Daniel Mack wrote:
> On platforms where the vmmc regulator is used, it might still be
> necessary to call the platform data's setpower() callback in order to
> drive GPIOs to power up hardware.
> 
> I can't see any pxamci user with power regulators enabled, hence this
> shouldn't break anything.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>

Am chasing up old patches, looks like this didn't get merged.  Eric,
any interest in taking something like this, or was your reply a NACK?

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
