From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Subject: MMC aware IO scheduler?
Date: Tue, 25 Aug 2009 17:38:37 +0300
Message-ID: <20090825143837.GA9440@angel.research.nokia.com>
Reply-To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33866 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187AbZHYOj1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2009 10:39:27 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7PEcnSN020488
	for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2009 17:39:14 +0300
Received: from angel.research.nokia.com (mrt.research.nokia.com [172.21.41.14])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7PEcYWo005671
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2009 17:38:35 +0300
Received: from jlavi by angel.research.nokia.com with local (Exim 4.69)
	(envelope-from <jlavi@angel.research.nokia.com>)
	id 1MfxAT-0002aK-Mr
	for linux-mmc@vger.kernel.org; Tue, 25 Aug 2009 17:38:37 +0300
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Has anybody thought about MMC aware IO scheduler?

Such scheduler would try to merge writes on the same eraseblock
even if there were gaps between the writes by reading the gaps
first.  Such merges would also be considered for writes on
separate erase blocks if they are close enough.

You may ask why bother.

I have tested a board with eMMC with 512MiB erase block which can
write 20 MiB/s when writes are contiguous with block size of 512
MiB.  Write time is then 20 ms per erase block at mmc driver from
startting to send the read command to mmc_request_done().

But if the writes are to randomly chosen erase block, write times
jumps to 250 ms and is pretty constant regardless of the write
size from 512 bytes to 512 KiB or offset or alignment.

Reading a random erase block takes 30ms. Read speed is< not constant
but grows slowly from 16KiB @ 11 MiB/s to 2 MiB @ 24 MiB/s. The 
device seems also to like sequential reads.

With these figures the cost of reading a gap between two writes
takes <= 25ms, writing a whole erase block takes 270ms,
altogether about 300ms. Writing two any size writes separately to
the same erase blcok would take 510ms.

The same speedup applies roughly to writing two writes to
consecutive erase blocks with gap between the writes.

Jarkko Lavinen

