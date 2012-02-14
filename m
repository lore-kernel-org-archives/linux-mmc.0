From: Johan RUDHOLM <johan.rudholm@stericsson.com>
Subject: RE: ANNOUNCE: new "mmc-utils" repository
Date: Tue, 14 Feb 2012 09:07:28 +0100
Message-ID: <E2E6AC6BFAD06343BA2D97432459C1B60723E34159@EXDCVYMBSTM005.EQ1STM.local>
References: <m2y5s8j86z.fsf@bob.laptop.org> <4F39F785.9070206@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:56356 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756332Ab2BNIHn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Feb 2012 03:07:43 -0500
In-Reply-To: <4F39F785.9070206@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Peppe CAVALLARO <peppe.cavallaro@st.com>, Shashidhar Hiremath <shashidharh@vayavyalabs.com>

Jaehoon Chung wrote:

> On 02/13/2012 02:03 AM, Chris Ball wrote:
> 
> > Hi,
> >
> > I've created a repository for userspace mmc tools now:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc-utils.git
> >
> > At the moment the only commands supported are Johan Rudholm's extcsd
> > write-protect commands, exposed as:
> >
> >    ./mmc extcsd read /dev/mmcblkX
> >    ./mmc extcsd write /dev/mmcblkX
> >
> > Johan, when I try running these I'm seeing:
> >
> > octavius:cjb~/git/mmc-utils % sudo ./mmc extcsd read /dev/mmcblk0
> > sdhci-pci 0000:0d:00.0: mmc_blk_ioctl_cmd: cmd error -110
> > ioctl: Connection timed out
> > Could not read EXT_CSD from /dev/mmcblk0
> 
> I tested with SD and eMMC.
> In eMMC case..
> 
> /opt/home/root # mmc extcsd read /dev/mmcblk0
> Power ro locking: possible
> Permanent ro locking: possible
> ro lock status: not locked
> 
> But In SD card,
> s3c-sdhci s3c-sdhci.2: mmc_blk_ioctl_cmd: cmd error -110
> ioctl: Connection timed out
> Could not read EXT_CSD from /dev/mmcblk1
> 
> What differ? Anyway..It's great about mmc-utils.

Yes, this is expected -- SD cards don't have the ext csd register.

Kind regards, Johan
