From: Marc Dietrich <marvin24@gmx.de>
Subject: emmc power select failure
Date: Fri, 13 Apr 2012 19:59:29 +0200
Message-ID: <1721770.czJDhHnFDk@ax5200p>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:59920 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752808Ab2DMSAD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Apr 2012 14:00:03 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

I'm running linux-next on a tegra-sdhci host which has a Toshiba 
THGBM2G6D2FBAI9 eMMC connected. During boot I get a "mmc1: power class 
selection to bus width 8 failed" warning. 

/sys/kernel/debug/mmc1# cat ios 
clock:          48000000 Hz
actual clock:   48000000 Hz
vdd:            20 (3.2 ~ 3.3 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    1 (mmc high-speed)

Any hints?

Thanks!

Marc

