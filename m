Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F11B4153
	for <linux-mmc@vger.kernel.org>; Mon, 10 Mar 2025 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741586164; cv=none; b=uyMLpPv80azc0OePCLAibShfdwgKkdIaF2ubbVr6kmRyXg6G9NpBZRMb7nCVwden3UYZIOuDbOplO/m8iDo0PbgUirDF1FA3A/cNhAwhlM1bZ8Dor+gDfBiNohLpA+f1eLRoH08a4JA1qApnMHvYNc4D3XUFLcH18nEenbhPMzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741586164; c=relaxed/simple;
	bh=K4GO1r7TD/0wQ6o1XNUWn7x9JuNiAKRCKy9LrWS61D8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ATSaVk771E4336dJmORGAUmbN1ZZrAbRfEvuDyMzApuZu/nNsMksM48lFFa5nHhBnwaAH10u0seMU4+X5EmMYk2O91PahopLZnSf4kogs2TRyea5xkYeXj4SvmOGy/aLYC8WbyPCpJndspd87VrDoRbS/XkPMlS68sQrBPgu5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=JHXTbEwy; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="JHXTbEwy"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1741586161; x=1773122161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K4GO1r7TD/0wQ6o1XNUWn7x9JuNiAKRCKy9LrWS61D8=;
  b=JHXTbEwy/v11HUVCbRRRMf0clJJE9NCmosLzToH4aOG0eO474nxpHea8
   PFxumJGRJ8cM90zQCHWoiqHVv9mIDXISzQUghMwR8qAry/505Yti/HJB+
   0PB+ylgz/rJlt/+JwHFxsqL6wBzsK6+vbEs2RIzfGs3ueM174nyr65N16
   ef9Sb2s17XQMoSVBQDVCoPpXA2WfVeowGT6h83KMob9okkvrRM+UPt89G
   wI6QEmvzDdpwLyakOVKCJD/1c+PBTqAuk1umerfzq398j8ZvuppU/t4ts
   1Upzs5snJRKjJhWwRCAhpRIrpkM5yNDCjkUCoopBREq8s3XBmDI9GwFd9
   g==;
X-CSE-ConnectionGUID: ztnsQCMaSlKNF63LOz+xDA==
X-CSE-MsgGUID: 8TRZtjjJQgef5TomvRPzKg==
X-IronPort-AV: E=Sophos;i="6.14,235,1736784000"; 
   d="scan'208";a="46164493"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2025 13:56:01 +0800
IronPort-SDR: 67ce711d_UUYpClo+SnmDoODJcwxQe2dBibU5/ka/nWK10F9JvlDMOeA
 /gGHxMVLWOnJKC7yAgWSnbJ6HNN7QSrU9TpqVxQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2025 21:57:01 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2025 22:56:01 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 2/7] mmc-utils: lsmmc: Remove redundant argument checks in do_read_<reg>
Date: Mon, 10 Mar 2025 07:52:26 +0200
Message-Id: <20250310055231.304728-3-avri.altman@sandisk.com>
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

This commit removes unnecessary argument checks in the do_read_csd,
do_read_cid, and do_read_scr functions. The checks are redundant because
the use of optarg in do_read_reg already ensures that all necessary
arguments are provided and validated.

The optarg mechanism in do_read_reg inherently handles argument
validation, making these additional checks superfluous. This simplifies
the code and avoids redundant checks.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 lsmmc.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index bc0e264..468a533 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -2192,30 +2192,15 @@ static int do_read_reg(int argc, char **argv, enum REG_TYPE reg)
 
 int do_read_csd(int argc, char **argv)
 {
-	if (argc != 2 && argc != 3) {
-		fprintf(stderr, "Usage: Print CSD data from <device path>.\n");
-		exit(1);
-	}
-
 	return do_read_reg(argc, argv, CSD);
 }
 
 int do_read_cid(int argc, char **argv)
 {
-	if (argc != 2 && argc != 3) {
-		fprintf(stderr, "Usage: Print CID data from <device path>.\n");
-		exit(1);
-	}
-
 	return do_read_reg(argc, argv, CID);
 }
 
 int do_read_scr(int argc, char **argv)
 {
-	if (argc != 2 && argc != 3) {
-		fprintf(stderr, "Usage: Print SCR data from <device path>.\n");
-		exit(1);
-	}
-
 	return do_read_reg(argc, argv, SCR);
 }
-- 
2.25.1

