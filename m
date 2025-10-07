Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8159C2E1EE0
	for <linux-mmc@vger.kernel.org>; Tue,  7 Oct 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845900; cv=none; b=TdHF0wQGsEzvPf25JiUPgHYFe4p3IkWdqdOEbd0vmcZje6Mn0ZpiZRsr+LBjvL38aVao2IciAMGoqUI8vIVF6Sptu1mjRHtnLILWMnxHUZM0sOEnTnDz32idvOThEJGuHhfC1s6IxA7PlJnuKD7N86gUHVvKatduw7R5DcmuOn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845900; c=relaxed/simple;
	bh=vUUmEvlmkeV1irok1/nIhqLFK/Atv2L+zIdkEFj6r50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kk+vYE2dsSkuKoVyx8u/hpRlqKndd8QpH00mL17cnSAnZoshteGG9tlpxXwnTrmZP7Gz7l7+vi2Yw1CqL9pvEIGbQRQSt3aT8O8GgQrsiNeYvrIuVG6VdSj2T8vbJFTSeVv4C3WQFweLUQIqp/IlHimivpAEMZ0jm4pwficIDYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NuoqihyM; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NuoqihyM"
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-31d8778ce02so5485611fac.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 07:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845898; x=1760450698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzHMYfimzskmCvhQZFOQq3Y8wAS1gFZFKB5XWvB1gEs=;
        b=p9QuC+Yc2lWuhOTshJXxCzhRjYih84YAmuml6E3wllcCpBFfWN2xlyDvUMu6ZSEnTP
         ykHOqWOCdqTuGREw78xSmP9I38bpdbsUFEctclSXZZaEAtbfXBQN3M39bFndSDsyrfOu
         nl3k72Am0LWPaWoC3jKlTE4U+biewvL8AL1XM8hVjI9Eo308Xx8pMrR9FYMbKNvvupIU
         y1fqvQJ6swyjeKCjA53asjFMoImmVYoHyTRE5eOkjicL7TE/3tHNzuRlTc7wnXR0qwbg
         hvyKKX3tbV80/FVZfMYyCZuH7xCkO4IPPPNB9Y9dkC75POOJnNo2dxhM9Cnh/PH/hlqE
         kfoA==
X-Forwarded-Encrypted: i=1; AJvYcCU+15uquks6Xxup4Lsgmgw+5nkp9IOaH8Q+2HnsIn08GosORCLyMhED5MuLO7WRecUI1TEBYU/SpWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8wy95nmRGqkgblS2hnTlfHgOKuayEvI6LXRotN8l0hjaEmqMP
	pVumSxL8IN1Yh9UMQTqUHfAH3aVvYELpB8vWLsj4+lJL/pn5LcjFrpZYRkZuOT1/j3fLwqed6Ef
	cKSlPw/A97HDGkXithALGSZ3ykd2CIRodiCss5L67l1u2Fd/5vPd8WADlWgiFqcLoy37pbszQQ6
	1WfvJJAxrWojfB4zjix6WyLobTLE1FrUHSZq49N6D9Qs7cfgsfIPT+hS+0odTLSFDw3e6Fr9Hr3
	n5pnIlqbHn+
X-Gm-Gg: ASbGncv/l2Fr+yzXuXNFqRyuEduYOBtPxlaVPyR3GZD4Vtfaj7iNORfvSus7IWlCpqp
	duHxA3F8mskCvUNosmfBxRjHB/QI3x2TDRP+WtNZVS/+dEIvKoD8nYa4vsx+RzPVL+BKcmj2EXD
	fKxXdXHNo6hfPXlQlHCcJEGvna26gqxUdEojhUDzclbqi2FwH09WH9eSkSZDC9kTevtL3iphTK+
	pWfta136oGRO+vMll6QOK66cVQIn0Dsr080rs/AfAiouPrK/bAwLVA+bKAoe5fUwNJYGj3FDd2T
	RjX16Jv1AGgtEEVD1sv1Za180GG2X2nBdPEzUKPgw/Z+lZEbhKIGvwUCHuNWjhCNOysEFY9ZVPR
	FV6WnJxXy/PXF9MPBTDX5Rah6d7sL7dNPCfKXlh1Y948iYzlCRxBA8U/pYyRygvvC49Max/Wr9B
	Pj2vCU
X-Google-Smtp-Source: AGHT+IHegORXS/kZ3QPxKJBNVArcZCjEy8kra3Xig8IKgFiEWxVzBi0BZ6fWYKNRQvtNWGwUDRasOzUvPqfU
X-Received: by 2002:a05:6870:b28a:b0:34b:9331:a9d5 with SMTP id 586e51a60fabf-3be6c9ef169mr1773021fac.16.1759845898152;
        Tue, 07 Oct 2025 07:04:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3ab98472c47sm1357977fac.24.2025.10.07.07.04.57
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2025 07:04:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-876ee102b44so151117676d6.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 07:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759845897; x=1760450697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzHMYfimzskmCvhQZFOQq3Y8wAS1gFZFKB5XWvB1gEs=;
        b=NuoqihyMDCEC+Ho30inYY3l85IznEQa1+z6KWRQ6EmB82zoWOjzqjwqzDZK0Q6mrQp
         gZYnoYrVHBZo4+DyTSIBCGp3+m0bu1NzFVUa3DdefRmpEbb+R12IJYq+Y5lTOBVROEBD
         U/+YXdIa6Q+LhUIAdZTdSElVIg4OdEbUah/pc=
X-Forwarded-Encrypted: i=1; AJvYcCX0S15B0HSo2Tn67/ZH2v1a96nMbFlyYf9fSs5mLvLm9mSL2nvlkrjmeoWNbsOgq8QXmGq03aQNC4U=@vger.kernel.org
X-Received: by 2002:ad4:5ca9:0:b0:78c:f62c:8eb1 with SMTP id 6a1803df08f44-87a052a7fc2mr39707596d6.26.1759845896960;
        Tue, 07 Oct 2025 07:04:56 -0700 (PDT)
X-Received: by 2002:ad4:5ca9:0:b0:78c:f62c:8eb1 with SMTP id 6a1803df08f44-87a052a7fc2mr39706726d6.26.1759845895821;
        Tue, 07 Oct 2025 07:04:55 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60b67sm142718956d6.9.2025.10.07.07.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:04:55 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v2 2/5] mmc: sdhci-brcmstb: move SDIO_CFG_CQ_CAPABILITY define
Date: Tue,  7 Oct 2025 10:04:30 -0400
Message-Id: <20251007140434.606051-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251007140434.606051-1-kamal.dasu@broadcom.com>
References: <20251007140434.606051-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Moving SDIO_CFG_CQ_CAPABILITY register defines to be in sorted order for
better readability.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index efc2f3bdc631..f81cc1889ac9 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -31,13 +31,11 @@
 
 #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
 
-#define SDIO_CFG_CQ_CAPABILITY			0x4c
-#define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
-
 #define SDIO_CFG_CTRL				0x0
 #define SDIO_CFG_CTRL_SDCD_N_TEST_EN		BIT(31)
 #define SDIO_CFG_CTRL_SDCD_N_TEST_LEV		BIT(30)
-
+#define SDIO_CFG_CQ_CAPABILITY			0x4c
+#define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
 #define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
 #define SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
 #define SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)
-- 
2.34.1

