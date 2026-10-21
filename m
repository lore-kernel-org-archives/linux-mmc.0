Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625625;
	b=YcB2bJNNfNpl01Db50JpUbF2vV+URXoE+6xZey8KyvRW697Pq1JooLnOZ7ueUHYX3n/O
	 qeVOSe4gYsfN9UjMgrpf/9YtCxGT7OyU6uYIVWWdLHTAfBmXkBFXPCr6g0Z003Wfgw0Lm
	 yOP76llX2Sa2e891m11bW5dDqNaRNSMCScuWjQlUEJKIGU7Kmpqujm4ImFY/KlN4qukKb
	 fFJv4OubjBEno2QscPiLDVkVlkmxbcaHySjgfLL9x3A9Zg2OMxJnRNsj59IjnbumIJzvE
	 8GHIxTNjG9Xr0nFqv67h09zN9MWoAPZBVvs7fX5DCBhySAwcm8gQYYVWYl0P8oBbLcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625625;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TfJDjIuUl4aJETYDbJIgG7qSKIZz1GaGZ/99HJHyisc=;
	b=vu5WW9IDaW3QIclE63k1Qko4kbfWeY/46PT83ccjlu0UWknHc830EUxy5n3SsQiXZoMt
	 sKfB4P2SKqNMCrB6x3wcDjJEu/ftK/hPhTPs7nbWj9kSEthHWVzv8cszIqbEyf/MzS6or
	 HtpeAmDacB3oIb6q9xd6SXmJEaq9WpVeJ9SqgWHo51bzNk/JzhMn0LOMtUJ3fUgVuNm33
	 qhFpkzzpDM0dAXIWAYaKr7IMHHqmFyXJwD0DJ7x9eA7E5e7HSYCFXmS4ZVqQfB7o28Q4s
	 Kjm+HC0rK4DvBWdaWMxKa7D1zBdbNee+JjoQfpQtgROfZSSsANTwOYWBV7ZjTXJpHaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="vLHDv/Dp";
	arc=none smtp.remote-ip=95.215.58.123
Received: from mta1.migadu.com (out-123.mta1.migadu.com [95.215.58.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F18606A319
	for <linux-mmc@vger.kernel.org>; Wed, 21 Oct 2026 23:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7F18606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vLHDv/Dp
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=331uUGN146HsRaO79pxY8Tvt1YQauDOWvdtP61Fu73M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792625621; v=1; x=1793230421;
 b=vLHDv/DpLOOiWnSIvOWDvFx2bhBUfIw/X/8/TXXh0vpXBEv1r8FpM+3rywjqcdCDHN/SC6Oy
 BqWMw32S7VIZhirP5V3TFwdc+asJ/90Zz+c20ZLqbxT9nxetF3qev5Fkej8qyMZRKxjHgbFTq2F
 ri4cIJbQoXLnrTtNj1zsf33M=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 139855eab81ec8b4;
	Wed, 21 Oct 2026 23:33:41 +0000
X-Mizu-Trace-ID: 139855eab81ec8b4
X-Migadu-Flow: FLOW_OUT
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Lucas Lai <lucas.lai@genesyslogic.com.tw>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH] mmc: sdhci-pci-gli: GL9767: Wait for UHS-II PHY before LPM
Date: Wed, 21 Oct 2026 16:33:13 -0700
Message-ID: <20261021233313.247155-1-matthew.schwartz@linux.dev>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sdhci_gl9767_set_clock() re-enables low power negotiation right after
releasing the UHS-II PHY reset. If the bus then goes idle before the
PHY has settled, every SDHCI MMIO read returns all-ones for about 250
us. sdhci_uhs2_interface_detect() takes that as IF_DETECT and LANE_SYNC
set, so a UHS-I only microSD card is treated as UHS-II. The attach then
either fails with "SDHCI_UHS2_CAPS_PTR(65535) is wrong" or, if the
registers come back before the CAPS_PTR read, runs DEVICE_INIT 30 times
with a 10 second timeout each and delays card detection by 5 minutes.

Config register 0x8CC reads 0x2000 from clock enable until about 250-300
us after the PHY reset release and 0x1000 otherwise. Poll its bit 13
before re-enabling low power negotiation. The register meaning is
inferred from that behaviour, and with the wait in place 12 of 12
UHS-II probes of a UHS-I card correctly found no UHS-II interface.

Fixes: 27dd3b82557a ("mmc: sdhci-pci-gli: enable UHS-II mode for GL9767")
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
 drivers/mmc/host/sdhci-pci-gli.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index b55618566d651..bd383918d27c7 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -205,6 +205,9 @@
 #define   PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN		  BIT(6)
 #define   PCIE_GLI_9767_COMBO_MUX_CTL_WAIT_PERST_EN	  BIT(10)
 
+#define PCIE_GLI_9767_PHY_STS			0x8CC
+#define   PCIE_GLI_9767_PHY_STS_UHS2_BUSY	  BIT(13)
+
 #define PCIE_GLI_9767_PWR_MACRO_CTL					0x8D0
 #define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE			  GENMASK(3, 0)
 #define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE		  GENMASK(15, 12)
@@ -1190,6 +1193,27 @@ static void gl9767_set_low_power_negotiation(struct pci_dev *pdev, bool enable)
 	gl9767_vhs_read(pdev);
 }
 
+static u32 gl9767_read_phy_sts(struct pci_dev *pdev)
+{
+	u32 value;
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_PHY_STS, &value);
+
+	return value;
+}
+
+static void sdhci_gl9767_uhs2_wait_phy_ready(struct sdhci_host *host)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+
+	if (read_poll_timeout_atomic(gl9767_read_phy_sts, value,
+				     !(value & PCIE_GLI_9767_PHY_STS_UHS2_BUSY),
+				     10, 10000, false, pdev))
+		pr_warn("%s: UHS-II PHY not ready after reset.\n", mmc_hostname(host->mmc));
+}
+
 static void sdhci_gl9767_uhs2_phy_reset(struct sdhci_host *host, bool assert)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
@@ -1276,9 +1300,12 @@ static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	sdhci_enable_clk(host, clk);
 
-	if (mmc_card_uhs2(host->mmc))
+	if (mmc_card_uhs2(host->mmc)) {
 		/* De-assert reset */
 		sdhci_gl9767_uhs2_phy_reset(host, false);
+		/* Low power negotiation before the PHY settles makes MMIO read all-ones */
+		sdhci_gl9767_uhs2_wait_phy_ready(host);
+	}
 
 	gl9767_set_low_power_negotiation(pdev, true);
 }
-- 
2.56.0

