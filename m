From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/3] Improve MMC error handling (3rd rev)
Date: Tue, 21 Jun 2011 12:23:30 -0400
Message-ID: <m2y60vrw59.fsf@bob.laptop.org>
References: <20110620190945.GK26089@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54150 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756881Ab1FUQXk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Jun 2011 12:23:40 -0400
In-Reply-To: <20110620190945.GK26089@n2100.arm.linux.org.uk> (Russell King's
	message of "Mon, 20 Jun 2011 20:09:45 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Hi Russell,

On Mon, Jun 20 2011, Russell King - ARM Linux wrote:
> This is the third revision of my improvements to the MMC block
> device error handling, which makes error handling more robust
> and permits MMC/SD to continue working in the presence of
> not-quite-perfect setups.
>
> Without this, my Versatile Express tends to fail to mount its rootfs
> on SD.  With this, it can successfully read and write data from the
> card in the presence of FIFO overruns and underruns, and also sensibly
> recover from command channel errors.
>
> There is more to come, but this is the "safer" bits of the improvements.
>
>  drivers/mmc/card/block.c |  279 ++++++++++++++++++++++++++++++++++-----------
>  include/linux/mmc/mmc.h  |   10 ++
>  2 files changed, 221 insertions(+), 68 deletions(-)

Thanks, pushed to mmc-next for 3.1.

(I'll do some more testing myself and let you know if I find anything
unexpected.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
