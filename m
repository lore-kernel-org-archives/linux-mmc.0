Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84221E5219
	for <linux-mmc@vger.kernel.org>; Sun, 13 Jul 2025 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752393976; cv=none; b=A6etwirLQohIHmuuHU7l8dyoycOp8Sj7x5LnBepBH6wy+zd6RF4dYZoVQRAi+FZK2LlZWkSlr9IiY2z6cp/cisftdaUDMfzzMoFJBBYkpud71F1QMf4QreOqR6PwSMkq8AesEmINNLZwNg5v+pPWu405XIgIQLsa6/lBFUmgPxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752393976; c=relaxed/simple;
	bh=nbSwp5ROysMSTLKLxq6Pg7q3VCWJ3MFGpodgkXirdrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bHYUcFfiXvhkt2uWoBRA6rFLA86pv3BL7CGMyNTeUn8oRKSLH7QUb5ivD2SEBlmLlxxDnefsBDdQn6tJZ1Gr8aCRwUlvMvx4UqZcNa4xbY5A3RXOC2O8fs5ZUDn6zBfIphNXcHzvN/3g6NBBEUymKk/G+TaOIQ2eVa0i70yDitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=dNQVvhcd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="dNQVvhcd"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b45edf2303so2982631f8f.2
        for <linux-mmc@vger.kernel.org>; Sun, 13 Jul 2025 01:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752393973; x=1752998773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjkVBqGocvldr3+5pDfPNG/mAD5wl5azsqsATuuDVzU=;
        b=dNQVvhcdTYxNi3jJkFCbONfvWJSR48ZWbzFhlfnHutB0yhV4nnuzWie5e9/sSx5gO4
         yRG98lDnyRgOVGpWyF49y0eafQ8YTyw8E40wm9stpMKN8weoLvkpKXqpFz7H8Oazydx2
         DYFaBGHuk+Vr71FCru6Zp0xdhW38gA9jxQT2j/Frer0BceEoAhMs+GWZEcOyWLsHLUfJ
         4dpCPhiTvE8JS7IsNDu6rEkJc3INlzYLHte04NsgINqP4pYa1y5yZkC1q1UZS7ctiLEb
         efbK1ULXRMtX1b5pnvZLqv3tArnOhhIVhxUSFkvUFfZdGPrZ6cAZ7wlA6eimmirKibc5
         ZDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752393973; x=1752998773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjkVBqGocvldr3+5pDfPNG/mAD5wl5azsqsATuuDVzU=;
        b=c8E0Pm9YJAQY0wSIxWT8CtiZLxqdWdovv3QgqdAVqTnF7cOcxkH6XrfMIO774J+29d
         D2G2xxTJbXoPumAy19jj2F9yFcBgaI5l3hr1gs4ctatvved8LuHJJgBOo7r8UE3wBti3
         Xqa6UX3FQ4bkRJL6JVB2yJz6BIbAEoWczHYJDPTc8QmUY+mj9qokGZp4mayslIehs600
         zPbjqNdOrL+DtUPW+m0by4Aw2yAGRtbXtoMpu40o+tyGt+sjPQlbeprm7x7ObECBnSgY
         q/kh1ixB6MsuLfqnQSbS8kqv8J9JYnpk7AieAU/KvXW2z52Uwe65wtKW1zfyrPgFHa2h
         2wng==
X-Forwarded-Encrypted: i=1; AJvYcCUam5t95+SWeNEHXS3CnqbE+qCUD92Do7AdEnpm4o8lp44zHcORoTGYgrqeiLa4x+0UuhhSOzEP3X4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3RTEoIox00dtWPQeGeMmgxGCyuEf5t0vSDi/XeYK4qdav2zd4
	RaIpwSkcw0Z8DxuEgYTeQs0EOnzUH96/63h0isLYxv5dpVr27136YPK77EFTLleEpFI=
X-Gm-Gg: ASbGncsGN94QwvqD/RmlLpKdRFkKvhOETkLhs9Bks7ep/+C22cv+PA/FxZVEnp+VVIt
	oevC+83K5G/Kdn4/+mEEpVPzUwbj3Glc9SRPHOboTTUhuiAVTqRVyOvfbXahNeQqADmlIvi1dxi
	zh9YyKqwWFTnkp2iWr67LShAf/VVDMpgf5qubkXaxMivX3ee7s2zh6zurjmbabauy5Q+7zwm96q
	PXdSrrm5iJ+Zrqctw3rzex/CoVMLr7P3WhIRoKVKdpedxkDWfQwKJJaZ18bNfuwvJXpQD+HfK2W
	YhhQDmcco4XA0YVg4N9ZlxRokt2IGaPJc2G8JO+4FqTRyL9aDa1BssOAezB63aBHT5+zP+XoOYv
	1eggPKSLslsGKMUERe6/Hui1bd0hXgQbbIPAB
X-Google-Smtp-Source: AGHT+IE7aiBW0y1UJWTkFw2jo19wh2kKOFls92CeELkcuzfmOFh/b4a0X3Mbc9B6RVDds+HgM7Z+rg==
X-Received: by 2002:a05:6000:4613:b0:3a5:2923:8006 with SMTP id ffacd0b85a97d-3b5f186ed15mr7662034f8f.25.1752393973014;
        Sun, 13 Jul 2025 01:06:13 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:06:12 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:24 +0200
Subject: [PATCH v2 02/15] dt-bindings: cpufreq: qcom-hw: document Milos
 CPUFREQ Hardware
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-2-e8f9a789505b@fairphone.com>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=1165;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=nbSwp5ROysMSTLKLxq6Pg7q3VCWJ3MFGpodgkXirdrk=;
 b=URo7Ywj7eQLjWeGSKpTNmv79uc7iAPWio/PyLw17wxDECtuAiz2Bu3PfwHvwHO3pZ1RhCb5ag
 VyL+DFxfUJDDy0DR7snG/iq810fQKBhCUA6IIAt4osJpIsLJpCqxh/T
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the CPUFREQ Hardware on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index e0242bed33420a39b8a8cff4229ba9eee994ca30..4fcadba87fbb90f960201aa0763f1a22c0f0f9b5 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -34,6 +34,7 @@ properties:
       - description: v2 of CPUFREQ HW (EPSS)
         items:
           - enum:
+              - qcom,milos-cpufreq-epss
               - qcom,qcs8300-cpufreq-epss
               - qcom,qdu1000-cpufreq-epss
               - qcom,sa8255p-cpufreq-epss
@@ -167,6 +168,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,milos-cpufreq-epss
               - qcom,qcs8300-cpufreq-epss
               - qcom,sc7280-cpufreq-epss
               - qcom,sm8250-cpufreq-epss

-- 
2.50.1

