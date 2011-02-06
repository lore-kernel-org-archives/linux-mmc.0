From: Chris Ball <cjb@laptop.org>
Subject: Re: [BUG] CMD52 sent as first command not CMD0
Date: Sun, 6 Feb 2011 01:15:14 +0000
Message-ID: <20110206011514.GA15322@void.printf.net>
References: <C85F98EE-B8C5-4037-A0FF-203265A7575C@marvell.com> <20110206003845.GA15019@void.printf.net> <BC6C6C10-631A-4482-BA1B-C6F0057BC54A@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55136 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747Ab1BFBPP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 5 Feb 2011 20:15:15 -0500
Content-Disposition: inline
In-Reply-To: <BC6C6C10-631A-4482-BA1B-C6F0057BC54A@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Albert Herranz <albert_herranz@yahoo.es>

On Sat, Feb 05, 2011 at 04:52:12PM -0800, Philip Rakity wrote:
> nothing negative but reset is meant to reinit the card.  This is the power up sequence for the 1st time a card is detected.
> There is no reason to do this if no card has yet enumerated.  If a sdio card was there I completely agree with the mod since we need to reset 
> the card. 
> 
> CMD0 should be the 1st command on an initial power up sequence.  Does my code suggestion work for you ?

Okay -- yes, looks fine.  Let's add a comment beforehand; something like:

/* If reinitalizing, we must send CMD52 before CMD0 for SDIO. */

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
