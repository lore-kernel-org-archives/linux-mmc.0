From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1 v3] mmc: Support of SDIO irq for dw_mmc
Date: Mon, 29 Aug 2011 10:57:43 -0400
Message-ID: <m2pqjow9i0.fsf@bob.laptop.org>
References: <1314603706-4136-1-git-send-email-shashidharh@vayavyalabs.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53654 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753579Ab1H2O7J (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Aug 2011 10:59:09 -0400
In-Reply-To: <1314603706-4136-1-git-send-email-shashidharh@vayavyalabs.com>
	(Shashidhar Hiremath's message of "Mon, 29 Aug 2011 13:11:46 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org

Hi,

On Mon, Aug 29 2011, Shashidhar Hiremath wrote:
> The Patch adds the support for SDIO interrupts for all slots.
> It includes enabling of SDIO interrupts through dw_mci_enable_sdio_irq
> and the handling of the slot specific interrupts in the Interrupt Service
> Routine.

Thanks, looks good, applied to mmc-next for 3.2.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
