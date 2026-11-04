Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802229;
	b=X0+kbWiHWXHp94aH1GbHHD5p9BNs1cRiQ2AYyVpqGYrNjNPHHIb9iqT0piNEseqcRyRC
	 YlGBtlzK+eNoKnDOjVgiW+r4bP3V1JEKr194D45I7XPCKQQh/fYMRfvV701t6OpGZ0g5n
	 kYC8xZ92Zznh/0CJkdfX8U+rsarIvEhsIi6vUk7slSHrMcYjb12dbvw9Gt3gcS14aEa/M
	 o/hsgA7ImqPcgfQDvHK3B1vZYM+TjoOxoa/hFMAC85tLSSF9fcYafo8LDK5GM+IZl9BTv
	 VomKz9hwzY68JX/Ei3gBOsDl8S8tHnApOrQn2+9x6YS5otLxl3GsRQ4swEfdSE2M2kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=eZCZkcTPfUksS6RSu967x7RWRN9mqW+uEGFex0sWbaw=;
	b=12PPpMYLLuCrgqjxwRm8FgmmMoo8iIo1w8S+C58V8HUFvr4oACdS+9Npau4OUkynHGcF
	 YVXG0ekDvHkJ7BM0mHLrpOuZ4048TLvDsjiV81Q5NYx+Pf1t0mUXIqiUC8F36z+HzjFHl
	 MZkfAWUqhxvBPZXDTwrtGQhh14fTitPAr+X26GfFI4oVym3j66KQb4Cynyjs7hoTeA7RA
	 Hy3E1E0GwYW+TL+7WtIMU8sAAYWR7ZKLSfb8ZVTqYNT94kHnfU5zlSknOSiESIy+5Sjm7
	 qAwqtM0XQZjbnVQaPCyjBRNpva7sJcAZc3EgI17LUu9gNwBRrNaQn07+fq9uE9jBvAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fqjT58Gk;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7559F606A326
	for <linux-mmc@vger.kernel.org>; Wed,  4 Nov 2026 14:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7559F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fqjT58Gk
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so702601a91.3
        for <linux-mmc@vger.kernel.org>; Wed, 04 Nov 2026 06:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793802229; x=1794407029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eZCZkcTPfUksS6RSu967x7RWRN9mqW+uEGFex0sWbaw=;
        b=fqjT58Gkm3M5UGsqH1HwuL1JJdEjOuKUCFsSN1r5FmBZ0UmR7A4yGSHnmPsV2quEd4
         e0M1hyWbVpJq4H7j48FjZaiSy0VjhgB2wjk/PqctQH2dRmXiebqjwN0WJJkxNyq5lnDN
         NlvSyRZNM6+YX/OPnJm1vjIgNT0ejG3e8HqqOwWe+sIhhLt57cpR1hqjLJkfFixw2j9L
         G3uIeX6Kg8d/bSEbO/3GO6XX5IrBgOuy/uhf7oo/DsblBoTxSwZ4TiVbKgbxQVtjcrW3
         j9vcHVxJ64eNeDXjSVGMtgzYtfKItGvvvpIEKl5tnPz8fZEiBuKidaEjaTQWcYu5S+Ar
         NUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802229; x=1794407029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eZCZkcTPfUksS6RSu967x7RWRN9mqW+uEGFex0sWbaw=;
        b=oD70piQ6W3KIDBZtZMjRcTXZzN20WX1sro9nAHf2sSa2Np+kim0avabGjRPPCDFKtN
         K8+YZICbju9WwM0JtRpypYoN3Vur1l4mmcltAL2HBIFdKdj5a1iYEbuopNRU2o1FZR73
         JQfZleVeArb3OdOgFCfIfflf8507MtzLW2XJvd3XDi7ygH7QQsQ3eN+vgz8jFrcELOCs
         9QMPR7XhQgQsh8p7kRMT5wPIlvjf+tNKheXOum0g7Mvw5aRxA1NnifCyj5ghzP7T9M3z
         bv8MJPsYe1COQIYM6kAz8BjxwcHSQFBiH8ouMBpe3wuEW1qsvvEjynsG1qMiZxv2Ed0F
         KbAQ==
X-Gm-Message-State: APuU4Z9F93wQEuMCao8G2/5SfbGdm4yxXQ0mNMyVw60TB6AuuSFmCOxH
	+OykIna+6NBWDz7VMlQHOH2exuuHP0lzYLb039PExkF7asQPwx3WKYPbqLOc6Q==
X-Gm-Gg: AYBFou2QsrdOsNbkkxAm1qG8eRHfFvcE8uePtR1cCoLC8M2lYXXeaFHFaRPeP3yA/Fe
	qHnk2gbU9YlDkzwHvT7WR1C99eWve+xRRBLdSSGqSa2NOAJxqZYKgxUNtBGOfrq/Dx8Uf9QJnmL
	CgfggQyFZHat0NwVLxxL+f1f601NhegMPu1+1QvrPx9IEww6+cr2vyCRsdGfK8EU3tbLrMJ1XaY
	yza6ERs7PNWLcToDlLkYI43kSG1RkmupzgM27YEjKHONsFrbxc+VqxDVtttmu8+USYzvcIap4yy
	aoRYlVOS6Pf/yy3JRHO5gmta0WcJmD6CcVUxCanBKJnfWyVdrSVtdBvwkBJpB+6e0lb12H57UCm
	a5JveMPEQF7Mw4rONt7TsDJ84j1OLzvBexCSrqMEn52YOV6yIg87bNWWEzdZnPfqJA3RN1HgvK3
	w9+8XvT8bfdL3GINB+hmXnvsmVxx8EbyitF29m5ItumLeT+rpDLMBruHetgGpN+Hpy9F1wZHKf/
	hYlmnxQrNPBboxaLRlcp/R+sWpLy92L0gkE2L5WleVdoDexZTV4GpocWf/wURwu8pwNqbqsrlBd
	JVqmoTT+DVS0PD0ybBdJGufFEFY3wdgwG7Y3GIHy0BcfzXfdYtzr
X-Received: by 2002:a17:90b:4a83:b0:3a8:c0cd:57fa with SMTP id 98e67ed59e1d1-3ae897c834emr14061251a91.11.1793802228634;
        Wed, 04 Nov 2026 06:23:48 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944d1a43sm4371609a91.13.2026.11.04.06.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:23:48 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: hisilicon: mv200: stop treating the CIU clock as the card clock
Date: Wed,  4 Nov 2026 22:22:19 +0800
Message-ID: <20261104142341.50294-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The card clock comes from the controller's own divider; the CIU only
runs at the rates its mux offers, 25/50/100/150/200 MHz. The driver
nevertheless asked the framework for the card clock on every
set_ios() and warned on every refusal. The refusals are the framework
working as designed: the 400 kHz identification clock is below the
lowest mux rate, and clock == 0 is a clock-stop, not a rate. On an
Hi3798MV200H board that warning accounts for 18 of the 24 error
lines of one boot.

Ask for the rate only when there is one, ignore refusals, and read
the settled rate back, so the divider always starts from the rate the
framework actually provides.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/mmc/host/dw_mmc-hi3798mv200.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-hi3798mv200.c b/drivers/mmc/host/dw_mmc-hi3798mv200.c
index fda417888be9..e64d5bdc068e 100644
--- a/drivers/mmc/host/dw_mmc-hi3798mv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798mv200.c
@@ -53,15 +53,19 @@ static void dw_mci_hi3798mv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 		val &= ~SDMMC_DDR_HS400;
 	mci_writel(host, DDR_REG, val);
 
-	if (clk_set_rate(host->ciu_clk, ios->clock))
-		dev_warn(host->dev, "Failed to set rate to %u\n", ios->clock);
-	else
+	if (ios->clock) {
 		/*
-		 * CLK_MUX_ROUND_NEAREST is enabled for this clock
-		 * The actual clock rate is not what we set, but a rounded value
-		 * so we should get the rate once again
+		 * The card clock comes from the controller's divider, which
+		 * only divides down, so a fast mode needs the CIU lifted
+		 * first. Ask for the card clock and ignore the outcome: the
+		 * mux has nothing below 25 MHz, so the 400 kHz identification
+		 * clock is refused and just leaves the CIU where it was.
+		 * Whatever the framework settles on is the divider input, so
+		 * read it back; clock == 0 is a stop request, not a rate.
 		 */
+		clk_set_rate(host->ciu_clk, ios->clock);
 		host->bus_hz = clk_get_rate(host->ciu_clk);
+	}
 
 	if (phase.valid) {
 		clk_set_phase(priv->drive_clk, phase.out_deg);
-- 
2.53.0

