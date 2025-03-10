Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3C91B4153
	for <linux-mmc@vger.kernel.org>; Mon, 10 Mar 2025 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741586175; cv=none; b=Fldy0DQEfNgk+dy7Z5SU5Fu9Dpa3OttRdB75ky3fkCgeAJyKmh3tejsJ18E+T4b19mqZx6KPcKP+AEYrSwDMxXiYhl8IEBzXgV9H/XBBHQH1w++yqRsuh6IrqdLjL0351boesuUE5pbxCkrtIlXUPYUgaYtaEr4XfwV4brPlem8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741586175; c=relaxed/simple;
	bh=SGu3ZDLCJ9MF6SGoXb/jypwM5D1amvazIz2XygvCCvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N2DoywlmUghRZvPaXiLKuwfAS7jY976GnW8763ufmtxSyx2R0oo1QYUwryot9o9Ces5AYbIsghntIXUhND3/dCtTXZnck0qYXPdDKG9C8MEbN/Nf9/P/+mAB0TbSbnv07XvBbnLBcn5i70E3xi4enx/9USonPqCpUuMVTJ2i/XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=Mz4i7425; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="Mz4i7425"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1741586173; x=1773122173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SGu3ZDLCJ9MF6SGoXb/jypwM5D1amvazIz2XygvCCvw=;
  b=Mz4i7425aqA1v9yFSxjW0emkRk5A15h8/iSADUIcmiqps2/EnreXLZsG
   eEIqTq/26LiRLWr7sgAaqUAveYKYxEOFkX8dnhm70alsxrblv44vbXVWH
   aqxaF7ZfciTlsCQ5y8j+2jq/pXCt9te0j2EdwF3LXzIWlmLd6kTQRYnH9
   VQnDsy2bDGVbOmQid1kJX/CoUguwVhuN9RzFO/TI19gqsmw+a62qJzVzf
   vUZv9hnzIlN0cJXUXKhfU/kkli9swYDSWvf+4ESr8IhBl3ukCAGGsjXP/
   6epj+grwGZVArN5yrilj2LEmJUp8D++w9MdHjeK5KD+zq3LMlIjpGk5rm
   w==;
X-CSE-ConnectionGUID: 1d2QUsSgSzO46qKR4Hn9BQ==
X-CSE-MsgGUID: L0rlq4qGQZeRcwphCBy3jA==
X-IronPort-AV: E=Sophos;i="6.14,235,1736784000"; 
   d="scan'208";a="45704324"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2025 13:56:12 +0800
IronPort-SDR: 67ce7128_5B0Eev59akjRBz1HbE9XQiXcMCHFv+d0e+Ra4sicBYHUIKm
 JMEqU+EtbqK8OqAzEPLVGqCbQIZQSJiwDSeUiQg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2025 21:57:13 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2025 22:56:12 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 4/7] mmc-utils: lsmmc: Update HOWTO to include CSD and CID read commands
Date: Mon, 10 Mar 2025 07:52:28 +0200
Message-Id: <20250310055231.304728-5-avri.altman@sandisk.com>
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

This commit updates the HOWTO documentation to include instructions for
reading CSD and CID data from a specified device path. While at it,
further clarify the description to specify that the path is of the sysfs
file directory.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 docs/HOWTO.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index 095a9bd..f4dd5c4 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -31,8 +31,14 @@ Running mmc-utils
     ``writeprotect user set <type> <start block> <blocks> <device>``
         Set user area write protection.
 
+    ``csd read <device path>``
+        Print CSD data from <device path>. The device path should specify the csd sysfs file directory.
+
+    ``cid read <device path>``
+        Print CID data from <device path>. The device path should specify the cid sysfs file directory.
+
     ``scr read <device path>``
-        Print SCR data from <device path>. The device path should specify the scr file directory.
+        Print SCR data from <device path>. The device path should specify the scr sysfs file directory.
 
     ``ffu <image name> <device> [chunk-bytes]``
       Default mode.  Run Field Firmware Update with `<image name>` on `<device>`. `[chunk-bytes]` is optional and defaults to its max - 512k. Should be in decimal bytes and sector aligned.
-- 
2.25.1

