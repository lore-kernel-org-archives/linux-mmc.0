Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183CF2EF287
	for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843411; cv=none; b=gJIcAdinFHTRiEG9RuZlFLzlq3258QqUGaEkhXlUFH4i25c+YnWynOidMYAPnpeZ5GVHHcgKy7LCG4lg+ZW7XnGlc624NXyaZxOOKuPABiJ2Xw5P4OQl/09XBbbtGHv7WJGRE1+ZR9FOMfD7Qnr9ia3v02fZQmFFz/cRo7N+bcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843411; c=relaxed/simple;
	bh=9mNvIjwX0GVg9+8QJn8ze4jldqNBVe9LJDYJHk6E7+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S+zssc2bvu0A6ypX2kWUFY4L4WtmQtGDozALcnL7AmpGEPLN5QiK6v0LX4kFBlmNAoDOf/LkSJecwHJzFKfBwHL86aDhk2WELD3WayEC+MxXKsraG1cGNnpWTNoTOVuLkKiDDP/iSk/xEHum+dSYEJYXe7FcqbXHnmmHzy+ucV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=niQJ8xYS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="niQJ8xYS"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so2468771a12.3
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 02:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843399; x=1751448199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3nipzKoLXU+khkgMT/iFK8MpGbKtAwTRvPNEeh+QTo=;
        b=niQJ8xYSkVwf+6xQsuuqZR5H6ES5aY8g9hs1GIGBhSdSVk4r07+N7nxdeoBrSIQEiQ
         a/KLk4+xMFs/rNSTKcrzTqgzhYoOwCh2jzVvKpYBQxRQOxZad1ZDGSCxE0FLSqaR9sFA
         E2Key73LclGtxtjAJfaNAX6BjxvMOKy6iCSkDqUjQR+QTbCdAsPMFITOGyJ8wC3418Xz
         SOgig9vE0ZMCGpNyMyE2Hwtg7BhUvr2sjuUI4zOD3zTnNHRD3fTpR8RKrvFxY65VUlTR
         60WRWGHawqTHZ0viLDD3LwzrcRb0qT1hQQWcpx4zit7kfq1+Hi27FsYYh5OM3obNT0bW
         UP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843399; x=1751448199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3nipzKoLXU+khkgMT/iFK8MpGbKtAwTRvPNEeh+QTo=;
        b=CjafZcQwqvTp6kVfmKvBqzQ8xS4512tPrdvhtTaeRfUfdtboSYiWNX3S+N+WMxhewL
         55SB321UP6vVRRerWtkiDF6wwjTCiWykVrE4RhorpNB9jf1XLLm1kZMv5oPj5Rx6Tzem
         lAMun6AA1G5DdhnwDEWrVNYiJdo3ds2Or/+5tl6F66XzFccmoWTkI7odgWiHeQfiCKt8
         pM8n0r8oIXUM3aHHvLVCmgxrxgRE4b4l27e21GlknHKDC2+oRjq4o+nVnClvatqgPs3u
         PYi+umsjWETnLDrTqREXF/TlSpxGx1l3E238I5H2ouN9O8byEu2nervOinoa2WKazwJa
         5pYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoe8byXUsLtc6zdE+91bavPMvkkahJy37MNufDHrXFrh+vlCFXabe7PKJwsv9QjXp2aVS/DyaWLRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxoh2nEQwiJ+zU45pZHw5zQF8YuoMCZq42OJfLoalu4QnKfXuy
	7V6tJHTQjgQ0WwXZkIFYgg0W0u0KqvM3wEJdA2C6I6Nt5Hppo391RlSlyfAuIiFh4yY=
X-Gm-Gg: ASbGncvIAUZwlwxot/QL3ZVoHKzauIu2SEq1ff98YN39JUmfo4GwVMC9V5y+xp0XZN9
	GVFkJ+C7+lXUKQv22UEb7AYEXzs3KT199MFbPeoxk/tZ+G/xw+JVCI8zph4LZZ3YHI2Mrd/d+E1
	Fte7jNYYCUC8wyrTZo/u57ErmL/4Tf4Intuk1MQR6BUskUesKLcS2PqDUX0x2ELuqLdv2rNw0mN
	hYKGm/UyTPqgXZdplzGURPqICpzC3/MS4R3G4mZPe/ucUef1+dyWzID1wDSYb63jjIVtq9EzRtR
	r3vxoen8dbaZBLceeS/KapOgFqoMZv17I9bsbpjbiNqWms9W07KafkWBHDag/UfknPCoVNy7Kxq
	ZDyrejcPfqln29AImvbWw7LaxPNPwuYAL
X-Google-Smtp-Source: AGHT+IGVifY90ul/kd9o3o6inz9kogKyytkNR1Mkk0jMmIxV8Ntq/CDmQ5WF/k7Z2pC/kCZPojhuLA==
X-Received: by 2002:a17:907:1c0a:b0:ae0:ca8e:5561 with SMTP id a640c23a62f3a-ae0ca8e5732mr22602266b.13.1750843398619;
        Wed, 25 Jun 2025 02:23:18 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:18 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:05 +0200
Subject: [PATCH 10/14] dt-bindings: mmc: sdhci-msm: document the SM7635
 SDHCI Controller
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-10-d9cd322eac1b@fairphone.com>
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=849;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=9mNvIjwX0GVg9+8QJn8ze4jldqNBVe9LJDYJHk6E7+Y=;
 b=ffd4klj28huseDrq2t0Ois6nd1kBF/j9T3yy2ZWpgFwV8hBk7iSpc/UKSVR/3ZIG3wkyYCYpY
 +TzW/dweg55BSVxNB51nndNlAVdd6s43fdl8zY73JdwEi8CKF8/opnC
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the SDHCI Controller on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 2b2cbce2458b70b96b98c042109b10ead26e2291..bde69ee1554642b8c2ed74b1fa0f68b421d7d64e 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -61,6 +61,7 @@ properties:
               - qcom,sm6350-sdhci
               - qcom,sm6375-sdhci
               - qcom,sm7150-sdhci
+              - qcom,sm7635-sdhci
               - qcom,sm8150-sdhci
               - qcom,sm8250-sdhci
               - qcom,sm8350-sdhci

-- 
2.50.0

