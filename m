From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: ANNOUNCE: new "mmc-utils" repository
Date: Tue, 14 Feb 2012 14:56:21 +0900
Message-ID: <4F39F785.9070206@samsung.com>
References: <m2y5s8j86z.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47638 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab2BNF4Y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2012 00:56:24 -0500
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZD00JD4CE7G1N0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 14 Feb 2012 14:56:22 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LZD00DD4CHYAW40@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 14 Feb 2012 14:56:22 +0900 (KST)
In-reply-to: <m2y5s8j86z.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Johan RUDHOLM <johan.rudholm@stericsson.com>, Giuseppe CAVALLARO <peppe.cavallaro@st.com>, Shashidhar Hiremath <shashidharh@vayavyalabs.com>

On 02/13/2012 02:03 AM, Chris Ball wrote:

> Hi,
> 
> I've created a repository for userspace mmc tools now:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc-utils.git
> 
> At the moment the only commands supported are Johan Rudholm's extcsd
> write-protect commands, exposed as:
> 
>    ./mmc extcsd read /dev/mmcblkX
>    ./mmc extcsd write /dev/mmcblkX
> 
> Johan, when I try running these I'm seeing:
> 
> octavius:cjb~/git/mmc-utils % sudo ./mmc extcsd read /dev/mmcblk0
> sdhci-pci 0000:0d:00.0: mmc_blk_ioctl_cmd: cmd error -110
> ioctl: Connection timed out
> Could not read EXT_CSD from /dev/mmcblk0

I tested with SD and eMMC.
In eMMC case..

/opt/home/root # mmc extcsd read /dev/mmcblk0
Power ro locking: possible
Permanent ro locking: possible
ro lock status: not locked

But In SD card,
s3c-sdhci s3c-sdhci.2: mmc_blk_ioctl_cmd: cmd error -110
ioctl: Connection timed out
Could not read EXT_CSD from /dev/mmcblk1

What differ? Anyway..It's great about mmc-utils.

Best Regards,
Jaehoon Chung

> 
> Were you doing something to get the card back into idle state first,
> perhaps?
> 
> Giuseppe, it would be excellent if you could add your ext_csd parsing
> code to the "extcsd read" command.
> 
> Shashidhar, please could you separate out the kernel-side changes needed
> for your test ioctl, and send a patch for kernelspace and one to add an
> "mmc runcmd <cmd>" command to this tool?
> 
> Thanks everyone!  If anyone else has userspace mmc code to contribute,
> feel free to hook it up to this tool and send patches to linux-mmc@.
> 
> - Chris.


