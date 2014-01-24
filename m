From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: iMX6SL Suspend mode (S3)
Date: Fri, 24 Jan 2014 21:24:10 +0000
Message-ID: <20140124212410.GH15937@n2100.arm.linux.org.uk>
References: <CACUGKYMxozVYUZ1neX9iRqRoaTCTOOY8VV92UAtcwUa_1f0XSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:48213 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753078AbaAXVYU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jan 2014 16:24:20 -0500
Content-Disposition: inline
In-Reply-To: <CACUGKYMxozVYUZ1neX9iRqRoaTCTOOY8VV92UAtcwUa_1f0XSw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: "<linux-arm-kernel@lists.infradead.org>" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, "Anson.Huang@freescale.com" <Anson.Huang@freescale.com>, Dong Aisheng <b29396@freescale.com>

On Fri, Jan 24, 2014 at 01:14:08PM -0800, John Tobias wrote:
> Hello all,
> 
> I am testing the suspend mode (S3) for my custom board with iMX6SL and
> the iMX6SL EVK as well. I am using 3.13 kernel, eMMC and MMC for the
> storage and systemd to control the OS. If I put my device in S3 mode,
> I got the following messages:
> 
> [   27.949393] PM: Syncing filesystems ... done.
> [   27.972392] mmc0: card 0001 removed
> [   28.033613] end_request: I/O error, dev mmcblk0, sector 0
> [   28.063493] end_request: I/O error, dev mmcblk0, sector 0
> [   28.107933] end_request: I/O error, dev mmcblk0, sector 0
> [   28.131456] end_request: I/O error, dev mmcblk0, sector 0
> [   28.153651] end_request: I/O error, dev mmcblk0, sector 0
> [   28.215530] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [   28.224284] Freezing remaining freezable tasks ... (elapsed 0.001
> seconds) done.
> [   28.233658] Suspending console(s) (use no_console_suspend to debug)
> 
> If I press any key, it will wake up. But, I got the following errors:
> 
> [   17.815008] mmc0: new high speed DDR MMC card at address 0001
> [   17.828024] mmcblk0: mmc0:0001 SEM04G 3.68 GiB
> [   17.833522] mmcblk0boot0: mmc0:0001 SEM04G partition 1 2.00 MiB
> [   17.839699] mmcblk0boot1: mmc0:0001 SEM04G partition 2 2.00 MiB
> [   17.847150] mmcblk0rpmb: mmc0:0001 SEM04G partition 3 2.00 MiB
> [   17.860116]  mmcblk0: p1 p2 p3 p4 < p5 p6 >
> [   17.883550]  mmcblk0boot1: unknown partition table
> [   17.899549]  mmcblk0boot0: unknown partition table

This is because MMC insists that when you suspend, the card will be
ejected, and when you resume, it will be re-inserted - it's effectively
the same as if you pulled the card out and then plugged it back in
without shutting the system down.

This is the default for the MMC subsystem, unless MMC_UNSAFE_RESUME
is set - and you can't have rootfs in MMC and suspend/resume unless
that's set.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
