Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A670120458A
	for <linux-mmc@vger.kernel.org>; Sun, 29 Jun 2025 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751195216; cv=none; b=sp1RIvJ+cbWgQrtB0bIAWf778/GiRgcNAnQQ67sRYwWq0+e1fBCdTrsfv81hwLSdFYe/1uR4079H1bFWi/sxVsWv+MGzruX9FXf0SoVbq0Hh68XSEHFyYYBNI9JC7pGNkXBKgiC+GNytfYKgH7sqNbZMQJLPZNhSTogSpwXnK/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751195216; c=relaxed/simple;
	bh=+fnnzg4qxemNGpMoOqzgOY6qG1RWuCcf98j2E1qYhmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q8AVT4gz+t0TMOA6XS5g9xykt7nN/r0U4iGevaBuTCOUgHKLzJfdHy6OKi+SlVeCw06kMpO1vNJP5WAQa5v3eZtpcKA1Wfrv5xRBpudT2BRyxskMRLj4qQ4BaFl/4y7WTHFwKCJ4hQ4l8+7W0p0CzXpedO3xIic9Tn/IzwM+jUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=j1moEjwj; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="j1moEjwj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1751195215; x=1782731215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+fnnzg4qxemNGpMoOqzgOY6qG1RWuCcf98j2E1qYhmY=;
  b=j1moEjwjwknRxL4Q6crzN+4oeFbWvKCSK8bVJ/ZwWF+D6pNPLkDPz86C
   M77GJfiutO/a4JSD3dLKE3SL/pJNAA53VEU9Uu/D59tVthrf3Yl9/S4iV
   Jo9nqHhxBYe8b2MgIivo6dXgjxcxCkyMii0J1r7ahlkgNILvwW0Vu77X+
   9DPpHIl0lVU2xD3uucdE+hKeEWXV1onaE7M8IeGHSCTuJGIU2m2eB6v/S
   cABo9NssNqsMgxUo+aQ6VpRv/R1WUMCZyLQ5L7pS9+cv5HWRkP/xclNyN
   VzFkqc/hOgQjCCw7xic5+D5lKmYOCi6ojL0Fkf0C3LZ6loWEA6fghyTUJ
   w==;
X-CSE-ConnectionGUID: 7Vd1niLsSxW0Hki/lPktMQ==
X-CSE-MsgGUID: Pe64YPK7TAa6GOpdIOD9KQ==
X-IronPort-AV: E=Sophos;i="6.16,275,1744041600"; 
   d="scan'208";a="86176611"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2025 19:06:54 +0800
IronPort-SDR: 68610fc7_KvyuvMsJVg3pX1wo4xtYx2ygNF3zP+Dzta2Kz/7AWsOCv2p
 zMzJHJJhWYtENn63f+Q8zt10d4lhkW73TjVsZgQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2025 03:04:56 -0700
WDCIronportException: Internal
Received: from unknown (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.49])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2025 04:06:53 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 2/2] mmc-utils: Makefile: Make version string to show commit date
Date: Sun, 29 Jun 2025 14:06:25 +0300
Message-Id: <20250629110625.112762-3-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250629110625.112762-1-avri.altman@sandisk.com>
References: <20250629110625.112762-1-avri.altman@sandisk.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the version string included the abbreviated SHA1 of the
latest commit (e.g., "v1.0-1-g5e67f7"), which was not very informative.
This change updates the version string to includes the date of the
latest commit instead (e.g., "v1.0-1-2024-06-29"). This makes it easier
to identify the build date at a glance.

Many mmc-utils users do not build the tool themselves, so having a clear
version string with the commit date helps greatly when debugging issues
or providing support.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c0284bb..7631524 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,7 @@
 CC ?= gcc
-GIT_VERSION := "$(shell git describe --abbrev=6 --always --tags)"
+# GIT_VERSION is set to the latest tag, number of commits since that tag, and the date of the last commit
+# e.g., v1.0-5-2023-10-01
+GIT_VERSION := "$(shell git describe --abbrev=0 --tags)-$$(git rev-list --count $$(git describe --abbrev=0 --tags)..HEAD)-$$(git log -1 --format=%cd --date=short)"
 AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2 \
 	    -DVERSION=\"$(GIT_VERSION)\"
 CFLAGS ?= -g -O2
-- 
2.34.1

