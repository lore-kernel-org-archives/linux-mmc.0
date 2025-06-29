Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D721E25E8
	for <linux-mmc@vger.kernel.org>; Sun, 29 Jun 2025 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751195214; cv=none; b=bxEdRor5VBay9qFLbIxwtrZC6Ov70Mz3hQRTfcKJZPHD91RImxC8NyLgHXdSFg6yyrAzGA/25gQqvULQrMyer2NuyqgHrOHrJs9jkd5gFSrRZOSh6awyvor0kt89n8YMQGO1lu9XfLfmSDwUKq9H51E9FZbwPiXXUEOrhq7G5is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751195214; c=relaxed/simple;
	bh=WpfXEEk9XRU73dOyHHHb09Rd/Y6XCfawiBFEYeJT2O8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DHLcYlZvRkd/fr3/JiJwMxKe1FPAD/FmtRVWypX0E7uEHn1XXmgaMOkaPq+7fBGle1SBEQt3Ew20UOYmC6gIKQQnR0ZZ8elV4ipkgjLjAqhSKgsIkolbGA5u79J0g+giDQv03VGR+mwVxl+sqTI38XpPsuZaS/NrOkEOsXolIRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=VCplkYqs; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="VCplkYqs"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1751195213; x=1782731213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WpfXEEk9XRU73dOyHHHb09Rd/Y6XCfawiBFEYeJT2O8=;
  b=VCplkYqsqbcn1OE1kJsSN3fniiAW+ypv6c1xWfC100sqhoMgvhuIWOYc
   utT1Tr9i9/YnedOVm717mePcxGvto70xoBIOhDGBuwvxYDgIKlqvri6Se
   AYLQYYb0IVTo5kws+vpJ/uDyDF40swfSt99zxhKrnkhDi3VVYMIEiWpoC
   UukasU9W0TK20OEWLb1AyJJUU/cfoKE6jlfBZVk3dDBDZ7GRC6PBj2QKX
   +buyx3/W6sOWLmc57CD7WS1LO13WNPDum5BIFFO1ZUKSjavSMiy2U1YkO
   vgzXJtfi07L+FL1OLOevguVzxYYAWNzHQ0DhP7XJI/q6ND+8xqUde/voz
   A==;
X-CSE-ConnectionGUID: OATtWWq2RPqaN3rrsKrb+Q==
X-CSE-MsgGUID: /kPxQ1zKTlSTA7GyK0ITaA==
X-IronPort-AV: E=Sophos;i="6.16,275,1744041600"; 
   d="scan'208";a="86176608"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2025 19:06:46 +0800
IronPort-SDR: 68610fc0_VOyBD7OT57niJwvX4cXn1RXDy++1LzzVhK9ylYSs3L2ybI7
 uP2mAXJ3vJqSYcc10QjRiHyEdwNQiXLzTuewmGQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2025 03:04:48 -0700
WDCIronportException: Internal
Received: from unknown (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.49])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2025 04:06:45 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 1/2] mmc-utils: Add option to print version
Date: Sun, 29 Jun 2025 14:06:24 +0300
Message-Id: <20250629110625.112762-2-avri.altman@sandisk.com>
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

