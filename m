From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 4/4] mmc: omap_hsmmc: Fix NULL pointer dereference for dt boot
Date: Mon, 29 Oct 2012 12:55:30 -0400
Message-ID: <87txtdtdz1.fsf@octavius.laptop.org>
References: <1350317108-10657-1-git-send-email-svenkatr@ti.com>
	<1350317108-10657-4-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56902 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758586Ab2J2Qzf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Oct 2012 12:55:35 -0400
In-Reply-To: <1350317108-10657-4-git-send-email-svenkatr@ti.com> (Venkatraman
	S.'s message of "Mon, 15 Oct 2012 21:35:08 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

Hi,

On Mon, Oct 15 2012, Venkatraman S wrote:
> From: Balaji T K <balajitk@ti.com>
>
> dev->platform_data is NULL in case of device tree boot,
> instead use the saved version in struct omap_hsmmc_host.
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
