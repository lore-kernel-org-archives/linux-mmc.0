From: Philip Rakity <prakity@marvell.com>
Subject: core.c patch for f_min has minimum frequency too low for standard
 sdhci controller
Date: Fri, 5 Mar 2010 21:10:52 -0800
Message-ID: <43E4817426ED174AA81263BCECB4351D1315CEEB66@sc-vexch3.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:55019 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab0CFFKy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 6 Mar 2010 00:10:54 -0500
Received: from maili.marvell.com (maili.marvell.com [10.68.76.51])
	by dakia2.marvell.com (Spam & Virus Firewall) with ESMTP id EDFE9AF7D5
	for <linux-mmc@vger.kernel.org>; Fri,  5 Mar 2010 21:10:53 -0800 (PST)
Received: from maili.marvell.com (maili.marvell.com [10.68.76.51]) by dakia2.marvell.com with ESMTP id fR2GCm88Fx0CQTDW for <linux-mmc@vger.kernel.org>; Fri, 05 Mar 2010 21:10:53 -0800 (PST)
Received: from MSI-MTA.marvell.com (msi-mta.marvell.com [10.68.76.91])
	by maili.marvell.com (Postfix) with ESMTP id DD339878CB
	for <linux-mmc@vger.kernel.org>; Fri,  5 Mar 2010 21:10:53 -0800 (PST)
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Lennert Buijtenhek <buytenh@marvell.com>, Nicolas Pitre <nico@marvell.com>


There is an upcoming patch for core.c  shown in the git tree shown below.

A standard sdhci.c controller running at 50MHz can divide the speed down to 50MHz/256 or 193000 bits/sec.  This MINIMUM value is larger than the +#define MMC_INIT_FREQ 64000 and will invoke the error message in

static void mmc_power_up(struct mmc_host *host) in core.c

		pr_warning("%s: Minimum clock frequency too high for "
				"identification mode\n", mmc_hostname(host));


=======

The minimum value should be raised to a more appropriate value.

Philip

==== upcoming patch in git tree for 2.6.34 ===

--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -907,12 +907,12 @@ static void mmc_power_up(struct mmc_host *host)
*/
mmc_delay(10);
- if (host->f_min > 400000) {
+ if (host->f_min > MMC_INIT_FREQ) {
pr_warning("%s: Minimum clock frequency too high for "
"identification mode\n", mmc_hostname(host));
host->ios.clock = host->f_min;
} else
- host->ios.clock = 400000;
+ host->ios.clock = MMC_INIT_FREQ;
host->ios.power_mode = MMC_POWER_ON;
mmc_set_ios(host); 

--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -15,6 +15,16 @@
#define MMC_CMD_RETRIES 3
+/* Spec says initialisation must happen at or below 400kHz.
+ * Some MMC cards fail to initialise at 400kHz (even as low as 200kHz) and
+ * Some host controllers (eg. tmio_mmc) cannot garantee to set the clock below
+ * 400kHz (it rounds to the closest clock freq available).
+ *
+ * 64 kHz seems like a good speed/reliability compromise.
+ */
+
+#define MMC_INIT_FREQ 64000
+
struct mmc_bus_ops {
int (*awake)(struct mmc_host *);
int (*sleep)(struct mmc_host *); 