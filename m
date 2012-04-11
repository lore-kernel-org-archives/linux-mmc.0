From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: remove linux/blkdev.h include from host drivers
Date: Wed, 11 Apr 2012 11:39:12 -0400
Message-ID: <87ty0qs2fz.fsf@laptop.org>
References: <1334084783-3572-1-git-send-email-mad_soft@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1334084783-3572-1-git-send-email-mad_soft@inbox.ru> (Dmitry
	Artamonow's message of "Tue, 10 Apr 2012 23:06:23 +0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Artamonow <mad_soft@inbox.ru>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

Hi Sascha, Wolfram,

On Tue, Apr 10 2012, Dmitry Artamonow wrote:
> I've compile tested everything with and without CONFIG_BLOCK enabled,
> except for imxmmc.c - this driver seems to be long time broken
> (at least since the removal of mach-imx in 2.6.31 - see commit
> 1341d34ffc296f98dc84876f35f3151525dc02a2 ) 

I can confirm that it no longer builds:

/home/cjb/git/mmc/drivers/mmc/host/imxmmc.c:32:26: fatal error: mach/imx-dma.h: No such file or directory

Should imxmmc simply be removed from drivers/mmc/host?  Do any of the
more current i.MX MMC drivers support the same hardware?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
