Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D512E21A437
	for <linux-mmc@vger.kernel.org>; Mon, 30 Jun 2025 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268280; cv=none; b=dss8ER4CF+5OD3+1gTzqrJEuMJvVtCobEil3hHyc3A95cMrHdfDJ//Fshr08SMD5lAi871ZqFcyIej+EeuhkYi4auOdnvXYrJJJP+dtinUihuQOSs+6RWJu5pKJrDA0qrDd5c6S9ZPORrgs5Se+jxXRd8r/jTuXklTwJB5vkNr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268280; c=relaxed/simple;
	bh=+fnnzg4qxemNGpMoOqzgOY6qG1RWuCcf98j2E1qYhmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DCPlvMLofBK11zqZ06RBl2hCcj/xPnTSOEOEGlSr0uO66SqU7RdtpdkD1u56xyXhSqcpo3NSmmZWPOKhZnQIJfQAKOWRkZuJ0D7WF8pQG2hy3/x+RDVppk1j3r8+8Gwe83cABSpdBAQAGnzTj/Gz+pOpSOFymAyGW3KIQ6Pqm9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=bXcaNO9c; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="bXcaNO9c"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1751268277; x=1782804277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+fnnzg4qxemNGpMoOqzgOY6qG1RWuCcf98j2E1qYhmY=;
  b=bXcaNO9c1iDuwOtpc0gtlFLqOyexO3/ZCUzk13afEahWp04gfhZ03Dku
   7m8sTTUmBSXFFuC1HmSAlbj20+52TVboMkYgtpW1OjHioYah8uZrhh14t
   KxXjDOe6YvMudheDvkrAOH78RkIddiCY3GV5EN0pCTeBH8J42Stt0AxBv
   A2JuU0wwn1x9VXQDGViercvhl/c9quIesMjUpIT8ZEuZAlIlU65EIrjdf
   oI6Y+21SvBzcBAV3dPs3eRO/sQFCdwlP9JjyPjcpLeI+lbArgcOj/TIJu
   W63M6somr9LPuTW9BzrAIqpHPpAbHjUh18UIs3Br694m84jAMKqlLVEsm
   Q==;
X-CSE-ConnectionGUID: x1Z7/jV+Tk2yIonKLXJi3w==
X-CSE-MsgGUID: IOF8F0gRS8mD1RtBj31z9g==
X-IronPort-AV: E=Sophos;i="6.16,277,1744041600"; 
   d="scan'208";a="85476340"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2025 15:24:37 +0800
IronPort-SDR: 68622d2d_ODVoVerpqtZrCpf1ij+pTvN6YDW4PZk2y+D6+k9xgMyZX5R
 Aah725LVO5VSSUPB96jJE+VFaqhkyzQ2UjOHpSA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2025 23:22:38 -0700
WDCIronportException: Internal
Received: from unknown (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.49])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2025 00:24:36 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH v2 2/3] mmc-utils: Makefile: Make version string to show commit date
Date: Mon, 30 Jun 2025 10:24:19 +0300
Message-Id: <20250630072420.114967-3-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630072420.114967-1-avri.altman@sandisk.com>
References: <20250630072420.114967-1-avri.altman@sandisk.com>
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

