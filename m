From: jyothishree <jyothi281@gmail.com>
Subject: Data CRC error in eMMC
Date: Fri, 27 Jul 2012 08:19:10 +0000 (UTC)
Message-ID: <loom.20120727T101420-949@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38782 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182Ab2G0IZO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Jul 2012 04:25:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1SufrF-0007Uf-0i
	for linux-mmc@vger.kernel.org; Fri, 27 Jul 2012 10:25:13 +0200
Received: from 203.247.149.152 ([203.247.149.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Fri, 27 Jul 2012 10:25:13 +0200
Received: from jyothi281 by 203.247.149.152 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Fri, 27 Jul 2012 10:25:13 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,
I am getting data CRC error for CMD25 during suspend mode. 
because of this eMMC error, partition is mapped as read only and system hangs.
pease let me know how to approach to fix this issue.


