From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP HSMMC problems with off-mode
Date: Tue, 7 Dec 2010 11:21:29 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012071101590.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44420 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070Ab0LGSVa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Dec 2010 13:21:30 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, sawant@ti.com, linux-mmc@vger.kernel.org


Madhusudhan,

On my OMAP35xx BeagleBoard here, HSMMC is non-functional after returning 
from dynamic off-mode.  The MMC LED turns on and stays on, and the process 
hangs, although the rest of the system still seems to run.  Looks like 
you're listed as the maintainer for this code.  Do you know why this is, 
and what can be done to fix it?

This is using linux-omap master at commit 
a04fd22204b13ce34a3f8a8157f83c44d64f8da9, using omap2plus_defconfig with 
DSS configured in.  My boot and root partitions are on MMC.  Following are 
the commands I used to reproduce this problem.


regards

- Paul

echo 1 > /debug/pm_debug/sleep_while_idle
echo 1 > /debug/pm_debug/enable_off_mode
echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_timeout
echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_timeout
echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_timeout

