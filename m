From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] mmc: build fix: mmc_pm_notify is only available with CONFIG_PM=y
Date: Fri, 13 Aug 2010 11:24:33 +0200
Message-ID: <1281691473-15481-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1276809814-28683-1-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1276809814-28683-1-git-send-email-maximlevitsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, David Brownell <david-b@pacbell.net>, Alan Stern <stern@rowland.harvard.edu>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org

This fixes a build breakage introduced by

	4c2ef25 (mmc: fix all hangs related to mmc/sd card insert/removal duri=
ng suspend/resume)

Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: David Brownell <david-b@pacbell.net>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-mmc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mmc/core/host.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

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
