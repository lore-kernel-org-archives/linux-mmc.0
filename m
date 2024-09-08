Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DD314F9CA
	for <linux-mmc@vger.kernel.org>; Sun,  8 Sep 2024 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790938; cv=none; b=Dyr+4d8ky3sWPQwrUIFRqtLXYMoboIXaS0PFjwcmd+kINxZnY3hFurWyVsYmhCwE+Jl4MHNerXu9rbQ4rYAsO9d0A47687MezrEnHPTT8jJNw8A1qPfkCD9h/3jO1Dx+YUKKEK5ZNUOf9Q9FQI/FSjvE9vMIz2gY2Sc+b/5OAh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790938; c=relaxed/simple;
	bh=H0lBf2bXh/Cf6DI9l9g/gVEyNbXwbdk7FWJV6uTKIJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TkQJUQ4oOSpJfxpuUCMnhPC6GWL3H8KkrkqguHEep23gy6w9mC6Sij9FgTJF4DS0hwUHpLj6L9b31XIJN/qQ/bgiloqOimFbk3AbSBfFj+zUwd+JOKnzkeM6mqRyhAP3C85dhY/Sj5kfXJ7KErQz9vUlDOFutEu4HGmmEiI9ecc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=X066LTwm; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X066LTwm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725790937; x=1757326937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H0lBf2bXh/Cf6DI9l9g/gVEyNbXwbdk7FWJV6uTKIJ8=;
  b=X066LTwmZZzKbYOfNktvbf+IMyG40tDEEHQdKlcxD6aCS+PzbAXMRteq
   ffOxXpTbADpyG2gkLsUuZMk/ZXlIqUYEPAVXCSpL87v7Ar15xEj3tBqi5
   uGa+YDUCJPRBIQjaV7gtF1BSjSnOF3F1aGyjOnviJ2riMW8B5wtqSAmKV
   Os5GxWq8yp1JslbTTmmqZ1hFXcJEaONG3/T0eV/scSSFR073MiLD/96Hd
   2vgZVYhH5BGWWNgHIYDU80XumEC50Ao2DCWp7mX4YNZzAZRv0UFy4FmSx
   CLHC8pJD6dhDM8yFyRsDO50qNGGQTVbZVnrMl/cRAqX9lcWIbs9ThG97Q
   A==;
X-CSE-ConnectionGUID: PZuPjTiqR32vuhIjM5drKw==
X-CSE-MsgGUID: yQuJraubQcKVtjYcxi++bA==
X-IronPort-AV: E=Sophos;i="6.10,212,1719849600"; 
   d="scan'208";a="25553867"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2024 18:22:12 +0800
IronPort-SDR: 66dd6df9_LAHe/sayQnCnydLvs7j5SsP5l8gjxnJVdMjeO0SkorTCP4v
 oBAwcAAvYweqFaMRGZUIT1an6vDQJHsjp+lU+nA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2024 02:27:21 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2024 03:22:10 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v7 02/10] mmc: sd: Add Extension memory addressing
Date: Sun,  8 Sep 2024 13:20:10 +0300
Message-Id: <20240908102018.3711527-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240908102018.3711527-1-avri.altman@wdc.com>
References: <20240908102018.3711527-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SDUC memory addressing spans beyond 2TB and up to 128TB.  Therefore, 38
bits are required to access the entire memory space of all sectors.
Those extra 6 bits are to be carried by CMD22 prior of sending
read/write/erase commands: CMD17, CMD18, CMD24, CMD25, CMD32, and CMD33.

CMD22 will carry the higher order 6 bits, and must precedes any of the
above commands even if it targets sector < 2TB.

No error related to address or length is indicated in CMD22 but rather
in the read/write command itself.

Tested-by: Ricky WU <ricky_wu@realtek.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/sd_ops.c | 16 ++++++++++++++++
 drivers/mmc/core/sd_ops.h |  1 +
 include/linux/mmc/sd.h    |  3 +++
 3 files changed, 20 insertions(+)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index f93c392040ae..bb83db85a689 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -16,6 +16,7 @@
 #include <linux/mmc/sd.h>
 
 #include "core.h"
+#include "card.h"
 #include "sd_ops.h"
 #include "mmc_ops.h"
 
@@ -188,6 +189,21 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 	return 0;
 }
 
+int mmc_send_ext_addr(struct mmc_host *host, u32 addr)
+{
+	struct mmc_command cmd = {
+		.opcode = SD_ADDR_EXT,
+		.arg = addr,
+		.flags = MMC_RSP_R1 | MMC_CMD_AC,
+	};
+
+	if (!mmc_card_ult_capacity(host->card))
+		return 0;
+
+	return mmc_wait_for_cmd(host, &cmd, 0);
+}
+EXPORT_SYMBOL_GPL(mmc_send_ext_addr);
+
 static int __mmc_send_if_cond(struct mmc_host *host, u32 ocr, u8 pcie_bits,
 			      u32 *resp)
 {
diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
index 7667fc223b74..fd3f10b9cf86 100644
--- a/drivers/mmc/core/sd_ops.h
+++ b/drivers/mmc/core/sd_ops.h
@@ -21,6 +21,7 @@ int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca);
 int mmc_app_send_scr(struct mmc_card *card);
 int mmc_app_sd_status(struct mmc_card *card, void *ssr);
 int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
+int mmc_send_ext_addr(struct mmc_host *host, u32 addr);
 
 #endif
 
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 865cc0ca8543..af5fc70e09a2 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -15,6 +15,9 @@
 #define SD_SEND_IF_COND           8   /* bcr  [11:0] See below   R7  */
 #define SD_SWITCH_VOLTAGE         11  /* ac                      R1  */
 
+/* Class 2 */
+#define SD_ADDR_EXT		 22   /* ac   [5:0]              R1  */
+
   /* class 10 */
 #define SD_SWITCH                 6   /* adtc [31:0] See below   R1  */
 
-- 
2.25.1

