Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975973BB683;
	Mon,  5 May 2025 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487355; cv=none; b=lB850wDiCFRSPSUM+CrSqnaXb2nax6B8kY4mXAMMyvUMTT1eJX2A8kLElT8mYf8IRH9fXqK7pMOhdFYf5/xLtCAM3+mvmHgdyPjZG4KVWp2Y12yFNqkuArc6oZs2XsoCaERgwXtIKB2+tejblnfqarTHw5iOCHNq7SjTfN0HVoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487355; c=relaxed/simple;
	bh=VOM5O+14HTHmYKeMhPfWAblhac6Pqnh2TcCPI5iT0lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4lqtyS0iieyODCrwiglchPRA09MU99lkvDYTltfj/O5Jw1hNVeD31ovbgXGAiHSJvJ7OR62FAKwMYThEHYJ/7oKKoO+It/hDvbMi+Xgk1HJKTFhtiVRN1tEa9P174+EOCAHsHPAf/rfYRZFM9oSdTDdQ/xDIVuSDRC2O08M3hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYiM22FW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYiM22FW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740BCC4CEE4;
	Mon,  5 May 2025 23:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487355;
	bh=VOM5O+14HTHmYKeMhPfWAblhac6Pqnh2TcCPI5iT0lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DYiM22FWiqwHnPAx9x3T7XBS7Uyt2Yj9+lNr5hCSGxIry8XU2a1/K5rxDdl12Dmr8
	 60iuBzOV4ixYwsReSynUxhadj/Cyo077ngEPqNSU8lPiH0LhK+6l5HBxKJp8dlkAbN
	 rteaPzgdPf+yhyiLo0h0v/CoAhZE1IUcVeVjXZYrCBeqTUGJfSl/zuUxpDFIr/oSoS
	 gNVu9ld/YFXe52/Iz0lE7QY4pX5Kq28MLL0wdYhkqC3X/o0gXrTWKk+cB6BNp35daX
	 SFvmxPsD+vtBHZ7VOWo6GsY7tbZyaD/yiZP5jtWRAUq0bku9fgQUFZtgzK3ubSOoPc
	 LeIMqNZ/hGA3Q==
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
Subject: [PATCH AUTOSEL 5.4 26/79] mmc: sdhci: Disable SD card clock before changing parameters
Date: Mon,  5 May 2025 19:20:58 -0400
Message-Id: <20250505232151.2698893-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index 4004e4e7b6226..f8d0a0e49abec 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1708,10 +1708,15 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
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

