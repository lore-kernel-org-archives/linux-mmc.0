Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71BE41C0C0
	for <linux-mmc@vger.kernel.org>; Mon,  2 Mar 2026 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464454; cv=none; b=u6LWB7C4Yk1n8ZV/RAMxYPg+3M+M4htFQwXAbynMSSKoVlOGh4lo4Uc5xVxPdkwEqiXM9Ce9gX53WEizu9AyvYnqfwwv51Xxgm/VkPk2pj/J2PfrrgANeRraH+6dlZqhKk0urM2qTh+EciLh2qgXceM8k5x6tDGlhAfcWIGVw/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464454; c=relaxed/simple;
	bh=q1S365EAUCSFZRfzHFj2YrxqxW/P8gDiboVdNm2IwmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oA3oFu7fgKRAt2t4Cezm7mUfxGyncyzUfg2Q6+TUXxuXZYv18T1NLf5Vt9y6YeVQYBo6EY3+sB4Vl45l31WpTQ3i6e5M3AiA6mHYYT9zn594QiC3paENBfPZ7UZo4dw80KhkHSvK0ywJ4SbARGUfSHPpqYbg0DvufYmBdIgRYTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqES2omY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqES2omY"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso39158945e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 02 Mar 2026 07:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772464447; x=1773069247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxmhxlsdpHuelB78+3YE0t0LkGzrS5SfPUfh1V6r7eI=;
        b=WqES2omY7rou7dSI2UcfEa3Vh3z45361b+z013IU+uc/wM747q+kU09w4bDNKGPtK3
         sLRHPLKnkThIT36BqGAn4som6akxOtURzpz2xy0DaOzS52pGzts3YG2wVZHuN2jBKTsv
         NjGOszLXbRa+Dj9n+Gy/qjUecUhOzV//ZlwTDqKkb5P1EWN7hs2Y0izSPcjCKv4DhAr1
         JdlbpQ/cvcunPwQ+uR1V+ItzCmBo7+iIhDK7gl/sNM3YCe/AZrEZVGxZ5AMb7xgWpTOr
         Es08m1GGLbiXZUrFW1OAqcq0qv0+n70H0HEPtsgNMfvdYau1spkIlZgbpPCvdpJuYN43
         0fuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772464447; x=1773069247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pxmhxlsdpHuelB78+3YE0t0LkGzrS5SfPUfh1V6r7eI=;
        b=wCMtBs5s9BH6aJwz4ljRFseLx9XR5y5u4g4HcqFs3WiMtxTKdRRz0ntrVE3vne99uu
         V0+azyDhHOCIz0BPOlNKmhFI042V4D3ih770rn1bz0Fkt6z3wICFKmBs2JqIjKRUIG/U
         2Ikdsu89CwTeSvf/v4/BPnF/Z1LhnlQBrsRHfUrBmzlKepp/ds4X7CSsM+Sr6VTtD/Ho
         QDuTRcdCEjEu8YHs/5EM0KxK3DhB5hDglBwXXJyQLgp1iU4ckUGAJm2B1arAcwOOIzjR
         Swtq3a5kNiwbHrnzBY3ANsBSLYxosPCIemstliOkMGN0m7okMvezJ5PvKPOCjmHIMGdK
         7iSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbZNIWIfs4S1JLa65cnPTjg9JYo7YGqNoSQf4KJ+0YrjbzUKNqxlO6lWtP28GRIv4UQuDFyI+lar0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzxzhtbLJfOtZrfg8AQgJedWbWpPqugzrYKqxOWQfBl6vA/UD4
	oK0yy1VwKX3CCiSSgQvvyd6mgw5GjQFSj+23t1pJSGJ4R6bivA12QaJZ
X-Gm-Gg: ATEYQzw+och55HK9seeg82gHP0Hwj7NkLFi5JlUwI5VTcJapr/lZWY3NwxSeK97yMM3
	WiOQ6s1KXYU0ylB9GQEA8UoQzaWgZ242Fkd+9dRcFhqoo8olmgDGr4Wty91PlxBopX0jxV9sNB1
	gaYmz17hOV5J7LmeaAa2WBM3qSEfvfmHJgYBobS/y4xea0CBJaYE2/qWB4rIX4w5iRHOrVpZSQg
	ihxXlDzoyIfXG/rQ8QnsOzPD0cjb2BenvRoWKDZJoMh+yDUSstCtSgLhxCyJG2L7Bd5bb8U57CH
	wAs5958ILg87aCJn5VDGO7GmkW9rBcQiGZgOztTbnlapsBgKFwXAUPZo+fpcyYQpqvjp1Y7hGc9
	ZBQvsTfoqM7cP0H1jT5M6eLK4DpYtM1V2nmQEdLUqyELt0yMDBfE4xOy3mblGE8GSPQnRS4v+Ob
	N6UY4fb7pZUUS0c1MdcDqL1P6ESz5d+ZU3A8Ht0vpWjBdzF5g6vDLM8WjOxTG91jDNMw==
X-Received: by 2002:a05:600c:4fc8:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-483c9beaca0mr263703895e9.19.1772464446760;
        Mon, 02 Mar 2026 07:14:06 -0800 (PST)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.235.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e692sm437240265e9.7.2026.03.02.07.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:14:06 -0800 (PST)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 02 Mar 2026 16:13:31 +0100
Subject: [PATCH 10/10] riscv: dts: spacemit: k1-orangepi-rv2: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-orangepi-sd-card-uhs-v1-10-89c219973c0c@gmail.com>
References: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
In-Reply-To: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

Add complete SD card controller support with UHS high-speed modes.

- Enable sdhci0 controller with 4-bit bus width
- Configure card detect GPIO with inversion
- Connect vmmc-supply to buck4 for 3.3V card power
- Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
- Add dual pinctrl states for voltage-dependent pin configuration
- Add AIB register properties for hardware voltage switching
- Support UHS-I SDR25, SDR50, and SDR104 modes

This enables full SD card functionality including high-speed UHS modes
for improved performance.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index 414b03f5e6480f05f5d7eeaaa0afb4e86425ae36..f22f7427b3370a6b6c1cd8360b33efc2a285f8d0 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -140,3 +140,24 @@ sd_vqmmc: aldo1 {
 		};
 	};
 };
+
+&sdhci0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_cfg>;
+	pinctrl-1 = <&mmc1_uhs_cfg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
+	cd-inverted;
+	no-sdio;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&sd_vmmc>;
+	vqmmc-supply = <&sd_vqmmc>;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	spacemit,aib-mmc1-io-reg = <0xD401E81C>;
+	spacemit,apbc-asfar-reg = <0xD4015050>;
+	spacemit,apbc-assar-reg = <0xD4015054>;
+	status = "okay";
+};

-- 
2.53.0

