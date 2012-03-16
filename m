From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH REPOST 1/2] mmc: davinci: Eliminate spurious interrupts
Date: Thu, 15 Mar 2012 23:32:42 -0400
Message-ID: <873999cjad.fsf@laptop.org>
References: <B6A220404B6BFC4BBD2AB91C54D39DF43176B8CE@DBDE01.ent.ti.com>
	<1331501999-13144-1-git-send-email-ido@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46496 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965275Ab2CPDcg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 15 Mar 2012 23:32:36 -0400
In-Reply-To: <1331501999-13144-1-git-send-email-ido@wizery.com> (Ido Yariv's
	message of "Sun, 11 Mar 2012 23:39:58 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ido Yariv <ido@wizery.com>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-mmc@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com

Hi,

On Sun, Mar 11 2012, Ido Yariv wrote:
> The davinci mmc interrupt handler fills the fifo, as long as the DXRDY
> or DRRDY bits are set in the status register.
>
> If interrupts fire during this loop, they will be handled by the
> handler, but the interrupt controller will still buffer these. As a
> result, the handler will be called again to serve these needlessly. In
> order to avoid these spurious interrupts, keep interrupts masked while
> filling the fifo.
>
> Signed-off-by: Ido Yariv <ido@wizery.com>
> Tested-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>

Thanks, I've pushed both of these two patches to mmc-next for 3.4 now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
