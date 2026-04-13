Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A402E3A6EFD
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067372; cv=none; b=RY3MzXiqOvCPrTt7hvYzWLS2mWFDOkSRKbP269d4EUDw5jOdF88UTXc1g5qFz/OabutRyCbeiLgd9JWtmP+wwfJl420tOfQG309w0QSwMB1FfyEXp67Y8DeoVNzo71IilcDAfaHpDOnkBwKFgXkQ1UPM7LUyUXPLkNfg2Zoztkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067372; c=relaxed/simple;
	bh=1HbIW6/OtwG0nzFhm8AN7DBXkGaNxAyxn8jiZchQifc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jXW95GPGIe6J0DEaen701atUDimaeRATeaSQ0vzK5C4uC0ae7NH5FvDabotWe8DZrFclYevQaUfw64XFeiwd/XORb5kzb/PQlFoxBD3rLmebyJMByBiaXmG6FmDL6sYk1Sgt/mhMfVazbJ7ZQ3YXSd9BLj5DPWqIAIB/o09hdeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apKxG8du; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apKxG8du"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b93698bb57aso738680166b.0
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 01:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776067369; x=1776672169; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgUUdQtr/fVKD3Ff4J9UbF4I4wxaToLEFfaMYOrzMgY=;
        b=apKxG8dua0+Xga190aQvovpy84ZW1N7XuS0EZ9F64/AMHegbb4oFTKbX69WS7D5mn7
         6Vd76Xt+CXqH4cj+U5N61mECmrCXXZgZ6f8ZtwdUHYpv25ckeFwqDIVNFw4foU2dakXY
         u5ZxpNYFbUSGeSEiMOsae5UmPboCydpU+emSThEor0ezhcigZ2Ia5FELCtHOYWUQbi72
         XXmdwrKjDkoiVB1o99EaM+NgEWK1+D84S/4U5fgN2//YJEGdTK72I8td682Gx7veJ5wk
         8HsdCWjlO1rOO00KBVGd20WSKAcaypoIT1Zt4oKr19tuiBHgcwu7vG8WKspQQPQkMd94
         UbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776067369; x=1776672169;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jgUUdQtr/fVKD3Ff4J9UbF4I4wxaToLEFfaMYOrzMgY=;
        b=n6JUUOAcGvqGT6PlLg3I7hGBmqM4it3xJqbIOWW2d7k5MSsKKE3P/bwFgbEYoycqJ0
         66uEm4Ef+P14d/gQQU3i+O6jhgcDnAdyXW74d7eYSmnnZ/+ySQUCzhdzfjN0FnifxChQ
         T/VvygX+R0B4hED/RJbLafMdXmHZPboB6lt0DCpdK9zQnHHhHCFbnQ2Md7bkiguFPVaZ
         1FL+nhizJXzgbBtuXks+RQ8VdJ1ToOKfIiHgnlQz8j084a+rtW23IKGPewSGPLTS7smw
         d6siL2ku7+XKT7dXG3L0xA1LoeaZ6CjCBtF5/lE7dkKkKdDo46WKsRNlrL3SGRMcXOkT
         vidQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9CLL6XN3EydpjyBDSP5hqbg9b4MnCLJokZ8yxFgD0SZ87gUeDp0Vzp+V6WfOi/i9c1dJa3JH+GL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC3g1qf05RqUq2X0U5hGqMiWl4noF+H5J+xlOid83P9GS/ZClr
	n23ATro0FsfUTblcdudWXMfTDfYOgNEtrp2we9P7un1dOVvQEsQKv8ke
X-Gm-Gg: AeBDies+OMsBDdsV/5eNuSv9TWcFK2sXKu1rej2S3KNJzTnToXYPISvxOur1UTx+r8y
	E0GFzhKAhR9Bg+pWYJqJdV0crBdeJvCHSLMA4CwGoIstWK+f1oXN39PzquecwDo7JCQBbq4J5Yz
	XPUicllOB3KeN2jLi/dlB9PxSEKBlx5/NJYqfoK2sdLwiaDWHWz3Y0T5XcdTUhoxC20vgITZIKk
	3kmneLl6Grl1NdHtV8LMjTVd+Ysb7n/Bg8wWTA3nrecPPj2SILfhhkctplVa0ogq3fJ+lb9kUes
	JA0dlhyJkwLCCW9Du6mTgpVh2HMnd2S/a48n1gSnGMvI3UrJ4JiqrdQ3/RAMAeCYyDp9bOkXpvU
	z/MQNBNH5flVjUlTck7wfI+eNPAqqNbyHOvh6ml5wRcgUmrpZ1vU+fKhji60C1htTLRdKlgt8eq
	X155tUE6VNua/RS70FukfZpXWaH6gf3ZPqXUGz1oVGl3qElqgazNODkEt0ReSTm8TJeJxDpj4YD
	Zs=
X-Received: by 2002:a17:907:60cf:b0:b98:8494:3174 with SMTP id a640c23a62f3a-b9d46265d98mr798014566b.24.1776067368357;
        Mon, 13 Apr 2026 01:02:48 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm32155932f8f.33.2026.04.13.01.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:02:47 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 13 Apr 2026 10:02:16 +0200
Subject: [PATCH v8 7/9] riscv: dts: spacemit: k1-orangepi-rv2: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-orangepi-sd-card-uhs-v8-7-c21c40ec16d0@gmail.com>
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
In-Reply-To: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
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
 Trevor Gamblin <tgamblin@baylibre.com>, Vincent Legoll <legoll@online.fr>
X-Mailer: b4 0.14.3

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
Tested-by: Vincent Legoll <legoll@online.fr>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index 9c417a483f6b..95cfb4681ced 100644
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

