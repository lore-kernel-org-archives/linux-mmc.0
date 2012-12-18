From: Johan Rudholm <johan.rudholm@stericsson.com>
Subject: [PATCH v2 2/3] mmc: core: Add card_busy to host_ops
Date: Tue, 18 Dec 2012 15:38:57 +0100
Message-ID: <1355841538-6674-3-git-send-email-johan.rudholm@stericsson.com>
References: <1355841538-6674-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:59243 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932076Ab2LROjx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Dec 2012 09:39:53 -0500
In-Reply-To: <1355841538-6674-1-git-send-email-johan.rudholm@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Kevin Liu <keyuan.liu@gmail.com>, Philip Rakity <prakity@nvidia.com>, Daniel Drake <dsd@laptop.org>, Aaron <leafy.myeh@allwinnertech.com>, Subhash Jadavani <subhashj@codeaurora.org>, Johan Rudholm <johan.rudholm@stericsson.com>

This host_ops member is used to test if the card is signaling busy by
pulling dat[0:3] low.

Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
---
 include/linux/mmc/host.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 23df21e..e2ed8c5 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -131,6 +131,9 @@ struct mmc_host_ops {
 
 	int	(*start_signal_voltage_switch)(struct mmc_host *host, struct mmc_ios *ios);
 
+	/* Check if the card is pulling dat[0:3] low */
+	int	(*card_busy)(struct mmc_host *host);
+
 	/* The tuning command opcode value is different for SD and eMMC cards */
 	int	(*execute_tuning)(struct mmc_host *host, u32 opcode);
 	void	(*enable_preset_value)(struct mmc_host *host, bool enable);
-- 
1.7.10

