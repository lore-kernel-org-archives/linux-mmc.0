From: Ricoh <yadav.rajesh@nts.ricoh.co.jp>
Subject: SDHC ADMA Problem
Date: Mon, 23 Aug 2010 06:05:24 +0000 (UTC)
Message-ID: <loom.20100823T075246-842@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:43892 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753031Ab0HWGFk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 23 Aug 2010 02:05:40 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1OnQA2-0006LT-R6
	for linux-mmc@vger.kernel.org; Mon, 23 Aug 2010 08:05:36 +0200
Received: from proxy.ricoh.co.jp ([202.248.73.112])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 23 Aug 2010 08:05:34 +0200
Received: from yadav.rajesh by proxy.ricoh.co.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 23 Aug 2010 08:05:34 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

For the ADMA enabled SD Host Controller, SDHCI driver is not working fine.
sdhci device gets an error "mmc0: unexpected interrupt" when an sdhc card is 
inserted.

This unexpected interrupt is the result of ADMA error. 
Refer the following dmesg informaion for more details. 

mmc0: Unexpected interrupt 0x02000000.
sdhci: ============== REGISTER DUMP ==============
sdhci: Sys addr: 0x00000000 | Version:  0x00000401
sdhci: Blk size: 0x00007008 | Blk cnt:  0x00000001
sdhci: Argument: 0x00000000 | Trn mode: 0x00000013
sdhci: Present:  0x01f70202 | Host ctl: 0x00000011
sdhci: Power:    0x0000000f | Blk gap:  0x00000000
sdhci: Wake-up:  0x00000000 | Clock:    0x00004007
sdhci: Timeout:  0x0000000a | Int stat: 0x02008008
sdhci: Int enab: 0x02ff00cb | Sig enab: 0x02ff00cb
sdhci: AC12 err: 0x00000000 | Slot int: 0x00000001
sdhci: Caps:     0x21e832b2 | Max curr: 0x00000040
sdhci: ADMA Err: 0x00000001 | ADMA Ptr: 0x020003b4
sdhci: ===========================================

Is there any updated information regarding to this issue??

