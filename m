From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v2 1/4] mmc: sdhci: add comment for get_timeout_clock callback
Date: Mon, 27 Feb 2017 16:29:01 +0800
Message-ID: <1488184144-122285-2-git-send-email-shawn.lin@rock-chips.com>
References: <1488184144-122285-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:55955 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbdB0IgH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2017 03:36:07 -0500
In-Reply-To: <1488184144-122285-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>, Masahiro Yamada <yamada.masahiro@socionext.com>, Shawn Lin <shawn.lin@rock-chips.com>

We need comment there to tell folks that we need this
callback to return the timeout clock rate in Hz.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/sdhci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index edf3adf..27c252c 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -547,6 +547,7 @@ struct sdhci_ops {
 	int		(*enable_dma)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
+	/* get_timeout_clock should return clk rate in unit of Hz */
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
 	unsigned int	(*get_max_timeout_count)(struct sdhci_host *host);
 	void		(*set_timeout)(struct sdhci_host *host,
-- 
1.9.1


