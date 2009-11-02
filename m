From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/6] Clean up the sdio_uart driver and fix the tty code
Date: Mon, 2 Nov 2009 22:35:35 +0000
Message-ID: <20091102223535.0d57ac09@lxorguk.ukuu.org.uk>
References: <20091102164039.11877.88825.stgit@localhost.localdomain>
	<alpine.LFD.2.00.0911021243040.13333@xanadu.home>
	<20091102191604.010acbc9@lxorguk.ukuu.org.uk>
	<alpine.LFD.2.00.0911021542520.13333@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43662 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757174AbZKBWeD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Nov 2009 17:34:03 -0500
In-Reply-To: <alpine.LFD.2.00.0911021542520.13333@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Alan Cox <alan@linux.intel.com>, linux-mmc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, dhowells@redhat.com

> However the kernel is now crashing when the card is pulled out while 
> some process is reading from the device.  This used to behave well 
> before. I don't have time to investigate that one right now though.

That usually means I've goofed on the ref counting. I'll add your patch
and review the code closely.

Thanks
Alan

