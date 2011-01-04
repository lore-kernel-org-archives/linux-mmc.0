From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] Fix sd/sdio/mmc initialization frequency retries
Date: Tue, 4 Jan 2011 17:27:38 +0000
Message-ID: <20110104172738.GA16940@void.printf.net>
References: <4D1A1B19.8000902@windriver.com> <20101231044942.GC19122@void.printf.net> <4D221748.5040701@windriver.com> <20110104012901.GA8788@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44093 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751671Ab1ADR1l (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Jan 2011 12:27:41 -0500
Content-Disposition: inline
In-Reply-To: <20110104012901.GA8788@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Ross <andy.ross@windriver.com>, linux-mmc@vger.kernel.org

Hi,

On Tue, Jan 04, 2011 at 01:29:02AM +0000, Chris Ball wrote:
> Thanks!  Pushed to mmc-next for .38, after adding Reviewed-by: tags and
> removing the mmc_bus_{put,get}() comment, since I'll take care of that
> separately.

And here's the comment patch:

From: Chris Ball <cjb@laptop.org>
Date: Tue, 4 Jan 2011 12:20:22 -0500
Subject: [PATCH] mmc: Explain why we make adjacent mmc_bus_{put,get} calls during rescan.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/core/core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 286e6ce..b8e3b97 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1529,13 +1529,15 @@ void mmc_rescan(struct work_struct *work)
 	 */
 	if (host->bus_ops && host->bus_ops->detect && !host->bus_dead
 	    && mmc_card_is_removable(host))
 		host->bus_ops->detect(host);
 
+	/*
+	 * Let mmc_bus_put() free the bus/bus_ops if we've found that
+	 * the card is no longer present.
+	 */
 	mmc_bus_put(host);
-
-
 	mmc_bus_get(host);
 
 	/* if there still is a card present, stop here */
 	if (host->bus_ops != NULL) {
 		mmc_bus_put(host);
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
