From: Chris Ball <cjb@laptop.org>
Subject: Re: [GIT PULL] at91 mmc fixes for 3.3-rc[45]
Date: Fri, 17 Feb 2012 11:28:59 -0500
Message-ID: <m24nupe850.fsf@bob.laptop.org>
References: <4F3E6BFF.9030307@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37806 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135Ab2BQQ3S (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Feb 2012 11:29:18 -0500
In-Reply-To: <4F3E6BFF.9030307@atmel.com> (Nicolas Ferre's message of "Fri, 17
	Feb 2012 16:02:23 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Hi,

On Fri, Feb 17 2012, Nicolas Ferre wrote:
> This is a couple of patches that fixes a sequence in atmel-mci during 
> DMA/PDC detection + channel handling.

Pushed to mmc-next, thanks.

> I also add the MAINTAINERS update and hand the SD/MMC drivers over to 
> Ludovic Desroches who already made great efforts to enhance them.

Okay.  Thanks for your work, Nicolas!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
