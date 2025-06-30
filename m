Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DA421A437
	for <linux-mmc@vger.kernel.org>; Mon, 30 Jun 2025 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268276; cv=none; b=q0tbnvQv4tv5TFOpdDhr8/+LizxDwnHaXoQzYuQL8Xs5x214JB+wUN1bHbbKd08BVMFDa+q4FQCDEudME62ots/1xaIw8AGgjktwB+62djBs7ZtbfS6xT+Sxgl9y69JPkTQhlEtU5neX9r5gvCl9HCIo1kqJ3Spu6WDwcHjxK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268276; c=relaxed/simple;
	bh=WpfXEEk9XRU73dOyHHHb09Rd/Y6XCfawiBFEYeJT2O8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rPepKjU1geb0c/2VTwctudr2qU9DH2MHLE/cQ0ihAcfTbdaYBkE67o2xLRMBkl4Y60pl6eDiys29RiEFr0GN2amRf4vc5DeO+wiqX48yyKCgZ4tbGGduJuWd6qKXu/JV19z2UvU8iljUsR0UrfIUxEZWaurdMRkQDIlQGYr0+3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=w+WgMFly; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="w+WgMFly"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1751268274; x=1782804274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WpfXEEk9XRU73dOyHHHb09Rd/Y6XCfawiBFEYeJT2O8=;
  b=w+WgMFlyzrcUaE3n5NeukpVUWGeuriznyuWZHC4IKLsqG2kic9kv4bOU
   BU4Eh3dYxqKduR7zBETPyutFKcXjoUJKpujhVdrw7rN6ahDsgWeV4HG01
   L446UTPnw8d0nJ+h99yM6jwnbAeAC+GSveuvoIBgYi8bhYLaPuyOTtJyr
   pOSd2NFX2hS4rx6nnopUQ0bNrhv0pAWpYg77Zrtl9z7jSx6I+Qm2V93br
   DLMCDmimKVVQVmJaB84TZoeOndpC+B+QyOLpQqdONfuOZ/73WQj5CNOoC
   T3eiIQskWl3TJW/ReidPOPXLBL36/XdmYsCAaVEywO9mnj86f9QYJC0Ik
   w==;
X-CSE-ConnectionGUID: toF0HPbGSnibcFStz9Wo3Q==
X-CSE-MsgGUID: CG3or40KRWGt1PD8J6u/Lg==
X-IronPort-AV: E=Sophos;i="6.16,277,1744041600"; 
   d="scan'208";a="85476337"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2025 15:24:34 +0800
IronPort-SDR: 68622d2a_s9fVYQESHKt2qON5Kr4rXhQJLc2b7hJibmCW11rBxeQ0mnl
 JkvBqmQNtjtuG/zlVU3eE8el4Si7jXAIWoov4Fw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2025 23:22:35 -0700
WDCIronportException: Internal
Received: from unknown (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.49])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2025 00:24:33 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH v2 1/3] mmc-utils: Add option to print version
Date: Mon, 30 Jun 2025 10:24:18 +0300
Message-Id: <20250630072420.114967-2-avri.altman@sandisk.com>
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

This change adds support for printing the version as a command-line
argument. When any of 'ver', '-ver', '--ver', etc. are specified as the
first argument, mmc-utils will print its version string and exit.

This makes it easier for users and support personnel to quickly
determine the exact version of mmc-utils in use, which is especially
helpful for debugging and when users are running pre-built binaries.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 mmc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mmc.c b/mmc.c
index 315fa70..e941aa2 100644
--- a/mmc.c
+++ b/mmc.c
@@ -460,12 +460,18 @@ static int parse_args(int argc, char **argv,
 	char		*prgname = get_prgname(argv[0]);
 	int		i=0, helprequested=0;
 
-	if( argc < 2 || !strcmp(argv[1], "help") ||
+	if(argc < 2 || !strcmp(argv[1], "help") ||
 		!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help")){
 		help(prgname);
 		return 0;
 	}
 
+	if(!strcmp(argv[1], "ver") || !strcmp(argv[1], "-ver") || !strcmp(argv[1], "--ver") ||
+	   !strcmp(argv[1], "version") || !strcmp(argv[1], "-version") || !strcmp(argv[1], "--version")){
+		printf("%s\n", VERSION);
+		return 0;
+	}
+
 	for( cp = commands; cp->verb; cp++ )
 		if( !cp->ncmds)
 			cp->ncmds = split_command(cp->verb, &(cp->cmds));
-- 
2.34.1

