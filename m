Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9084B1D7E4C;
	Fri, 11 Apr 2025 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744400901; cv=none; b=bCS15QEtKbcH+8Wwvyu+V7la8llrV2X1fEYV/OkTWoDEO5cB4sd8Id1G8G8uZH4s+lzxjZrrjVC4tdWN/BU4audGgfC3fO6UmDuCfyTf86A4pADcFsHWXiFMULHPWmEH6OjEVyppYaU9KapJA2kINBe784FbNWB8GAnpgrxSoKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744400901; c=relaxed/simple;
	bh=k4Gi76/49/ctoVoIryDuSC9i0T5HZn8pYbER+CERB4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSLMYjpFy3ZXdnJgAN09I4NKoE73ckI9rp8wpnp613ZG7FdDEAPaUkqwBFEisEHQAofpTNj1KuhZXlJrXhcxqe7XQlXHugauHHkvBN6v5iwd1IPxGJFhrf5LmsSTAL+uRJc67w7tS/Nb+nh6mrttWV0uRTazuwWgwfdmBzK81e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7ryjq8B; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7ryjq8B"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-226185948ffso27802315ad.0;
        Fri, 11 Apr 2025 12:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744400899; x=1745005699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rfq26cEktn40XE2O1IhX7vdCEk2PUKsN0fsx2Wtr+d8=;
        b=F7ryjq8BpQh+FlSh+457/MRcr3SGCqUSYS+ThL+l0Eyn27/ySJK2/E7CPDndTOg5Gt
         TE/e2/OjLL1P9PURyUqxqbWRjbvWXidmrgwvkmKw16Biog/JDUJ+1M9InxEALvBeZrwG
         HTenJy6b3cszqGAQein/QNQDdhoF5mW4nVkx8U3sovXtN251Knr99Ij4s5JjZfRsozyP
         ad1EI3XoETVpUwCzzWDZt9PpwW8w6Jt/ZcBeOdcImSh4MlWbT1icPeYLL2cZMFaC33xh
         7MSeojf7Nmf+S6auokbPFkAm/B3KwhBqt6Nr+Q6bxMlviZe5d1FtYRnUA7uqLco4ngPW
         HiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744400899; x=1745005699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfq26cEktn40XE2O1IhX7vdCEk2PUKsN0fsx2Wtr+d8=;
        b=YJ/FsZ8bd4fzDgHbBE7VBrShphG5wSM28Gffyi+Yu4L9AqWBeyHe8fmYt+UG3QRUIH
         LUeMWZH34I1AQIFeNDHUF5Xn0eXlPqAyZ/wBEgZBvZgoyB9TuKxhYsI0ULyX0JR2zhRb
         SHEnyl0zMbe7iV9XEfCyR1sj7G545QpDgaDRzLFZes/Y016Z4IdCD89ezZvidGcuQkdb
         KS6FwVdMwBvFFCv9aeIJbPyjK9IeTb1TeByHpUhr20b60bZLrJAE+pNZ8ijqsdDIozhu
         41SrD+N55yMFxnwIvNCDe5Qk8rupIMa2fLKj6ycvBLibParVHVRyx1Ih3y2MD0IaDszZ
         s3uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK5V7S8xlZeKWjyKZ7HvhrOy7RD7oLjI7S76nu/Dc65B2TS/ZA9qVDXupVVOoLCXXEYriTpiHnHEH/@vger.kernel.org, AJvYcCXYPBAQzMgx3MuHx06YrDNjTDLx60Z0HDpcp4kgsG7vHbn374aVT9ux+Ykxokppofifc3G0fMtoa/6J7VE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFGb4Z6IQzEnsA0VgZWGDufBef2MSkDo6cG5eH5VDrH3ZBWFfn
	Wd1W6AClc2vj/Zh3P/aRo/H0I20gR0gOyWPkmqs/qJlft8knwpTybSo1xo+e
X-Gm-Gg: ASbGnct5sfMq1ehkopCOJ5XMKn8mMsAhJExtYIn+4Oo0ipThZ7BuhsflcLC1OuPaOGB
	4zJTEql+ERVVQd42L8TweMYVQI2q4ejDViAsKqtZIs76R/zvI8A+AFF9ftVUgbvqhXWXs9W/TxJ
	Yg3GOceTg5lhGvADA+McWcJ93NmIFet/vMamVRJlLUvGL5u//xeK6AKsa9UoqFMaHDuxICoJ5+r
	U0R7fBkyjqrV6QP7DWlcvklI2OH3oXHKsA/cH9SA/Jycn4vKYsoJqW0PBmYKdVkRn2ticilpbTr
	yuSCw7de6aDLNxpUGfuLEMoTuz08IKOm1/jn1IHB
X-Google-Smtp-Source: AGHT+IHkyOunL7xeK25I68Nls6Mlo5XcrceXaZwp0Fp9Y2cpYT+2SMz2Ho2MxH5emFFxAkwDCXrH5g==
X-Received: by 2002:a17:902:dac1:b0:224:1c1:4aba with SMTP id d9443c01a7336-22bea4ff067mr61574885ad.50.1744400898607;
        Fri, 11 Apr 2025 12:48:18 -0700 (PDT)
Received: from hiago-nb ([2804:1b3:a7c3:a964:d95f:3ae8:6dd0:549d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2198e9csm2026930b3a.28.2025.04.11.12.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 12:48:17 -0700 (PDT)
Date: Fri, 11 Apr 2025 16:48:13 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Judith Mendez <jm@ti.com>
Cc: Josua Mayer <josua@solid-run.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Moteen Shah <m-shah@ti.com>,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH 0/2] Fix V1P8_SIGNAL_ENA and HIGH_SPEED_ENA
Message-ID: <20250411194813.c4ft2uxgdiuza5cm@hiago-nb>
References: <20250407222702.2199047-1-jm@ti.com>
 <20250411130354.dc3sv3e7ruekkhkp@hiago-nb>
 <d8e45e50-f0eb-41d0-9c50-56147eaf262a@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8e45e50-f0eb-41d0-9c50-56147eaf262a@ti.com>

On Fri, Apr 11, 2025 at 11:37:14AM -0500, Judith Mendez wrote:
> 
> The reason that patches fixes SD init for you is because in original patch,
> quirk was applied for both SD and eMMC with the exception of SD for am64x
> SoC. This patch only applies the quirk for eMMC.
> 
> We cannot use the original implementation because the logic applying the
> quirk is based off of vmmc/vqmmc nodes in DT. The assumption was that am64x
> based boards will only have vmmc node since there is an internal LDO that is
> used to switch IO signal voltage instead of vqmmc. However, SolidRun
> HimmingBoard-T board has a different implementation on voltage regulator
> nodes in DT and the quirk applied to them as well and breaks their SD boot.
> So we now only apply the quirk for eMMC. Without this quirk applied to SD,
> am62x SD will continue having some stability issues.
> 
> ~ Judith

I got the idea now, thanks for the explanation, I missed in the original
patches this was only about the eMMC and *not* the SD card. Is there any
plans to send patches to the SD card as well?

About that, I was wondering if instead of checking the bus_width to
apply the fix for the eMMC, we could set a devicetree property to
explicity apply the quirk. This way, we could also decide to apply it on
the SD node without checking any bus width. As example:

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 1ea8f64b1b3b..c4423c09e809 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -1466,6 +1466,7 @@ &sdhci1 {
 	vmmc-supply = <&reg_sdhc1_vmmc>;
 	vqmmc-supply = <&reg_sdhc1_vqmmc>;
 	ti,fails-without-test-cd;
+	ti,suppress-v1p8-ena;
 	status = "disabled";
 };
 
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 4e1156a2f1b8..a0485c2bb549 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -87,7 +87,6 @@
 #define CLOCK_TOO_SLOW_HZ	50000000
 #define SDHCI_AM654_AUTOSUSPEND_DELAY	-1
 #define RETRY_TUNING_MAX	10
-#define BUS_WIDTH_8		8
 
 /* Command Queue Host Controller Interface Base address */
 #define SDHCI_AM654_CQE_BASE_ADDR 0x200
@@ -844,7 +843,6 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	int drv_strength;
 	int ret;
-	u32 bus_width;
 
 	if (sdhci_am654->flags & DLL_PRESENT) {
 		ret = device_property_read_u32(dev, "ti,trm-icp",
@@ -886,9 +884,11 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 	if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
 		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
 
-	/* Suppress V1P8_SIGNAL_ENA for eMMC */
-	device_property_read_u32(dev, "bus-width", &bus_width);
-	if (bus_width == BUS_WIDTH_8)
+	/*
+	 * Suppress V1P8_SIGNAL_ENA for MMC devices if ti,suppress-v1p8-ena
+	 * flag is present.
+	 */
+	if (device_property_read_bool(dev, "ti,suppress-v1p8-ena"))
 		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;
 
 	sdhci_get_of_property(pdev);

Which makes our Kingston SD card work again:

root@verdin-am62-15412807:~# dmesg | grep -i mmc1
[    1.897055] mmc1: CQHCI version 5.10
[    2.043673] mmc1: SDHCI controller on fa00000.mmc [fa00000.mmc] using ADMA 64-bit
[    2.260610] mmc1: new UHS-I speed SDR104 SDHC card at address 0001
[    2.268150] mmcblk1: mmc1:0001 SD32G 29.1 GiB

Sorry if I missed something, would also be a valid solution?

Cheers,
Hiago.
