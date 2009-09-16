From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 0/3] PM support for SDIO cards
Date: Tue, 15 Sep 2009 23:51:46 -0400
Message-ID: <1253073109-13849-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:61396 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243AbZIPDvs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2009 23:51:48 -0400
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KQ100870PEFU890@VL-MO-MR001.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 15 Sep 2009 23:51:51 -0400 (EDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-mmc@vger.kernel.org

This is a repost of the patches I've posted to linux-mmc a while ago,
with additional comments to address Pierre's concerns wrt proper card
validation upon resuming.  No other issues were raised.

[PATCH 1/3] [MMC] core SDIO suspend/resume support
[PATCH 2/3] [MMC] propagate error codes back from bus drivers' suspend/resume methods
[PATCH 3/3] [MMC] make SDIO device/driver struct accessors public


Nicolas

