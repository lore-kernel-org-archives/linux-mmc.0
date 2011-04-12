From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC] mmc: sdhci: work around broken dma boundary behavior
Date: Tue, 12 Apr 2011 13:29:49 -0400
Message-ID: <m3y63fz8c2.fsf@pullcord.laptop.org>
References: <20110314172129.GA20654@pengutronix.de>
	<1301388814-10931-1-git-send-email-mmvinni@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60943 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753914Ab1DLRZA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Apr 2011 13:25:00 -0400
In-Reply-To: <1301388814-10931-1-git-send-email-mmvinni@yahoo.com> (Mikko
	Vinni's message of "Tue, 29 Mar 2011 11:53:34 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mikko Vinni <mmvinni@yahoo.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org

Hi Mikko,

On Tue, Mar 29 2011, Mikko Vinni wrote:
> Some SD host controllers (noticed on an integrated JMicron
> SD reader on an HP Pavilion dv5-1250eo laptop) don't update
> the dma address register before signaling a dma interrupt due
> to a dma boundary. Update the register manually to the next
> boundary (by default 512KiB), at which the transfer stopped.
>
> As long as each transfer is at most 512KiB in size (guaranteed
> by a BUG_ON in sdhci_prepare_data()) and the boundary is kept
> at the default value, this fix is needed at most once per
> transfer. Smaller boundaries are taken care of by counting
> the transferred bytes.
>
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=28462
>
> Signed-off-by: Mikko Vinni <mmvinni@yahoo.com>

I know you posted this as an RFC, but I've pushed it to mmc-next for
testing now, and will plan on merging it for .40 if everything goes well.
Thanks very much!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
