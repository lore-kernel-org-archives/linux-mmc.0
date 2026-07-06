Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394103D8128
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367974; cv=none; b=uOZBFEqOu+vEgoScDny6+37zJ4J/QRyJs5I5ohVZLd4kPQX/34x7c546S+nH3gZmL+W1Oyy+wRL0ePvOjn0VADFAihBkD7wjQaTA/HBeb6HKvNls5Eqq2Dyvyhj5vRDK/pAQiSWND22tDdHVvXxAzUQwU9Eqqd1MOZvpvuDCsC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367974; c=relaxed/simple;
	bh=djaG/NGurBf4ZQsNMptxWQoa3v2kz8PFn1TmQ/FGVSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjGaJvvG2sG0Iumhc2qLLb6/RQBFRVcAVhE+MGZMpigf+TOJvcwqcdW11vJayuKsnIarENeFVAu+V30keLg5ymX/9GadYZ1FEibA9EB3sy5ODOwB3bB3i0WNmMakwUqxohG8PvmmFUJF50z5MdVVtMhKlC/NfiItGym77iu6wIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UhcRMvXG; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UhcRMvXG"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e9f829d75aso1633908a34.0
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783367968; x=1783972768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9pR1b7+xzGSlhQK0IQGnCFDCaN1WTfnJWTFTWbY2IVA=;
        b=UhcRMvXGwqRzLiR2Lc1EtHG6ypGarDeP/HfiuiB1nzhIC/oLfL3rnlhLsOXpC0F9eh
         bTgXghJHUYCwOlvH87WWXt9sRN5LuT3hH91UDczaPFFEuhArVKk1kQe/p/IajiJtPO1I
         +Z1e/OrUuX8sW0++kz0aQcIKrExBn7lZD9DPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783367968; x=1783972768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9pR1b7+xzGSlhQK0IQGnCFDCaN1WTfnJWTFTWbY2IVA=;
        b=ndRuW4rspSDluZMkXnwS9gDGtAQ+YBEzwzd25qumd3SMCrrZANkBR9KB0E/dOD0s+W
         G0j5+mjb83hIGNxCq6/VuifUGvhp/MFIJM/lndO7KVHZAZwLKZ1c+XDWzDjla/rIEtSx
         6DpHjm4EcYaQTb0mQlTDXH+K0T9TXKG5i14CVasP+lQIffmD/EU4iCIIz9oQA7k5nzS4
         Wo9Jn+D4tRO6pdqB5PGxbCWz+dfG/FKWOwsWbxN25fZTiiORQChOL55pCGkW7dgtU85t
         WzifPgdLDKO6TOgnRLK5TMpPJ7sfEJ7yTuZQZ99xREghSg58KWrHyN0iH5xdkl3bZoN9
         HZOg==
X-Forwarded-Encrypted: i=1; AFNElJ9W8BCHottSxYrYOAYaAEsxu+mWhLCX+7gHRjwGNVCuqBgSiWKGonrKEy7H5cio63k+YsPQbLHeP1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6pwDLzpnOX+2ThHARzNGTl5Md4WUWYc7UuJzogujrJuvjvSx0
	6by0mCxsQFNFPtj3l2Tju4e8eMUWM1OPCQ4vql20BmxVIzd3zzY/flwmeyaFeS45DQ==
X-Gm-Gg: AfdE7cmtFGxp4bCfNfUkikpnPeyMd+MpsDNyPmuyUNMuCHSTsPQzOnVYxhC+W8vpxoF
	ZmY1Qy8Cd4kn5PH+O2JX+fxFHNmJzqrGhW/634DDqu9LClOjDuCupd020vhQglm6cDGaWfY06CF
	IZy9RrLp0wz8CwxWC+1dSDwfgoGZs1E9jCVeSPhzzjFLCoECUYu+eFJ1s821M0Az6267GVcbsvm
	pbKT0fzt3+3oloPUD/fB0HjZkoAwzA+w0GTTlkESfVEnip6AztIlB5Vda4YqUr12Gc6bMLEvi2c
	fZ3V0qOgkgrQw+QfPE2ulDmOKHDVm1OTtjbhtyKIK+iACU9B9XxqEh+uFdpSWd0dXrwzvGzAJAK
	tNFw6m5Wc/MEH0aZkAvxaFqN6gVnZFNNXoS/mZhrKgq12ic2CIvJNCW/9ejDb6IUGavpsGgIGoL
	IHlQPiGoI=
X-Received: by 2002:a05:6830:3887:b0:7e9:b4d0:53a2 with SMTP id 46e09a7af769-7ebb23a11b0mr1118805a34.27.1783367967800;
        Mon, 06 Jul 2026 12:59:27 -0700 (PDT)
Received: from chromium.org ([174.51.25.52])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb542d017csm12161834a34.8.2026.07.06.12.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:59:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@nabladev.com>,
	linux-arm-kernel@lists.infradead.org,
	Simon Glass <sjg@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH 07/12] dt-bindings: mmc: rockchip-dw-mshc: Add RV1106 compatible
Date: Mon,  6 Jul 2026 13:58:03 -0600
Message-ID: <20260706195818.3906949-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706195818.3906949-1-sjg@chromium.org>
References: <20260706195818.3906949-1-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible for the MMC controllers of the Rockchip RV1106,
which are compatible with the RK3288 variant.

Unlike the newer controller in the RV1103B, which uses the RK3576
fallback, the RV1106 controller is the older IP whose drive and sample
phases are set through clocks provided by the GRF, so the RK3288
fallback is the correct one here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index 4965bb518c54..21ecfaa454f4 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -43,6 +43,7 @@ properties:
               - rockchip,rk3562-dw-mshc
               - rockchip,rk3568-dw-mshc
               - rockchip,rk3588-dw-mshc
+              - rockchip,rv1106-dw-mshc
               - rockchip,rv1108-dw-mshc
               - rockchip,rv1126-dw-mshc
           - const: rockchip,rk3288-dw-mshc
-- 
2.43.0

