From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH] mmc/sdhci-spear: Don't set power gpio to 1 on probe
Date: Mon, 12 Sep 2011 16:52:49 +0530
Message-ID: <afc56880fea90e49b8e64bc379be4572381791f5.1315826468.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:48662 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755043Ab1ILLXT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Sep 2011 07:23:19 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org, linux-mmc@vger.kernel.org
Cc: armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, viresh.kumar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com

Currently if card_power_gpio is passed from platform data, it is acquired and
its value is either set or reset. After that its value is written 1, which is
not required.

So, this patch removes this extra line while sets its value.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/mmc/host/sdhci-spear.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index a152b5c..63cc8b6 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -178,8 +178,6 @@ static int __devinit sdhci_probe(struct platform_device *pdev)
 					sdhci->data->card_power_gpio);
 			goto err_pgpio_direction;
 		}
-
-		gpio_set_value(sdhci->data->card_power_gpio, 1);
 	}
 
 	if (sdhci->data->card_int_gpio >= 0) {
-- 
1.7.2.2

