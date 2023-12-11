Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fESYPOZq"
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37F9F3
	for <linux-mmc@vger.kernel.org>; Mon, 11 Dec 2023 00:58:37 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c3fe6c08fso18461095e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 Dec 2023 00:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702285116; x=1702889916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xndb3S0aJ33QuSezQAhJtJok3tQar4xBD7H+FypbxGQ=;
        b=fESYPOZqQRo4exK22pcFuRV9GYGoEGUAE32whSmB9c341eUJQVGCSPY9z/qllqQl+I
         kpGlYxYuah0edkqZoxIFHUt9CYp8cBP1eQyl1RvkyMreaywc3jtbQfWowofwnrTQPa+H
         Z5SUMayA3XGNttxsXLjYJckZl+36jxkysSaIfZtylsu43WaIKehJrR8LvEHeXPhfCJ1+
         NCaXYp1UTxvQrI8Qj9+gSkamq6NzeD+ldbJ6uB7vb3VCefRbwpsfwjCgn1L6R26rMCjL
         wJ81gE4xuNmKv6KAJQAsNNkT7o3GO/SyhBvPy78417v6UYL0eBauHf4gdUY+RGMXTlbl
         L5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702285116; x=1702889916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xndb3S0aJ33QuSezQAhJtJok3tQar4xBD7H+FypbxGQ=;
        b=wh2lJCBwOMQY8X1wLjvlFo+mBYehh0YVb3A/j4JywuJFf5ZBMMcR0oCTFhwbI4wIaI
         wnc3gUBkqOD0A+T1NnDo61kip9pqOlgPgzgYOO3S78sEeq0pJ/a7Ytjkiy/CF6rmJHCP
         DV+41OOOpXt+kmT1XCALbz7xCGwdUDPGGe5RT9BHlVGxjJrVCzEtrxmn9d709X0JIWcl
         5JeXygNIefBvzeGiwMrGflMqXubznvs+L+fj757dDistJT8DVUG5iqR0C7OTN48KraQ5
         a0fSwG76nWvyg+CMXhj6xiYbfkBMXj1QVQU775gRi2nyJoy3qurQ+P8glHqXH5jPWEH/
         msFA==
X-Gm-Message-State: AOJu0YwLlaiY4UrmbkqgRYMucrQvV7miZPWwVEiYcnBgAdmqo+MQOWsT
	r2x0dxApgOwxKTnz9MChI2Frvg==
X-Google-Smtp-Source: AGHT+IFj7nAJyqu+vNt9O5FvQS/Z/HfcaRXMdNaRLjM9frtJGn8AOK1htzp5C1UgMbr5OAVzW2Flfw==
X-Received: by 2002:a05:600c:2184:b0:40b:5e21:c5af with SMTP id e4-20020a05600c218400b0040b5e21c5afmr1423973wme.125.1702285116186;
        Mon, 11 Dec 2023 00:58:36 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id fl9-20020a05600c0b8900b0040b43da0bbasm12315067wmb.30.2023.12.11.00.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 00:58:35 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 3/3] arm64: dts: qcom: ipq8074: add dedicated SDHCI compatible
Date: Mon, 11 Dec 2023 09:58:30 +0100
Message-Id: <20231211085830.25380-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211085830.25380-1-krzysztof.kozlowski@linaro.org>
References: <20231211085830.25380-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dedicated compatible for the SDHCI MMC controller, because usage of
generic qcom,sdhci-msm-v4 compatible alone is deprecated.

Cc: Chukun Pan <amadeus@jmu.edu.cn>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index dca7005c0a9d..915c22b0f270 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -400,7 +400,7 @@ spmi_bus: spmi@200f000 {
 		};
 
 		sdhc_1: mmc@7824900 {
-			compatible = "qcom,sdhci-msm-v4";
+			compatible = "qcom,ipq8074-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x7824900 0x500>, <0x7824000 0x800>;
 			reg-names = "hc", "core";
 
-- 
2.34.1

