From: Yadav Rajesh <yadav.rajesh@nts.ricoh.co.jp>
Subject: SD Host Controller Driver Compatibility
Date: Thu, 25 Mar 2010 05:08:29 +0000 (UTC)
Message-ID: <loom.20100325T055937-827@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:43621 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752383Ab0CYFPH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 25 Mar 2010 01:15:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1NufPL-00050D-Rp
	for linux-mmc@vger.kernel.org; Thu, 25 Mar 2010 06:15:04 +0100
Received: from proxy.ricoh.co.jp ([202.248.73.112])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 25 Mar 2010 06:15:03 +0100
Received: from yadav.rajesh by proxy.ricoh.co.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 25 Mar 2010 06:15:03 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

The current SD host controller driver (kernel 2.6.33) does not support the SD 
host controller standard specification 3.00 ??

Is it going to be supported from the next kernel? Is there any patch for the 
older kernels to support the SDHCI 3.0 controllers?

Thanks!!

