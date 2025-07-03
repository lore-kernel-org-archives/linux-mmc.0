Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A3523C4E9
	for <linux-mmc@vger.kernel.org>; Thu,  3 Jul 2025 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751521748; cv=none; b=PYSPFxl0BFWumPzHG5j3M6EQiaIqIKlRNtl0vgUquwzigrRE3CvN/hz5nSVgZSipyrscwrMCdsXKB6RuUiMRwa2JdlD4l+2A3Cvhi1Y0OgiziQRDw5im2ksuxnwWcPWmV7AeqVqwqQIM4vrOvRsqNRa6yrtkNZj1d96RxHbHObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751521748; c=relaxed/simple;
	bh=zJLlF3TBHmJH1+PxipzRq8qYJSFNyeI/F6pqFd+m5QY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i+wV0QDSk3eO0z6KwUhSpSeGa5qzuRHijtIQ/QnjIBWpG4Noeift/hMfmrwhlGRgyvCifskl+OxmMz46nl0mgqHHhPbSvCR3oZxqP4bPdhMFoyGAH6vq3E5aJ2kNdKddtac+eVjizzIC6aU90Av4MorOTe1RvZIrZepLKj/NhY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=bkA/Dr35; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="bkA/Dr35"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1751521746; x=1783057746;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zJLlF3TBHmJH1+PxipzRq8qYJSFNyeI/F6pqFd+m5QY=;
  b=bkA/Dr35jiJRmNE0skYy5KrrDohAY67TpahoipPVvCtD4f7IVKykNEsx
   TExapmW73Mmka6fW5CQAGzVa8lZNiby7pqkYRlaGvbOnpx/TNZ+Qxxkqn
   7ZfKQLvjEqzKD6xaM0xs69oLLooROroQCv2Osil5JPJELhAMZbIqhdqu/
   dIpzoUVDcVt+zUxpRchxD8ySiNrXUwgNWmU6aZT9QuFwEtu67FOfcJszB
   uk3PK1Awzoj4/Y4vpOzNnxoZfsuWcS+G42vX93jcX2uXasG4FR9KNKS6Q
   j1xxzac1zIroZAIqox7tqWs6pgKu15sv70LqWGYQe0437YCPQS9Res+ie
   g==;
X-CSE-ConnectionGUID: sR0BRL7PTTC7AT/stch7aQ==
X-CSE-MsgGUID: vVZ9gRAIQKS6UPnu0UaY8w==
X-IronPort-AV: E=Sophos;i="6.16,283,1744041600"; 
   d="scan'208";a="87685629"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2025 13:49:00 +0800
IronPort-SDR: 68660b40_ZWJ+4ELWoSEarZUog1L1CEjaopmfh0l4K4K0JScY3FgCGqC
 gkFQkcFijZW6muhfq/m3XxUjEvJ58XyqR9pdoEA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jul 2025 21:46:56 -0700
WDCIronportException: Internal
Received: from unknown (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.49])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jul 2025 22:49:00 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>,
	Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] mmc-utils: Remove unnecessary null pointer checks
Date: Thu,  3 Jul 2025 08:48:45 +0300
Message-Id: <20250703054845.49206-1-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify memory cleanup by removing redundant NULL checks before calling
free() on pointers. Markus suggested it following static analysis by
Coccinelle.

Suggested-by: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 mmc_cmds.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 7994223..b16ac69 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -3421,8 +3421,7 @@ static int __do_ffu(int nargs, char **argv, enum ffu_download_mode ffu_mode)
 		fprintf(stderr, "FFU finished successfully\n");
 
 out:
-	if (fw_buf)
-		free(fw_buf);
+	free(fw_buf);
 	close(img_fd);
 	close(dev_fd);
 	return ret;
@@ -3651,10 +3650,8 @@ int do_alt_boot_op(int nargs, char **argv)
 	ret = 0;
 
 alloced_error:
-	if (mioc)
-		free(mioc);
-	if (boot_buf)
-		free(boot_buf);
+	free(mioc);
+	free(boot_buf);
 boot_data_close:
 	close(boot_data_fd);
 dev_fd_close:
-- 
2.34.1

