From: Johan Rudholm <johan.rudholm@stericsson.com>
Subject: [PATCH v4 2/4] mmc: core: Add card_busy to host_ops
Date: Mon, 7 Jan 2013 16:10:26 +0100
Message-ID: <1357571428-19466-3-git-send-email-johan.rudholm@stericsson.com>
References: <1357571428-19466-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:57049 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752870Ab3AGPL5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jan 2013 10:11:57 -0500
In-Reply-To: <1357571428-19466-1-git-send-email-johan.rudholm@stericsson.com>
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
index 61a10c1..3b56ef2 100644
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

