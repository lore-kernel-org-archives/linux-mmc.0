From: =?utf-8?b?6JGJ5p+P5Z2H?= <balado0318@hotmail.com>
Subject: How long is appropriate for SDCLK change from 3.3v to 1.8v ?
Date: Mon, 26 Sep 2011 03:13:48 +0000 (UTC)
Message-ID: <loom.20110926T035520-669@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59281 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047Ab1IZDUI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Sep 2011 23:20:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1R81ji-0002hg-1n
	for linux-mmc@vger.kernel.org; Mon, 26 Sep 2011 05:20:07 +0200
Received: from 59-124-179-67.HINET-IP.hinet.net ([59.124.179.67])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 26 Sep 2011 05:20:06 +0200
Received: from balado0318 by 59-124-179-67.HINET-IP.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 26 Sep 2011 05:20:06 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Dear all, 
SD card takes at least 5ms to stable the output voltage at the end of the supply
of 3.3v clock. Now, I have two UHS-I cards, Sandisk 16GB Extreme Pro and Toshiba
64GB. It shows the following two messages when initialization of these two cards
are failed:

for Sandisk 16GB Extreme Pro
sdhci: Switching to 1.8V signalling voltage failed, retrying with S18R set to 0
mmc0: error -110 whilst initialising SD card

for Toshiba 64GB
sdhci: Switching to 1.8V signalling voltage failed, retrying with S18R set to 0
mmc0: error -84 whilst initialising SD card

But, as time interval between 3.3v to 1.8v increases, the mmc subsystem can
identify these cards. Is it normal to expand the time interval in
sdhci_start_signal_voltage when it switches from 3.3v to 1.8v?

Any suggestion is welcome.

