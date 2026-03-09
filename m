Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99403A962D
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056444; cv=none; b=Bdrr2Hei7eLJASMD2adL5a4L9juvh26sSpJn29AvH6UxyINKQP3orhPdcf3ICYjUCqEsT7RhOlfdCW/dLlcS/kw+bMg1My18og/VKbcSIB8zHcHlQfdDPq8fju1X3Fd9K51HaDFj09vnPB3PXiZUzNcuEz+MLTd/NzgVNp5a0Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056444; c=relaxed/simple;
	bh=JfN8DfHHQxhwjIM1D93NxIpzHPkcFqd9tyZUtqUCLT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=metfAzJGmjXgpZfYfXPXaSC+Py7/45Xge+cia8Bo0DBcBeoxLMgBT1vVQxMCIwk8nEaj55V66+PUATtS9zkhX+ITJYpUdCT8oJs76xA5XV7JVVxyjKxbLJrlHR+o8KS8joKOJAuacwLvhSwBeb5U4BLcA/f+ypjmc6rlV9JlFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcnV2Fva; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcnV2Fva"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so1529281f8f.2
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 04:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773056441; x=1773661241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njsRP4EImn90P32g9UPmNNWBlL1/zM1gb0xUIcz/r+Q=;
        b=FcnV2FvarKhQyFysWmhzj4pSQNkaUgVhuh0J9NmTYb98sNIfQFwL7vdvrF2ouSs+dv
         j6FPhXyruE+TE3nOneEWUPgRKqwx5eIdJI0NmnHb2bq/mSuznMzbuFQtt8bceRI4s0yr
         6rXR9yTrMqFglK1o9IM8JISZxXguY+jVU8Q8SQnOTsjxyftkCXXj9DWYOW+bsNyQOXUD
         CX6iqIdsWMj3um8IYyYVxusluzpZlZt8dkEItAxHytuM2jJ5WZ6ZNMcdoAMV8CECQPfv
         ft93pZJczpHJoc1fraJl/C1RW/WDavEeqWyASnbXKiwRhZICBOoN8K7NSZRtBrVAQ0lH
         zqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773056441; x=1773661241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=njsRP4EImn90P32g9UPmNNWBlL1/zM1gb0xUIcz/r+Q=;
        b=Pk7KUkhWcIdGGguO4oLrgPxJVh7LofbzFEJZQw0Yvo1+o89hzv7uca3PfGMGcNV/+D
         cFzRhfvRy5SQwMHCBzzipcLO9/bCRMkfpxdRbsAzTgd5Sld8G0fPGvWIVnkRCa032ewk
         lB6ePbFblPl9cuRYY2bTgQ7HiAqBiIhSNnf9lG26+M00YWTve/lQ2pya2jcDpjf3Oq8t
         17sai/v5eM8GFRxS4fKEFRRhbXMUEf6qOeR/xPDf/UzSF8NlbWWQBuOmhlVJnxzKhdw6
         NRzo8sR2cihHL17RXNfCekjBghmZjdlyFGpSrAkIIp6d+OJlngrm4Er8BXO0f2FX0GWi
         bgEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/X7QiwqTjAP6whDHbMVSaz2S6ImU2iQcpAzGkea9weW0K5t85h9vaqqa0ZSJHBwsMV8ypy0kJYcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGcQySwl9C9zxWlm0CWeG2njzmBMdzzWAsNiYF88rK1ngkA/oz
	BwvKQ3lAnsUWwIE4MrOXRy+Oky/1W9G5h+C26syE89RkxvVsW8tNUpDi
X-Gm-Gg: ATEYQzx8Cmm1g/jwXIT+J8YlC8AmtqueVGeM3rIk4yOIu+cUpWTGMJaa6jxVNME/Efy
	JMQKWzd//ZRJnxYtIY+OKpY41eyIKgglqGOMru8QLSXw9M1t2w1eqfA0XKmWhW171W10wQyuok0
	2rQutqTmJHEw2mTgrwI6hRxbevCYGjfInT/kcDVGJ863HvPeEOtnTQjXeBrwAAEv2OTYit1SWLF
	MZYvjPtHEuHUTjF6KPo5JcApNOtzjn9lWrRgnnp4j7dlzt0BvsnNkovCuQU6cd16URYzKeX5U11
	MmJuRrCq1IFmGGrnSdIQ1k8JlBMS9E4K0pSgE3KEtoGQCi22wXyO3sSsjCO1OjMq0itYh233nK+
	femrMG/Ryw33rSNX4Y4N21wzX4DQrf/tjtK7UdtF/ASV6YXDSmwZsHhAFdyXc5ZzrbeY7Su8X2W
	GZUAa48iBfI15UjOu5sQwPpHcxb7YMgzAS9wPrZgSNlhBiTNYPx4al/QClrKX1J1xw
X-Received: by 2002:a05:6000:61e:b0:439:c18f:5aaf with SMTP id ffacd0b85a97d-439da67bf28mr20283499f8f.34.1773056441001;
        Mon, 09 Mar 2026 04:40:41 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.236.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8ec97sm28471699f8f.5.2026.03.09.04.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:40:40 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 09 Mar 2026 12:40:17 +0100
Subject: [PATCH v2 7/7] riscv: dts: spacemit: k1-orangepi-rv2: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-orangepi-sd-card-uhs-v2-7-5bb2b574df5d@gmail.com>
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
In-Reply-To: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
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
- Support UHS-I SDR25, SDR50, and SDR104 modes

This enables full SD card functionality including high-speed UHS modes
for improved performance.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index 414b03f5e6480f05f5d7eeaaa0afb4e86425ae36..361135269801f436703b6f1d768c91325a52f07f 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -140,3 +140,22 @@ sd_vqmmc: aldo1 {
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
+	no-mmc;
+	no-sdio;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&sd_vmmc>;
+	vqmmc-supply = <&sd_vqmmc>;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};

-- 
2.53.0

