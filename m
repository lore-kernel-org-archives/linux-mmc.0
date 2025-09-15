Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4502F0C73
	for <linux-mmc@vger.kernel.org>; Mon, 15 Sep 2025 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925228; cv=none; b=IeTOJ8sqLrJ8Mu7AyuHSpzsvOelbT0XUj8RiBYl8zFCXqhbtNy1KKASMnff9h3abDUXCBk7DzXoEUMp8fKnY0L9nUxmYxUfjAen9txEUXJMOCeZQOYo74Tc1pY6IARqmjZ8g55iLqLfE+xU4/PO5wZjtRCnXwWtF5nS5YAYD8mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925228; c=relaxed/simple;
	bh=wucKZjXUVtRxrGoS9CppvLYgJwFvEG8gqGPWzlZGBag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBjwZRHfh76HR0+/bTzVu/x1DpGt/CbDi+fuOZypE2vbbs9ElCkUxAqjDxeRb8zUnxcXjbMVYa3/Z2/pmtlRpza6jkhrbVWxf9oSm1PPNdcblGCNSJtzPQUJLBMCOtiVeWzXnDpA44E7ASN5DLwvXi5ySZsgBlvgueqVrSmHnw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZLTOx798; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLTOx798"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f74c6d316so4002737e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 15 Sep 2025 01:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757925225; x=1758530025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qUTD8uROnoCtAqaX/Ri9iIJ3aP0OlkHXH5AZacDoiM=;
        b=ZLTOx79863Y9dBGRIyWS02ByXJ5b3dBO7796MWO2BA9YvYPYyrfqyKOgPJ/9O9jEcx
         sh5ls7fehOXmv2n2NgbYuj6zvE/6WlesqtRxA2ppoFQKhxfRvwJ9ywJ1trLtSeqmO5i9
         8rAzhG3em7G6C1rlf82Br1v205tdwLwfMqUF8+5MXsKFcMHRvsLqqeFSaAtyP+NhdZWH
         JwIrhyPLIX/6xL6SV6p8DoBm+nx+ijjeC2QzPBpeudP/7nsbB9/C1bxzWMTSZuKBVmdd
         ECkGS3LcnjuhKsknbC5fYIurpy211mPzM/S7nWiGEUwgrPfwtPglZrRSncoGx+SZk78m
         vfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925225; x=1758530025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qUTD8uROnoCtAqaX/Ri9iIJ3aP0OlkHXH5AZacDoiM=;
        b=FTdiH8CUTFby3u0NqJFgwwEinPLku7W8Pzh/5H2m18GzG78G5RwgMMQwmNoAnBpKsw
         /IwQD9DtfCrFo+W/zqQtKnHaJv9f9a4MRVXX79ZjAALeR5QEIB7VPFS/iwPgB83YAzR8
         i2KcE0aMp9jI4d87c8ns+kTb66MV0ARh6CAJwUy3LhWv1S2Ew330Otio7DOKFZRNeZCa
         gQto3PZ9QF8HlR+bc8vSHtnQht0e82QK//5zYKkEf7VOWfh6mhn+GmSLSa6MaFUdOs8p
         QCOcJ2jttQsqKptP9pCiLHKK/vwHGwETcaH1plQtzRoia+ks7JcB4kon4E36bCPDpNas
         Y5sw==
X-Forwarded-Encrypted: i=1; AJvYcCXmEa/qKQ3V6/8lrfkaYSV0qr+9QE2LxyFCS0aH/xnZGVkqu6cfZONBoFMAgMg3AfXvnyA37TqOGxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZqcq2wJ0HEK7+2fRXkoiV/XRgzFQQ1z7Qpwkwth/ydkymQxW
	DJQpb/PvP9fgeCJTntsZCQHO00uatxm0Z8vH6sHJbk94BH9j4EK7V6SAeeNIrIq0iOo=
X-Gm-Gg: ASbGnctb56w9Ei8sRafaIaMEmUSpoFSZW19vhdE064N8Y/vPZUev7d8uTExnM7NEro1
	3M7uqwmdMK7QKCJvaaMflXtBYguHgRcEsjeUNwsKd4w2oPb6DkrE7ICESzURPJ4+kISIgnTTsvP
	KC+5C5t2+MgzhEv+bzKZ4Bq84/Id7kFP4lCKC1CAbgNpLB35aKt/UJnfKJYlpgUBKWtRVvgE5UE
	zL5Tywk/eUK5EGzUWhGPjqC4j8HLqm/8atfarMdZ9UKNx6S02MPhqwXc+YIgdK/czRXqVBdnMPb
	jZgZzFGY9e3fBod1Ujdb+Wy370/n/DX3w77imM1ZAOvAX6HeG5PApzrUOPOMn8GAb7epJ9i7efn
	3h9JDq2BPSToXPO1efwDrEvaM1UOtIIXi51VyOu4yxx0rAVEwVCUGlM8=
X-Google-Smtp-Source: AGHT+IFCaOIerdSvA+z61cnaMnc6f4/AxdvboyLIWVzD2Istbx7t/KAwnGHxWdDUQK//4BQjlegbXg==
X-Received: by 2002:a05:6512:3f05:b0:55f:3e4d:fb3b with SMTP id 2adb3069b0e04-5704d0071c6mr4042367e87.30.1757925224185;
        Mon, 15 Sep 2025 01:33:44 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a6a33ba8sm2335142e87.46.2025.09.15.01.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:33:43 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v4 4/4] ARM: rockchip: remove REGULATOR conditional to PM
Date: Mon, 15 Sep 2025 11:33:17 +0300
Message-ID: <20250915083317.2885761-5-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
References: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PM is explicitly enabled in lines just below so
REGULATOR can be too.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 arch/arm/mach-rockchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index b7855cc665e94..c90193dd39283 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -13,7 +13,7 @@ config ARCH_ROCKCHIP
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select DW_APB_TIMER_OF
-	select REGULATOR if PM
+	select REGULATOR
 	select ROCKCHIP_TIMER
 	select ARM_GLOBAL_TIMER
 	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
-- 
2.34.1

