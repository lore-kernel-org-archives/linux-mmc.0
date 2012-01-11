From: Chris Ball <cjb@laptop.org>
Subject: Re: Erasing MMC partition from kernel module, what's best way to do that?
Date: Wed, 11 Jan 2012 14:19:55 -0500
Message-ID: <m24nw2f3ms.fsf@bob.laptop.org>
References: <21845361.155711326104068000.JavaMail.weblogic@epml02>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37240 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933339Ab2AKTUF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Jan 2012 14:20:05 -0500
In-Reply-To: <21845361.155711326104068000.JavaMail.weblogic@epml02> (JONGMAN
	HEO's message of "Mon, 09 Jan 2012 10:14:28 +0000 (GMT)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jongman.heo@samsung.com
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On Mon, Jan 09 2012, JONGMAN HEO wrote:
> Hi all,
> Please excuse me, I have some noob question regarding MMC.
>
> I'd like to erase(discard) certain MMC partition from kernel space
> (i.e. kernel module).
> I know this is quite ugly design, but I have no choice but to
> implement the feature (erasing given MMC partition) within kernel
> space for other reasons.
>
> Assume /dev/mmcblk0p2 needs to be erased.
>
> First, I tried to use BLKDISCARD ioctl. From user space, it works.
> In kernel space, I had to use ugly code, like set_fs(), filp_open(),
> etc in order to access "/dev/mmcblk0p2" device.
> I stuck at sys_ioctl(), which is not exported symbol so that I
> couldn't use the sys_ioctl() from my module for the BLKDISCARD ioctl.
>
> Alternatively, I want to make a new exported API to execute the
> discard request for "/dev/mmcblk0p2" device (like
> mmc_test_area_erase() in mmc_test.c).
> Here, it seems that I need to get "struct mmc_card *card" instance,
> which is a first parameter of mmc_erase().
>
> How can I get the "card" instance for current MMC device? Is there any
> way to do that?

I don't think we'll be interested in helping you with this -- as you
say, this is a very ugly design, and we already have the proper
userspace solution.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
