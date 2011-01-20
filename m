From: Daniel J Blueman <daniel.blueman@gmail.com>
Subject: [2.6.37/38] SDHCI spurious interrupt...
Date: Thu, 20 Jan 2011 11:21:14 +0700
Message-ID: <AANLkTi=koHRNJaVQGwdPiEkSOwveOKHK97oO99n6PiwF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34709 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215Ab1ATEWR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Jan 2011 23:22:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

With 2.6.37 (and by extension 2.6.38-rc1, as the code hasn't changed),
I occasionally see an 'IRQ 16: nobody cared' message a second before
shutting down (previously reported [1]); the culprit is the SDHCI
driver for my Ricoh controller.

I modified the interrupt handler to be unregistered later with a
delay, and to dump out the interrupt mask read, but didn't catch it
yet.

Any ideas?

Thanks,
  Daniel

[1] https://patchwork.kernel.org/patch/416211/
-- 
Daniel J Blueman
