From: "Madhusudhan" <madhu.cr@ti.com>
Subject: MMC retry mechanism
Date: Fri, 4 Sep 2009 17:08:05 -0500
Message-ID: <011c01ca2dac$2de779d0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47215 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934366AbZIDWIM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Sep 2009 18:08:12 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Adrian Hunter' <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org

Hi Adrian,

With respect to the below commit, It looks like currently the retry
mechanism only handles the READ path.

I wonder could a similar retry logic feasible for the WRITE path?

Regards,
Madhu

 

commit 6a79e391df295bd7c2aa1309ea5031f361c197fd
Author: Adrian Hunter <ext-adrian.hunter@nokia.com>
Date:   Wed Dec 31 18:21:17 2008 +0100

 

    mmc_block: ensure all sectors that do not have errors are read

    If a card encounters an ECC error while reading a sector it will

    timeout.  Instead of reporting the entire I/O request as having

    an error, redo the I/O one sector at a time so that all readable

    sectors are provided to the upper layers.

 

    Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>

    Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

