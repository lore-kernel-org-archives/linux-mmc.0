From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/6] Clean up the sdio_uart driver and fix the tty code
Date: Mon, 2 Nov 2009 19:16:04 +0000
Message-ID: <20091102191604.010acbc9@lxorguk.ukuu.org.uk>
References: <20091102164039.11877.88825.stgit@localhost.localdomain>
	<alpine.LFD.2.00.0911021243040.13333@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52169 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755766AbZKBTOb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Nov 2009 14:14:31 -0500
In-Reply-To: <alpine.LFD.2.00.0911021243040.13333@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Alan Cox <alan@linux.intel.com>, linux-mmc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, dhowells@redhat.com

> However I have problems applying your patches.  Most of them require 
> fuzzy patching to apply, and one of them even doesn't apply that way.  
> What is your base tree?

Linux-next, but there is a patch I posted afterwards that goes before the
sdio_uart patches. Want me to send you a set with all the patches
including the other one ?
