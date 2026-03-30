Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2516B3B3BED
	for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2026 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859919; cv=none; b=ikS3wuJF8Rdz5jIwSZEETkimbufFkH/6IrBw0Imf9lWoQyGpnH+j+iPsC17u4CkSjksLBDbsDlT3LX3iWMVd35gXyb4r33d4i2N4WNX0Bd0uDpoL45W57UHsZZx4e2zw3eylLtccgT+oI4gt69gbRfq9W9Ay8w9PCjOcoyi6LV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859919; c=relaxed/simple;
	bh=0EFZ53q2XAEQCbsr9UzobauZinI9NCe/+PQ0fxu05PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NYXQZNsDVwDJCDLVP9TT/Sl99FPZ4WqC8DOYKrx4Uon49fsLfctRCXaL5gQsMyGxYfxKCODRxnMDNngbsMphmT5EtJx+/qx/30bRXgSZDZgYxvVw9wNZVNtz3SmyKFbsZS2J+xi1AwCatC7Km+3oCMFq8TIyqDzUVge5pe8LSiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnMcNEiF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnMcNEiF"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4870206f73bso25047375e9.3
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2026 01:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774859916; x=1775464716; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LbwR62Ox4pP35TzcC1/kMlb8rYdhZytDukagY2Rkq4=;
        b=dnMcNEiFeYrIQil/90dVJ2OKaDAY5lqJiAhtTrAjNq4i5SkOn8H+Izj7JNnTJl6nRA
         NE7ludU0HQyEr/Djbzrp60tfXFJR5v6Z87WwmUOooftBHt97U38w9bk1l4I9cB7MQcug
         G+UDGzsHzyUAp/rb6rvzn2ON9z4To7kjfidEIP8cBOe7kwO/A24syOHPoCLVLmerohJo
         IiV6zZkBOd+pQ114/ECIgXSl4n5LwBZxJJ7RAotTGuT43hhX7Vox3J81DpysEaJoTNaF
         vPvH3b53Z7kliIhtoFnpfs/7g8w7yPE3orx6KnKCOinPywzHPIo/JHihGeyho0YGwgHF
         GKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859916; x=1775464716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1LbwR62Ox4pP35TzcC1/kMlb8rYdhZytDukagY2Rkq4=;
        b=SAQW08Imilps5EapJIP632tyPfCX5+WnU8Lbmw5mLliaaPOeZtwG3AmUzCV7SszOft
         OJruo0hWuuO3nPH1Md7JHiqc2UDIwIdBYeKhQOrS+D8CFpTPdZgXLrVDu+00qHJPFSGI
         BZe61OwL3wikv127bVjHD1XE5jxfdZfHTlyf+3m4811pef/50/ucBuvaG71hjObz1kh/
         Gtq0eGk2J1D3Igb0FmORfdVHOfCpc4HIZ6E7xwdugjaf4UDbmmqZwYSUjCMJl0vXiKlM
         TQVKLj9C/rQQ32fgwABiF9j9PubM3sWixXmVQHR27gkjBAYm+obEKzruvtyie3qsv/xU
         Xbbw==
X-Forwarded-Encrypted: i=1; AJvYcCWaV0GyBsQ6WPFd1lHIvR5C0GL1mi4EOTk+Zeg0iEeO22onJGbSA/dO9XcOciYVEb8GGAV/sTB3KW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAwM8I0SMc0dcbcu6E5s7kuJ+EtwIiXuMrytloo1/VVAouUEhu
	ZA1nRYYL3KYYkulFkmfcO+sUbBLZDqNW4MYnWQi96avQqL1m8XIzAvf2
X-Gm-Gg: ATEYQzzNs422GgThsWuoZ2fwlQmM59g0y/ELkJTRkhqTVoSgu/QKdbsn8pZXHaW/74k
	bd42Fe7/MDy5IW6XIaqnXrR6n/RjR1FS6DWOC1KVqkLJxgNIsj24CcSPwS4Ymphx/4fQsbbvFhY
	RxpLoLKyuxFRNuuKnKFiYoH2a4GshIVLsT1YBp4yurfUZqb6I20EyLjzxJ+R7Vn60pNAKrZ3LyA
	pzZxsylltpQasG+RvRyCYcnpS6d5bRJ5wf4uZmeVHrHgPS+eNOnerSDJbKuoKdEQmS+jUUeMbZB
	jdAvZT32YMQkrENsoxsf/caOIx2+VkmpvfdlM/tfnG74Pf8rAGcKHTTBv1xkP1evmcQs8BtXx8b
	2sT9L9ey8YNSuwkutR5z+nYQ4kaZ+4YGLMZPbeuouzOOpeNqCOR8SFVMggZt8VF1KS9XXCVd8hB
	rx4eEgeYfrpKhd2MX7+tj3nh2lAAWaqdpL0AmKDlh73uMkfSGz1PoNJvtqpS2KIguB
X-Received: by 2002:a05:600c:5249:b0:487:386:3714 with SMTP id 5b1f17b1804b1-48727f7bb08mr213736895e9.17.1774859915529;
        Mon, 30 Mar 2026 01:38:35 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.232.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872712c236sm74063315e9.14.2026.03.30.01.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:38:35 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 30 Mar 2026 10:38:08 +0200
Subject: [PATCH v5 7/9] riscv: dts: spacemit: k1-orangepi-rv2: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-orangepi-sd-card-uhs-v5-7-bd853604322d@gmail.com>
References: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
In-Reply-To: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
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
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
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

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
Tested-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index 9c417a483f6bad6e60617cf8d5400ca079588726..5f823611c969eb0e15546862228ae4f65375675a 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -140,3 +140,22 @@ aldo1: aldo1 {
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
+	vmmc-supply = <&buck4>;
+	vqmmc-supply = <&aldo1>;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};

-- 
2.53.0

