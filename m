Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A978836
	for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843705; cv=none; b=efoci0Kj9kO1cpgcmmLlVMYYSlwr7s73nBRVeTuOoWgyAKjPMYkVfmtkgWWYc49MWhPnOeJrQS6b4bqCgi10/SD4jPJr+GfVzETWWlUdT9oonFUtvXz3hhRpbPkQgomLr5E5LE34Qy1xs5D+K6I49oxuqllQRtNNvjCtsyUigac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843705; c=relaxed/simple;
	bh=SflBB2VFuOBBwt1Ljs+/xQ+g52r0onQOKLs5tQUKMes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hg6rSm3smaTEPP1tCWqLyhZrU7RbmDg7Hifjlms0YaAo/lZicT3dp53ZUWNRO7qNrlf28BkV4Ge4qCzsKh5nC4Fr5xtIQJY/6TbjRZXI+86mTiGKwHpMumHXnibpgGBBPm/YlEocqg5bWIuboR2uTjlt2okzGzWs+F5hlDram/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=mev0IHqP; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="mev0IHqP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1745843703; x=1777379703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SflBB2VFuOBBwt1Ljs+/xQ+g52r0onQOKLs5tQUKMes=;
  b=mev0IHqP/37pwQRv0jPlVMP2l4mHQendim1Q7sKMYvaC+X94US1o5XLc
   Yl/A5sMgSKxb/m53frcAq5X/7HnElnjFVsePWPPB0LpHyFDMNildNdA8w
   sdomiqxmdLLELLUu9LjpEti27FSr1WA2ly2lKZHCUx32Vcwlvc/DjIjXJ
   w4385BmbWsltz6xVthDlv4Q/ymYJ4LpF4erKfHsu2VGhyqQE8tiDVTVen
   iPGZh5uGxTS2ddN+AdC7o3v/5inPVxs/KRAW7Icpbzukc/iNmImC3MB6T
   5x5zUToYXzSxBG35NpXsj2Yiq6O/ZxUexcFWZ2itzs4gSgA+NKkrQfO0w
   w==;
X-CSE-ConnectionGUID: EhECQLamQbC6loOZicScgA==
X-CSE-MsgGUID: Sxk8ofLrTcusnogO6c1XZQ==
X-IronPort-AV: E=Sophos;i="6.15,246,1739808000"; 
   d="scan'208";a="82650436"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2025 20:35:02 +0800
IronPort-SDR: 680f67d5_OFw0PQ2kdBMFz7lBBj0Cj+9l0dsqC4Op4KMl3FCU0sgVrw6
 KR+RbtiRQ8BS8K5X2XmlpAOgPdZg4waJyJDJthQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2025 04:34:45 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2025 05:35:02 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 2/4] mmc-utils: Simplify and streamline print_help function
Date: Mon, 28 Apr 2025 15:29:49 +0300
Message-Id: <20250428122951.317055-3-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428122951.317055-1-avri.altman@sandisk.com>
References: <20250428122951.317055-1-avri.altman@sandisk.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The print_help function uses a character-by-character processing of the
help string.  Replaced the loop with a single printf statement to print
the usage message in a cleaner and more efficient manner.

While at it, removed the redundant programname parameter from print
help, as it was no longer needed.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 mmc.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/mmc.c b/mmc.c
index 2b58162..6e834ca 100644
--- a/mmc.c
+++ b/mmc.c
@@ -316,31 +316,21 @@ static char *get_prgname(char *programname)
 	return np;
 }
 
-static void print_help(char *programname, struct Command *cmd)
+static void print_help(struct Command *cmd)
 {
-	char	*pc;
-
-	printf("\t%s %s ", programname, cmd->verb );
-
-	for(pc = cmd->help; *pc; pc++){
-		putchar(*pc);
-		if(*pc == '\n')
-			printf("\t\t");
-	}
-
-	putchar('\n');
+        printf("------------------------------------------------\n");
+        printf("Usage for command\t%s %s\n", cmd->verb, cmd->help);
 }
 
 static void help(char *np)
 {
 	struct Command *cp;
 
-	printf("Usage:\n");
 	for( cp = commands; cp->verb; cp++ )
-		print_help(np, cp);
+		print_help(cp);
 
-	printf("\n\t%s help|--help|-h\n\t\tShow the help.\n",np);
-	printf("\n\t%s <cmd> --help\n\t\tShow detailed help for a command or subset of commands.\n",np);
+	printf("\n\t%s help|--help|-h\n\t\tShow the help.\n", np);
+	printf("\n\t%s <cmd> --help\n\t\tShow detailed help for a command or subset of commands.\n", np);
 	printf("\n%s\n", VERSION);
 }
 
@@ -504,7 +494,7 @@ static int parse_args(int argc, char **argv,
 		if(argc>i+1 && !strcmp(argv[i+1],"--help")){
 			if(!helprequested)
 				printf("Usage:\n");
-			print_help(prgname, cp);
+			print_help(cp);
 			helprequested=1;
 			continue;
 		}
-- 
2.25.1

