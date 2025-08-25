Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3A4393DC5;
	Mon, 25 Aug 2025 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124583; cv=none; b=PswiLX4/nfSJtqJPDQJaEFPz4COJS6au+i3FBeX/n1zKOl28JnFyJKrQAN6JSs5OUKGQKQpCBtguk062gKMCOmdOlifU9ySN/qpAcpKMBYXC2SMcjW6iwajiRYwGpfY+GMkKGzXOkh3+SYSne8lA57H4ddUy9eV5Mabeq7IrDPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124583; c=relaxed/simple;
	bh=kKxfowU+lFnO6Sx/tYMbzuwN+vuaIFOmPCUem3m8aV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IWp7VFl1dqo2YINXa+23dQd+cwUO4xS80rLZFWmpqqKm+AouxwVDQDNgxZRD/4ePmaxt+RIDVcO+dsAg31fe0INGZmHBZfh8Kg6UDM3ZS8OaJnwoKFC/QrlZsGKm+M2NgUNOtlcfLYskgl7VMlFWwEIQ6yuYwGweAlhdkkweSmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=lPmTLOdq; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=f+jLdy5k reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="lPmTLOdq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="f+jLdy5k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756124581; x=1787660581;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v9NnnW+zvNjTslqtm+u+Itjh8Uy2oU249B2/+mvC5kU=;
  b=lPmTLOdqcXB8AbT4HzDqapZtcaL1fLSD+DqAnbmPS35eTvtdJgPf+GDM
   qWrFGOkQTnBiaKfbbr1sSTcS9ZlIjwOuVHVZNgZytJNkCz0ptd4QSA8j/
   PLxbBH453h47OsSJGUYU2OE5OHcStu5ML1SPomDx6J6bdNnXZOqyU+eoi
   9pj1+bBnusqIhOLCWiEBN8PBszAdIuBaP2j4Djt024msWcTvWYXtv4cHj
   y+v81Lwakwxqoru8H9z3OIKTtBC8UYb9/PfF9hc7esZHK3HIZWguswC99
   UV3xo7YCkdizIkeqx0+wiMSHg4lxVeFSsbOvWl9Uy+bZkS90zwHV12cVh
   g==;
X-CSE-ConnectionGUID: nEE82dVgT4mVYk1ulIo8SQ==
X-CSE-MsgGUID: YY0ziuEOT4WZqmCaCtxvoQ==
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="45893372"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Aug 2025 14:22:57 +0200
X-CheckPoint: {68AC55A1-17-20CAA7DA-EC9DC758}
X-MAIL-CPID: 74E2BFA017117BFE38357260016FEE8B_0
X-Control-Analysis: str=0001.0A002119.68AC55DB.0035,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2A8E1673C2;
	Mon, 25 Aug 2025 14:22:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756124573; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=v9NnnW+zvNjTslqtm+u+Itjh8Uy2oU249B2/+mvC5kU=;
	b=f+jLdy5kQt9ZN7N9x7IoqIosjBRJurPI3KmQRnqUAbGzqaUYqhVV7kZiBFk5QFGCl9ox1G
	GTwa3s6lNxISbnRZ3/PXEeIcGh5oYoxRTVgYsujg6j2NGR+zm5mC4fpeWeA+r7KKgE/wOu
	sVEz4ZkPewbXZnJPTNi9CIEhDz2UWNUOTGt1O0YUaV8r2xS4I++20S2PzJO4sQJEC9pnEw
	1kjVKtfPGguVhayN3YFNZa42+0CzApi2pY/B6gCSE0P+eh5/HOryB/pj7Y3B5IBRK73fiC
	obZz6c1IIvwd8WHxFerEZ2H/3rUWNGolfNUCN4FwhjkJm4KJztIReKA/yScjQQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: Matthias Schiffer <matthias.schiffer@tq-group.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v2 1/2] mmc: sdhci-omap: properly check regulator_is_supported_voltage() return
Date: Mon, 25 Aug 2025 14:21:46 +0200
Message-ID: <20250825122149.2169502-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Matthias Schiffer <matthias.schiffer@tq-group.com>

regulator_is_supported_voltage() returns negative values on errors.

Note that this patch might result in regressions on existing boards that
should support voltage switching, but don't have their regulators set up
correctly.

Fixes: de5ccd2af71f ("mmc: sdhci-omap: Handle voltages to add support omap4")
Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
New in v2

 drivers/mmc/host/sdhci-omap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index b5d7c1a80a92f..08d5a82b7d01b 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -949,11 +949,11 @@ static unsigned int sdhci_omap_regulator_get_caps(struct device *dev,
 	if (IS_ERR(reg))
 		return ~0U;
 
-	if (regulator_is_supported_voltage(reg, 1700000, 1950000))
+	if (regulator_is_supported_voltage(reg, 1700000, 1950000) > 0)
 		caps |= SDHCI_CAN_VDD_180;
-	if (regulator_is_supported_voltage(reg, 2700000, 3150000))
+	if (regulator_is_supported_voltage(reg, 2700000, 3150000) > 0)
 		caps |= SDHCI_CAN_VDD_300;
-	if (regulator_is_supported_voltage(reg, 3150000, 3600000))
+	if (regulator_is_supported_voltage(reg, 3150000, 3600000) > 0)
 		caps |= SDHCI_CAN_VDD_330;
 
 	regulator_put(reg);
-- 
2.43.0

