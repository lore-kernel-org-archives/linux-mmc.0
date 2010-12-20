From: Bringfried Stecklum <stecklum@tls-tautenburg.de>
Subject: Re: 2.36.1 sdhci R5C822 regression
Date: Mon, 20 Dec 2010 10:18:40 +0000 (UTC)
Message-ID: <loom.20101220T111508-685@post.gmane.org>
References: <4D0B380C.4000407@tls-tautenburg.de> <20101217153024.GA26910@void.printf.net> <4D0BA461.6050803@tls-tautenburg.de> <loom.20101218T203354-286@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:48422 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755057Ab0LTKSy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Dec 2010 05:18:54 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1PUcpR-0000uo-1s
	for linux-mmc@vger.kernel.org; Mon, 20 Dec 2010 11:18:53 +0100
Received: from i5E86DE2F.versanet.de ([94.134.222.47])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 20 Dec 2010 11:18:53 +0100
Received: from stecklum by i5E86DE2F.versanet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 20 Dec 2010 11:18:53 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I figured out that a suspend to memory after resuming from hibernation is a
remedy. When the system is back from suspend, the card is properly reckognised.

