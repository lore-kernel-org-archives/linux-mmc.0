Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AE51CFA9
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718869377; cv=none; b=KCRjAJR9Ru+UDr7whsZJzRie9Fn2zh4sZ5uVKoB6Z2p0tb20DSh9WLCtreg5dw/A0SJlNfXnfASh64HMEfzpJnPgOIfWSURSprz7TWps7nE8oq+PCTdfsA303+0Z+H3IrzSiMmyeXU/OS4kzgrLN7dBIHLrfmzFOS17XKuEYd/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718869377; c=relaxed/simple;
	bh=vi2f2BGgfaxiryucMfewORwUfZoUHDg+ft2gWzpXzvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cvLC5NiI/Xd0QFJ4oV6GwNkgdmlfl/7KVfO1qIrTcagvSCQe4ez7HcESyvTXf7x9vTP9B/6+0G7+x41wGPVweSltl3WamdCWKdMH9Fph//FDmykcUNcS/gh+QTHE2c3PNCHlMjdd7tgtd2JyAuFS74ZoYa9vNEH8zFf69/Azoeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGoUEDT1; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGoUEDT1"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-361785bfa71so534555f8f.2
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 00:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718869374; x=1719474174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9aW05OUKDknOGPBrwhlBzTL0aEH/HJUKA3/crfdeC90=;
        b=TGoUEDT1BuYsl/mtzDK1C24n5L6ELOM5+EpZ6Pr45pMcUsj0P6ObTLbt/PjZCzKMNX
         r4pqG3fm0GqaKCYSakgX10Tq37rnkcTRe6/a1PDSeiaL7OQQViIjwSKtBa1G+wI2drsu
         OjohUA2gZXXpvYK1kYh9kjyfBGJSkpkPWQG40SHqKt21ekP9EkQLorJcxganfCQYOS2m
         Q4zX/2XT5RcalLiZDr6d8tCba0w1ifEVdZW06PwXJIHCwd25QxREaBDEklR3KjoWT11L
         5l7XliuVDIqeaPuD5KAjFIpqEOdS7kJrAiq8DCRsq2p9jDCAQCDcvpq2WViC+acdG6rL
         zSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718869374; x=1719474174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9aW05OUKDknOGPBrwhlBzTL0aEH/HJUKA3/crfdeC90=;
        b=VPBS3r47C92/uvLTXY3jWH/Fj4PCG8xmf50v4Bq4IDJnP34wGssM0PWQPkSXJwy29i
         XniSLBVIEpeaNlPd1LlKoozVbsLWMqjDAVAUlYywN5jsgLK4gf9BcgRrN7fA54ajgFGw
         A9j0BgDTsPA9+vBRUn1iYZqH9bkwyccAGlgOZfkkPzei+LAjdTOUaxLUhgAwon08UPCd
         owsbsoN5ZdG7w67Kbu/UQ8KWlJ5/ndiM4DXEx23iu6o2fWNTwRucNQ8mutQ3RpcQbynE
         mxWHOcAsHshZS9X+65b0b/Z0QQXxbWWNfBMVNMJTG7hM/VF3GjN0dkXT6FNHSAh+kWRP
         FYkA==
X-Gm-Message-State: AOJu0Yzh+Gan87JWQF8K0xzW+wqanFzRSQAI7ZKEZPNpfGayO8oM0WwV
	xbkncQEb9YGTtYDdSf/jyu52SPNhHe0ICx2GnmzSZ2cV4wY++/agpX8ocw==
X-Google-Smtp-Source: AGHT+IFfnrrOUROovu9neII6J+upMUkXJgywLmGs/Y7ajVij8bcAuFCVyeEClI4+8Es66k5UDhTjxg==
X-Received: by 2002:a05:6000:24e:b0:364:a088:6525 with SMTP id ffacd0b85a97d-364a088666amr810225f8f.22.1718869374088;
        Thu, 20 Jun 2024 00:42:54 -0700 (PDT)
Received: from morpheus.home.roving-it.com (8.c.1.0.0.0.0.0.0.0.0.0.0.0.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681::1c8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3609c53b508sm7952797f8f.111.2024.06.20.00.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 00:42:53 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci-brcmstb: Add ARCH_BCM2835 option
Date: Thu, 20 Jun 2024 08:42:38 +0100
Message-ID: <20240620074248.152353-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Raspberry Pi devices have to date all used ARCH_BCM2835
as their SoC arch dependency so configurations that use this
and not BRCMSTB won't end up with this module in their config.

Cc: Andrea della Porta <andrea.porta@suse.com>
Cc: Stefan Wahren <wahrenst@gmx.net>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Fixes: 40f22df5269e6 ("mmc: sdhci-brcmstb: Add BCM2712 support")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index bb0d4fb0892ae..eb3ecfe055910 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1016,7 +1016,7 @@ config MMC_SDHCI_MICROCHIP_PIC32
 
 config MMC_SDHCI_BRCMSTB
 	tristate "Broadcom SDIO/SD/MMC support"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
+	depends on ARCH_BRCMSTB || ARCH_BCM2835 || BMIPS_GENERIC || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	select MMC_CQHCI
 	default ARCH_BRCMSTB || BMIPS_GENERIC
-- 
2.45.2

