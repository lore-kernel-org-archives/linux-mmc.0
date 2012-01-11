From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: fix a deadlock between system suspend and MMC block IO
Date: Wed, 11 Jan 2012 14:30:05 -0500
Message-ID: <m2vcoidole.fsf@bob.laptop.org>
References: <Pine.LNX.4.64.1201041527480.30506@axis700.grange>
	<m2lipnfs9x.fsf@bob.laptop.org>
	<6C03668EAF45B747AF947A1603D1B300023363E95E@SAUSEXMBP01.amd.com>
	<m2hb0bfr1r.fsf@bob.laptop.org>
	<6C03668EAF45B747AF947A1603D1B3000233727D97@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35512 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932901Ab2AKTaU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Jan 2012 14:30:20 -0500
In-Reply-To: <6C03668EAF45B747AF947A1603D1B3000233727D97@SAUSEXMBP01.amd.com>
	(Arindam Nath's message of "Wed, 11 Jan 2012 02:56:17 -0600")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Andrei Warkentin <andreiw@vmware.com>

Hi,

On Wed, Jan 11 2012, Nath, Arindam wrote:
> I think we can push this patch now. If someone has any objections, we
> can discuss later.
>
> Acked-by: Arindam Nath <arindam.nath@amd.com>

Thanks, I agree.  Guennadi, I've merged it for 3.3 with the following change:

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f0b464f..bec0bf2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2175,6 +2175,7 @@ void mmc_stop_host(struct mmc_host *host)
 
 	mmc_bus_get(host);
 	if (host->bus_ops && !host->bus_dead) {
+		/* Calling bus_ops->remove() with a claimed host can deadlock */
 		if (host->bus_ops->remove)
 			host->bus_ops->remove(host);
 
@@ -2398,7 +2399,9 @@ int mmc_suspend_host(struct mmc_host *host)
 			if (err == -ENOSYS || !host->bus_ops->resume) {
 				/*
 				 * We simply "remove" the card in this case.
-				 * It will be redetected on resume.
+				 * It will be redetected on resume.  (Calling
+				 * bus_ops->remove() with a claimed host can
+				 * deadlock.)
 				 */
 				if (host->bus_ops->remove)
 					host->bus_ops->remove(host);
@@ -2491,7 +2494,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 		if (!host->bus_ops || host->bus_ops->suspend)
 			break;
 
-		/* On 2 occasions above bus_ops->remove() is called unlocked */
+		/* Calling bus_ops->remove() with a claimed host can deadlock */
 		if (host->bus_ops->remove)
 			host->bus_ops->remove(host);
 
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
