Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D8121A437
	for <linux-mmc@vger.kernel.org>; Mon, 30 Jun 2025 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268282; cv=none; b=MebDW7S+RLVUHCPpSRwAWn6URukJGs9MEgrvKMmkdclVPqFd8WYiyDhC5w9thWMKe1zG5EuV49otkpi7uHF8Kng0bjRJh4PqUG7TvwFyJ+Q+60/EA2yaWOef0TSNRsiihBaQPzvs0ZXJXRjK7jwFDJIF2WhmxNTlgJb4uziwhjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268282; c=relaxed/simple;
	bh=v6h4HIq+MsZmwCtUp9HxgGIE1qJnDm2e7Mrt+8Mz/8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5Ewazdv51AuQrDOFzrcX7N4LOseLwoZYde7iRPxI5Sduvzc0HmWi2jh/Mv4ENPmiXRVN5st3I6prK/JgwPxvLXscTJ/czlkrJnLHh/mywt6b48fdy8P6iPTyzDLqPlH3qAXnoMwPAkYjtJrNezluv2gLRR3m09JBbOzIuxOvYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=B5HT+4RD; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="B5HT+4RD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1751268280; x=1782804280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v6h4HIq+MsZmwCtUp9HxgGIE1qJnDm2e7Mrt+8Mz/8w=;
  b=B5HT+4RDeNL98Ql9LCWiqlXZiGSAnKt//ncjyrjqC09mm3PC3+Pn3h7L
   /WHjShpHyL89ujJCsDY7G2ARrZ/6wr90hzAxAUy9GfV5AGSwWul+7tes/
   Nj48AG9ZsmagH/CeVJlrVg/fSzKt5zkUjcCOVrb9Hj34T3c27r0ZXzklM
   R2lCgGzGT/0FSHDfmnozMNIEBJU0k2MvHgKsNXKsRqYg0MlfdKSW8GPXY
   WzgcoD8Nry2Nis1pSjm3vWwdxI/H3d1thh5JN3WiyFahB8SzjnswTLwwD
   DUV257RkHNdnNcIp9bTBthNGsKGzfBObmetTmiBWWZ7unx43TMPO2AytM
   A==;
X-CSE-ConnectionGUID: MZt+Kc65RRCaCYGu6bG0iw==
X-CSE-MsgGUID: Kxo34Hl1R5yAtcXPRHYN6Q==
X-IronPort-AV: E=Sophos;i="6.16,277,1744041600"; 
   d="scan'208";a="85476342"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2025 15:24:40 +0800
IronPort-SDR: 68622d30_o3zKeEdOVhzEYKI07CXAotN6Vm5NG/cNZzPSvxGhtjOSiXX
 tMNWCdBseANFF3FypVoDBa6wqwi9WfZIkJ3PZEQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2025 23:22:41 -0700
WDCIronportException: Internal
Received: from unknown (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.49])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2025 00:24:39 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH v2 3/3] mmc-utils: mmc.c: Print version at program start
Date: Mon, 30 Jun 2025 10:24:20 +0300
Message-Id: <20250630072420.114967-4-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630072420.114967-1-avri.altman@sandisk.com>
References: <20250630072420.114967-1-avri.altman@sandisk.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enhance the visibility of the mmc-utils version string by printing it at
the beginning of each run. This makes it easier for users and support
personnel to quickly identify the tool version in logs and outputs.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mmc.c b/mmc.c
index e941aa2..6770a45 100644
--- a/mmc.c
+++ b/mmc.c
@@ -573,6 +573,10 @@ int main(int ac, char **av )
 	int nargs = 0, r;
 	CommandFunction func = NULL;
 
+	printf("\n┌───────────────────────────────────────────────┐\n");
+	printf("│  mmc-utils version: %-24s  │\n", VERSION);
+	printf("└───────────────────────────────────────────────┘\n\n");
+
 	r = parse_args(ac, av, &func, &nargs, &cmd, &args);
 	if( r <= 0 ){
 		/* error or no command to parse*/
-- 
2.34.1

