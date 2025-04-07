Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9985228CB7
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014859; cv=none; b=BCbvHx8PCk22BWZggMWTXzQwA5HL0wccyxUEk6C3b5bjWqau7uNRzxndZwdzWLu5PuFqGIQ1uIi8uYLH/MOR/QREpvMDdEwyGAlwQcGatIi4FOq4S8/ZrVCZ5RXgMt6IonOyfqC7+Kw7Oa+PFvH+/mnGRllhJ86d0Uzfkm0N+os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014859; c=relaxed/simple;
	bh=jFbSgVC6e8PJpYBXHxwCaiWaVW06k7b3K5g88XSbuEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BM9YisQGv5tiE76JsMomdRRHSy9f84tNaPnPLCbyoWOP+gTMLeTOpWN47rB2SiC4FnyV3zpRsLhHNhOsh8VsSZ24bjRJFK4+/Q1ke2XR0c9Qzx7L3M+PYT7EgVWjSEPE8/ptohzvHuyJPuTz2UhI5aIvqP5rVz84D4FnmM6q2Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=iMDz9kfo; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="iMDz9kfo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1744014857; x=1775550857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jFbSgVC6e8PJpYBXHxwCaiWaVW06k7b3K5g88XSbuEw=;
  b=iMDz9kforlhPr0uMzo85OJV9sXRxUkK4bovQSTAPx49IBI6z5z9ZmJlU
   Q2Rs5h3NKnk9h8RH2oZlbwImK4izpN3LOtf0lxxd7Ma6vcGJdiRwS/05b
   gaGVk+2Fw2HvfNWw2nU+umNSUwwWCuy2A4RLlJ4Cy1uhLg0HCE9iIFz/j
   7/Glv4fHJR8msHYY2rxcjuI/Hqko5meWLmp99CUxaYCaN5iF4GhRz0mYX
   A9lbdtl/NscxR+/yoA+jqGNyhMRrGgg3kvspHVpqPoEPAZg4UsXEwR2Xb
   q67eg7z07/ju+l0Z3DsNwUWZlIYDTwcCZylKn8husWxNkp1dKIZ28jDsB
   w==;
X-CSE-ConnectionGUID: QpTvo1/GSiSOFmduCdPz7Q==
X-CSE-MsgGUID: pIKQqmKSTKO94/SBRQLmvg==
X-IronPort-AV: E=Sophos;i="6.15,193,1739808000"; 
   d="scan'208";a="78093031"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2025 16:34:15 +0800
IronPort-SDR: 67f38008_r61VF1Clc6QLV+tHO5Sk+wzRJ19rTRjAbBDKmKyugY8ajlt
 9c05dQzj9DbIJHgolPZMhyx7uiEfzREYUQm+Smg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 00:34:32 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 01:34:14 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 10/10] mmc-utils: Doc: new secure write protect commands
Date: Mon,  7 Apr 2025 11:28:33 +0300
Message-Id: <20250407082833.108616-11-avri.altman@sandisk.com>
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

This patch updates the tool's man and HOWTO pages with secure write
protect commands documentation.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 docs/HOWTO.rst | 14 ++++++++++++++
 mmc.1          | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index 7a27a50..f2f2f35 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -93,3 +93,17 @@ Running mmc-utils
 
     ``mmc rpmb read-block <rpmb device> <address> <blocks count> <output file> [key file]``
         Reads blocks of data from the RPMB partition.
+
+    ``mmc rpmb secure-wp-mode-on <rpmb device> <key file>``
+        Enable Secure Write Protection mode.
+
+    ``mmc rpmb secure-wp-mode-off <rpmb device> <key file>``
+        Disable Secure Write Protection mode = legacy mode.
+
+    ``mmc rpmb secure-wp-disable <rpmb device> <key file>``
+        Enable updating WP related EXT_CSD and CSD fields.
+        Applicable only if secure write protect mode is enabled.
+
+    ``mmc rpmb secure-wp-enable <rpmb device> <key file>``
+        Disable updating WP related EXT_CSD and CSD fields.
+        Applicable only if secure write protect mode is enabled.
diff --git a/mmc.1 b/mmc.1
index 921ca19..e4ac7bd 100644
--- a/mmc.1
+++ b/mmc.1
@@ -166,6 +166,45 @@ Block of 256 bytes will be written from data file to
 .br
 Also you can specify '-' instead of key file path or data file to read the data from stdin.
 .TP
+.BI rpmb " " secure\-wp\-mode\-on " " \fIrpmb\-device\fR " " \fIkey\-file\fR
+Enable Secure Write Protection mode.
+.br
+The access to the write protection related EXT_CSD and
+CSD fields depends on the value of SECURE_WP_MASK bit in
+SECURE_WP_MODE_CONFIG field.
+.br
+You can specify '-' instead of key.
+.TP
+.BI rpmb " " secure\-wp\-mode\-off " " \fIrpmb\-device\fR " " \fIkey\-file\fR
+Disable Secure Write Protection mode = legacy mode.
+.br
+TMP_WRITE_PROTECT[12] and PERM_WRITE_PROTECT[13] are updated by CMD27.
+.br
+USER_WP[171], BOOT_WP[173], and BOOT_WP_STATUS[174] are updated by CMD6.
+.br
+You can specify '-' instead of key.
+.TP
+.BI rpmb " " secure\-wp\-disable " " \fIrpmb\-device\fR " " \fIkey\-file\fR
+Enabling updating WP related EXT_CSD and CSD fields.
+.br
+Applicable only if secure wp mode is enabled.
+.br
+You can specify '-' instead of key.
+.TP
+.BI rpmb " " secure\-wp\-enable " " \fIrpmb\-device\fR " " \fIkey\-file\fR
+Disabling updating WP related EXT_CSD and CSD fields.
+.br
+Applicable only if secure wp mode is enabled.
+.br
+You can specify '-' instead of key.
+.TP
+.BI rpmb " " secure\-wp\-en\-read " " \fIrpmb\-device\fR " " [\fIkey\-file\fR]
+Reads the status of the SECURE_WP_EN & SECURE_WP_MASK fields
+.br
+Applicable only if secure wp mode is enabled.
+.br
+You can specify '-' instead of key.
+.TP
 .BI cache " " enable " " \fIdevice\fR
 Enable the eMMC cache feature on the device.
 .br
-- 
2.25.1

