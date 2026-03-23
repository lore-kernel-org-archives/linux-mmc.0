Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AFB38C42D
	for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261180; cv=none; b=uJcMNLgYzxTXwMacsnapEWWj1FePtPqN0k9A3mXpoP0UUjD1pFYKvC+2eZM9S1ct1CpWINdr/w/Nv0Mgtxb9w8HcJUJBPLzpkbTSPDGbmYatmzZYXwQB04pH14Nqy3yZNSid4G9Apl9g+chqA1iA8ntGZmmLfxQjdIgoVVqafx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261180; c=relaxed/simple;
	bh=UQ7f01+3cOZP1rigv0i6MWf6GRkDoBBSKgBLPigIAzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SrCGhgj0hGMoDCarTOgW6LmozV6LMYtuDM5rv33JoRRNMrBBVvSOMm3WpgEkIwExFXb6uNxRKaHf969wRsUKtjT9EfDzHiAZwEVKw4MewGb2wZ6WXJhVitPmk9LqNdQFmQqXceOrayS960UNfLY1RxhRJEQa2UvG2zwAyr8axo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2AappYE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2AappYE"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-482f454be5bso46402685e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 03:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774261178; x=1774865978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzM6tXzzJeFaZBA5QZ0/60M4eJdHh0h1cI1z3A71Evc=;
        b=c2AappYERkdb0kOFozvjaut8/5qe5/o8cvfVHy5powY3vPBgKxyRqO6tlFoJRnSo8R
         jDROj1TIJFbBHbifMLKSE1SOqry87FwUUIvClq9cO90QDvJEr9+3fn4Be5p12S7mSFlG
         ZYEFDCwKIokCA+UBWu2LZd2NOv+HMEYewbBcpCdR0UsC6h3mB7lea9r5qi3s5ebDX2QE
         NtsxFr/f65IqM4iBvXG5E+pWlVrqdaI3tNzbok2VJ/e99bdynCHTy7VNQvrgPRpzfJG5
         /PEfR4BgQ7fFepIQe7pmOrKy4dLsfXGE2LqCGEO3s6TMhTbZbDc+7oS3gogu1WtfUCl1
         Z9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774261178; x=1774865978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LzM6tXzzJeFaZBA5QZ0/60M4eJdHh0h1cI1z3A71Evc=;
        b=Z80IMNo6KpJxUCRKyNR9bw9YYkZcJU4dphKHoNt+sAK/TdJvxFTdib36pY6Y2vdT+q
         d5dfjMT4oFpPGgBYILE7Gnsoo2NKtVdQVqkaDofT0Loe0JCeFbJiEXUcOomKlBteQ/R2
         b6mNwZiMzfy4ycbXvGRpanBIN8hi55v0Ndh4oirv0VpLouI6wA0oqrdoFgp7YTknebS8
         tDtk6gN3YaW5jWWwKUFismWPO0k/8J+u1cHtfR1cXltVuhw4nq+R9sE6RjioaNpQKJrq
         Q/jCpUaPcL+WjFW+JCHZlWvIs6KfDkE7jpeIrBYNKMtxHsCx2VQ6cRt9sd3A8FdQAVml
         5ljw==
X-Forwarded-Encrypted: i=1; AJvYcCVnCgtD/11YbT6FXpF7Xv+hIKqsQdnZWG+1+cNNOcIec4uuYSbGgXhB9yFSUola0664cRjL5BX7FVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUBEKT6qCGZNSkBpc7lb2ECfeq8vry9NmwCUoeqhajRYVstx+T
	pblfDN/owL7fdg4WmUoOOJNOt5k0Jq0Gri+p9j/ihjAasFzVEXo507PF
X-Gm-Gg: ATEYQzw7u1RkCSgO8GfxDMRrTsyXHDZ9obueQiKsMBt/i0gY8fUmRLxFMmzDFKADlWZ
	ktTzxsWBlySED0UZkLMZZ8AiOgHogXUyBbGMujm72vlhKstqqzvsjKt0IL3UQcnf1uHkpQ+co15
	yu1cdbYsklxVpI8gVTBhBII+Vjx5OX0V0ss38cJqmeMt184LHPvl8vR4OgWLwvlSErGXLkQI8eL
	S2P0VVZZe47z/CCUkknJNlCxyGArV3ZVYm5oxD1KIJX6QSL8B7lRbasjHg8h+X1Y3y9mIaqvih7
	F7mh33H12Wh2iYl4Whut6zckhZvCU44RrHxMVrbdINU1mWKxuhfMWSOoBpEOZuidIuYP3Acisiz
	TowmkHgH9xkAnd2UuRx/jbAxMRrygwVEgLE1wvxjsN4HQx7j3Arx5WGdkVx0UGoHip3QZB6uvnm
	wXN5v3JKCqdNUTJotFPe8EbhMGZaDwwFumOQLjFIuh9P/nVtxF4A02afkrfJY8yJuUbW0YQmPg2
	lE=
X-Received: by 2002:a05:600c:1e0d:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-486fe8efb0amr191701715e9.13.1774261177699;
        Mon, 23 Mar 2026 03:19:37 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.232.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe86acb0sm78755445e9.6.2026.03.23.03.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:19:37 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 23 Mar 2026 11:19:08 +0100
Subject: [PATCH v4 5/8] riscv: dts: spacemit: k1-orangepi-rv2: add PMIC and
 power infrastructure
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-orangepi-sd-card-uhs-v4-5-567c9775fd0e@gmail.com>
References: <20260323-orangepi-sd-card-uhs-v4-0-567c9775fd0e@gmail.com>
In-Reply-To: <20260323-orangepi-sd-card-uhs-v4-0-567c9775fd0e@gmail.com>
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

Add Spacemit P1 PMIC configuration and board power infrastructure for
voltage regulation support.

- Add board power regulators (12V input, 4V rail)
- Enable I2C8 for PMIC communication
- Configure PMIC with buck4 (vmmc) and aldo1 (vqmmc) regulators
- Set up regulator constraints for SD card operation

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 48 ++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index 7b7331cb3c726f11d597f81917f3a3f5fc21e1b9..9c417a483f6bad6e60617cf8d5400ca079588726 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -19,6 +19,25 @@ aliases {
 		ethernet1 = &eth1;
 	};
 
+	reg_dc_in: dc-in-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_in_5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_vcc_4v: vcc-4v {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_4v";
+		regulator-min-microvolt = <4000000>;
+		regulator-max-microvolt = <4000000>;
+		regulator-boot-on;
+		regulator-always-on;
+		vin-supply = <&reg_dc_in>;
+	};
+
 	chosen {
 		stdout-path = "serial0";
 	};
@@ -92,3 +111,32 @@ &uart0 {
 	pinctrl-0 = <&uart0_2_cfg>;
 	status = "okay";
 };
+
+&i2c8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c8_cfg>;
+	status = "okay";
+
+	pmic@41 {
+		compatible = "spacemit,p1";
+		reg = <0x41>;
+		interrupts = <64>;
+		vin-supply = <&reg_vcc_4v>;
+
+		regulators {
+			buck4: buck4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			aldo1: aldo1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};

-- 
2.53.0

