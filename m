From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCHv4 0/3] OMAP: HSMMC: cleanup and runtime pm
Date: Sat, 09 Jul 2011 18:30:51 -0400
Message-ID: <m2d3hjjdd0.fsf@bob.laptop.org>
References: <1309538376-23260-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58972 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309Ab1GIWbC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 9 Jul 2011 18:31:02 -0400
In-Reply-To: <1309538376-23260-1-git-send-email-balajitk@ti.com> (Balaji
	T. K.'s message of "Fri, 1 Jul 2011 22:09:33 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, tony@atomide.com, madhu.cr@ti.com, khilman@ti.com, b-cousson@ti.com, paul@pwsan.com, kishore.kadiyala@ti.com

Hi Balaji,

On Fri, Jul 01 2011, Balaji T K wrote:
> Balaji T K (3):
>   MMC: OMAP: HSMMC: Remove lazy_disable
>   MMC: OMAP: HSMMC: add runtime pm support
>   MMC: OMAP: HSMMC: Remove unused iclk

I've merged these three patches to mmc-next for 3.1 now.

> MMC runtime patch has dependency on
> [PATCH 0/6] OMAP2+: hwmod framework fixes [1]
> for MMC1/MMC2 clock to get ungated after idle in OMAP4.
>
> Without [1] patches, MMC1/MMC2 fails to get detected on OMAP4.
>
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg51457.html

I'm assuming that these patches are going to make their way to Linus via
someone else's tree.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
