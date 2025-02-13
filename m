Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F721207E1D
	for <linux-mmc@vger.kernel.org>; Thu, 13 Feb 2025 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432030; cv=none; b=EXQkiUZ7cI6+GmCABgvaUvSRt6uaVnEmAieR5owbUEcC0uFAZTZMdH3WzUflwfxeUMhhgjH63C7DRW36FZLg/8xZXX7UqB+AB3tWO3BY3OKxnaIf5rtxPoKLDqygBH92ab8rO8d3Vs9HH1SOKPooUgtzyvcetnB7To5hLzYJJ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432030; c=relaxed/simple;
	bh=y8Py8vmPxH5OTpjW0qjXvB94jDiwq/LS/b8CpEO0a+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JlXVqCTiAvslhSo4vewGK8XDDPHxR34csSGOy+2hyrMaPmGVh3g70QkoZ9DXRpn/5vMvuXBepmX2/9UBiF6TTxQdwYWpa0+bzMhqCIOnzzrBbhUWSFsv8w89osCw/IijlyXa/Lx5getGvYUGuzWDGyX0kwcedceNeOHv62b3qQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YluAzpIu; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YluAzpIu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739432028; x=1770968028;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y8Py8vmPxH5OTpjW0qjXvB94jDiwq/LS/b8CpEO0a+I=;
  b=YluAzpIuWbCFWNkOdh+OwqvWrE0T75l44S4q9IrqgqFGW8wYKtRgPqGV
   xQL//q9CoYpHYgwSekCxuXKX2/6wy412rENq0tXEQX9MLPvzjDhKksaIq
   8WpOgtjrMxWqMEWW2WSgzfAEOO2Qtz1X3kYwViQpmJNbFA1vezgJoJiWr
   VxSM5hq+W8puDZ7q0hYqtsW1Kt/rnhY3lrPp90/CIKXt/Ux1Iu8ko1VRf
   XekwQOzSh1Jc7yWnJKCiaPNnXjNkpaqKqPSCwhSojrS/fI9EGak1AutIK
   PU8jYafQQ0o4nIE1s1d8zJId10VDIntt6OydjMcTCuGCt8eaBBorS6yVz
   w==;
X-CSE-ConnectionGUID: cw3qzNbyTiu1/6cW2muBIg==
X-CSE-MsgGUID: b0krq/5gQ0u93E4fSpF3Aw==
X-IronPort-AV: E=Sophos;i="6.13,282,1732550400"; 
   d="scan'208";a="38138231"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2025 15:33:47 +0800
IronPort-SDR: 67ad92a8_Lj9ADp2o3NpEmq3VzzSw4Tfl73ra3iROMVm9WuKYGB+Zq3E
 +VAdlDixC1mEYhQo2Z2EWbB4Dc4gVJtxf0LyzmA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2025 22:35:20 -0800
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2025 23:33:46 -0800
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] mmc-utils: Docs: Fix Sphinx build error
Date: Thu, 13 Feb 2025 09:30:38 +0200
Message-Id: <20250213073038.77937-1-avri.altman@wdc.com>
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

Signed-off-by: Avri Altman <avri.altman@wdc.com>
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

