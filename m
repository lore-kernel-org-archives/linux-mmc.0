Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B9394498
	for <linux-mmc@vger.kernel.org>; Tue,  7 Apr 2026 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550376; cv=none; b=Mo5RZkY8/+cZIMJ8xgSlhSUScVYkM+NzPvF5NuY0tMA2uk2nAZfydPLemytkWC/38Ls4ZcwJRpvCt/alP2Qok8DmU+ZYr1YjC3tCCdqwRSPqoXgws5x+1oxctssHOLADa0OP78/fXN/GKta0NfY9M5aPghVu05FxAeLL32AJtzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550376; c=relaxed/simple;
	bh=KJIzry4A4nurV1BrjZIQd6f00tZQA/BJAngY3gGarwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VXDxI4UmUrwV9Wl0KeMHp30tiBLWLegsobqrmURmXQ3RZ3HRnP/PT8G/Ds5Mo6OH6/cNTF1ubUh4QgfWcJETJsfbUXwin7K1qX+QaZiXkK2RWn+1FmaTpfJRehQWOrKKq5XoqHElm7Zhg5dYZe2Jc19O+vBAX+U6HD+tI7RPov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7F/kaEe; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7F/kaEe"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43cfe71e5d3so4169615f8f.0
        for <linux-mmc@vger.kernel.org>; Tue, 07 Apr 2026 01:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775550373; x=1776155173; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KR1DjVt7yf8BAFWkx8gfMXo+nWfoRdvH9vj0RlDPuXA=;
        b=L7F/kaEe5m64Iagz64rRExv9x0uTrL/aR5iFsS/oWJvFZ5bkc5BNVRPffwQJQHw6ep
         EsuZp32ZlLMtCmYI3Traza3OUzNLFdvtUP94XRrw7qgYayjixVZ+1mqGVYhUdF1FNoEU
         AqRkRu7jyDQWv6TxoOYG7ACQjWWxQUbp6unLrUMLiaVVw17J3lWpC3tq3cuVndcX4/Yk
         Yj/hS5D33qHaRwY+4Ty3/aj+JEQLDn9ZXLsgyRR58F/dMNAMcNA88WUr7779sLtS8fiV
         hoNWDKrrK72zh1VUl5sd893JR7/H8HdGeUIN1+IThKyrHejvEjoegb2xW1gF2YIiNsNg
         zM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775550373; x=1776155173;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KR1DjVt7yf8BAFWkx8gfMXo+nWfoRdvH9vj0RlDPuXA=;
        b=tFI8nmaRrNRPc3+U/peOcf7zTu8OtBOcZJzPn2jXHDCB8fpe24hJKCEb/9jz19Ihlg
         3R8YEOs5trpeHXBTssaYlbQMa3YSJN+REQopVcEPi9VMcR4PzdoFbN80mgtNGW0uAX3I
         Q05jiujoo41wn0lfcWBj7a7VPDZNhxroHY+C35ClfAb8RyBLvgs0sLW/TZhLLnbQfLgg
         15gW7iaQ85dkmHrzbamjim8oFeiXPkhoezVt3IRq/f8arZUhNOAAXpgDSWa2wiqhTSNN
         CF+g8IR7LbuXgigiFMvjcZMvsTQQU6V3onh/MUrhenwJ1BrIjxBGYQkBmsWT9kc12pBx
         HatA==
X-Forwarded-Encrypted: i=1; AJvYcCXErRJqqNMusQ0H2jnD1RYZFhPtLBx3PxLbHaL+W54SeX96pyHu74QQpLXWT3PnkUmpC/k3OHWcrWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFG9QYym4c1Mb6qeP75DWBTWs1JbOPlY6UoFVBSQ36B1odIDpv
	IvRhaZ4Zwuta2aC0kjvUCFRk6NYGqpWT9aC2RGcZdO6g/CWVJqlTaMkd
X-Gm-Gg: AeBDietnC5F11jgcGgui0JV8GiM00n35mQaVJquv2IdIkNbigNLaGry+xvoJYGWJ5nI
	pBUbpmarsOMRPLgjQuOK/d2cGlvwYQ0ePTGMLEx53K0/1vd7bvAfNbKn/wbuyb8Kv1UTvFETcof
	GX+rjGzNVBvHrdS5gcsW5IMSIq4HXzVcBR5HdcF0P/mOUXFrLUVAliOkPBaTSSGz7wFeefPcItV
	qlU7uo5Sf9rbBNbK4In81sNrFBSa5a37+FsqEv3UVF6l3hj/sFRMIyRXePmlmdlNt8ANp+L/68t
	m7E4Ep6Q/G/lkYd0mu6IYMO4IUuNcXOLeme0uzizAr1IjlUByj36y3C3ICS7pdckKcKNZvliNO8
	Z+Rhh0FNjLhyDRIg+ogeCjTlAs55UBanrSEHDcsiM9EG1//QeeL/3WITarCKgpPrQwvf+ogT8/V
	YOUzv+DPbzVUNeKdVknNPahFZ+OgXoe1/rsHubyglJLfRLk7nW1tpt4zEK6wndvfVCebfhxjKVV
	RM=
X-Received: by 2002:a05:6000:18a9:b0:439:c2b6:d5d8 with SMTP id ffacd0b85a97d-43d292db1b2mr22596880f8f.36.1775550372704;
        Tue, 07 Apr 2026 01:26:12 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d29bbsm48669958f8f.21.2026.04.07.01.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:26:12 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Tue, 07 Apr 2026 10:25:27 +0200
Subject: [PATCH v6 7/9] riscv: dts: spacemit: k1-orangepi-rv2: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-orangepi-sd-card-uhs-v6-7-b5b8a1b2bfc8@gmail.com>
References: <20260407-orangepi-sd-card-uhs-v6-0-b5b8a1b2bfc8@gmail.com>
In-Reply-To: <20260407-orangepi-sd-card-uhs-v6-0-b5b8a1b2bfc8@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
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
index 9c417a483f6bad6e60617cf8d5400ca079588726..95cfb4681ced8f539693717e718a3633c35989d5 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -140,3 +140,22 @@ aldo1: aldo1 {
 		};
 	};
 };
+
+&sdhci0 {
+	pinctrl-names = "default", "uhs";
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

