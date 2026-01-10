Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8621FF23
	for <linux-mmc@vger.kernel.org>; Sat, 10 Jan 2026 01:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768007255; cv=none; b=dexWr8PDvj+0yAcz22LCF7KNMrN6INQROoiW42lB3ADgO+4qCb9pqaAuWNFgzrH/e2QvG4BhTWVbB3FTemG507iOasyBgvb8BP5i59uqMjmr+ksCn+DMM4dvb27KKTsjtPmtQsNWizzjnHS2WyhJIcznFBv/gCcmaTZkq1KDQOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768007255; c=relaxed/simple;
	bh=hbAE7fLVMqhiz0ka0f4DsncIMuz8hdHk+5ZelWshzCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaLxKUZoJ7iYTqsHc71ieCSmLcVNQnC38p1y+/Gc7AjWjavtxgA1frt7wSRQsUZu+KX6TJsmMpFDEaI17L2imv+kU0LSBSk7m0FcHkSZ9+uN6dvbMCy9/zo+2k8iaMz8Vd6W8XELh0wnmJAMD9iKLL7w0tcepJv0Z9E4DufamWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gi+ecyIQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi+ecyIQ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso34837095e9.1
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jan 2026 17:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768007252; x=1768612052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DN6MSURqxWOvIBN2xDV0KAizo7981QvoO4K7apHW68Y=;
        b=gi+ecyIQXaR1N6LoeHRr9V5r4awfzKwMsT9tF9xNJ1mKbJtchpcMUJmti76x/YIF81
         TB/H0WkXTKHg0YFdYAR1vM4sDKXYCBd+ckOnbftgVcRtO0svI6dp19E7c6gTPHNZIbAk
         B8aX7It9I1vbjomFsfWbY3NhOp5NS/WEeMH5d2hw0Pudbmqyi3bAcjTNgyp2I5mzVTnp
         OhttGZD2NcRjAh+K71QduIr0VFE3boLD4CY9pR6JlQ/mwAxG0tJatHm2AiK5Bz994UHx
         /f4TSrGR3fRcsrgSV64ZA7pVIuM1xQO33wHL4ojxQ6+3WID9Gur92U5jFpaeAcRD4Otf
         0gaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768007252; x=1768612052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DN6MSURqxWOvIBN2xDV0KAizo7981QvoO4K7apHW68Y=;
        b=B2yHpJF/vaqun/cQVh7gbY6jRlwHTP2lSQTBx39oCqNUYnV2Axy7ubb4lUn1e35gzT
         SQZE1SnCvgrd4i0af09/CRtNsgse1gj0K8kX+xyMUOeipDZeelgOsJO6i6t11WLt7e7G
         WWO+Ne9NSeSl77VMUU4ncF3vVVBWuD1mB0m6ZyaGiRTIoszCifwqtjR8AAZ1UkvwZ/0P
         OKgdHel823eIH8yuZR7ga94F+9Y6tmuuCfxHJyitRePaMnLYI+N8KlXGHC3lD5Mz9JSr
         QuuBaLu1wWM5CNC3x89ruM7Qq4Rq11HgwpwOSlzntyUHnmofYTI2XwuxqSlF3nXwAMe+
         MRtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+D2aBmBRojy0TKqF0sJxtWJ6QbkWsucD1asq4qgF7syClAV3QQtWtQIyn4JVBJajIXP3042sjq2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/LrHJ1zncutiwzelSwIyByhSbBQtxDY3xkBxksg73WFsxPL0B
	L21Ll4w2v73KGPRv9UMKOLaHpL0xBH3uvGOvopS4DxRtTGnoan44MJ2j
X-Gm-Gg: AY/fxX7+tIelhKprGpVUaBcIM+nUz8/7DMcTnFBsL5ZwUtcqLNFw6nA9VNu3l21B3Dv
	ZbKxvYiTx+ep7stBBQJuD9R49g9PTg17rf/zZ/IYveWs5o3ScNldhLwBkaIfwO20bLzl+2QVNeS
	Z00vaNmLaOSPBSRxMWM/Vg4RupVi//ZEKyW4HK1b3PTD9E6l9E3xiyki9la3ZxNz4V0oAb8Z1Ld
	FVXd+K+y1DTQgVnR+cNJiqhDS2qLjTbQv/hleBHbNYeaWCCE5ZMjJ0vKwW7uE37kRDD+NzU7Iw4
	C4wD+PMOrG9ezjqmfo4UtL/i5Gtlgl5LWBV92EZmDfNCwD4G36v6dcVHqtf9QDSPeAiU49VfBd2
	FHEwsc/BjtCsC7CaRxr6PgunILXGorJ00gmEq6FlW6e2N+Jdibbc5PhimrKACcoCPD2CNWKUSu+
	uikvjp6iwqX1hpQ7ZSGYznggca8NR9NoPkPBJD6VPtYoxJSdjXORvf0hWhVV5spNbwUSYPzhj9n
	/M3iwQ=
X-Google-Smtp-Source: AGHT+IHUUZ/4ZQNhh9IvF2WBWql7HyWhiFdLiU8Xz+XMhgJCU3OwR9PNJC6uNnx3kZs51See/jVZpw==
X-Received: by 2002:a05:600c:4fc6:b0:477:a21c:2066 with SMTP id 5b1f17b1804b1-47d84b0a902mr114638605e9.5.1768007252116;
        Fri, 09 Jan 2026 17:07:32 -0800 (PST)
Received: from stor1.home.marco.cx (ip-178-202-227-016.um47.pools.vodafone-ip.de. [178.202.227.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8717d9e7sm71779475e9.8.2026.01.09.17.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 17:07:31 -0800 (PST)
From: Marco Schirrmeister <mschirrmeister@gmail.com>
To: heiko@sntech.de,
	ulf.hansson@linaro.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Marco Schirrmeister <mschirrmeister@gmail.com>
Subject: [PATCH v1 3/3] arm64: dts: rockchip: add stability quirk to NanoPi R76S
Date: Sat, 10 Jan 2026 02:07:15 +0100
Message-ID: <20260110010715.1610159-4-mschirrmeister@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110010715.1610159-1-mschirrmeister@gmail.com>
References: <20260110010715.1610159-1-mschirrmeister@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the 'rockchip,disable-runtime-pm' quirk for the SDMMC node on the 
NanoPi R76S to prevent bus instability and retraining loops during 
idle periods.

Signed-off-by: Marco Schirrmeister <mschirrmeister@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
index 31fbefaeceab..90a798ee9e68 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
@@ -754,6 +754,7 @@ &sdmmc {
 	disable-wp;
 	no-mmc;
 	no-sdio;
+	rockchip,disable-runtime-pm;
 	sd-uhs-sdr104;
 	vmmc-supply = <&vcc_3v3_s3>;
 	vqmmc-supply = <&vccio_sd_s0>;
-- 
2.52.0

