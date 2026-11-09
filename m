Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258535;
	b=5ck1IZWzXH0fwrWx8/+e/WXZAEMGQsR8xvaUEPdjfpRC+gi46nMMJsICeL+C/znTA2k+
	 EBb6cNooZP0Ii83GSFv6L4bKXKNjPcImGhKzNTGt3YCrn0OeWxIaugrBq1MyrKeJqzlrw
	 4Ytw2Q65+LOabxAgl5m/uJZXnW05pYOCA0sdR+TlBspvoOtJyWjWje9PmvE484L3k1p+2
	 iTcrbjOfmcADpBZtFh8izcfF/6RjDbWm1+V1+OH7dw4x/tmJHQsDJx6PT9CQ4eALoHMQY
	 qJAJKV9Y/Swdh0hXIaP7iBrIb2hpHgoG9rEniTzeQ6k5EhfHHvkfsLOXntxt/ly7JZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258535;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=nJXpT9iXdx94yXelr2/lcrtGyQw9Dx0QS5S60pLVPxc=;
	b=XgSD9nySPjbVn0/HBKSZvcNGA3oKsbjlg/bGBY3QP3GrUalqOeWWOWyBDSqDgdonrMSr
	 MTL4O+1jSFHA+AO+93Up4Tanzj1BoOVJ4b77KLEVteaxasMB4CfGOdQ3LXH+Ed1OWNnxg
	 X7sWP9xBngFqKQE+nWzdRTJhsC8bAIPsNgG9R6Fq46C8AQwWPGYZcX6/csKR6qIOvVTTw
	 Z2EmgLsBEf3UVz1LN6cxQOiee5VywaEsnIPFcTCVYgOwGE/e+ANnyJm6ZH5D0mMTSeUE7
	 BUC0xJD86TORJcCXT2t0MzsNphBXEf6rXwisgsKHZfZkmcbvrlt0GV+GKqK0zMDmhpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jclOP7MP;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D760A261F;
	Mon,  9 Nov 2026 21:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D2D760A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jclOP7MP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794258535; x=1825794535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GJSEzZmICoPE/wW6tSgVwwNOD9tll7j5fgf72H9u2Bo=;
  b=jclOP7MP01IquL4V2uCkKuy+tYKDWJKAGqsY853nAxTzGIvS3VBiu/XS
   vhgJVbxKGh1oBO6QaLZkO1Y6MSfM63QW7D4Rlpxz6PkPfVZW/5I1q6hSd
   Vi5lXvR4kG7hlhsE48+FBtqK+1iob6ZqLvwylffyH1rT0k5OuS+4Pxlh0
   fo70now/oYbfBvoXn9q0gNFxkC47l0zFY6H+CAVDfA90OWNvRbNkQvGln
   0zrzl0q7sEHTWpYveGi53TSd72YBB6P+DjOMEMO8rTVAwUWDDxHkx249i
   mzajH94EwgR6Zti7TO9pXEG5VBuIJImnxybBecCcgp0xynaYTeuaqqNWS
   A==;
X-CSE-ConnectionGUID: hwba+UV/TIKtc3f+2FilFQ==
X-CSE-MsgGUID: tyeAUBxfTHaQ6BhnqJJD+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3004820"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3004820"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:08:55 -0800
X-CSE-ConnectionGUID: YXmaD0cCRv221kbduNrunQ==
X-CSE-MsgGUID: YhzI90G9QVeJ7E8zK6HsLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9747008"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:08:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-mmc@vger.kernel.org
Subject: [RFC PATCH 10/11] PCI: Move Ricoh RL5C476 MMC quirk to setup-cardbus.c
Date: Mon,  9 Nov 2026 23:07:10 +0200
Message-ID: <20261109210714.3862-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ricoh_mmc_fixup_rl5c476() disables the proprietary MMC controller of the
Ricoh RL5C476 through Function 0 of the chip, which is a CardBus bridge.
When CONFIG_CARDBUS is not set, CardBus bridges are ignored and, as
Function 0 is then missing, pci_scan_slot() does not enumerate the other
Functions of the chip either. The quirk has nothing to do in that case.

Move the quirk to setup-cardbus.c so it is only built with CARDBUS.
CARDBUS defaults to y when CONFIG_PCCARD is enabled, so existing configs
for systems with these chips should mostly keep the quirk.

CONFIG_MMC_RICOH_MMC is an option of the SDHCI PCI card reader driver
(CONFIG_MMC_SDHCI_PCI), which drives the SD controller of both the
RL5C476 and the R5C832 family. On the R5C832 family, the MMC controller
is disabled through the FireWire Function, which does not need CardBus.
Thus, do not make MMC_RICOH_MMC depend on CARDBUS.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org

 drivers/pci/quirks.c        | 32 -----------------------------
 drivers/pci/setup-cardbus.c | 41 +++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 78f6df5d4d19..85b4c39617a6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3320,38 +3320,6 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020, quirk_hotplug_bridge);
  * #1, and this will confuse the PCI core.
  */
 #ifdef CONFIG_MMC_RICOH_MMC
-static void ricoh_mmc_fixup_rl5c476(struct pci_dev *dev)
-{
-	u8 write_enable;
-	u8 write_target;
-	u8 disable;
-
-	/*
-	 * Disable via CardBus interface
-	 *
-	 * This must be done via function #0
-	 */
-	if (PCI_FUNC(dev->devfn))
-		return;
-
-	pci_read_config_byte(dev, 0xB7, &disable);
-	if (disable & 0x02)
-		return;
-
-	pci_read_config_byte(dev, 0x8E, &write_enable);
-	pci_write_config_byte(dev, 0x8E, 0xAA);
-	pci_read_config_byte(dev, 0x8D, &write_target);
-	pci_write_config_byte(dev, 0x8D, 0xB7);
-	pci_write_config_byte(dev, 0xB7, disable | 0x02);
-	pci_write_config_byte(dev, 0x8E, write_enable);
-	pci_write_config_byte(dev, 0x8D, write_target);
-
-	pci_notice(dev, "proprietary Ricoh MMC controller disabled (via CardBus function)\n");
-	pci_notice(dev, "MMC cards are now supported by standard SDHCI controller\n");
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_RL5C476, ricoh_mmc_fixup_rl5c476);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_RL5C476, ricoh_mmc_fixup_rl5c476);
-
 static void ricoh_mmc_fixup_r5c832(struct pci_dev *dev)
 {
 	u8 write_enable;
diff --git a/drivers/pci/setup-cardbus.c b/drivers/pci/setup-cardbus.c
index ef35393aca1b..33aca7b28354 100644
--- a/drivers/pci/setup-cardbus.c
+++ b/drivers/pci/setup-cardbus.c
@@ -330,4 +330,45 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
 			PCI_CLASS_BRIDGE_CARDBUS, 8, quirk_cardbus_legacy);
 DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY(PCI_ANY_ID, PCI_ANY_ID,
 			PCI_CLASS_BRIDGE_CARDBUS, 8, quirk_cardbus_legacy);
+
+#ifdef CONFIG_MMC_RICOH_MMC
+/*
+ * Disable the proprietary Ricoh MMC controller on chips whose function 0
+ * is a CardBus bridge. See ricoh_mmc_fixup_r5c832() in quirks.c for
+ * details.
+ */
+static void ricoh_mmc_fixup_rl5c476(struct pci_dev *dev)
+{
+	u8 write_enable;
+	u8 write_target;
+	u8 disable;
+
+	/*
+	 * Disable via CardBus interface
+	 *
+	 * This must be done via function #0
+	 */
+	if (PCI_FUNC(dev->devfn))
+		return;
+
+	pci_read_config_byte(dev, 0xB7, &disable);
+	if (disable & 0x02)
+		return;
+
+	pci_read_config_byte(dev, 0x8E, &write_enable);
+	pci_write_config_byte(dev, 0x8E, 0xAA);
+	pci_read_config_byte(dev, 0x8D, &write_target);
+	pci_write_config_byte(dev, 0x8D, 0xB7);
+	pci_write_config_byte(dev, 0xB7, disable | 0x02);
+	pci_write_config_byte(dev, 0x8E, write_enable);
+	pci_write_config_byte(dev, 0x8D, write_target);
+
+	pci_notice(dev, "proprietary Ricoh MMC controller disabled (via CardBus function)\n");
+	pci_notice(dev, "MMC cards are now supported by standard SDHCI controller\n");
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_RL5C476,
+			ricoh_mmc_fixup_rl5c476);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_RL5C476,
+			       ricoh_mmc_fixup_rl5c476);
+#endif /* CONFIG_MMC_RICOH_MMC */
 #endif /* CONFIG_PCI_QUIRKS */
-- 
2.47.3

