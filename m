From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 0/3] mmc-block fixes
Date: Fri, 18 Dec 2009 14:15:27 +0200
Message-ID: <20091218121527.4351.14601.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38280 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbZLRMRF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Dec 2009 07:17:05 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pierre Ossman <pierre@ossman.eu>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>

Hi

Here are 3 fixes for mmc-block:

Adrian Hunter (1):
      mmc_block: fix queue cleanup

Anna Lemehova (1):
      mmc_block: add dev_t initialization check

Jarkko Lavinen (1):
      mmc_block: fix probe error cleanup bug

 drivers/mmc/card/block.c |    8 ++++++++
 drivers/mmc/card/queue.c |   18 +++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

Regards
Adrian

