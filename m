Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E218BB8E
	for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739169783; cv=none; b=eiS8xOcwkWmz5HrvswH70B5jCYS6rOeT3KYw9sDxRuExYjjBLEQSyVXprN0u3pMr1xxal5nolQCxtInAz4YSfZ/IZdCmfkHSZ3E1xdnfYd4WwTNpLNjKBDjtaGEP0bWbJyvg9BHEtv1HUFel4C5dEAidfbuUxRi+XMtCMDNLyIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739169783; c=relaxed/simple;
	bh=sTu8gjKbXe1oc8dKzkH0idFxydW0rIupJhcyZN81l/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PILpmMupQCgRk1s2WBrVdGVPORcyshqFiAMUOJd1GRiNaoWYZDAYyF6+G9Pr0XPWKzgtSP0yIqBA6NvWZoPkbTR7EfnhDaFBEYaa0x+MlQIajaAhsSh6oGvr8pgw0SHDYiPoQpoZV48nJ+I1pNPPTyy/5eM4qRy+oHl+RiR96pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gZ3fCz+G; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gZ3fCz+G"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739169781; x=1770705781;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sTu8gjKbXe1oc8dKzkH0idFxydW0rIupJhcyZN81l/Q=;
  b=gZ3fCz+GT57zULaNaDG2dJbcX4VMUYPJmdgLNuy6cJg/4O8RfaTd0WY8
   IIkpjMG8UMPDf8d+yZPu6eaAIkOZZrUNucG8xmvuHVK404WHmaF8uUJw4
   +8Sy01sOJwYZAq/JRHg8CdeCe8dJG8JJQaoGuVjFhEvH5FKByGLx7FT5l
   Nkkmy450zRuM+8K/hbZsGwfpX3vzy3bPIGlHSVqoKvHE+yZRJ2sMO3uQ4
   TsJWpyqSvPx0rZwUTCXxhUVpqAlTpV9pHpT3T4fUCREMb0NwIpa3kzNwQ
   RSax4SDBMT3H4ZYB/xR6ShCrkg1uE589aeSD8RALmDZneYC3C7Wxj7aj9
   Q==;
X-CSE-ConnectionGUID: 5/fSwzVtRridtcbeNoxojA==
X-CSE-MsgGUID: UoI+pV+pTjeKY2cyZFK+1w==
X-IronPort-AV: E=Sophos;i="6.13,273,1732550400"; 
   d="scan'208";a="38615565"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2025 14:42:54 +0800
IronPort-SDR: 67a99240_SyREymF35KtSQLQn7y9/6SL5mk8lX2zMXicQ/i3tmCyn/bi
 q5Qc4D46sv+3yza16CmBKKIAZNACwlV06BQetyw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Feb 2025 21:44:32 -0800
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Feb 2025 22:42:54 -0800
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2] mmc-utils: Documentation: Add missing entry for "writeprotect user get" command
Date: Mon, 10 Feb 2025 08:39:47 +0200
Message-Id: <20250210063947.3298-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds missing documentation for the "writeprotect user get"
command to both the man page (mmc.1) and the documentation page
(docs/HOWTO.rst).

The "writeprotect user get" command prints the user areas write protect
configuration for the specified device.

Signed-off-by: Avri Altman <avri.altman@wdc.com>

---
Changes in v2:
 - Fix a typo (Christian)
---
 docs/HOWTO.rst | 3 +++
 mmc.1          | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index 095a9bd..3902fa4 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -28,6 +28,9 @@ Running mmc-utils
         If <number> is passed (0 or 1), only protect that particular eMMC boot partition, otherwise protect both. It will be write-protected until the next boot.
         -p  Protect partition permanently instead. NOTE! -p is a one-time programmable (unreversible) change.
 
+    ``writeprotect user get <device>``
+        Print the user areas write protect configuration for <device>.
+
     ``writeprotect user set <type> <start block> <blocks> <device>``
         Set user area write protection.
 
diff --git a/mmc.1 b/mmc.1
index 543742c..2f7209c 100644
--- a/mmc.1
+++ b/mmc.1
@@ -27,6 +27,9 @@ If \fInumber\fR is passed (0 or 1), only protect that specified eMMC boot partit
 .br
 It will be write-protected until the next boot.
 .TP
+.BI writeprotect " " user " " get " " \fIdevice\fR
+Print the user areas write protect configuration for <device>.
+.TP
 .BI writeprotect " " user " " set " " \fItype\fR " " \fIstart\-block\fR " " \fIblocks\fR " " \fIdevice\fR
 Set the write protect configuration for the specified region of the user area for the device.
 .br
-- 
2.25.1

