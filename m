Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C525224FD
	for <linux-mmc@vger.kernel.org>; Sun,  5 Jan 2025 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736079463; cv=none; b=UxCq60npLwPxc2EKMn3uaGwAWfDkt72nrwG8dvYNSIy9MaIgr+aUCEY3INbwkeYqQWy/lkPMcMxgSac+mvozaQzPIo2tbDaPgrg6t98s+rX6m+oCramH8RWtg269/b7NcjSidOsf1f3IoyPRI53cMm6Oo9hBYyMAJq7wm660NU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736079463; c=relaxed/simple;
	bh=7P91Jo5VY4imh7oOdG9cLC711YcloVpy6qO8CIOzvew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VMomOM0ytwmvR4uKwjSeoRdrL6WvEw9Vsmka/uVMGEthyaMQI2ctOGKcLVQLLVzrJRb+cxiut1BYv0WiH0/q43wPBCEzLl4J1mcbU1Mcx73gbyuP5Alg0/2rzpe4Z+mXozAumUDlbdNxCmtbEsupf/e7vRPg0HT6ii1AZwi4ws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=habIZUFY; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="habIZUFY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736079461; x=1767615461;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7P91Jo5VY4imh7oOdG9cLC711YcloVpy6qO8CIOzvew=;
  b=habIZUFYOOOUSJzsDicoL77snO60nyOWA2BuOLjOeyirtk/KfaDq7Ueo
   xhaSBK1SnO9npJu58WOP9DO31sZBv1y7GB9jSNLXyZg6IbzBDxJVlabOE
   vEUwMokc28t6mPpTKH2YR3CbDHTmoPKwyCSx+zsKeeVKSukykhkM4a5P6
   Ljh3pI230mNDn0eqEc9/CcxUN+4FxHpKnmCwr1tCpq4cnAllMJu1yHLbJ
   SCsA4kuXZ/i6glp1tqAuG4OSl8w6yqi21npdsyzGhwGeD2P/GSV2jmqU1
   Aqz/sfD4ZxaY+twNTUNgE63mGaFRpnG0KBLFYd6tiHnhdBzTMxufXOPI0
   g==;
X-CSE-ConnectionGUID: XHJsoOUITeieekrS1eGDsA==
X-CSE-MsgGUID: CRkretZDTcuKPxUuDoYC0Q==
X-IronPort-AV: E=Sophos;i="6.12,290,1728921600"; 
   d="scan'208";a="35021192"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jan 2025 20:16:35 +0800
IronPort-SDR: 677a6957_jzWOEQdfRnlzin1bvIV/tfrtMF0iLzxRQLrm8vYaSMxoAb0
 pnFT9ORLpo1VZcfc33VRKZPRiDdLkqMk9HlajwQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jan 2025 03:13:28 -0800
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jan 2025 04:16:34 -0800
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>,
	Bean Huo <beanhuo@micron.com>
Subject: [PATCH] mmc-utils: Add ffu modes documentation
Date: Sun,  5 Jan 2025 14:14:07 +0200
Message-Id: <20250105121407.71566-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation entries for the recently added optional ffu modes,
specifically, to exist in https://mmc-utils.readthedocs.io/en/latest/.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
Cc: Bean Huo <beanhuo@micron.com>
---
 docs/HOWTO.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index 0ce7279..095a9bd 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -35,7 +35,20 @@ Running mmc-utils
         Print SCR data from <device path>. The device path should specify the scr file directory.
 
     ``ffu <image name> <device> [chunk-bytes]``
-        Run Field Firmware Update with <image name> on <device>. [chunk-bytes] is optional and defaults to its max - 512k. Should be in decimal bytes and sector aligned.
+      Default mode.  Run Field Firmware Update with `<image name>` on `<device>`. `[chunk-bytes]` is optional and defaults to its max - 512k. Should be in decimal bytes and sector aligned.
+
+    ``opt_ffu1 <image name> <device> [chunk-bytes]``
+      Optional FFU mode 1, it's the same as 'ffu', but uses CMD23+CMD25 for repeated downloads and remains in FFU mode until completion.
+
+    ``opt_ffu2 <image name> <device> [chunk-bytes]``
+      Optional FFU mode 2, uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.
+
+    ``opt_ffu3 <image name> <device> [chunk-bytes]``
+      Optional FFU mode 3, uses CMD24 Single-block write for downloading, exiting FFU mode after each block written.
+
+    ``opt_ffu4 <image name> <device> [chunk-bytes]``
+      Optional FFU mode 4, uses CMD24 Single-block write for repeated downloads, remaining in FFU mode until completion.
+
 
     ``erase <type> <start address> <end address> <device>``
         Send Erase CMD38 with specific argument to the <device>. NOTE!: This will delete all user data in the specified region of the device. <type> must be one of: legacy, discard, secure-erase, secure-trim1, secure-trim2, or trim.
-- 
2.25.1

