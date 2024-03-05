Received: from smtpcmd0871.aruba.it (smtpcmd0871.aruba.it [62.149.156.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C957870
	for <linux-mmc@vger.kernel.org>; Tue,  5 Mar 2024 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636583; cv=none; b=GGG0fP0vWJ0PXccOEV1gPlSpUr/32u23zEEeSZ9JKSCfQ1W9357B+4hEUdvGwQDS/SUEYFrQtI1hR3Je6WfkHnvBGDi4HkpU4K924JSh9sWHW6ICQ5JP3nUeSIgJcusNj0QgWQoHHzjH1cDYpA6P4a/sFGU+p4fLJ8q2qbKjGWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636583; c=relaxed/simple;
	bh=n0AXGq42a8Y3YaIVBg6aGp0q3mMFkUPb85dOrwAo3xI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fzgv0wVpqLqA5/nX249xFKJzXp4AQRgoJ35tqf1dEC0p2R5wtBm9vHCw2IhnKzjE8/xV86sTh4Nme9DgLO4U0baVrgAEhyGs6aYXboEujL/hCH5kViJRcwUwZZBlFiALeJm2JrkTaZ4sR4sIYOmCEqqkb3QfBhbdu+dqixVWcuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benettiengineering.com; spf=pass smtp.mailfrom=benettiengineering.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=KdEelTTb; arc=none smtp.client-ip=62.149.156.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benettiengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benettiengineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="KdEelTTb"
Received: from localhost.localdomain ([84.33.84.190])
	by Aruba Outgoing Smtp  with ESMTPSA
	id hSWUrDCHsnAihhSWUrEADC; Tue, 05 Mar 2024 11:59:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1709636390; bh=n0AXGq42a8Y3YaIVBg6aGp0q3mMFkUPb85dOrwAo3xI=;
	h=From:To:Subject:Date:MIME-Version;
	b=KdEelTTbpdiL73L9bzLym3Hz4wfLApFbgrt4lrOUj2/D+sb9ac9RrvBjhaVTKRGUq
	 9+Uva1q+jbQXsxGihPe2xH7NrLxZ/sq4pJICgZTpaDXh8hx/gzig+kClTYZgphRml8
	 hpdq8+ZoYjdDEi5nqkbeujTwHCdarxM/2ZXb1I6N/FINF3BpfcP/6XaYN0MfBVX3CW
	 4R4XYTJlIKLIMq/bvqHYeEK28IfYHCgRvHf/fk6iJzB8KIheokdmU+2ZvTZc6alJNt
	 lPmn2+he1eXNjiLiJ5r0nFigrZyFKv3/xhdyZMmnnGkZyqnkBXlAM9DfnPj605Up9h
	 FFq5+ze6gYPZQ==
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
To: linux-mmc@vger.kernel.org
Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH] mmc-utils: mmc_cmds: fix type-punned warning on &ext_csd[] casting
Date: Tue,  5 Mar 2024 11:59:49 +0100
Message-Id: <20240305105949.392092-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOfpKKt87V2U1HcTQkPWA1g+osVocjl+SiImm+heEO6RbGktBkJOMDL2w+9U/HHJOAg832HS+umyOrOE0LPOoQcigFjQ5VhrOQG8/d+hHiq8PYnr/Va5
 6ANp1n7HW8xSl/SBf2h19c1Hg4IGq1WqgG8bVmH6oRerk9hru+kWPu1TV9Vnwk4deFlg0my5Hopj6zCf+cBCo6OCFMVQhM51EK0IiSQ2xMF2SRpf9TeW3Ztk
 tgJB+I5ih8zrxqTKEtnDES5IXnNbndXdw9M7tz2bRWBX+C0P9dupNyR7csMCJJ06

When building with -Werror=strict-aliasing error is thrown:

mmc_cmds.c: In function 'do_ffu':
mmc_cmds.c:2972:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
  sect_done = htole32(*((__u32 *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]));
  ^
cc1: all warnings being treated as errors

Let's fix type-punned breaking strict-aliasing by memcpy() the variable.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 mmc_cmds.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index ae7b876..dcd60aa 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2968,7 +2968,8 @@ do_retry:
 	}
 
 	/* Test if we need to restart the download */
-	sect_done = htole32(*((__u32 *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]));
+	memcpy(&sect_done, &ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0], sizeof(__u32));
+	sect_done = htole32(sect_done);
 	/* By spec, host should re-start download from the first sector if sect_done is 0 */
 	if (sect_done == 0) {
 		if (retry--) {
-- 
2.34.1

