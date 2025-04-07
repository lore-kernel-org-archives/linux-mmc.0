Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A5F23A6
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014821; cv=none; b=NVceIaBeY3gBgpGYhHRMyYvSdIAVI/eIEwBd9k6Ek1CuaQevEffQNAjyJcgFsSnVI/svyQKBvQorfQomtTm55iHEKh3KnfrB/c3dGrB/dJBMoOSnAQ+suHRZZSJaQYz1jjbydgGZ9ERHN8bYFACb71AXG4p3t3C62Nc3OImEYv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014821; c=relaxed/simple;
	bh=+UKp4ILNAIzKNE7F6m6NoKjHwghYlFRYzy4o3opKA9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ssTWtUGWqJh7riWmCOr3TmiYoKuAy/LqUoahQ2EZAo2ye/U56PgIHODE8tIs/AeFoCqQBwvIYjKSLoytweFwSYKTmW0gZWfbCy5mYqV60WlvfZMJCyCMEkPaZFgKTHmlOUZdoX0fRQvQy1xxeJE3cz5wEuoHth4SVmG9Yiq111I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=mLkUCqa5; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="mLkUCqa5"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1744014820; x=1775550820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+UKp4ILNAIzKNE7F6m6NoKjHwghYlFRYzy4o3opKA9Y=;
  b=mLkUCqa56cQm8QnQvSpjpE/e1uyL3w3BmSwYa5LcjVial/Jvis3j+esu
   kPHFKDgaI00oYuFE67ScMZjN06U+H3ZUnQLjWp0xevdHQfolUd2fevzJN
   g+SwrKaVD4HqHqfMopnGdy5nmlcd6FlhlGgHbIkGFoPTWFppJMQHWy50j
   Tmmz+QYDMuvpA5bzizWgWD0xEN6WZnk+rn27ZzUMDI5NNFwj8tU29q9ol
   FliK8cJ8kML5mOSs36jGaAxEYvztZVlCTo7kjsVvvkBBR8B3jJFY/KbOe
   7QoiX5x4Dadh7JCCZV9VDj4Z3Ka/DsL4sRhUcTS6AuCpilGsfOoyhKRE5
   Q==;
X-CSE-ConnectionGUID: LHSmDUcvRvqbCXQYcFe8tg==
X-CSE-MsgGUID: fEBdcpK0Rp64zKkY6jI4cQ==
X-IronPort-AV: E=Sophos;i="6.15,193,1739808000"; 
   d="scan'208";a="74116738"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2025 16:33:38 +0800
IronPort-SDR: 67f37fe2_hHKbAga+QqzcUsdZcKcs19w1dgLDq4Dov9L7IaCX2QJxKLP
 IjXO8d/pqUzPHniCo1DGFKTqj7OLcwaD8uZcjaA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 00:33:55 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 01:33:37 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 05/10] mmc-utils: Add SECURE_WP_INFO field in ext_csd register
Date: Mon,  7 Apr 2025 11:28:28 +0300
Message-Id: <20250407082833.108616-6-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250407082833.108616-1-avri.altman@sandisk.com>
References: <20250407082833.108616-1-avri.altman@sandisk.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Avri Altman <avri.altman@wdc.com>

This patch adds support for reading and displaying the SECURE_WP_INFO
field from the ext_csd register. The SECURE_WP_INFO field provides
information about the secure write protection features supported by the
eMMC device.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 mmc.h      | 1 +
 mmc_cmds.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/mmc.h b/mmc.h
index 14dac38..9fc22ec 100644
--- a/mmc.h
+++ b/mmc.h
@@ -106,6 +106,7 @@
 #define EXT_CSD_SEC_COUNT_2		214
 #define EXT_CSD_SEC_COUNT_1		213
 #define EXT_CSD_SEC_COUNT_0		212
+#define EXT_CSD_SECURE_WP_INFO		211
 #define EXT_CSD_PART_SWITCH_TIME	199
 #define EXT_CSD_REV			192
 #define EXT_CSD_BOOT_CFG		179
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 7e3ac7e..d019dc8 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1952,6 +1952,10 @@ int do_read_extcsd(int nargs, char **argv)
 
 	if (ext_csd_rev >= 7) {
 		printf("eMMC Firmware Version: %.8s\n", (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
+
+		printf("eMMC SECURE_WP_SUPPORT: %u\n", ext_csd[EXT_CSD_SECURE_WP_INFO] & 1);
+		printf("eMMC SECURE_WP_EN_STATUS: %u\n", (ext_csd[EXT_CSD_SECURE_WP_INFO] & 2) >> 1);
+
 		printf("eMMC Life Time Estimation A [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
 			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
 		printf("eMMC Life Time Estimation B [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x%02x\n",
-- 
2.25.1

