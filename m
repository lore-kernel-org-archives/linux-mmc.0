Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2E72727E4;
	Thu, 24 Jul 2025 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356533; cv=none; b=uDOgOkeDDUkgoFuGVP47zFsioYOZbzPfFM3PaxE4Bc8pAp96TfPsRd6Azjzem9IOcTaWQ0mdUK2UtPTsFuO+TY7osO0IKjm1Br+tPqX+1bo+rPObRDggYbDyyMs9B6MIMM2f5f8tQ/2xn+YBbJtjczrFtxcvDlg7XtY88jMeaGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356533; c=relaxed/simple;
	bh=0IaLIP2KkubPcx7b9qvtF9U4GI61/YekRlyAlo76kSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DyHyHuh1VXdLAXWS97EYud9lgYXJDcRxxgUknEQgPbOYffnTv6lWTvYSC6AmLuTsu833+YXCo5ah/Zh3n8oVIe1pZSa2zYa90hy++jAEhtbNvFzH+J/PTZQKjSi1pzGIVDihsMxIBSk7URpE91rPIBkqWjXT/YWflwYUfZLIIeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRP1rFf0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRP1rFf0"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so8795355e9.3;
        Thu, 24 Jul 2025 04:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753356530; x=1753961330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QPotOZ8Ga3dXelFzNNAZNVkNalbstbUanKtcLwNmZx0=;
        b=RRP1rFf0xHGi0aKIjGKIHT+2KMUm+tmsJc12pT/LPAdiR08Z28ovD/LnWej32bvCyA
         csN7wACbl3jWDw5y7hkM6XhbIuEE2yKomANyibTvUagThtaNRUCZMviLeza9qh2kOlW9
         6LCiaDjRm9J626cWzGONSmImhLSoGkIXlstGrMBJf5eYAtzwk6funHD05MRjPsbdHqw2
         blNpCt7H3P1COOsDWETyjTmsPZ1i7N7cdpHsOiWgY/Iv4CMb1Dk3UlXarfpWb9GBrNen
         eIMqwNKDCrIqaTu8SauldzigidB9W7FZ4sQqeM1RG3BDmC2wbotWROccfKffcB7SczoS
         GY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753356530; x=1753961330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPotOZ8Ga3dXelFzNNAZNVkNalbstbUanKtcLwNmZx0=;
        b=h4StS26yzxVH4cGspFI4egT7qnYhFUO1d4fV8th+HzSIH9VySpiu993eoExm2evaRh
         ejyH80lVQf5z+f098XDveamJQ96NQiyDPzfEfYaue17kOYftkruR5U6f051TMgobm9Ne
         58XsiH4IuN5qxVNd3UHzI/iYcTJ/9Fxxy58rHNZQZMszJgR5OYPa8oTPNSvGRtliUU6d
         J6E7+pixiaHzP3N6LWfTwOm2NylgrSkA36mouKBGi1BNlgWo9AztpPUlUJ35mn4yMHVI
         8RuPlIf7Dce/GYHajTeoGmt0+JZW42TgPEVn74Fg3QH6h+VXikSOh0CYS+QU1K8SwXB5
         caLg==
X-Forwarded-Encrypted: i=1; AJvYcCVza0tbLteUqrCPGav2CO2wLLm37eTPxWYco8qXCQcR1eVYnIRywCJR+UpF2J3Tvk5tZTd+/4VqaLam@vger.kernel.org, AJvYcCWwqpZSsfHd6hxeoRHxkA1VL/THc4BeL2UE4UI3S7npf0DIyVeBqVrAkMgKbr0rGF1qrj75RTKOT+DBb3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSYOBhTDLSjgWl55aCGYHGCDVorss6usHxDtBN4SvxOrq4isoI
	pE/g06J9QWFgBkE80j1KZO6s/DFKkVAQ+McQHETyTenlOISjMLiJmFrGvUeKyoQYqt8=
X-Gm-Gg: ASbGnctj72k7NO/iUHf7j/IPgRIR/YUIqSJFCKY0xjoE6v8IKTE43YyxbBR102uAgeI
	RMPgddn2o5frIEutZXcuNu8JL5bTP95CI7YDskZ0zSBOg7OCxHcZtf1tWCumtTX/ybwaGUey+yc
	UrHyQtuW87VbHHBwQayphCV54JT7vdjBoR2v5FhgChJwV0XCHlPtJ4E4SF7KQQ+BXxOr5RTG4cd
	hEXpCzM7v3BoucbkR/KiBCvPdUySpA6DTMP0BjNpeFUNUXtzINilM9IyiHLQ0F5vktFoZ+rfdhz
	4m1qZkjKDMbDEKb0ylyPiEr5OWrgSilC3UiWX7Fh7kFFJOptbtLiaQ05JsSrmj5X/egEMJq6w7j
	ufv7PTSkaAUwS0uG2BkVo
X-Google-Smtp-Source: AGHT+IH1EhcurvPnQijuAxK51VLX1iOh6PM1RpmsVzMiEDdXmQ4OtxzDVBwoAGD/kvqdAI3D8wG/9g==
X-Received: by 2002:a05:600c:46d2:b0:456:e39:ec1a with SMTP id 5b1f17b1804b1-45868c84329mr68770685e9.14.1753356530123;
        Thu, 24 Jul 2025 04:28:50 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458705c4fcfsm16633565e9.29.2025.07.24.04.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:28:49 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mmc: Kconfig: Fix spelling mistake "referrered" -> "referred"
Date: Thu, 24 Jul 2025 12:28:17 +0100
Message-ID: <20250724112817.142784-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are two spelling mistakes in the config. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mmc/host/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7232de1c0688..4afa0130779d 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -359,7 +359,7 @@ config MMC_SDHCI_S3C
 	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
-	  often referrered to as the HSMMC block in some of the Samsung
+	  often referred to as the HSMMC block in some of the Samsung
 	  S3C6410, S5Pv210 and Exynos (Exynso4210, Exynos4412) SoCs.
 
 	  If you have a controller with this interface (thereforeyou build for
@@ -401,7 +401,7 @@ config MMC_SDHCI_SPEAR
 	depends on OF
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
-	  often referrered to as the HSMMC block in some of the ST SPEAR range
+	  often referred to as the HSMMC block in some of the ST SPEAR range
 	  of SoC
 
 	  If you have a controller with this interface, say Y or M here.
-- 
2.50.0

