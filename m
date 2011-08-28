From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/1] mmc: Support of SDIO irq for dw_mmc
Date: Sun, 28 Aug 2011 13:46:03 -0400
Message-ID: <m28vqdzaxw.fsf@bob.laptop.org>
References: <CANYdXnqfBP74Xi1SuWJh3pjrZ4h7hjrc7xE+vXL0Bw41xEbVUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52232 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab1H1RqO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 28 Aug 2011 13:46:14 -0400
In-Reply-To: <CANYdXnqfBP74Xi1SuWJh3pjrZ4h7hjrc7xE+vXL0Bw41xEbVUw@mail.gmail.com>
	(Shashidhar Hiremath's message of "Tue, 23 Aug 2011 18:50:02 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org

Hi Shashidhar,

On Tue, Aug 23 2011, Shashidhar Hiremath wrote:
> The Patch adds the support for SDIO interrupts for all slots.
> It includes enabling of SDIO interrupts through dw_mci_enable_sdio_irq
> and the handling of the slot specific interrupts in the Interrupt Service
> Routine.

Please send a v3 patch that:
 * is not corrupt (the line starting "@@ -1249,6" is broken by a newline)
 * applies against mmc-next.

Then I'll apply it for 3.2.   Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
