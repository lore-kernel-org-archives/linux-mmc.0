Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820942;
	b=oFUV/hblT1foZv/qU/nZPcBqg04l+7md9ny/IS5/l2ZOWuTpZlgi8RXdmTpelCXy+5pV
	 svxfnLFx5QAkTI8cW2TOJqViQsVvyPeKu/rsU7pp/X76inUpZeOnZTxtKSM5Hb5D9OSFL
	 bR5rDDc3fFejXsYcWISVeH/u2KPOxy1Pmxuo1pPS6YZw4kDmJg6RmCARRMaucLkjqODv0
	 t7p5PYvtY5fiBONfHV5LPpLzRF0HuwSNiMYsOe+iny3Q7b3NAhxrgjRjKGRhqGVDjktJi
	 yd6KTTijkxYCQxCrBpyXd4K3UcjoxCNYgYBWFXczr2+dmyZxY/dcIUP4Fc8eTt3hRMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820942;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VDOFL3d+ub4yjMVuoehWUSad0hDpPNXCkiwE5FaNJF4=;
	b=aaxvyTbdbtXniwZmFTHNBS+iHAN3WSwGYHxh3HEzT2IxXWUm0OX+wh6uRAYePMfX0vr5
	 q7DAdzmi9wMwkoCFFBwNA4vTXB/mProR11ChQ3slSb5fDKF/kfmEWobrF18voqcJOljDG
	 vsrWA40QGA5PrqtdVTlai8c8taGxu9mQjhn00g5kGtRO9nhuqHxPp8DweDFRqH3DInJqc
	 kEj8vj2ZN8q1kkwyEkG6zCwNz0fiPdKknOoCgEGPmKNpMHJulIbkxoiYri85T8hJ1iNLq
	 /EEDjWsLqNyeZUyHOAgnLtmx9ELmX15v4khizoYKHBfQY2T96re0bz/1IHdKPpDhpEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mZGSp8cs;
	arc=none smtp.remote-ip=95.215.58.112
Received: from mta1.migadu.com (out-112.mta1.migadu.com [95.215.58.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763FF606EE84
	for <linux-mmc@vger.kernel.org>; Wed,  4 Nov 2026 19:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 763FF606EE84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mZGSp8cs
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cIl24ltpk8q7nNI3NVoNhFWZ80fCtpJgZXOiThKH9q0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793820938; v=1; x=1794425738;
 b=mZGSp8csSsPugZW4xtZ9gkhhqTX8xQG5ljrjZcQQHqMCJwpoytj4YIDkxJ7nLndOSVzAmISA
 /HMVDXASCQkIegEiZir9zKID1yumN48Cw+nyhkB+0DcNaS3oGf55UtzNbwbBxUj1gygUowL87/r
 sJl4DNuyZyylmGw91rbCxAA4=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 369e746f1d47a615;
	Wed, 04 Nov 2026 19:35:29 +0000
X-Mizu-Trace-ID: 369e746f1d47a615
X-Migadu-Flow: FLOW_OUT
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: adrian.hunter@intel.com,
	ulfh@kernel.org
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Lucas Lai <lucas.lai@genesyslogic.com.tw>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci-pci-gli: GL9767: Wait for UHS-II wakeup before LPM
Date: Wed,  4 Nov 2026 11:35:21 -0800
Message-ID: <20261104193521.1488192-1-matthew.schwartz@linux.dev>
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
UHS-II wakeup has finished, every SDHCI MMIO read returns all-ones for
about 250 us. sdhci_uhs2_interface_detect() takes that as IF_DETECT and
LANE_SYNC set, so a UHS-I only microSD card is treated as UHS-II. The
attach then either fails with "SDHCI_UHS2_CAPS_PTR(65535) is wrong" or,
if the registers come back before the CAPS_PTR read, runs DEVICE_INIT
30 times with a 10 second timeout each and delays card detection by 5
minutes.

Bit 13 of the UHS-II Status register at config offset 0x8CC is
UHS2_WAKEUP_ACTIVATE. It stays set for about 250-300 us after the PHY
reset release. Poll it before re-enabling low power negotiation. With
the wait in place 12 of 12 UHS-II probes of a UHS-I card correctly
found no UHS-II interface.

Fixes: 27dd3b82557a ("mmc: sdhci-pci-gli: enable UHS-II mode for GL9767")
Tested-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
Changes in v2:
- Rename the register and bit to PCIE_GLI_9767_UHS2_STS and
  PCIE_GLI_9767_UHS2_STS_WAKEUP_ACTIVATE as suggested by Ben, and the
  helpers to match
- Use read_poll_timeout() instead of read_poll_timeout_atomic() (Adrian)
- Describe bit 13 by its documented name instead of the inferred behaviour
- Say "wakeup" instead of "PHY" in the subject and description to match
- Link to v1: https://lore.kernel.org/all/20261021233313.247155-1-matthew.schwartz@linux.dev/

 drivers/mmc/host/sdhci-pci-gli.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index b55618566d651..263bb091374be 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -205,6 +205,9 @@
 #define   PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN		  BIT(6)
 #define   PCIE_GLI_9767_COMBO_MUX_CTL_WAIT_PERST_EN	  BIT(10)
 
+#define PCIE_GLI_9767_UHS2_STS				0x8CC
+#define   PCIE_GLI_9767_UHS2_STS_WAKEUP_ACTIVATE	  BIT(13)
+
 #define PCIE_GLI_9767_PWR_MACRO_CTL					0x8D0
 #define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE			  GENMASK(3, 0)
 #define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE		  GENMASK(15, 12)
@@ -1190,6 +1193,27 @@ static void gl9767_set_low_power_negotiation(struct pci_dev *pdev, bool enable)
 	gl9767_vhs_read(pdev);
 }
 
+static u32 gl9767_read_uhs2_sts(struct pci_dev *pdev)
+{
+	u32 value;
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_STS, &value);
+
+	return value;
+}
+
+static void sdhci_gl9767_uhs2_wait_wakeup(struct sdhci_host *host)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+
+	if (read_poll_timeout(gl9767_read_uhs2_sts, value,
+			      !(value & PCIE_GLI_9767_UHS2_STS_WAKEUP_ACTIVATE),
+			      20, 10000, false, pdev))
+		pr_warn("%s: UHS-II wakeup did not complete.\n", mmc_hostname(host->mmc));
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
+		/* Low power negotiation during UHS-II wakeup makes MMIO read all-ones */
+		sdhci_gl9767_uhs2_wait_wakeup(host);
+	}
 
 	gl9767_set_low_power_negotiation(pdev, true);
 }

base-commit: 4df4d2a577db2d3d57b888bcfb1206fc74661d16
-- 
2.56.0

