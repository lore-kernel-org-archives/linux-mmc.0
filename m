Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546F1A8408;
	Sun,  5 Jan 2025 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736093638; cv=none; b=QZylnQzIXBKbUYluEqic5L5JeVVodtjW+UgmWjFMZuuayrEfdFnoAUmYJZVY2K9JkqkWjGjS3OpGhco0rgSV1R9TzmxrYl7iuzDzcgpVqF+Ieyp5LZTrhsLnMV0ARkO5fISnmLKYahhycEMbAz0jlvhSYRh6TA63rIwKe9DIc3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736093638; c=relaxed/simple;
	bh=xz9TkS8fZcmJTgdNAmHnREeigZQ5G/rApRQFHj9HL8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUlm3na9FoQ8nCXO9HNC1AaW3lik/y9GRgA/+rck7FYiftUjCufgkUOB8CEWgQMxMZXGvtetwuOI8e+nP9XkuLRdTC4MA1gzVuueqt/X3tUi5N3aB9T+Xrk4aD1IknJfLedkVwAW9NoqK7b6ZNXc7KpWuEx23SZLqbM8tOH+dWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioVda0La; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioVda0La"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso93238435e9.0;
        Sun, 05 Jan 2025 08:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736093635; x=1736698435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMcuEJIoEyeliFcoiN1rN1Xlq33F+vpylS/RXg2R5T8=;
        b=ioVda0LazlHbAUjz/QVrONJuWZ9nfi+Rvw7Cz1JQ0SmNa7Bdei1oaJHbUBzq9K2ZBW
         fpW6MVFECKWe1Uu0pJd/r9Ir7BozXT2Nnc9deZsHJ9f0mh53/zqPHPpfWbzGx4xjN7/v
         FM2Ir8+3zxCl6I1S4ZEDQJsERFZUyPEqsZoWd73bG+nVH5wMU8U1ld6pzPvvnbyzFDg6
         GGGrDmOtYHzepxHtiaHMAoLBHsJV1cAZ4Hv3ima3fk1QTXNKkItbbsaQnvXHqdt3xMsm
         +frmGhe5j011A/LNkZ9x0AV1OuMwbiEGvlE8z/YpvyAIvBUX8xL2lV5oS/poB6k6mt/9
         xtmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736093635; x=1736698435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMcuEJIoEyeliFcoiN1rN1Xlq33F+vpylS/RXg2R5T8=;
        b=ceoDYrN+cnBTZzu0Pw2ZaoXVzOSnSpsCKzFADOUuEHgdQKL9BLcWcdF9l/J0RAasxy
         bMsAI4G50ae8sa3APNktFKPBJRyMwkhV2/KuRSAPoFgC7L6oSKiNvqAE6j6SfsYYaC9B
         AhyC6/VL/XsHpf+izzJS96TXMFZ7WGGOj1F0ievQkXEkZJfJAH3PsGcmMcLcc6qCas4i
         Ja5q/YGVH65d8saz15GvfyetqpeIA2obtm03kcbrFHIkk8EwU8U3dp+JAaRnqW57D1mj
         lmxzacGT0mRu8afNTW6jprKyCNGXaUOSXY6FZa4rNd3EAm3W0/AymvnO9qUbH20PX7/k
         rSzg==
X-Forwarded-Encrypted: i=1; AJvYcCUrKYLJH9lfzv1q1geRCb8S/PZ0sAXb/6s5GqJ/QoOkxyaUYSAM94LOj9fNNdr+H29u7IvQXRtslsYzTt71NBnl5B4=@vger.kernel.org, AJvYcCVQASjNXH6fJuj4e41Iwe8boHnkAb+WGwkwiOxsu5wnByPvGmZ7yt2ZT1gGnVk4qAi+MDm1jxin4zZT@vger.kernel.org, AJvYcCVeaPly3zbrLYEElefhBsUYBqLN77szdePQzlCKsJiSBn8ppngiSAXse2EbKZJdtvcEt/+e24QuwoS+ZOld@vger.kernel.org
X-Gm-Message-State: AOJu0YxNv0wdyB/98yMnuo37npyHqu79GuPWgP6kdWnmNGfrmd6TQb6+
	6MQuXbqrrvJ5+MVRNbIQwj5HwnYqHLZZZodf5IUYI/nDf3CgAm1I
X-Gm-Gg: ASbGncs3aMRJpb9Peqxglp7oUeQz/IpvzWFbyN/+fYkUZi27QlFrNhnltJpSdjB3X0Q
	IbJ5/gPP5kHu73HTWfclAUZq9UzlvbRfBKZzvGYAEXGnrAYSVOC10ogLlHLNbyL8El7juSpKDQu
	Ew4pARvmFZgROsuogC8EGRl/2tatRAWVuECFRU0aqw+blR/PQSIPzUJygsV65Hm+eeEWAWj4o93
	2Ut0RUT98zxU0t3TxY0SpY7vObynQn7DmLxgGNopWdGaY6wrQjfOrucvr0qATlcu/ePftE=
X-Google-Smtp-Source: AGHT+IGi2vV5nk3t35IRdS2EtJiGq1THtyKt4WXcE+8E93rhZ7B0ooKHzQcnIOVx/iet4T+BYNL+oQ==
X-Received: by 2002:a05:600c:35cb:b0:436:1c04:aa9a with SMTP id 5b1f17b1804b1-4366864379bmr470705475e9.14.1736093634661;
        Sun, 05 Jan 2025 08:13:54 -0800 (PST)
Received: from ivaylo-T580.. ([94.131.202.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b4274csm578250565e9.38.2025.01.05.08.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 08:13:54 -0800 (PST)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] arm64: dts: exynos8895: add a node for mmc
Date: Sun,  5 Jan 2025 18:13:42 +0200
Message-ID: <20250105161344.420749-5-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250105161344.420749-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250105161344.420749-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an MMC node in order to allow devices with that SoC to make use of
it. It's typically used as a secondary storage option for SD cards. In
the vendor kernels, it's labelled as mmc_2, but since there don't seem to
be any other blocks, treat it as the only MMC.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 arch/arm64/boot/dts/exynos/exynos8895.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos8895.dtsi b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
index eedbd1728..f92d2a8a2 100644
--- a/arch/arm64/boot/dts/exynos/exynos8895.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
@@ -1296,6 +1296,22 @@ pinctrl_fsys1: pinctrl@11430000 {
 			interrupts = <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		mmc: mmc@11500000 {
+			compatible = "samsung,exynos8895-dw-mshc-smu",
+				     "samsung,exynos7-dw-mshc-smu";
+			reg = <0x11500000 0x2000>;
+			assigned-clocks = <&cmu_top CLK_MOUT_CMU_FSYS1_MMC_CARD>;
+			assigned-clock-parents = <&cmu_top CLK_FOUT_SHARED4_PLL>;
+			clocks = <&cmu_fsys1 CLK_GOUT_FSYS1_MMC_CARD_I_ACLK>,
+				 <&cmu_fsys1 CLK_GOUT_FSYS1_MMC_CARD_SDCLKIN>;
+			clock-names = "biu", "ciu";
+			fifo-depth = <64>;
+			interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		pinctrl_abox: pinctrl@13e60000 {
 			compatible = "samsung,exynos8895-pinctrl";
 			reg = <0x13e60000 0x1000>;
-- 
2.43.0

