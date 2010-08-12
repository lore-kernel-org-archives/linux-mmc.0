From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] mmc: fix for CONFIG_PM disabled
Date: Thu, 12 Aug 2010 09:36:43 -0700
Message-ID: <20100812093643.852adc98.randy.dunlap@oracle.com>
References: <201008112340.o7BNenDe021017@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:16494 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760080Ab0HLQhP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Aug 2010 12:37:15 -0400
In-Reply-To: <201008112340.o7BNenDe021017@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-mmc@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Minimal patch to fix mmc to build when CONFIG_PM is not enabled:

(.text+0x128fcd): undefined reference to `mmc_pm_notify'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/mmc/core/host.c |    2 ++
 1 file changed, 2 insertions(+)

Seems to be needed in mainline also.

--- mmotm-2010-0811-1610.orig/drivers/mmc/core/host.c
+++ mmotm-2010-0811-1610/drivers/mmc/core/host.c
@@ -86,7 +86,9 @@ struct mmc_host *mmc_alloc_host(int extr
 	init_waitqueue_head(&host->wq);
 	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
 	INIT_DELAYED_WORK_DEFERRABLE(&host->disable, mmc_host_deeper_disable);
+#ifdef CONFIG_PM
 	host->pm_notify.notifier_call = mmc_pm_notify;
+#endif
 
 	/*
 	 * By default, hosts do not support SGIO or large requests.
