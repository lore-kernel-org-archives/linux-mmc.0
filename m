Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [195.130.137.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B47194151
	for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2024 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282837; cv=none; b=YplIUwkdN56A90cbnQqKvujs9EdEIPREJICUvFagI62kduVqvFhCRJ+ls0Gb0qb902NJXniClrIm9T4mKiVU8DZEjH6WE1YfMRLSKQLWhVjTRDz/tUF4+k1R7qXCQ86i0lotilFI8IZyfO4SRrwsvjx9p5bv+9eYBddWmV0ppfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282837; c=relaxed/simple;
	bh=IxWOzOcXLbCyF5KE/BHYteO5dIdffrmHNFkpJrH8kNw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q5p4/g5A2qjUu8lQ/C4rEJrN1IltOSCBpqJGL21TMde5VXl6UOndhR830aCs6o7nS4utCPx2DnhVteCyFWtgp5/afLz0gujmXl+CzGsSeTfBXNOgfTbYgRkzl6503UX2g7GUo0j2/zBFM0GnzOOVbHRRXJioh94xrbDVIKRNHd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
	by riemann.telenet-ops.be (Postfix) with ESMTPS id 4XdjTl2LjWz4wyvt
	for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2024 11:07:07 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:ceb8:3fda:3601:820f])
	by michel.telenet-ops.be with cmsmtp
	id Wa6z2D0044BbGPD06a6zKD; Wed, 30 Oct 2024 11:07:00 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t65b6-005zPP-Ht;
	Wed, 30 Oct 2024 11:06:59 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t65bO-006QXP-Rt;
	Wed, 30 Oct 2024 11:06:58 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Victor Shih <victor.shih@genesyslogic.com.tw>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mmc: sdhci: Make MMC_SDHCI_UHS2 config symbol invisible
Date: Wed, 30 Oct 2024 11:06:55 +0100
Message-Id: <079f2b7473d34895843ad278d79930c681385b2e.1730282633.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to ask the user about enabling UHS-II support, as all
drivers that support UHS2-capable devices already select MMC_SDHCI_UHS2.
Hence make the symbol invisible, unless when compile-testing.

Fixes: 2af7dd8b64f2fd6a ("mmc: sdhci: add UHS-II module and add a kernel configuration")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index fec47022558443fe..6824131b69b188ca 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -99,7 +99,7 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 	  This is the case for the Nintendo Wii SDHCI.
 
 config MMC_SDHCI_UHS2
-	tristate "UHS2 support on SDHCI controller"
+	tristate "UHS2 support on SDHCI controller" if COMPILE_TEST
 	depends on MMC_SDHCI
 	help
 	  This option is selected by SDHCI controller drivers that want to
-- 
2.34.1

