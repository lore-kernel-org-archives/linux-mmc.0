From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc_test: Don't warn about not waiting for busy if
	controller can't do this
Date: Sun, 6 Feb 2011 20:31:04 +0000
Message-ID: <20110206203104.GA23366@void.printf.net>
References: <1295283631-7965-1-git-send-email-pawel.moll@arm.com> <20110206195359.3dfeef7a@mfleming-mobl1.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56475 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984Ab1BFUbI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 6 Feb 2011 15:31:08 -0500
Content-Disposition: inline
In-Reply-To: <20110206195359.3dfeef7a@mfleming-mobl1.ger.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Pawel Moll <pawel.moll@arm.com>, linux-mmc@vger.kernel.org

Hi,

On Sun, Feb 06, 2011 at 07:53:59PM +0000, Matt Fleming wrote:
> On Mon, 17 Jan 2011 17:00:31 +0000
> Pawel Moll <pawel.moll@arm.com> wrote:
> 
> > If the MMC host controller does not support waiting for card signaling
> > busy state (MMC_CAP_WAIT_WHILE_BUSY cap), there is no point in prining
> > the relevant warning message.
> > 
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > ---
> >  drivers/mmc/card/mmc_test.c |    7 ++++---
> >  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> Seems straight forward.
> 
> Reviewed-by: Matt Fleming <matt@console-pimps.org>

Thanks very much, pushed to mmc-next with Matt's Reviewed-by.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
