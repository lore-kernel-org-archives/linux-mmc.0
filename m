From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: OMAP: make MMC_OMAP* depend on DMA_OMAP
Date: Thu, 19 Jul 2012 10:41:57 -0400
Message-ID: <87liif95je.fsf@octavius.laptop.org>
References: <1341450721-20993-1-git-send-email-ming.lei@canonical.com>
	<87pq7s9w8f.fsf@octavius.laptop.org>
	<CANfBPZ8K3=EG296_ZBd_ZaMaKPCXx4YWBOT6LjCy9T6ZsVhRHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53232 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894Ab2GSOmD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Jul 2012 10:42:03 -0400
In-Reply-To: <CANfBPZ8K3=EG296_ZBd_ZaMaKPCXx4YWBOT6LjCy9T6ZsVhRHw@mail.gmail.com>
	(Venkatraman S.'s message of "Thu, 19 Jul 2012 16:59:45 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>, Kevin Hilman <khilman@ti.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-mmc@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>

Hi,

On Thu, Jul 19 2012, S, Venkatraman wrote:
> Chris,
>  I think we have to hold on to this patch just for today. There's
> another thread about this same issue on linux-omap

Thanks, I've dropped it from mmc-next -- I'll wait for Russell or Tony
to agree with one of the patches.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
