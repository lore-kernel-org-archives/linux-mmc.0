From: Marc Dietrich <marvin24@gmx.de>
Subject: power class selection failed warning
Date: Sat, 27 Jul 2013 16:13:56 +0200
Message-ID: <59782679.nKg2SBZ8OK@ax5200p>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:60702 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586Ab3G0OOl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 27 Jul 2013 10:14:41 -0400
Received: from ax5200p.localnet ([217.229.199.90]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0M8edX-1U6q7A1d59-00wFaA for
 <linux-mmc@vger.kernel.org>; Sat, 27 Jul 2013 16:14:39 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

since 3.11-something, I get "power class selection to bus width 8 failed" 
during boot. This is the same device as described here already [1], but this 
time it is non-fatal, because it's just a warning.

Since I reported [1], I was thinking about the origin of this problem and 
found that the eMMC announces two voltage caps, but the board wired both 
supplies vmm and qvmm to the same voltage supply, so the eMMC may report error 
on powerclass switch - at least that's my interpretation.

If the interpretation above is right, is there any way to avoid this warning 
(e.g. check the voltages of the regulator supplies).

Thanks!

Marc

[1] http://marc.info/?l=linux-mmc&m=133434010207837&w=2

