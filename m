Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103522A4EF;
	Mon, 10 Mar 2025 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615925; cv=none; b=iMud6Bti1Qpc3/yX/Y2KlWXrZwBMjJA+3fuB0NYZO+lci0ih8GRIaBhOnqIbhDkmYW4TkJ9YRtpF+QP7RNibEYqoIQ23MVDBz3UuG6h4ZzrIAnBAtUjXVFJIO/iCo5C5YNE40eClRbmlTcs2PCKvtKjQcUeBzXTHKovFuxBCxgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615925; c=relaxed/simple;
	bh=hKS/i1hDoNE5fqZsxk8aQhzq7/t6eyz9xhmOphitBy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XdARnxJNz3VoLIwdm7CqWpr4MoOFDs7AJE7NPGzk88IEnpku2U9mmMy1C5VH5L3r/N0hmNhu7Sc8y/SFWcyoQrJCho9Xh5SFCTLFpYvljHkBHvYHwmSXJxYIhbEVETrA7kvl6pGf9rJjIKL5ueOn6u0VLLn7PTVyWHWZzgHz3Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=agwxbEHn; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="agwxbEHn"
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1741615901; x=1742915901;
	bh=HuP1U8WK3q0G9GFLKBjjPxeJAILtXpxpnuy3cWlTYF8=; h=From;
	b=agwxbEHnfhBdXNTQaUyutFxVT15eZMKGmdudwjfimIaHCQz66X3n6PEweyQeKpthd
	 UszogEARqzGIanqOmPXwpr2ZsvQTJa89dMjFM3WdnmhgpGLQAUjr9bc0NNX1mv+4Hn
	 dVB3KIj/i/JZg6V1R/zrNQxTdO+lwnNlpTrCwnnc+gdMzKacmdJbXJhpGsBV529uvB
	 nm31UpiSUEPeMo3kBANqO9mrYzKlpbng1bSJXglwOwSt98FBwy2NfpYAybA5vcc1Ip
	 ynDOvpXRBxe8cQRTzT0KP+n9ewrGcpbMQ/F6adqinLA8KXuzfOm3DcYy5gVEcPEC00
	 cD9XNdyAtonxg==
Received: from localhost (wlan-eduroam-130-237-240-93.su.se [130.237.240.93])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 52AEBcRm043117
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 15:11:40 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org (open list:SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI...),
	linux-kernel@vger.kernel.org (open list))
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Karel Balej <balejk@matfyz.cz>,
        =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        stable@vger.kernel.org
Subject: [RFC PATCH] mmc: sdhci-pxav3: set NEED_RSP_BUSY capability
Date: Mon, 10 Mar 2025 15:07:04 +0100
Message-ID: <20250310140707.23459-1-balejk@matfyz.cz>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Set the MMC_CAP_NEED_RSP_BUSY capability for the sdhci-pxav3 host to
prevent conversion of R1B responses to R1. Without this, the eMMC card
in the samsung,coreprimevelte smartphone using the Marvell PXA1908 SoC
with this mmc host doesn't probe with the ETIMEDOUT error originating in
__mmc_poll_for_busy.

Note that the other issues reported for this phone and host, namely
floods of "Tuning failed, falling back to fixed sampling clock" dmesg
messages for the eMMC and unstable SDIO are not mitigated by this
change.

Link: https://lore.kernel.org/r/20200310153340.5593-1-ulf.hansson@linaro.org/
Link: https://lore.kernel.org/r/D7204PWIGQGI.1FRFQPPIEE2P9@matfyz.cz/
Link: https://lore.kernel.org/r/20250115-pxa1908-lkml-v14-0-847d24f3665a@skole.hr/
Cc: Duje Mihanović <duje.mihanovic@skole.hr>
Cc: stable@vger.kernel.org
Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 drivers/mmc/host/sdhci-pxav3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 990723a008ae..3fb56face3d8 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -399,6 +399,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	if (!IS_ERR(pxa->clk_core))
 		clk_prepare_enable(pxa->clk_core);
 
+	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
 	/* enable 1/8V DDR capable */
 	host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
-- 
2.48.1

