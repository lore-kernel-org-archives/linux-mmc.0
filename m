From: Chris Ball <cjb@laptop.org>
Subject: ANNOUNCE: new "mmc-utils" repository
Date: Sun, 12 Feb 2012 12:03:00 -0500
Message-ID: <m2y5s8j86z.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59531 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754471Ab2BLRDM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 12 Feb 2012 12:03:12 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Johan RUDHOLM <johan.rudholm@stericsson.com>, Giuseppe CAVALLARO <peppe.cavallaro@st.com>, Shashidhar Hiremath <shashidharh@vayavyalabs.com>

Hi,

I've created a repository for userspace mmc tools now:

git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc-utils.git

At the moment the only commands supported are Johan Rudholm's extcsd
write-protect commands, exposed as:

   ./mmc extcsd read /dev/mmcblkX
   ./mmc extcsd write /dev/mmcblkX

Johan, when I try running these I'm seeing:

octavius:cjb~/git/mmc-utils % sudo ./mmc extcsd read /dev/mmcblk0
sdhci-pci 0000:0d:00.0: mmc_blk_ioctl_cmd: cmd error -110
ioctl: Connection timed out
Could not read EXT_CSD from /dev/mmcblk0

Were you doing something to get the card back into idle state first,
perhaps?

Giuseppe, it would be excellent if you could add your ext_csd parsing
code to the "extcsd read" command.

Shashidhar, please could you separate out the kernel-side changes needed
for your test ioctl, and send a patch for kernelspace and one to add an
"mmc runcmd <cmd>" command to this tool?

Thanks everyone!  If anyone else has userspace mmc code to contribute,
feel free to hook it up to this tool and send patches to linux-mmc@.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
