From: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Subject: RE: [RFC 1/2] mmc: davinci: Eliminate spurious interrupts
Date: Fri, 27 Jan 2012 08:11:55 +0000
Message-ID: <B6A220404B6BFC4BBD2AB91C54D39DF43176A5C7@DBDE01.ent.ti.com>
References: <4F1E9194.90608@mvista.com>
 <1327403766-962-1-git-send-email-ido@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43240 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509Ab2A0IMI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Jan 2012 03:12:08 -0500
In-Reply-To: <1327403766-962-1-git-send-email-ido@wizery.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ido Yariv <ido@wizery.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "Nori, Sekhar" <nsekhar@ti.com>

Hello Ido,

On Tue, Jan 24, 2012 at 16:46:05, Ido Yariv wrote:
> The davinci mmc interrupt handler fills the fifo, as long as the DXRDY
> or DRRDY bits are set in the status register.
> 
> If interrupts fire during this loop, they will be handled by the
> handler, but the interrupt controller will still buffer these. As a
> result, the handler will be called again to serve these needlessly. In
> order to avoid these spurious interrupts, keep interrupts masked while
> filling the fifo.
> 

I tested both these patches and they work fine on the OMAP-L138 EVM. I
observed that with these patches the number of interrupts during a transfer
are less compared to earlier. For a 100 MB transfer, I could see around
700-800 interrupts less. Did you see any performance improvement with these
patches?

Thanks,
Sudhakar
