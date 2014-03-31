From: Paolo Pisati <p.pisati@gmail.com>
Subject: Re: 3.1[34]: omap4: panda: hang on reboot?
Date: Mon, 31 Mar 2014 23:56:59 +0200
Message-ID: <20140331215659.GA8214@luxor.wired.org>
References: <20140327175414.GA5795@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140327175414.GA5795@luxor.wired.org>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc' <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Mar 27, 2014 at 06:54:14PM +0100, Paolo Pisati wrote:
> I've been experiencing hangs on reboot on two different panda boards (es rev1
> and vanilla rev a1) with v3.14-rc8 (but reproducible in 3.13 too):
> 
> toolchanin: gcc version 4.8.1 (Ubuntu/Linaro 4.8.1-10ubuntu7)
> 
> the config is a multi_v7_defconfig plus a couple of codepages:
> 
> http://people.canonical.com/~ppisati/omap4_reboot_hangs/config
> 
> a prebuilt zImage is available here:
> 
> http://people.canonical.com/~ppisati/omap4_reboot_hangs/zImage
> 
> sometimes i can hit this two times in a row, others it's a bit less
> frequent - put this into your crontab and let it go:
> 
> */5 * * * *       /bin/date >> /reboot.log && /sbin/reboot
> 
> it never passed 2hrs of reboot cycles.
> 
> I already tried different u-boots but that doesn't make any difference,
> am i the only one experiencing this issue?

i bisected it down to this commit:

commit e002264f7e45d7661b237045577052fd0b40f89c
Author: Balaji T K <balajitk@ti.com>
Date:   Mon Oct 21 00:25:18 2013 +0530

    mmc: omap_hsmmc: Fix pbias_disable for omap4
    
    pbias_disable is set to protect the mmc pbias i/o cells in DT boot
    by preventing voltage switch. Currently pbias_disable is enabled only
    for omap3 and not for omap4 due to reg_offset difference of 0x100.
    Enable pbias_disable for omap4+ too by using res->start
    which does not include the reg_offset.
    
    Signed-off-by: Balaji T K <balajitk@ti.com>
    Signed-off-by: Chris Ball <cjb@laptop.org>

with this commit reverted, i can reboot in a loop for hours without any problem,
while if i keep this patch, my pandas don't survive more that two hours (again,
it's really random as it could hang a couple of times in a row and then work
like a charm for ten reboots straight).

Any idea? does it ring any bell?

-- 
bye,
p.
