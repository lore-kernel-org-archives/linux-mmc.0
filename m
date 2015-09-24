From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: All OMAP platforms: MMC is broken
Date: Thu, 24 Sep 2015 23:53:36 +0100
Message-ID: <20150924225336.GH21513@n2100.arm.linux.org.uk>
References: <20150924090048.GA21626@n2100.arm.linux.org.uk>
 <56047E77.5030301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:45413 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227AbbIXWxp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Sep 2015 18:53:45 -0400
Content-Disposition: inline
In-Reply-To: <56047E77.5030301@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lokesh Vutla <lokeshvutla@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>

On Thu, Sep 24, 2015 at 03:51:35PM -0700, Grygorii Strashko wrote:
> Hi Russell,
> 
> +Cc: Lokesh
> 
> On 09/24/2015 02:00 AM, Russell King - ARM Linux wrote:
> > Nightly testing has revealed that both the OMAP3430 LDP and the OMAP4430
> > SDP fail to boot due to lack of working MMC.  Both platforms fail to
> > find their rootfs, which is on a SD card.
> > 
> > The breakage occurred somewhere between trees of September 9th (commit
> > 4e4adb2f4628) and September 12th (commit b0a1ea51bda4), so during the
> > merge window.
> > 
> > Diffing those two trees show no changes to OMAP platform code, but
> > substantial changes in the MMC code:
> > 
> 
> [...]
> 
> > 
> > So this probably results from the MMC update during the merge window:
> > 
> > 85579ad7f1df Merge tag 'mmc-v4.3' of git://git.linaro.org/people/ulf.hansson/mmc
> > 
> > The OMAP4430 reports this during it's boot log:
> > 
> > mmc0: new high speed MMC card at address 0001
> > mmcblk0: mmc0:0001 SEM08G 7.39 GiB
> > mmcblk0boot0: mmc0:0001 SEM08G partition 1 1.00 MiB
> > mmcblk0boot1: mmc0:0001 SEM08G partition 2 1.00 MiB
> > ...
> > VFS: Cannot open root device "mmcblk0p2" or unknown-block(179,2): error -6
> > b300         7757824 mmcblk0  driver: mmcblk
> > b310            1024 mmcblk0boot1  (driver?)
> > b308            1024 mmcblk0boot0  (driver?)
> > Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(179,2)
> > 
> > whereas previous kernels reported:
> > 
> > mmc0: host does not support reading read-only switch, assuming write-enable
> > mmc0: new high speed SD card at address 0002
> > mmcblk0: mmc0:0002 00000 971 MiB
> >   mmcblk0: p1 p2
> > Waiting 2 sec before mounting root device...
> > mmc1: new high speed MMC card at address 0001
> > mmcblk1: mmc1:0001 SEM08G 7.39 GiB
> > mmcblk1boot0: mmc1:0001 SEM08G partition 1 1.00 MiB
> > mmcblk1boot1: mmc1:0001 SEM08G partition 2 1.00 MiB
> > ...
> > VFS: Mounted root (ext3 filesystem) on device 179:2.
> > 
> > OMAP3430 only reports:
> > 
> > VFS: Cannot open root device "mmcblk0p2" or unknown-block(0,0): error -6
> > 
> > where previous kernels reported:
> > 
> > mmc0: host does not support reading read-only switch, assuming write-enable
> > mmc0: new high speed SD card at address 0002
> > mmcblk0: mmc0:0002 00000 971 MiB
> >   mmcblk0: p1 p2
> > ...
> > VFS: Mounted root (ext2 filesystem) on device 179:2.
> > 
> 
> It looks like mmcX enumeration problem, which is not new, I think :(
> Most probably with the last DT+code changes probing of MMC which handles SD
> is deferred and as result it will get different ID.
> 
> I think Lokesh can comment more on this as he fixed it by switching uboot to 
> UUIDs instead of partition names.

No, that's not the problem.  The SD card is simply _not_ detected in
both cases.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
