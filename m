From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC} sdhci.c set_ios -- disable global interrupts and
 Question on Power Management
Date: Tue, 15 Feb 2011 10:13:36 +0100
Message-ID: <20110215091336.GB13934@pengutronix.de>
References: <7953F5A4-7BFA-4E40-8202-C682C0314F49@marvell.com>
 <AANLkTimh2cZbtnoSLQ7ddq9hFxx7ddfM-NJmaS1f=pXh@mail.gmail.com>
 <447896B1-8836-4DFE-A00D-D41C395C79FC@marvell.com>
 <B040EC60-E156-4863-A735-15876F835FA1@marvell.com>
 <AANLkTikYYo4bJxQEa3+p=gE8iKNHxxbv7JPjB6vnywrs@mail.gmail.com>
 <20110214095528.GA30100@pengutronix.de>
 <E318EA02-8219-41BD-81B0-90C91E84F2D8@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60651 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab1BOJNi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 04:13:38 -0500
Content-Disposition: inline
In-Reply-To: <E318EA02-8219-41BD-81B0-90C91E84F2D8@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Pierre Tardy <tardyp@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Feb 14, 2011 at 09:27:52AM -0800, Philip Rakity wrote:
> 
> I wonder if I can remove the locking (spin_lock).  The disable and enable irq should be enough.  

I discussed this shortly with Sascha yesterday and we agree the core serializes
requests to the host (by means of mmc_claim_host and synchronus requests).
Protecting only the interrupts works for drivers like pxa and mxc. Such locking
might or might not be not enough for sdhci, but that would have to be carefully
evaluated. Should be worth trying, though (unless we missed something).

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
