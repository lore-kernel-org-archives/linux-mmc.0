From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH 3/3] MMC/SD: add callback function to detect card
Date: Sun, 5 Sep 2010 22:46:21 +0100
Message-ID: <20100905214621.GA24748@console-pimps.org>
References: <1259913309-27146-1-git-send-email-r66093@freescale.com>
 <20100827190513.GC20407@void.printf.net>
 <20100831191040.GB7847@console-pimps.org>
 <4C7D56AB.1060307@nokia.com>
 <4C7D5AB1.3020306@nokia.com>
 <4C7D5EA5.2060701@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:54530 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754264Ab0IEVqX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Sep 2010 17:46:23 -0400
Content-Disposition: inline
In-Reply-To: <4C7D5EA5.2060701@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Chris Ball <cjb@laptop.org>, "r66093@freescale.com" <r66093@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>

On Tue, Aug 31, 2010 at 10:57:25PM +0300, Adrian Hunter wrote:
> 
> But now I think it should be in the mmc_rescan() function
> because that is where the main other use of .get_cd()
> is, and also the only call of .detect().

That's a very good point. Aren't we duplicating the code in mmc_rescan()
with this patch? If there's something that mmc_rescan() isn't doing,
wouldn't it be better to modify that function instead of pushing it down
into the bus_ops detect functions?
