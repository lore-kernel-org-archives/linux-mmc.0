Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6812E35DCEF
	for <linux-mmc@vger.kernel.org>; Fri,  6 Feb 2026 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770401620; cv=none; b=JME9cwtxCXmLUOW7Y8RCVsTP4sclSPYZNsilLmCBJ4qhHTaCSfhaNPWYtQeX+z91y1NNZTgOqN+e9ojAmpz4oouc81bzvB6aBxCoOZ3JJvEWtMxVptT9A9O10+WxTLKYd6mu/wVGqd/glnArT4HII99WpMpdePjzh4bOo92Ij5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770401620; c=relaxed/simple;
	bh=NzDFBFbCVGzKBFvJlT5stD8040LteH5XcM9Cm8vtdFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MMJb+Z5ki2aKoe4cDRsv2WJHqD+SZwJxAj3q8BhAo7d/ihRi2Tv4smsQ7fGeXKPTzqAIKHXy5A/vWfg/nSvzjRXMxMY3aucGqEwF6aTk4cHecq8r2zP/fVAHcr81G7cNB77Z7CRnzReBx5YL7uubKOYlnjDf5QsstlxQCZq/BJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1TyTumD; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1TyTumD"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b71557299dso952832eec.1
        for <linux-mmc@vger.kernel.org>; Fri, 06 Feb 2026 10:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770401620; x=1771006420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Plp3Yk6cNKttphBRZ6WkXav3acKM+/WvJHxDeTend20=;
        b=S1TyTumDHl1nOU4mx0i4839gl1yw72r5z/RVmQlUVzVOItSS4k1DLb80HNxUddph+T
         gs2X75eiUOkBEAKUtlWoB+vtOjTicmXiyYd9D1Kt2F6ixMbVUgeetonNSc+O6HUbRG1u
         qglyg2BxV3dRJg7ZZ+qmmwBHH+aoS7CnW7MFXPM02rRWq/n+WvlafmudP4+oEckxyO+K
         tSirB/BrOyt00HCWDPqlP454LDQ0CQjInoZMMO5dm085X4dQ80t3JiI96Iq2UrI4AIjN
         iETBMmp4/yFl1aWQYuBvbSUIJNgH2Mh6L/HUT2fplpbD4DRU981nmBiBzQ/hQqViCzwv
         vA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770401620; x=1771006420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Plp3Yk6cNKttphBRZ6WkXav3acKM+/WvJHxDeTend20=;
        b=e4UCQpykxY6EOwB7RNL5qy0Sz/XzFLzb+Z1LUuNYVhptS1LBZoXnFerBoImt8tgWVX
         ePvhazRXXf7UF9jsyLmkGvzO6HX37O1AN1uqOFeLY4BWOGuK10H/MJ9OO4ml0oP/xuch
         rnzq+i+DcJHKDyWMNn8mWeklPAp+6oOIa0kuXfgFMyVXtbSc1EcTWqZjbR0/QDROjD/B
         9BVR6fq22jj3WgWKDz0B3qv6C+wYA5zqxKntoWnxRYI9LydJTWuabzuRLOHkg6skzcaY
         9Cx/up/1OZPuybsmp1DSIfPA4/1ybvLzhAYk3ahZGVuTJd4cOod9kV4Q4ars+xAwgbLe
         PWug==
X-Forwarded-Encrypted: i=1; AJvYcCXiELlBGKK6N+a3rnwtLs4oF+JB/Ez4eh3XIYVaN478iB8ua+mTCyA7I4Sg8RLLUmDiLro737BWRVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMggnDlgl2MvwmbVePsa4MO/8Cy0Yf0/adtpMb23zxxKZEZqo5
	1ZS0+1/2eiOP6FdQQmv4NB5rR9k/H13hWlUug5qVsASxuE+YUOV/2+w7mrTI+w==
X-Gm-Gg: AZuq6aLlMvy68oxpt2RjQYSFLceIMI01hBlOynMI96JQwOOtgWMtjHOnTAFlYa002+w
	CP07xLMTf+8EoRci9ySgt02RNVOEyt2lpnoSPqcnqXqb/m9I+eFS/Mm1J/SLaM1Ncsya7YSe5/Z
	L/1kKuQP8NSionYEfJzKibfbzMUvhpFyaSBHMwvwv6GCEYGXNMDyPcDp2TeFa72jrUuEqKwGRki
	PplD+dchsFyWR6YE/MgbAnWEn7yFr04EW11qNlk3RFkIQHBcFoX5dD8ZFx1zjX5ULsZS7LIXRX0
	VccEAlGVXMc/zYrI0Yj8KxQCffEXeNygd7IpFYoIOAdmml5j4jIkKRq1z01Biiws4hc9FCrkuyO
	0+mDEdsSbmO0MqnHTcqM2ZYmpk818RzzzpXdWyU7Cthe17c8mfrYUqRCZ11py5/qMWXzOtmS6sV
	zBouRE8Q4S3AwEUAEizT4W1jdl
X-Received: by 2002:a05:7301:19a5:b0:2b7:24ad:5c54 with SMTP id 5a478bee46e88-2b85644ec11mr1930047eec.9.1770401619551;
        Fri, 06 Feb 2026 10:13:39 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:44a3:2bb7:a035:fd7e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270433ab31sm2782500c88.11.2026.02.06.10.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 10:13:39 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Fabio Estevam <festevam@nabladev.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH 06/11] dt-bindings: mmc: rockchip-dw-mshc: Add compatible string for R1103B
Date: Fri,  6 Feb 2026 15:13:04 -0300
Message-Id: <20260206181309.2696095-7-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260206181309.2696095-1-festevam@gmail.com>
References: <20260206181309.2696095-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@nabladev.com>

The dw-mshc controller in the RV1103B is compatible to the one first found
in the RK3288 SoC, so add the RV1103B to the variant list.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index acb9fb9a92cd..a75209bd2710 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -43,6 +43,7 @@ properties:
               - rockchip,rk3562-dw-mshc
               - rockchip,rk3568-dw-mshc
               - rockchip,rk3588-dw-mshc
+              - rockchip,rv1103b-dw-mshc
               - rockchip,rv1108-dw-mshc
               - rockchip,rv1126-dw-mshc
           - const: rockchip,rk3288-dw-mshc
-- 
2.34.1

