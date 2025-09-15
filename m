Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36072E9EA8
	for <linux-mmc@vger.kernel.org>; Mon, 15 Sep 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925217; cv=none; b=bBz6L5Skl83MLLdkfckCPFPjkliV1/TPPJFrXIek0HevSv7w5W6XrsVxFK4YDivziTQ51b80KEiMWR+PFODST5qPXT08D4moxynFc4CJp2KZzXLyLG0t+iCtCr+07EuceFtWfwBtPPpt+pfRTRHm3goadX1m2aUbGsXY7bwkD0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925217; c=relaxed/simple;
	bh=qgHExHKX0GUPykcINnOhpIWsYtDUUek2qoRVQ2W22yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eJ4RkQmyS75iFSJu+M4zfCUvf2Bz7KGIczRAM9sJAxw/Fc1JnT7Jvj6VDMT5RB4sFdjzK/NyzaDAlcP/r9wYSg3dKHQUqQFVSRWNdWCfumXFTGAVL7hyqy/s6hMfXSyjSeiIyCFB+K5hFJQrTBKbza5zETCuWHDdpOMJrlyx2Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VEURqaG7; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEURqaG7"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f7ab2a84eso3710593e87.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 Sep 2025 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757925213; x=1758530013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/EihPg0rDDUsO2zpTiZR4g9YFvnwO8fGm9cXNKFjmmM=;
        b=VEURqaG7fwCnnAy8nXUfmDd/YFkXcSbKQuKC1SS45fz7n1jUtzoSliGXXgjAibWode
         KBrK21App5AFoFGgoWBWLLsSkPPxWWaC41jLHUfGeMw9K3sRKvh5c22beEt1c2n+uu1z
         9q20us91iJWPer1aNSEgtA5a3LPFftBT02DBj5qNYyYTD43y0FdSoVAVPe6tLvmYBxY0
         FReBddjbdkHJODgNbzS1F13q5ZXjucTp6d0uh117uO73fXeTYVQmL5H6A/CJM0aWElwd
         8NtOL+/IbvUovX1/saj+SKEXs5MLZfGA+ObACR0n14Ciyg7zUGXz5KKjj4XoAvv99FKo
         P/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925213; x=1758530013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EihPg0rDDUsO2zpTiZR4g9YFvnwO8fGm9cXNKFjmmM=;
        b=FHBwEkhxvkij08kq1iFp2qnF07feVWJAF/3V0t1kUsju1Rf0Rb/L99h2I5+56U32Zy
         TatMw1JIKZwHj4gQCe/0P56pIxtc13GBDgMsY+fR0H/oOSrGhcpRFHyzwBRAcHFGpt+/
         14rLaYMLJow4+mt9s18OsaJLLre4Gur8g+P5zxQij3Gbh6cuGGLW9D4diKAqH7fEk9SL
         SticSM+qt7bWzeFWb1eqZouch751kwb4mL77hcsiXhc/qCHLReelgJ57nINCgirQKFmf
         3VxcwG9joxk1kzPdFIO+seKIRPJXT1wiX++gphnaxDHSfZyebtuR95el5IJ1YYMp5+Z9
         1blA==
X-Forwarded-Encrypted: i=1; AJvYcCUtg9m3rFkqlC66DgS7G1VtFEX9fgI5qQLsGpc2X/0RKVq0q15z+aOl/yXqxDu6E7NsMrcWxAGVwxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLnNGwI6GEQBOrrVXlhWusRHx3dOnqevRdFQZWihniB37DHBl6
	IaQ462o9uCqYzzTHN+J7XGgoQ5IqHfWAgeLC4ge5q2Tr9nKHW0iUB3EvhNW8p3g4ywk=
X-Gm-Gg: ASbGnct3YMrPiX4zFBfUHatmF57PZdQEpSZ8X0ggpk9C5HF/3nR0KLP4e/deTZmL8/D
	L98bwGOnOZVFCmRg/gUZMfNjoWKEHgtNtlq+g1aIspz2WFTtRR9rT7ti7hyHfDwi/2NyPrLexcb
	lQqiytXaGkVmymeJcg5ctd2QbBF5wgYxcq9XK1eHa9TXrpSQ4yJ3RB4Y4kng2kKBnSurnyHyHvD
	yOSFrRhwwAdGo6J95XSIFws6rvYdMWpGRCks1syvxY5qCiUMFPsd9oiFHNR7f6pyK3nCw5pH52I
	hyZ4i3oFkkCt2X8Q7Zh6RJQSKCxIYufNkiYo7cilfZvVCSMT9FAbnrrRzUaac+Ajww0wAGFJTh9
	Q7BdC3N3+Sb2HbWs2sonTSbMDel0KJP14yq6Z1xswtcR1n6YOBtcUjRX2yishmo5LkUXm8NgVAj
	K/
X-Google-Smtp-Source: AGHT+IGOXTY6MavVKngLCpLB1G9dg0jsTMPCjkwVytxoyznWD2WrW7pxjPzUDjOIZ3mMkSDu12yFmA==
X-Received: by 2002:a05:6512:2585:b0:55f:43ba:9410 with SMTP id 2adb3069b0e04-5704b52f23emr3366686e87.15.1757925212793;
        Mon, 15 Sep 2025 01:33:32 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a6a33ba8sm2335142e87.46.2025.09.15.01.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:33:32 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH v4 0/4] enable ROCKCHIP_PM_DOMAINS
Date: Mon, 15 Sep 2025 11:33:13 +0300
Message-ID: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

MMC_DW_ROCKCHIP needs ROCKCHIP_PM_DOMAINS before MMC is detected
on Rockchip rk3399 rockpi4b and similar devices. Make this dependency
more visible, or the default with ARCH_ROCKCHIP if possible.

v4: fixed Kconfig whitespace, added select REGMAP_MMIO to MMC_LOONGSON2
    instead of disabling COMPILE_TEST

v3: use "default ARCH_ROCKCHIP" in ROCKCHIP_PM_DOMAINS as suggested
    by Arnd Bergmann <arnd@arndb.de>, enable more MMC drivers for
    COMPILE_TEST and remove MMC_LOONGSON2 which doesn't link,
    remove PM dependency as suggested by
    Geert Uytterhoeven <geert@linux-m68k.org>
    https://lore.kernel.org/linux-mmc/aMQv1V49xa_MThGq@nuoska/T/#md2b3252f9dce14f3f79a493c426f2761cba1dc25

v2: changed from "depend on" in MMC driver to "select" as default
    on ARCH_ROCKCHIP as suggested by Ulf and Heiko
    https://marc.info/?i=20250912084112.2795848-1-mikko.rapeli%20()%20linaro%20!%20org

v1: https://lore.kernel.org/linux-mmc/20250911144313.2774171-1-mikko.rapeli@linaro.org/

Mikko Rapeli (4):
  pmdomain: rockchip: enable ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
  mmc: add COMPILE_TEST to multiple drivers
  mmc: select REGMAP_MMIO with MMC_LOONGSON2
  ARM: rockchip: remove REGULATOR conditional to PM

 arch/arm/mach-rockchip/Kconfig    |  2 +-
 drivers/mmc/host/Kconfig          | 10 ++++++----
 drivers/pmdomain/rockchip/Kconfig |  1 +
 3 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.34.1

