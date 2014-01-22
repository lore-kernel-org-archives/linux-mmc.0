From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [RFC PATCH 0/3] ARM: mmc: davinci: Small fixes on host davinci driver
Date: Wed, 22 Jan 2014 12:46:02 +0100
Message-ID: <1390391165-27906-1-git-send-email-michael@amarulasolutions.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:50689 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941AbaAVLqL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2014 06:46:11 -0500
Received: by mail-wg0-f43.google.com with SMTP id y10so227519wgg.22
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2014 03:46:10 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Manjunathappa Prakash <prakash.pm@ti.com>

Hi all,

I had the omapl138 board for one day.
Looking at the code I have noticed that opendrain mmc configuration is buggy.
I don't have the possibility to test but it should be correct to use
host clock variable information. The other two patches are small style cleanup

Michael Trimarchi (3):
  ARM: mmc: davinci: remove unused variable mmc_pclk and fix opendrain  
      clock calculation
  ARM: mmc: davinci: Remove cast to the same type
  ARM: mmc: davinci: clock rate is an unsigned long

 drivers/mmc/host/davinci_mmc.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

-- 
1.8.1.2

