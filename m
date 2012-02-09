From: james <kungjam@gmail.com>
Subject: Re: SDIO wifi card works with 2.6.36, not with 3.2
Date: Thu, 9 Feb 2012 01:46:30 +0000 (UTC)
Message-ID: <loom.20120209T024313-919@post.gmane.org>
References: <CANN7TQkp4t2rhfS=LM38TSUdrp2pE7d0VX_t36AjiEEqayqNmQ@mail.gmail.com> <4ED03ABF.5070604@gmail.com> <CANN7TQnuJ55RUuhC3UBhmqyMQ0p3mFtbghCmssAw6jWMSOJY+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39814 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755558Ab2BIBuI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Feb 2012 20:50:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1RvJ99-0003Tl-TB
	for linux-mmc@vger.kernel.org; Thu, 09 Feb 2012 02:50:04 +0100
Received: from 203-206-234-247.perm.iinet.net.au ([203.206.234.247])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 09 Feb 2012 02:50:03 +0100
Received: from kungjam by 203-206-234-247.perm.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 09 Feb 2012 02:50:03 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

My kernel is 2.6.38.8, and WiFi is AR6103. I see exactly error message as:

[  208.327200] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000003
[  208.327226] mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[  208.327227] mmc0:     4 bytes transferred: 0
[  208.327235] mmc0: starting CMD53 arg 1408a004 flags 000001b5
[  208.327238] mmc0:     blksz 4 blocks 1 flags 00000200 tsac 1000 ms nsac 0
[  208.327260] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000003
[  208.327284] mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[  208.327286] mmc0:     4 bytes transferred: 0
[  208.327295] mmc0: starting CMD53 arg 941ff804 flags 000001b5
[  208.327298] mmc0:     blksz 4 blocks 1 flags 00000100 tsac 1000 ms nsac 0
[  208.327320] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00208003
[  208.327357] mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[  208.327358] mmc0:     0 bytes transferred: -84
[  208.327362] AR6000: SDIO bus operation failed! MMC stack returned : -84 
[  208.327368] Unable to send the BMI data to the device
[  208.327370] Unable to write to the device


Any help is appreciated!

