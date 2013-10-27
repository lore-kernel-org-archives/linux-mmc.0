From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/5] mmc: omap_hsmmc: Fix pbias_disable for omap4
Date: Sat, 26 Oct 2013 21:30:58 -0400
Message-ID: <87eh77lctp.fsf@octavius.laptop.org>
References: <1382295322-18995-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33013 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753344Ab3J0BbC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 26 Oct 2013 21:31:02 -0400
In-Reply-To: <1382295322-18995-1-git-send-email-balajitk@ti.com> (Balaji
	T. K.'s message of "Mon, 21 Oct 2013 00:25:18 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org

Hi Balaji,

On Sun, Oct 20 2013, Balaji T K wrote:
> pbias_disable is set to protect the mmc pbias i/o cells in DT boot
> by preventing voltage switch. Currently pbias_disable is enabled only
> for omap3 and not for omap4 due to reg_offset difference of 0x100.
> Enable pbias_disable for omap4+ too by using res->start
> which does not include the reg_offset.
>
> Signed-off-by: Balaji T K <balajitk@ti.com>

Thanks, all five patches in this series pushed to mmc-next for 3.13.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
