Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCEF29AB00;
	Mon,  5 May 2025 22:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485049; cv=none; b=RhwEEMUq4LlnBQWu3BGIf9xVh5pOzRMHELus0GtUt9coBsJ8DQsOVv7+FdXJqgHHImvsaygfcpGVar74frnoCixB1lYf/FXHVTMx1jkd4ce+QFmhXbtaYaBb0hESn6+c59BVdwAmRqDUkLqk9MYYwVzsFwima5L3bmhBWRf+EgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485049; c=relaxed/simple;
	bh=dKplsdO0QespV981ykJXLvjosiYEVvEB0Xth2m7bseA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOhbIb+NZNyRrr0E0WzpftL/scZ8fpEAXjF/0JcYjFXInIAyaukZR7PPuNDK6OxHKpOhqbZO6TVMqk1lMpnJLbOpsS8cafBBYhUZk03WY7Osce0hAYWaFCdyICu4PhQy8IGfqEziM9JldJEjy8TZn5baypGZhRdP8jeJZ9OUoqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrMEfmNN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrMEfmNN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5C2C4CEEF;
	Mon,  5 May 2025 22:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485049;
	bh=dKplsdO0QespV981ykJXLvjosiYEVvEB0Xth2m7bseA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GrMEfmNNka0mpHR0//FDhRzVZhy6OIleRykiPRGMSGVd04/ecoHzGxpScr5YmthRZ
	 RR+ql5cbaEeGAlMK/H8THl3mtDWW10gayE96U3PEQeabpDYq+FnhLc2SK38DnUiAVo
	 EdI1KKIYEvKuAMvXvVzffe+u+IOsIiME9ES5m7IS4lod1Ym7q8DJZLRBzZt1yWPQ5R
	 BYfXLeNb5Dvh54xJ2MGPN84b2SWkhK9FLOLGhkA8nVEm1nChItibweycECjRukeZiS
	 TKjNTPUmyWFHScqhSyaTPf4OGWNO4Vg2qdOUlQY+sgKOi8D/dSCLcc3UkAHG83TGk3
	 xlzmtQHikQCow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Erick Shepherd <erick.shepherd@ni.com>,
	Kyle Roeschley <kyle.roeschley@ni.com>,
	Brad Mouring <brad.mouring@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 141/486] mmc: sdhci: Disable SD card clock before changing parameters
Date: Mon,  5 May 2025 18:33:37 -0400
Message-Id: <20250505223922.2682012-141-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Erick Shepherd <erick.shepherd@ni.com>

[ Upstream commit fb3bbc46c94f261b6156ee863c1b06c84cf157dc ]

Per the SD Host Controller Simplified Specification v4.20 §3.2.3, change
the SD card clock parameters only after first disabling the external card
clock. Doing this fixes a spurious clock pulse on Baytrail and Apollo Lake
SD controllers which otherwise breaks voltage switching with a specific
Swissbit SD card.

Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
Signed-off-by: Brad Mouring <brad.mouring@ni.com>
Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250211214645.469279-1-erick.shepherd@ni.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4b91c9e966357..8ae76300d157d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2035,10 +2035,15 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	host->mmc->actual_clock = 0;
 
-	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	if (clk & SDHCI_CLOCK_CARD_EN)
+		sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN,
+			SDHCI_CLOCK_CONTROL);
 
-	if (clock == 0)
+	if (clock == 0) {
+		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 		return;
+	}
 
 	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
 	sdhci_enable_clk(host, clk);
-- 
2.39.5

