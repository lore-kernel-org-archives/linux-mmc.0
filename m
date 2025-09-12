Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A947F2D47F2
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666503; cv=none; b=PyV7AISRDBWHt9VaMRUnICUkP9WGLotg3jx1Suw0Tlypuq1wVq663FON2OsnjvWgpidcZswBqO5h09qo8ZmLFp+avwlOW20rvm6zPLGLqWHlYVK5eSU7mX2pl9UWmMvRjpWiN7q2EBu1qUkMw8jexLvtn/1LbzYM8oKbC0GLZAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666503; c=relaxed/simple;
	bh=j8WiM1AwcmR4UKZ24HXYJnllvBCh9jUhE7SQfdx0nG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3CZZEZVxgP8GOlHuxXA/Zzi1hpKV7rGqpkQ3EHBjg3s0y6sfIzmB5DcyhTxfMbvL0walgyrRQ0Lz2zQLKzD0N4Cl+FktX8jOhvZ/tCFXZ8chTopqAjMr4+m/RwspknAQGCPWr5D755pNeCMtsgNrdoKExcDA7ZlYd+/SqY/MLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ocFZuqaV; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ocFZuqaV"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-56088927dcbso2020656e87.3
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757666499; x=1758271299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zi9mhYSrg+uoSn4FWmIZqdjd0t9zWFL1Q75akd3T2yM=;
        b=ocFZuqaVuwx3CVQKWQlJc8PMRi6+FZtfuDsu+irA033g+kqDpI1bFxPi8Rp7QQKnRe
         9fsYpedxzehIyuLl+Cv1hTDLQq9+fZAAxXEloJrp3Ms0gMIKrpiQlRUmkiL9t2j8uc4o
         epE57ExvvH33JU3XAkyjEfcbU8iFOVml8ClCKlHU1jEkL1iNiG3pYq8uXOLSNVdcZ8J/
         x2z/Nuclrznfo93BSd1Am3Uhqq2RwZRvfRGY2oO54lNkQbzQpEtoNoAsAttFE0GGbahA
         AIgl1tdCIg/SYd8u0xCIUSFTFBdiaaxmVKCidLfEQvhW/fiAiAiFVYr35RMNuXTgFmqd
         vKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757666499; x=1758271299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zi9mhYSrg+uoSn4FWmIZqdjd0t9zWFL1Q75akd3T2yM=;
        b=JGztti8iJt+yV/JYso43TYGUpZygEW2+4v6JcEYGvi4WNJJF1Eo5Q7HXU8CCpWlRzY
         FlO6xf5trEx/xDVvxuKI+GmL4Lbm1u24YjuSBMsr7T+Ev559rsX5iiLNkKzKpmacFFSA
         gkaqJpZMBrB96iu55Fup6HFOLVA58KyLQL1BoRWgZqYyDtVWFB0ueoBmgAZgP59/ODKs
         qZ2IlcE/jAAZqly1RGRpclJxkzzHQ3y9T6SjuMMToSaKtO0sjrl3ypMEe7x3nGa2XCPV
         H7xodpg2JlxmjsvjBdn11yglCGN66xee0mHC9tXbl/KfRP+8kmwAmm1Umk1fqs60WYNM
         7scA==
X-Gm-Message-State: AOJu0YzCvGAW+hToBbP5hcFVKD04Tqzb/QcrGiqX2wHyANQmxijJXyvx
	eECwm/IDJ7EBn1NgtndqhA/PhCNsPyeOTHNZgNypnz5tDUlFDNRp5wi8t5/yaoAy/2vFAmj7K3q
	8n6p8SMKdgA==
X-Gm-Gg: ASbGncsPQZMWYra0VsfiqgF6Af4FGtV3GWzWbqPfsKvZCbW2d2OJ+xfHQpV2ZCS6J4J
	WES8DC98HUlBxXsqhPj1RlZSrlQORi4EqjOx+5EvCzQOekICAzwDESg+A0mQWiSYz2+onNtElSh
	FyMevNtzTy2Esxa7DCtZ84/ZlBZigQeeU6MM+hxUF+LedE3m3pAmnDXp7yJa05hQxs7AjJadpBA
	5t0rnRxXPORzKhd8xeKC4rdY3OInXsLjlw+RtF6VnqmsWbr2yFwDjywaRiRaTxhU8Ko0Oc2dD2F
	zlz1IiI+5qtStuE+QLCCPmlCI0l0lbkBFzp+jh+GKCZBpyqnxMgVr7/AG9ImHOx3NYsRYggV4Cr
	CmhKoo7cpMEOTwrNKX9vqGxpiCYS9itFCez9ZH6L60bjJhAijGEFHs76qOkVeTtUayw==
X-Google-Smtp-Source: AGHT+IFx7Iz5XF+xrNLJkCkiosSOnrJ09CXvrdjTO4FZGsUjEDPPR94YYqvJ/Qo7O7hEYIQNGxSzOA==
X-Received: by 2002:a05:6512:3599:b0:569:a257:acca with SMTP id 2adb3069b0e04-5704f1ce7f2mr581298e87.32.1757666498725;
        Fri, 12 Sep 2025 01:41:38 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63f6csm989050e87.86.2025.09.12.01.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:41:38 -0700 (PDT)
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
Subject: [PATCH v2 2/2] ARM: rockchip: select ROCKCHIP_PM_DOMAINS
Date: Fri, 12 Sep 2025 11:41:12 +0300
Message-ID: <20250912084112.2795848-2-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912084112.2795848-1-mikko.rapeli@linaro.org>
References: <20250912084112.2795848-1-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Heiko Stuebner <heiko@sntech.de> all SoCs
since 2012 have power domain support in HW and
ROCKCHIP_PM_DOMAINS should always be enabled.

Suggested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 arch/arm/mach-rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

v2: added "select" for ROCKCHIP_PM_DOMAINS also on arm
    mach-rockchip as suggested by Heiko

v1: https://lore.kernel.org/linux-mmc/20250911144313.2774171-1-mikko.rapeli@linaro.org/

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index b7855cc665e94..37f1cf38a010b 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -14,6 +14,7 @@ config ARCH_ROCKCHIP
 	select HAVE_ARM_TWD if SMP
 	select DW_APB_TIMER_OF
 	select REGULATOR if PM
+	select ROCKCHIP_PM_DOMAINS
 	select ROCKCHIP_TIMER
 	select ARM_GLOBAL_TIMER
 	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
-- 
2.34.1

