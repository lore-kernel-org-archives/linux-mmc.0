Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479EB321455
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686989; cv=none; b=cAjaMcrwH4SLzfKycyv7TSPD+BdEmer9jQJXyqiXtsXZ00fPJ12grGTnZxXCq26JgR4bAIbri5ggHjNOGVJDy2luoYNBoA43raJl5eOC0ggQSFOmMsHLazhfVJKVIP7BzDHaP+PwaGFCCRNucwjaSCUU7hvQNDiDQoFrnvUZa8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686989; c=relaxed/simple;
	bh=o0lA08GVazKzewGuezaxd9TEVrOola7Ut4wOWEH6hrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KrJVYuiOnSJiaNFkEYqlq12LPe1+RVXZJ8FVYxb4zzZJFAL33xDuh3LXr6lMhBU7zZRBX9CIw8g2tmf6hUkcyRKKbiM3xFvpynadWHMFutg27ZZsdOeAMhapm6xxmGSHusia3ZnH7oZwCS2JyU+hHD1Ni23JQMOzzWO7MaI+mo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XIVYY700; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XIVYY700"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f7039aa1eso2035904e87.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 07:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757686984; x=1758291784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/yHJV3+N8pLzUbLZyCHNtm3fHXHEjlBUmkhDKwaFLWw=;
        b=XIVYY700/6NVJ9wp6jgNlGPkTo7jJ+MD1HXqxyLqDIxikL8HBnuwdc0T8Oy03bzfAz
         gSUSSsZz13wrYrZ36j3yRtrOZ8QchE+W0H0ssHWnmT/koU1JwAikEAj17LOEA+kLtsM7
         6n6nzzpaJR1EgLc2x7RV/pagtRk0tQ6NZDXGSG9t/HNvvcQX4Tl1YoislZJoIuWVSIFQ
         FHBazSm+miN5JoVnihjV1jOQUgZnscWkej6TA6vzFwGzprWoeQW2+4t7GLRyjYuEtsW2
         8CLolvJcGVMu4xDgf1VO7yC5474jKd6k8SiAfY1hZVSSIi/YMPRj8/WHTN1SluwNSzwY
         tICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686984; x=1758291784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yHJV3+N8pLzUbLZyCHNtm3fHXHEjlBUmkhDKwaFLWw=;
        b=ZmSBDAcOjrbuR8lRZ0PfFUpsWHMS0uHkWgbDgeLZSlud+bV46cHAirA/OtN1z/sQA4
         AVZ2TqT9xZnfnfhvljYqZ9iNTSTcwKvAgk7fNiK4ps2KF9TzS526IcmYN0zpGEyDzHzH
         RNUtFhm/5MrjUy99qSdqdRXPv9e/Azz4gEljDvY0zkvuADByyS/hWAmXAcpuntR9eG22
         qXhs6BHhwnlPf4cqAQnze/b6FxFKjOvzpj45sRvgCdml4GmOYxSZxA4oMO6UtEOrHS9A
         Dpv7ydptleH/Vp1zOn/8U0JrW6vyjJswtol8ovO2GAXKUWUY9haZoF1hlDz7rzgNUx4l
         LvFA==
X-Gm-Message-State: AOJu0YwENUFh/iDlzFrjh05R4uZV+rIv0XUUkBDoC5y1Yzs1e2d8pFfo
	vtX4kk9M+eZ5eZV5LtS+9O3N2QeZYbqmqQQTva+yEVbROEsEWmCnDPnRx5/e+5tFLRBYqY7coUO
	EedT9I4eXAg==
X-Gm-Gg: ASbGnctow4gZmtiqrR4G9iva/cQzhpxvFtlPsIKY9mvAz1K95PzU+7R0haBbu29kSlg
	AaUQKtijeoo6iYf34nhRHOCfchLOswCqo/bvEQO3r9D6LzPydWlAgeg6xgsyheoQWv6de6QWn5b
	RvKJCfSfNxGer2KUeme1g/vTwa2r6gR9+Yr6akkT4KggbGalc6Io1EUme8jRZbji4Aq08kiih0g
	RZ1HWPRoai4FXSW1KdFTEEKIqAY6UZrrQcYPHe39xgi4nWVKGMDnZj1aXBaYzriUuptlHfkc0Ym
	rkO5otLnKN92FWUqRS1wZOQDb8cTXzZzj65hO2ZxvLXwxsa3ctq5QtbQqT21w+xAP4kE5tll8MU
	nvIJZT7G3JO7bYnkLDWZ9h6xW3nhbl+Gw7NbwORiX/TuGPQoI64mxPar4wrvHG60QLQ==
X-Google-Smtp-Source: AGHT+IENzXPjTBozBO5xqGVD7LsBdowwRnBvhEvWrUb7bwzjPSa5sZKgtmjZFq+52KQWVjRkxyVY0g==
X-Received: by 2002:a05:6512:3f18:b0:55f:4495:51a with SMTP id 2adb3069b0e04-5704f99aed3mr1005515e87.52.1757686984214;
        Fri, 12 Sep 2025 07:23:04 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a5df5f74sm164981e87.54.2025.09.12.07.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:23:03 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	adrian.hunter@intel.com,
	victor.shih@genesyslogic.com.tw,
	ben.chuang@genesyslogic.com.tw,
	geert+renesas@glider.be,
	angelogioacchino.delregno@collabora.com,
	dlan@gentoo.org,
	arnd@arndb.de,
	zhoubinbin@loongson.cn,
	Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH v3 0/4] enable ROCKCHIP_PM_DOMAINS
Date: Fri, 12 Sep 2025 17:22:49 +0300
Message-ID: <20250912142253.2843018-1-mikko.rapeli@linaro.org>
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

v3: use "default ARCH_ROCKCHIP" in ROCKCHIP_PM_DOMAINS as suggested
    by Arnd Bergmann <arnd@arndb.de>, enable more MMC drivers for
    COMPILE_TEST and remove MMC_LOONGSON2 which doesn't link,
    remove PM dependency as suggested by
    Geert Uytterhoeven <geert@linux-m68k.org>

v2: changed from "depend on" in MMC driver to "select" as default
    on ARCH_ROCKCHIP as suggested by Ulf and Heiko
    https://marc.info/?i=20250912084112.2795848-1-mikko.rapeli%20()%20linaro%20!%20org

v1: https://lore.kernel.org/linux-mmc/20250911144313.2774171-1-mikko.rapeli@linaro.org/

Mikko Rapeli (4):
  pmdomain: rockchip: enable ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
  mmc: add COMPILE_TEST to multiple drivers
  mmc: remove COMPILE_TEST from MMC_LOONGSON2
  ARM: rockchip: remove REGULATOR conditional to PM

 arch/arm/mach-rockchip/Kconfig    |  2 +-
 drivers/mmc/host/Kconfig          | 10 +++++-----
 drivers/pmdomain/rockchip/Kconfig |  1 +
 3 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.34.1

