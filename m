From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] mmc: build fix: mmc_pm_notify is only available with
 CONFIG_PM=y
Date: Wed, 18 Aug 2010 09:25:38 -0700
Message-ID: <20100818092538.f36a2246.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:45730 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab0HRQ1b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Aug 2010 12:27:31 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>, torvalds <torvalds@linux-foundation.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, David Brownell <david-b@pacbell.net>, Alan Stern <stern@rowland.harvard.edu>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

=46rom: Uwe Kleine-K=F6nig  <u.kleine-koenig@pengutronix.de>

This fixes a build breakage introduced by

	4c2ef25 (mmc: fix all hangs related to mmc/sd card insert/removal duri=
ng suspend/resume)

Cc: David Brownell <david-b@pacbell.net>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-mmc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: Maxim Levitsky <maximlevitsky@gmail.com>
Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

---
 drivers/mmc/core/host.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

There have been 3 patches like this posted, but no one is pushing it
for merging...


diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 0efe631..d80cfdc 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -86,7 +86,9 @@ struct mmc_host *mmc_alloc_host(int extra, struct dev=
ice *dev)
 	init_waitqueue_head(&host->wq);
 	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
 	INIT_DELAYED_WORK_DEFERRABLE(&host->disable, mmc_host_deeper_disable)=
;
+#ifdef CONFIG_PM
 	host->pm_notify.notifier_call =3D mmc_pm_notify;
+#endif
=20
 	/*
 	 * By default, hosts do not support SGIO or large requests.
--=20
1.7.1

--
