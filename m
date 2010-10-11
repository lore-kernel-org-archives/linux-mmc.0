From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 0/1] MMC DDR support
Date: Mon, 11 Oct 2010 12:43:42 +0300
Message-ID: <20101011094342.27911.94016.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18521 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494Ab0JKJob (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Oct 2010 05:44:31 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>

Hi

Here is a tweak to MMC DDR support.  It applies to the mmc-next
branch of Chris Ball's mmc tree at:
	git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git


Adrian Hunter (1):
      mmc: refine DDR support

 drivers/mmc/core/core.c  |    7 ++++---
 drivers/mmc/core/core.h  |    3 ++-
 drivers/mmc/core/mmc.c   |    6 +++---
 include/linux/mmc/host.h |    3 ++-
 4 files changed, 11 insertions(+), 8 deletions(-)


Regards
Adrian

