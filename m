From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] sdio: fix suspend/resume regression
Date: Thu, 21 Oct 2010 19:55:13 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010211952110.2764@xanadu.home>
References: <1286788315.3101.11.camel@sven>
 <1286955116-22793-1-git-send-email-ohad@wizery.com>
 <1287704855.12734.14.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:12291 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab0JUXzO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Oct 2010 19:55:14 -0400
In-reply-to: <1287704855.12734.14.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Sven Neumann <s.neumann@raumfeld.com>, Chris Ball <cjb@laptop.org>, libertas-dev@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Mack <daniel@caiaq.de>, Colin Cross <ccross@android.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@kernel.org

On Fri, 22 Oct 2010, Maxim Levitsky wrote:

> So what happens if you set .suspend to NULL? instead of -ENOSYS return?

At run time, the driver may decide to handle the suspend request and 
return 0, or decide to simply return -ENOSYS if it doesn't want to 
bother with the suspend meaning that the card should be removed, or 
return another error code meaning that the suspend request must be 
aborted.



Nicolas
