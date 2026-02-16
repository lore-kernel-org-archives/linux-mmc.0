Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D361DF963
	for <linux-mmc@vger.kernel.org>; Mon, 16 Feb 2026 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771269353; cv=none; b=FPDk7+8C+S8zXfbPuED6R16b0VQodToHp4BehJNg+hPkDEV9k35DkDtaxgpbyzGzyP/BjMpUVGqihs/xdicK54VDPVGY4nv934zcFdu6oGRKdYDqCttbXLrtxpy4AHNN5oegij2VD/9ejdUjYHJ+bRp7WiH0+IlyfwfcjMcH3dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771269353; c=relaxed/simple;
	bh=8x/wvBM+OG9JdM5lpNSxPpncq9AHJ/Gaw3amH4rui80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gicGKP5KL+ljQOMdQ3LGDZaHEcUt5AalVclBrvQOMGsjulwEdT4tkgh0c1dTo3HmTBE4w129WyY+23K2c1vHKcHxaLsWwirc1byXlb3eYoItVqmFea2pSxnjkpCk58kwON5/dJodJdxClSKZK8B32/PO2of7000aXPsc52Imha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UJ0Oy61D; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UJ0Oy61D"
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-5673804da95so1366064e0c.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Feb 2026 11:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771269351; x=1771874151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJl/yKqTclNT9kEkBmAeTF7lEJo3F6xT2CC7EiH5zHk=;
        b=AQD9bDrvVVYMg6H6F3tH6MEV8qxY4VGjmwQCW2cjt7Of58BFsmedJAlBM9qI767vFy
         auDfG5mYK2665o+fAH1BT4834E9kD1ledso9e8HuCxOCv9j2O6fjFKc4EwHSYdXKuzWS
         2mo04+twW5Y2s1iHwmpT/Boo2KusE67wRLyHa/kjWkKFCvPCGTkOeDBZV62+riEOpAE+
         WCk1AOzJl+NQZLVMmH+QU9MCLOz4QpPduA3Tdv/oO/az7VgnAFcYcNyyFNHHMjVYpMtJ
         FU25aAhdQ2Sf1YvF6B85qAY1DeVcRvkm28vMb4+zbDylT7Z6CYHbx7W/oThI7GDJ1MZB
         8q/A==
X-Forwarded-Encrypted: i=1; AJvYcCW24Kx/Mtxxn3EDspEebnqNSUm4J1Klw5oikGGiPONhSO11zuDHC05koE42irkoVomE69EBWNI5ZyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEnwCj3SedveleJtG9bsrDEPoLnDJGXEASN79WWzkInkQRMlyO
	cgF5owLX9h9Z1f8lzxxAbiSiOn9W8czjpxSojhB+yOLXRZpcORDsiQ8GYFm7Gh/C25N5iths1Gv
	dk9Mf2YpBZXP+1orQsqXFBpPZymrPG+AiqUoS61xcr9/Ply8EBr7jW+oy8rRzTQzFwjSeUK+lqb
	GM/yYiIDal58gCY0j95yWqij9DK5YBIhP/trtw3rmWK5p5UChS45bCsF7h0zIQ87oox8xHQN7vK
	LcIOFUKz34B
X-Gm-Gg: AZuq6aLyg7yQOQtkbsoVIsfiZmLNbC/vlak7UkKaUznWUJgkDU+SV6f3tgjfMx3qpAF
	p5SBygWE0/nKO88ihixtyNoa1+2eyXN8mUuDEedUMqg65h3jfNCqj6Ky38HyB38+V8p+gzp/yOJ
	SncwD/Vq9ld6JBDs4u1lYJbgLYdfXKFKr0/6PhCCMWv578AelAeNK3yLQOWTWkjkL+fVcfb4+ox
	nyxF/kQHkOUnlhn/MDG/JydXC/PC07L4hlJFC/IqmrR8QJz8I8nwmeHYrkWJv7VH5w/OfVIsyJv
	dtMH0s0OONDYkVIcTKbuacRNnowo6Gj7An3VprxGUnno1eZaIPc3+FicSSkJ4DCTtyhmU0sdHJl
	aCJjCAH1/rp4ca3ZaBwbv0T1BdGNKLe6728t1UKcITygbPubPz98jiNCmG3SjTV1k7D5v5MrIXQ
	+B6HAa/8+A+gq4vdeTs9vk02TGF7rEuqEudeo/uT7bjm3xxopeqdWDrg==
X-Received: by 2002:a05:6122:4d84:b0:567:d87:e152 with SMTP id 71dfb90a1353d-5676aa6454fmr3175581e0c.18.1771269351046;
        Mon, 16 Feb 2026 11:15:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-94.dlp.protect.broadcom.com. [144.49.247.94])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5674c1c2146sm2340266e0c.8.2026.02.16.11.15.50
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Feb 2026 11:15:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-124a95b6f61so61568777c88.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Feb 2026 11:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771269349; x=1771874149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJl/yKqTclNT9kEkBmAeTF7lEJo3F6xT2CC7EiH5zHk=;
        b=UJ0Oy61D3UOfKoBaExzYzym7+EqIiB67Wm6FxNQA1mf9STV23cbzbgwTgVBEj0w/lw
         ng7Hdlrnzj0vRKWX8PfuQyJ3hBo8QjU0NrONCghoYb0dBv9CNgOs/zZVgIV6M2czTbHH
         D6qyInvuosJgm2+oFQkkTzrSJAQO2F1m0VZWg=
X-Forwarded-Encrypted: i=1; AJvYcCXerbPGYWhnegHrPHX1cBzLMWZaumFnQLSwVR9OEX3YZKLZjISUP5Xy8UkxI+RhBahVQcVXF38KOxM=@vger.kernel.org
X-Received: by 2002:a05:7022:439e:b0:122:153:d161 with SMTP id a92af1059eb24-1273ae1655dmr5050539c88.17.1771269349597;
        Mon, 16 Feb 2026 11:15:49 -0800 (PST)
X-Received: by 2002:a05:7022:439e:b0:122:153:d161 with SMTP id a92af1059eb24-1273ae1655dmr5050523c88.17.1771269348982;
        Mon, 16 Feb 2026 11:15:48 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cada1csm11067327c88.9.2026.02.16.11.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 11:15:48 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	florian.fainelli@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH] mmc: sdhci-brcmstb: use correct register offset for V1 pin_sel restore
Date: Mon, 16 Feb 2026 14:15:43 -0500
Message-Id: <20260216191543.2514647-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The restore path for SDIO_CFG_CORE_V1 was incorrectly using
SDIO_CFG_SD_PIN_SEL (offset 0x44) instead of SDIO_CFG_V1_SD_PIN_SEL
(offset 0x54), causing the wrong register to be written on resume.
The save path already uses the correct V1-specific offset. This
affects BCM7445 and BCM72116 platforms which use the V1 config core.

Fixes: b7e614802e3f ("mmc: sdhci-brcmstb: save and restore registers during PM")
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index c9442499876c..57e45951644e 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -116,7 +116,7 @@ static void sdhci_brcmstb_restore_regs(struct mmc_host *mmc, enum cfg_core_ver v
 		writel(sr->boot_main_ctl, priv->boot_regs + SDIO_BOOT_MAIN_CTL);
 
 	if (ver == SDIO_CFG_CORE_V1) {
-		writel(sr->sd_pin_sel, cr + SDIO_CFG_SD_PIN_SEL);
+		writel(sr->sd_pin_sel, cr + SDIO_CFG_V1_SD_PIN_SEL);
 		return;
 	}
 
-- 
2.34.1

