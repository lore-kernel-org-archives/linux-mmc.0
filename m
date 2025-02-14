Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C6421518D
	for <linux-mmc@vger.kernel.org>; Fri, 14 Feb 2025 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739519696; cv=none; b=DzLoUONO8+Fs7umfBGYEa/o4kdt+CSs9GVI3IsDUhr5chKwcg8wRxCLuGDIDZulyZtelVmtXo7xmyqk11P89ZQOsXFr8v3VPUFrpdRhfa575bO7MJUEZNfozWT52bKp94WdfMNMs4ePoR0YECxajhSh6l6N6keYrvhqd9Ak5e1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739519696; c=relaxed/simple;
	bh=FdeeB1KeYuyF/yfsp+KHT7pYy9SIRgqoWQ+DxBZe11M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tFDDCT0IwlXNEcTGvGzCYM2wf4Em1jK8q7RoNoOwGXm/kgxMTT33/dkSO9cNXKi0F0cdIhle+hqnvIb7hBQ7lTPtrkrY9D12pzbXanLN9DQrFBKtAgwwNgxO4GfyyrvGhHzaIqIWR1GydrbcNPOFfJ45mqZCeRm/CXHkcvwbWsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=En+rrgX1; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="En+rrgX1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739519695; x=1771055695;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FdeeB1KeYuyF/yfsp+KHT7pYy9SIRgqoWQ+DxBZe11M=;
  b=En+rrgX1ZEh+N5I+CbaDQP/pfNy/y0vTD3IzosEWuYFh90Fu8dtRtUKd
   YdjwzD2SZ0Bzot99fI3lWWn8Qhd7K2+WkJKnhOtpwsUz1FWFIEYvcnDMz
   416UF7XHUwor94w2yCRIiOE2XuuF/yLWFHtYQ4zNiNmR5f+tYHT0yJje8
   SOnY7onbJrOKkgr817YIOdzCWT5QVQS2PtbPE0iD5ySlh6xf5mb+ziQYX
   Hkx8/Ex9ctLywAY5HV+hFdmsaJ2RhHqgYfNJTpHmB5SxHYoSNB9kH4W2p
   cZ0AeDUpEdGodtZcIcPrRNNYVjjBu+dHqOkGrz1/AglA5epQMg2FKEzzE
   g==;
X-CSE-ConnectionGUID: HqWQDiwmQtuV686AFg87eg==
X-CSE-MsgGUID: vS6V4D9JQNS2Ty6oVNyaeA==
X-IronPort-AV: E=Sophos;i="6.13,285,1732550400"; 
   d="scan'208";a="37896466"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2025 15:54:47 +0800
IronPort-SDR: 67aee913_kWDAuQndOJiRt9neSJEeUCvOdIysCNenjlUl0NVtP9/cIJy
 TycGbAef0Y0Qie1dBVdyKFTqjOC+XbsZArIGsgQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2025 22:56:19 -0800
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2025 23:54:47 -0800
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2] mmc-utils: Docs: Fix Sphinx build error
Date: Fri, 14 Feb 2025 09:51:46 +0200
Message-Id: <20250214075146.85101-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a Sphinx build error encountered during the
`make html-docs` process. Apparently the _static directory was absent
and the master document not being set in the Sphinx configuration.

Fixes: 1d1b1159ce7a ("mmc-utils: Add documentation section")
Signed-off-by: Avri Altman <avri.altman@wdc.com>

---
Changes in v2:
 - Add a fixes tag
---
 docs/_static/.gitkeep | 0
 docs/conf.py          | 2 ++
 2 files changed, 2 insertions(+)
 create mode 100644 docs/_static/.gitkeep

diff --git a/docs/_static/.gitkeep b/docs/_static/.gitkeep
new file mode 100644
index 0000000..e69de29
diff --git a/docs/conf.py b/docs/conf.py
index 9c08a23..9bc69ce 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -39,6 +39,8 @@ templates_path = ['_templates']
 # This pattern also affects html_static_path and html_extra_path.
 exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']
 
+# The master toctree document.
+master_doc = 'index'
 
 # -- Options for HTML output -------------------------------------------------
 
-- 
2.25.1

