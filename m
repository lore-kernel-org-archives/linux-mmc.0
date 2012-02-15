From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: ANNOUNCE: new "mmc-utils" repository
Date: Wed, 15 Feb 2012 13:55:50 +0100
Message-ID: <4F3BAB56.80606@st.com>
References: <m2y5s8j86z.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:51142 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757971Ab2BOM4G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2012 07:56:06 -0500
In-Reply-To: <m2y5s8j86z.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Johan RUDHOLM <johan.rudholm@stericsson.com>, Shashidhar Hiremath <shashidharh@vayavyalabs.com>

Hi Chris

On 2/12/2012 6:03 PM, Chris Ball wrote:
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


Is it worth now trying to add the logic behind the patch (mmc: debugfs:
parse ext_csd via debug_fs (v2)) I sent time ago to parse the EXT_CSD?
I can do that on mmc-utils if not yet done. Pls let me know.

Peppe

> 
> Johan, when I try running these I'm seeing:
> 
> octavius:cjb~/git/mmc-utils % sudo ./mmc extcsd read /dev/mmcblk0
> sdhci-pci 0000:0d:00.0: mmc_blk_ioctl_cmd: cmd error -110
> ioctl: Connection timed out
> Could not read EXT_CSD from /dev/mmcblk0
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

