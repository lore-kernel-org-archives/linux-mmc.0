Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437C51FCCE1
	for <linux-mmc@vger.kernel.org>; Thu,  6 Feb 2025 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831374; cv=none; b=UomaITyoQH2teDw2ph08JM7j4N00YWueRdUowNkRy4aLjBHmI1EL/yTdktK+oWgx5S34l6n/a1qrfhJqMa/fQ7GwU7ifUa7vL4WaMFkOmgr/K7AUsmqK1cJK9jVDHqC09YbwugI9fMvb3HezOsJjHTfA+Ry9mE2bd3salHdqNzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831374; c=relaxed/simple;
	bh=z4Xzj6nGj3GvGMZ4WeaoXdqXy0UD5ygQGUmgVuaaqz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pSA9My7yj7/oqYtCOx+G0vWFhQRnz1nGFmE91CLSHSxj320Kmg3mJ4jHySgdN+yCA98zoy69+aWFt0FMp7Ia6Vhx9lJKGZKPa88iEtvckzelgpRCWtVkCVI1Z4u/DDE5nO7spdeclUywv1VDvJOK0D+Mh5eYNPaJ4k7vO7AOjmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Tdw+b/QQ; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Tdw+b/QQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738831372; x=1770367372;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z4Xzj6nGj3GvGMZ4WeaoXdqXy0UD5ygQGUmgVuaaqz4=;
  b=Tdw+b/QQRtxHOeVGFDb5guaheykVGNKNWdVlzeXKblocINxxudchR9TA
   9LN701E9AKcb3CxTpFjdW+tXbh+PTOS36tevaFe5lvfhb2ITtVtg8IjvY
   AGyJ3m4a9Ut4yj83nGNraIGEyC1Q9kQsiYn65RqP7Kd/3ty9zr/4GAMv8
   kPzrp+jvidWs6ljfIdnOoKr+TJM4z2Cy+jaws6KwUOyBQ/5paLAw16yxQ
   eEk0EjvqDTod5WyayCeMGJrcL2ndjjBqlKEw65nKyKsoU6uaYzu+xzyq2
   N3oQMM1Tc71fHbKwqUAzZhNgX3QEhNPc+5wL7p8tA16CsmsuoOxuAUzX1
   g==;
X-CSE-ConnectionGUID: S9r5Jb1PSRqSJ4kGkGlBJQ==
X-CSE-MsgGUID: SAOBUTbKTWOMV3KoIhX1yQ==
X-IronPort-AV: E=Sophos;i="6.13,264,1732550400"; 
   d="scan'208";a="38324562"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2025 16:41:43 +0800
IronPort-SDR: 67a4681d_Dyt6iWdQr7P3R/cfEodjN7GKEwfqbiPoVTXgfJ0fstn9Pdu
 IMyw0glUqAoPWjOVRtlZMlFdhhi0aDyp5xoXvSg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2025 23:43:25 -0800
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2025 00:41:43 -0800
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] mmc-utils: Documentation: Add missing entry for "writeprotect user get" command
Date: Thu,  6 Feb 2025 10:38:35 +0200
Message-Id: <20250206083835.1294859-1-avri.altman@wdc.com>
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
index 543742c..7e94557 100644
--- a/mmc.1
+++ b/mmc.1
@@ -27,6 +27,9 @@ If \fInumber\fR is passed (0 or 1), only protect that specified eMMC boot partit
 .br
 It will be write-protected until the next boot.
 .TP
+.B writeprotect user get <device>
+Print the user areas write protect configuration for <device>.
+.TP
 .BI writeprotect " " user " " set " " \fItype\fR " " \fIstart\-block\fR " " \fIblocks\fR " " \fIdevice\fR
 Set the write protect configuration for the specified region of the user area for the device.
 .br
-- 
2.25.1

