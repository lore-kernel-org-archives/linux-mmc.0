From: Rainer Kaluscha <rainer.kaluscha@web.de>
Subject: SD card reader stopped working in kernel 3.6: =?utf-8?b?Q09ORklHX1JFR1VMQVRPUg==?= troubles (solved)
Date: Sat, 5 Jan 2013 16:19:57 +0000 (UTC)
Message-ID: <loom.20130105T170733-403@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53082 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755796Ab3AEQYt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 5 Jan 2013 11:24:49 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1TrWYR-0006VE-KA
	for linux-mmc@vger.kernel.org; Sat, 05 Jan 2013 17:25:03 +0100
Received: from HSI-KBW-095-208-079-040.hsi5.kabel-badenwuerttemberg.de ([95.208.79.40])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Sat, 05 Jan 2013 17:25:03 +0100
Received: from rainer.kaluscha by HSI-KBW-095-208-079-040.hsi5.kabel-badenwuerttemberg.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Sat, 05 Jan 2013 17:25:03 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

My SD card reader which worked fine with kernel 3.5 stopped working with kernel
3.6 and 3.7. It is a "SD Host controller: Ricoh Co Ltd R5C822
SD/SDIO/MMC/MS/MSPro Host Adapter (rev 22)", PCI-ID 0e:06.1 

I finally noticed messages like "mmc0: Hardware doesn't report any support
voltages." so I tried disabling CONFIG_REGULATOR in kernel config which solved
the issue.

Maybe this is also of interest to others. Feel free to contact me if you need
more details.




