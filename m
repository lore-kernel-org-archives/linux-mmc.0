Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716EC324B15
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686997; cv=none; b=ZyYYsBCKCXGzHq6RZ0ayAdgSeGN09cs91FGwNUp4S9r326bm5QKpMG6tqYdO1b7I7Y9qqxCJ5gthH8gj3WZTGnpQs0WRPHFzMwe1RjFYMYRnNLMyXFWrm63RH+az72vO8G7ltES/i1f/bNzjE2P6kXmLiCHnuYQXzLnXVHQej6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686997; c=relaxed/simple;
	bh=wucKZjXUVtRxrGoS9CppvLYgJwFvEG8gqGPWzlZGBag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7Vy8jy8iyISN5j1soQveyWQmA2I/vDiFuirA/hrLh4lc5iLDQP30CZjFDLS+sJnO5+VuY6s8m2kLEmTqDM3mX+Y6P0uJkcx5/R/yC0GKrZJJ0jbOhZ+/sgCwdmQMqkVrnWFt0ui/FKVwMCIDB7IG3HDqH+Cd8In+f1D6lQQ0GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tIq9H9Tm; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tIq9H9Tm"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f6bb0a364so2426431e87.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757686994; x=1758291794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qUTD8uROnoCtAqaX/Ri9iIJ3aP0OlkHXH5AZacDoiM=;
        b=tIq9H9TmxDH/1kVDrO7qX2kdboxTA4Mb37p7mZK1STG+VIV20K8KydJK39oPBjkrL4
         vzjv83yAWIfOSlnhD9OS4Nf3dbRHkMUGFgHnX10biqGRQaNTy194acN0Yn0Hu6If051V
         ifLuMiOSeI64IBbPcMCLjZWYD2/oaIWmn89LQ5QCElwEZWOWPQZh/d3hhlxDdsVVFZ2n
         13Gfb5DPaZG9tHUyNW1l0G2SogKr/lvPM8gsWQjVI4/l+mCYoV5bZy6qInYIU6AOLm8D
         O/NX3tUUxAEstH0X03bNvwOPbT1MtHfH4eMN70J/L2qCRAWx2nDZn9ysqXG7hPDAe40i
         WmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686994; x=1758291794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qUTD8uROnoCtAqaX/Ri9iIJ3aP0OlkHXH5AZacDoiM=;
        b=vKormuElCFoY7d+Yly7CdPdDAxIopNKc36krp6L8xmhfieoOD2MpOBP3Zmh5tcYu+s
         XwYujW0pmOKpFeEahAvvm2d61aC048x/lflEcltY9SB4MDnxTRmOhXZLKgTSBly2FwyE
         mko4ljyQvpSTYoZufMNnGH191PTikD157UxW4KMXkAxcR2ndRkS6OCNeHOtE28g8/Z3u
         vlA01CpQ49hxBNjsFWPd2FKs8icNSylt8KzBPPcVY9DJAEmXj6ZsrqnKETUzlzCJ0Qs9
         G5kPuHCLLwo3F5jtPVPZkCj77sA4p1GC+jw0h/YVw2Kj3utphiGzYyHKiGKvjADyOhN7
         GLIw==
X-Gm-Message-State: AOJu0Yz7iFI2BYMmB5O6Oq8B0xWmgIOqoEYweKeFvygsZ9q9uT9+ndDi
	kf0CDeo3XbrFiMuT+7aDGxjJoDw7WmxByhhTNmICP8mwwgVgVfB+x/SCk6CuMQ47oJPT9B6gb9B
	IjQKuacrdXw==
X-Gm-Gg: ASbGncuwVzoxXjp3G3hiZLSDFAlZVwjvkz2qYpHpx9RbZohhVVqDUea7IN4xfc1+msJ
	ehtug8RERBXeRpXQT3AXiFFHIwCCx821osUGtPekP2hugVbItowflmLef88CPhMyFIhjXBPQS2o
	CgGiFNpOqiXqBYELzP8Nz0nZArXNkuL1GYIqCanCNjT5Y+MBvbDs7hNgVlpRryHML86MfXH2VK2
	+KEzdnVE8kgeV9+WLCVcmBYkN6jzOfSJPMl7Nc1wXmN2KxTDD+GqUVFifGaCRH54D6jCESMn1kf
	Sig11E+8vNyVM729C3rYcVMKYVANEj/NqemhXwSafLpxZmkmPS7EEWV/ONNLMqqRRgLCfcLauOB
	lYwzblWFgIwsj8qPDrf4MgKSNJ8bw+L0K5zZlcjv05WM6OA1RWABqdzY=
X-Google-Smtp-Source: AGHT+IHDFRgPZbd1jhBBu88b8yJFrtWAcpBpyVnbXWAjvg5OaUKHdeJnnNgJtLSLypAN7OXDfvPL5g==
X-Received: by 2002:a05:6512:1242:b0:55f:6649:45c5 with SMTP id 2adb3069b0e04-57048beb11dmr1249146e87.11.1757686993595;
        Fri, 12 Sep 2025 07:23:13 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a5df5f74sm164981e87.54.2025.09.12.07.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:23:13 -0700 (PDT)
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
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 4/4] ARM: rockchip: remove REGULATOR conditional to PM
Date: Fri, 12 Sep 2025 17:22:53 +0300
Message-ID: <20250912142253.2843018-5-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912142253.2843018-1-mikko.rapeli@linaro.org>
References: <20250912142253.2843018-1-mikko.rapeli@linaro.org>
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

