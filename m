From: Raul <raul.garcia10101@gmail.com>
Subject: Re: [PATCH] mmc: sdhci: add quirk for broken write protect detection
Date: Thu, 27 Nov 2014 14:08:54 +0000 (UTC)
Message-ID: <loom.20141127T150653-41@post.gmane.org>
References: <1393198345-8365-1-git-send-email-eli.billauer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48459 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbaK0OkG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Nov 2014 09:40:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1Xu0Em-0007KY-LR
	for linux-mmc@vger.kernel.org; Thu, 27 Nov 2014 15:40:04 +0100
Received: from cspc304.cs.man.ac.uk ([130.88.198.248])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 27 Nov 2014 15:40:04 +0100
Received: from raul.garcia10101 by cspc304.cs.man.ac.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 27 Nov 2014 15:40:04 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Eli Billauer <eli.billauer <at> gmail.com> writes:

> 
> The write protection signal is absent on a board based upon Xilinx' Zynq
> processor ("ZyBo"). This leads the kernel to think that the MicroSD card is
> write protected, and causes a kernel panic during boot, as root fails to
> mount RW.
> 
> This patch adds a quirk and an optional OF property, sdhci,wp-broken to
> work around this issue.



Hello, I am hitting the issue described in this thread, where can I get the
patch or the repo to fic it?






