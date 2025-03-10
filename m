Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21EB1ADC7E
	for <linux-mmc@vger.kernel.org>; Mon, 10 Mar 2025 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741586256; cv=none; b=eMHiHZWsuT4hkP2h1qF0XDs3sN0BUsiZSJeFIW803mWN0rgx9c9ElDQ2S4O8Vj+XSV9pKrXtIyL4U0tVoH6V3PI6rw4kFUSnDV3903eeWiVASZOgsgYq6dk3kCVqRhOMuRNaDxl424DS1yLktZlAyqdwFBG1jWVY/fQT4PHuVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741586256; c=relaxed/simple;
	bh=O7G+WkwPrecCAI3wecop9Kf4SESvYjPH3muh2jQOBJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mGZUeG00KVZX6db6j9Lkh3CjGlKvXO1TxnX86H4ztiKRSLr5XTsb/4hTG7TiINgTcXEc/QMX8SDKHHzwnX1b9hOO+ZMQ9I2wTA7zEV3IrDr1PYNvZRp9R77GpjkfeAuNrbCZd2bVgC/zQ5Lj9KLKci1YccpitAlpyItzdt7Hfr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=XDUmA9HS; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="XDUmA9HS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1741586254; x=1773122254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O7G+WkwPrecCAI3wecop9Kf4SESvYjPH3muh2jQOBJw=;
  b=XDUmA9HSRFwvBojOJKY+7h/IVBbUQk9FCfy2Wk2hltJ9PXYEjJcCuX9t
   vMQfSIE9OosM5Av60DfGDY8+BMJ6+2pSB15uqrSIUoSHIzOgsP9GYAt7o
   K6OCnG8x9BB8C+FxeLuF7X2BQE6WntCmFnP/q3ZWNFYm8U/n1GtXFMCyD
   l250y2MnpT2POGCPNxT/6T23OhT4P7JBbePrjZ7P1/7kzDxA7eH/lL6F+
   6PBtnXmvuH49ojGQdvB8qswoFNlvHRnwpxagp7ch/N0TW14sElVV+MhQv
   PkB8YewEGzt2MlFRPsITGT3wKRclAV6EbKnUb2JnMIzjfvzKj7EST6D2o
   Q==;
X-CSE-ConnectionGUID: 64mWkJk1SxKLQ3BG5EgoYw==
X-CSE-MsgGUID: FlINO0pTQsiKBupg9EIguw==
X-IronPort-AV: E=Sophos;i="6.14,235,1736784000"; 
   d="scan'208";a="46600016"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2025 13:56:28 +0800
IronPort-SDR: 67ce7138_EYlg2Rshwuz+CA759/mlibx7U9y0/xKfA9Z3w06T2CBBb9l
 4Jpz+HqYHRUY026f/j9vWgYUJ3okE/gQPELISOw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2025 21:57:29 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2025 22:56:28 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 7/7] mmc-utils: lsmmc: Update docs to include new options
Date: Mon, 10 Mar 2025 07:52:31 +0200
Message-Id: <20250310055231.304728-8-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250310055231.304728-1-avri.altman@sandisk.com>
References: <20250310055231.304728-1-avri.altman@sandisk.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit updates the man and HOWTO page entries to include the new
options for the csd, cid, and scr commands. The updated entries reflect
the changes allowing the use of bus_type and register content as
arguments. These updates provide users with clear instructions on how to
use the new options for the csd, cid, and scr read commands.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 docs/HOWTO.rst |  8 +++++++-
 mmc.1          | 18 +++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index f4dd5c4..3c308c7 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -31,14 +31,20 @@ Running mmc-utils
     ``writeprotect user set <type> <start block> <blocks> <device>``
         Set user area write protection.
 
-    ``csd read <device path>``
+    ``csd read  [-h] [-v] [-b bus_type] [-r register]  <device path>``
         Print CSD data from <device path>. The device path should specify the csd sysfs file directory.
+        if [bus_type] is passed (mmc or sd) the [register] content must be passed as well, and no need for device path.
+        it is useful for cases we are getting the register value without having the actual platform.
 
     ``cid read <device path>``
         Print CID data from <device path>. The device path should specify the cid sysfs file directory.
+        if [bus_type] is passed (mmc or sd) the [register] content must be passed as well, and no need for device path.
+        it is useful for cases we are getting the register value without having the actual platform.
 
     ``scr read <device path>``
         Print SCR data from <device path>. The device path should specify the scr sysfs file directory.
+        if [bus_type] is passed (mmc or sd) the [register] content must be passed as well, and no need for device path.
+        it is useful for cases we are getting the register value without having the actual platform.
 
     ``ffu <image name> <device> [chunk-bytes]``
       Default mode.  Run Field Firmware Update with `<image name>` on `<device>`. `[chunk-bytes]` is optional and defaults to its max - 512k. Should be in decimal bytes and sector aligned.
diff --git a/mmc.1 b/mmc.1
index 543742c..85f8109 100644
--- a/mmc.1
+++ b/mmc.1
@@ -173,17 +173,29 @@ Disable the eMMC cache feature on the device.
 .br
 NOTE! The cache is an optional feature on devices >= eMMC4.5.
 .TP
-.BI csd " " read " " \fidevice\-path\fR
+.BI csd " " read " " \fR[-h] \fR[-v] " " \fR[-b " " \fIbus_type\fR] " "  \fR[-r " " \fIregister\fR] " " \fI<device\-path>\fR
 Print CSD data from \fIdevice\-path\fR.
 The device path should specify the csd sysfs file directory.
+.br
+If \fIbus_type\fR is passed (mmc or sd), the \fIregister\fR content must be passed as well, and no need for device path.
+.br
+It is useful for cases where we are getting the register value without having the actual platform.
 .TP
-.BI cid " " read " " \fIdevice\-path\fR
+.BI cid " " read " " \fR[-h] \fR[-v] " " \fR[-b " " \fIbus_type\fR] " "  \fR[-r " " \fIregister\fR] " " \fI<device\-path>\fR
 Print CID data from \fIdevice\-path\fR.
 The device path should specify the cid sysfs file directory.
+.br
+If \fIbus_type\fR is passed (mmc or sd), the \fIregister\fR content must be passed as well, and no need for device path.
+.br
+It is useful for cases where we are getting the register value without having the actual platform.
 .TP
-.BI scr " " read " " \fIdevice\-path\fR
+.BI scr " " read " " \fR[-h] \fR[-v] " " \fR[-b " " \fIbus_type\fR] " "  \fR[-r " " \fIregister\fR] " " \fI<device\-path>\fR
 Print SCR data from \fIdevice\-path\fR.
 The device path should specify the scr sysfs file directory.
+.br
+If \fIbus_type\fR is passed (mmc or sd), the \fIregister\fR content must be passed as well, and no need for device path.
+.br
+It is useful for cases where we are getting the register value without having the actual platform.
 .TP
 .BI ffu " " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
 Run Field Firmware Update with \fIimage\-file\-name\fR on the device.
-- 
2.25.1

