Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E60C2E2EE7
	for <linux-mmc@vger.kernel.org>; Tue,  7 Oct 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845910; cv=none; b=HGL8pCvmC5wWlBkWSQEFBaKD1buaS5LuvKNXCrDoZl3x6DEDDJEl7/HwDXxmR1yxuiAnozQJisXBcjoCMDrhYEH5psMY7tfP5+H66MHkDJB+r6r/rXQLfrnpRW3X9cr+u+89ROD6jNIrVCEpY3ke3LykHbboMUPXTTrVEqVVikU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845910; c=relaxed/simple;
	bh=Rk6f7wi+QRbO64RAAHsaYdej9yZMvSjKm8kZyMLaGdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WBZNZGrKdXVmpJppmVwLMraOTa4PUQmSOaVIKjsfT60F/vcOwqO7qcwXWh4W2Jwjtp3b/Cc9XRf4YacMzciiv0DR7jMT2jDf6Pf1UxMJpy1CN5jvYSxtMTuSMC18f3HOy4kFpZvaLMe9O55dTgE6BQTppsH5upmk6C7kBcQ0h90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Vmw7xoDD; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Vmw7xoDD"
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-4de1b5a6b7fso59403321cf.2
        for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 07:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845907; x=1760450707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qxUFkx3TIQhAfsBZkcTY7Gt7i9ylaZPTGmpdbY/RyQ=;
        b=sJkl3JoUDDVtOBB9iga3KGyAkLlLb+aoqUHE/d8nLPMg36iPiys0lFiqU7+sbiaaNe
         yLc4aeLx1Ra2RobSoLokj5h8uG0IbPHe5hE3LhzYm1E6h5akHfnXBgKmEVG43H92Wmk7
         RMBjFWNy6K1Qs4ZtiC7PDTsahIIDWDLcBV/aeMTUlpstKq0xo2ax7p6jsztI8YZnlrTL
         OBwNdXgGYDPcaBqWWqo0u13PR1uM1Qe2cCwQsjDa8l5+E3AIciamZZm6D6L6MuDoEUw3
         yoXII2lxg5YT+3w5r6p1vxevc4KFAoqLNexR9h1VlPx9FtXYjDaMEG67FuBQogTu9V/C
         4KiA==
X-Forwarded-Encrypted: i=1; AJvYcCVMdQDyj5sxOtcJYJKRbnf8a98ky62opLcGP+C3fnLEqaT/klSbnyapY9IYYqbyjkvrBqZltJWyOrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBsOs37wsVwB5pryIfsM+044Y94EhwaWWAWF47KH3Eq2GxOVQp
	i1X0y7rpJisP0q/Q4jb/dK6IqMBpXTJQrPXfuT8WdCyZlrGtKtRAWrnk5IaMVuG+Azmh3YYkGSt
	WmAjYb4A//3rWLZOxlh+ZMCE7KoX5Yli1MJ8gtbgbRXDzrxQuWCccXfey6HePKYykawfvLvVCOh
	N906CLBOin0RvoNhyLByiVTjvGpvZ/7T7sr8aXP2auq+ZY1ijHMSb2KJa5wpi0Z6GxCEXaIiQ5d
	2Edm0bPYeL3
X-Gm-Gg: ASbGncuTvZV5ypMkmMs1iTYSRZ3hyJQvPDmVXaX9E4dPfwSyFZnvoZ4Zv/CqViA5m6y
	r9mS/VQdbPzrTAwNtJtTMWkbBTwnUc3/6p+HXh5+VrMbz3/zRhs7hrGxrW14/Qg8wwNtMaeJzkZ
	SREwm9LfZHByIWLEm7b1bgkkbuyoIivydulO5u1dTVrszAyBzFfEnqAUNKmHW3Qbiik4CTgkcz2
	lmgIaU3dUv6pfKE9wxzQqzm80vhS0KuxpOFRrua3IoaGzBqfcPxlNix2Cj73FOzUod4wvNLwGGX
	nnI2P+JQgVSnhnQo79+pqQlHDF4QwqQlsfUH2gSVE2gcMYFa5MnenK4HpbpKOHgT1vcdYtkOizw
	XkmEKJHa2t3cxfPIcgfKHggBAjKHNA8VCBYyoY9FN1zP/m7XKGtabQCz8vewqyC3qR+xSWrIgtm
	I8GZ3Y
X-Google-Smtp-Source: AGHT+IHyJ1MIy3II7d/nk8cOq5Ymmbn69GNzMT4lnkuOjTUevl75HtjZvzwxD4O5CbCcv6p4IfpSMOI6K6vY
X-Received: by 2002:a05:622a:410d:b0:4da:f8c2:c0d with SMTP id d75a77b69052e-4e576b43693mr204161471cf.82.1759845907030;
        Tue, 07 Oct 2025 07:05:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4e5577e3eeasm5475931cf.0.2025.10.07.07.05.06
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2025 07:05:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-818bf399f8aso166560426d6.2
        for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759845906; x=1760450706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qxUFkx3TIQhAfsBZkcTY7Gt7i9ylaZPTGmpdbY/RyQ=;
        b=Vmw7xoDDoEMBI6g9LgPlDHkoJdbvtc+cPEpsRXzRgSOlxgBIDswsAzfy+WTJTzEgS7
         aHrHR1pVJhnaoprR6Riwu9LQ53uLiKmQoz0Ys/TLSjQ/fNkKNecEdU4vUYQ1hkqsk50b
         jVFuniQA3Vg70NhmqYKBQFXYO6GrT5tRwWfJs=
X-Forwarded-Encrypted: i=1; AJvYcCXBt1ysnJEcNWlwUOIU0ALcgpxrtqgNltF2umFPGDgMc0WrfJ3d/EuVs99jnvjDSaogWLA1aebn9QU=@vger.kernel.org
X-Received: by 2002:a05:6214:1254:b0:70d:6df4:1b21 with SMTP id 6a1803df08f44-879dc87fd21mr239627786d6.62.1759845905120;
        Tue, 07 Oct 2025 07:05:05 -0700 (PDT)
X-Received: by 2002:a05:6214:1254:b0:70d:6df4:1b21 with SMTP id 6a1803df08f44-879dc87fd21mr239626916d6.62.1759845904420;
        Tue, 07 Oct 2025 07:05:04 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60b67sm142718956d6.9.2025.10.07.07.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:05:03 -0700 (PDT)
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
Subject: [PATCH v2 4/5] mmc: sdhci-brcmstb: Add BCM74371 support
Date: Tue,  7 Oct 2025 10:04:32 -0400
Message-Id: <20251007140434.606051-5-kamal.dasu@broadcom.com>
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

Added "brcm,bcm74371-sdhci" compatibility to the controller driver.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index d25bf71d79f4..42709ca8111d 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -299,6 +299,11 @@ static struct brcmstb_match_priv match_priv_7425 = {
 	.ops = &sdhci_brcmstb_ops,
 };
 
+static struct brcmstb_match_priv match_priv_74371 = {
+	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
+	.ops = &sdhci_brcmstb_ops,
+};
+
 static struct brcmstb_match_priv match_priv_7445 = {
 	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
 	.ops = &sdhci_brcmstb_ops,
@@ -324,6 +329,7 @@ static struct brcmstb_match_priv match_priv_74165b0 = {
 static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
 	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
 	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
+	{ .compatible = "brcm,bcm74371-sdhci", .data = &match_priv_74371 },
 	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
 	{ .compatible = "brcm,bcm72116-sdhci", .data = &match_priv_72116 },
 	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
-- 
2.34.1

