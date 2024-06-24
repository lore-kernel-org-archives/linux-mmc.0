Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD0137C2E
	for <linux-mmc@vger.kernel.org>; Mon, 24 Jun 2024 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228390; cv=none; b=bIQZcqJ64ok4McXf/3G2foCn8fwkH9pLFQvAwL6PYxvJdGXFAU2WKjzSXX6YstmT+eCHIL19g/uxFEDDW7sX9TUJXmN6Tg7oYo7nHjSTM4zjxKxwCJOvK2mc9AmWevK0lXNCJqAwQrPmkSxn6z/iFBDshz9yESkYH14/MkMWe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228390; c=relaxed/simple;
	bh=Xq+fwyI/FsFvLNpojMmCx2WNoO4mNfqq1i82vJwg3EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AR3jqkz8xAQWe6yrNPYzRdsg20WMjRpNICkkDlZJxSGP51buCQlLOGgbYfV7USt5jgmswLVgGkJyxAjh+uyLT5l6kgvZVNv1sqQTvAjulx4zARoh+0LKoI9KZYfylDqRnZGmEvlr+McSEeBOrJa/5nn8mzuyYUSlwE3FE8NeUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=au2k67OZ; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="au2k67OZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719228388; x=1750764388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xq+fwyI/FsFvLNpojMmCx2WNoO4mNfqq1i82vJwg3EM=;
  b=au2k67OZZF2vkyZI9XqzeR/s1UvtVmMPRauw9AfVkmJ9iaQW209gRAYm
   rj5ofeuZ8pJlNCyWYauwMKQP41RuQlgg2J2U8oqWsZyEyI5oNFZbW9mUW
   wiGvqNoUu0R8trVi+XUIMM8OmYIYQKutRZ80IJd5wA2Dvv4+32wIR29CO
   JTzva7MWz30uVWiFDYndZP5CNvlIBA0kHAGJmeegTHq5TUEpGBuguqTL5
   D2NCMfBWkjOvVgxhelX/EL9Rq7ESfverAAV723qenSBoaD23sqJCz/SC6
   QzwVf5Mg+eYW/omFbNvHQEB7liarYVPJ6ixwRmCdLADVGeK8cmSxy7ACp
   A==;
X-CSE-ConnectionGUID: 37afjnc4TQujJsdUHCvNXQ==
X-CSE-MsgGUID: 8+fuDEV1RhKBW6wVCGMnRw==
X-IronPort-AV: E=Sophos;i="6.08,261,1712592000"; 
   d="scan'208";a="20646181"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2024 19:26:21 +0800
IronPort-SDR: 66794a18_lp5ZRHY/Sur+hegrkiQgovzFuY24vHrk9SDiYL5BA5erDTV
 MyUTvYNEC49GF90XjFC1mXjW1lpskOJ8zPogg2w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jun 2024 03:27:37 -0700
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Jun 2024 04:26:20 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 2/2] mmc-utils: Add Read-the-Docs configuration
Date: Mon, 24 Jun 2024 14:25:42 +0300
Message-ID: <20240624112542.25657-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240624112542.25657-1-avri.altman@wdc.com>
References: <20240624112542.25657-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prior of building the documentation page, read-the-docs expects a github
project to be imported into it, so I had to mirror the mmc-utils repo
into https://github.com/avri-altman-wdc/mmc-utils.  It also expects some
mandatory settings in a configuration file - .readthedocs.yaml, add
those as well.  Finally, the public documentation is in
https://mmc-utils.readthedocs.io/en/latest/

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 .readthedocs.yaml     | 17 +++++++++++++++++
 README                |  6 +++++-
 docs/requirements.txt |  2 ++
 3 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 .readthedocs.yaml
 create mode 100644 docs/requirements.txt

diff --git a/.readthedocs.yaml b/.readthedocs.yaml
new file mode 100644
index 0000000..c6e885c
--- /dev/null
+++ b/.readthedocs.yaml
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# .readthedocs.yaml
+version: 2
+
+sphinx:
+  configuration: docs/conf.py
+
+formats: all
+
+python:
+  install:
+    - requirements: docs/requirements.txt
+
+build:
+  os: "ubuntu-22.04"  # Specify the OS (if this option becomes available)
+  tools:
+    python: "3.8"
diff --git a/README b/README
index 71a4e7d..f18fcde 100644
--- a/README
+++ b/README
@@ -12,13 +12,17 @@ process used for the Linux kernel itself.
 One can document themselves by reading how to submit a patch in the official
 Linux kernel documentation:
 https://www.kernel.org/doc/html/latest/process/submitting-patches.html
-
 Not all sections apply but it should be a good way to get started.
 
 A patch should be sent as a mail (not as an attachement, see documentation
 above) to the linux-mmc@vger.kernel.org mailing list with maintainers as
 Cc recipients.
 
+Documentation
+-------------
+https://mmc-utils.readthedocs.io/en/latest/
+
+
 Maintainers
 -----------
 
diff --git a/docs/requirements.txt b/docs/requirements.txt
new file mode 100644
index 0000000..fbf6840
--- /dev/null
+++ b/docs/requirements.txt
@@ -0,0 +1,2 @@
+sphinx==4.3.2
+jinja2>=2.11
\ No newline at end of file
-- 
2.34.1

