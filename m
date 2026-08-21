Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4780E46EC88;
	Fri, 21 Aug 2026 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306779; cv=none; b=P4aEObZMcKenyZPKRdzKPOwZAHQZdTW2qb2MlIlo/YHsEkRtCxp0QMnHLQcVJA3qAzR1coZg7OJ3oN/E9x0jEEZQ2Y1bKnfn0SigIORjXU4Rw77I0Wg3WJCXFqclEqJt5/jFW0gv9i5eDYyIpKbnRTS2ozUselM/XnHc1/wqPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306779; c=relaxed/simple;
	bh=CQKux+4D4MDQvci8T+nb7QEwkvWySbr8ODUhwdXikoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuEmyXNg6xZoOllQ1GtQwd4SP97bDKNIdHy3l48DucWHyYvpz0pm4lBzG2YWJgfeFB6s41CTST013BlWPW9CF6iEMeJGlDsznYprKCmNUVCO+HqkHXrVM9ipg8VzDFA/hk9sIBoeB8sCWhes1feiIgH/zqSjDjdL4IQFH4klwX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD951F00ACA;
	Fri, 21 Aug 2026 10:06:12 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulfh@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Michal Simek <michal.simek@amd.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] mmc: sdhci-of-arasan: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 12:06:04 +0200
Message-ID: <0235d3a3d5b71a125eeff6d7be25ddaec80ce539.1787240090.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787240090.git.geert+renesas@glider.be>
References: <cover.1787240090.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clk_init_data structure contains several mutually-exclusive members
for different methods to specify the possible parents of a clock,
prompting drivers to initialize only the members they need.  However,
not initializing all members may cause subtle issues, which are only
exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
enabled.

Make sure all members are fully initialized, to avoid such bugs, and to
prevent future breakage when converting drivers to a different method
for specifying the parents.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/mmc/host/sdhci-of-arasan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 4ca73e7d799ead0d..0ee22923ad568124 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1552,8 +1552,8 @@ sdhci_arasan_register_sdcardclk(struct sdhci_arasan_data *sdhci_arasan,
 				struct device *dev)
 {
 	struct sdhci_arasan_clk_data *clk_data = &sdhci_arasan->clk_data;
+	struct clk_init_data sdcardclk_init = {};
 	struct device_node *np = dev->of_node;
-	struct clk_init_data sdcardclk_init;
 	const char *parent_clk_name;
 	int ret;
 
@@ -1604,8 +1604,8 @@ sdhci_arasan_register_sampleclk(struct sdhci_arasan_data *sdhci_arasan,
 				struct device *dev)
 {
 	struct sdhci_arasan_clk_data *clk_data = &sdhci_arasan->clk_data;
+	struct clk_init_data sampleclk_init = {};
 	struct device_node *np = dev->of_node;
-	struct clk_init_data sampleclk_init;
 	const char *parent_clk_name;
 	int ret;
 
-- 
2.43.0

