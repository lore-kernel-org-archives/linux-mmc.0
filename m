Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BA9394464
	for <linux-mmc@vger.kernel.org>; Sun, 27 Sep 2026 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790521955; cv=none; b=sHmowatfHUMT+MlGRg1T01HwXB0IbmLJ9eJuNygdz2/xdwEgty9258OSSa2+ov30tV+8aQ2CBi78Axt70QGAlN/kNIYpzBha4Tzf59fOlCnGvU2ZWz1zvhKX1GMaefx/zIO8cNpmggjv06nefjHzYCfTfiihjo7uYT3aowYMYRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790521955; c=relaxed/simple;
	bh=dplioYOzQkTgB7OtXIdIJ8d7kiQ1EMlzvR3wJI4xDb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXr9Ror3G45viW+nPChDJ10BLZbVLhpCgmBErd/uVuUarJAG1WeD0dbjPFF1a4HQuBbz4dHkrtM7JBr7GvstF9rWMor1tFwzN9SLhBa4+fscm2Zg+j7+SyuLI6DrjjEV6IBoY0EyjSynIUfq8BFSE9vvfU6+T+5Ww5uFs3sMF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fq2LIlwO; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq2LIlwO"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so1404372f8f.3
        for <linux-mmc@vger.kernel.org>; Sun, 27 Sep 2026 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790521953; x=1791126753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JVRS8IDqRClJGzLh+AyZKtdvQwPlkBwHKoeRoTOl5Sw=;
        b=fq2LIlwOjgj++P1mVuzsLl/m+qWW6vOoShRUgRxdUoJafrJUkmUkKqpIKU7YRi0JJ3
         Bc+Po1+cypX6jFZ21GL+eo0rHC3t7SXQcbPgEzyKWPtpOO7e7rFZBvbVxFW2cA8FWDuf
         Sp8u+3/2DWCNvjjsC2M6CsYx9mbC1qwmAIx5KHDgV1qXXREEnPbc4gjhLwNh9Bs5vwrn
         lTgtsxlCgGrq8z9Al+j30r2fJDbdfx1zkzOb4+PwADuJfzvoOVwpzgati/dsBwbAiF/n
         6/aiVSXo5J1exqbnwy6my8lqb5VSuagOza9AODD8E4T58bMy7GCs/J5J+w+lZRk016iy
         578A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790521953; x=1791126753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JVRS8IDqRClJGzLh+AyZKtdvQwPlkBwHKoeRoTOl5Sw=;
        b=ax77duCSzwNJSZ5gVvQLcvy6OVPS8BVkzEDRY3fGx6efR4OaXT1LKFPVUkC4GCNgKu
         EtxEJFzcioL9uKqWcO3wt2JGl2bTCSqM6dls3re7FS1kVzWi9te4OQqyIIQqUg2Eo1/P
         y7PmaEE+724njPvFFZqgZxVX9GaYNDNvi9C648VoXhKsq59s56ZQ/pSlw0MNR0zdkVWd
         ew09EDK+yxyud42oBxTgnWQayJW1rZIWiRX/bo6jVxzZXhwN7hw70txm00NHoeeG4z1e
         f4h8ixbGtuVzxFUULG1a63oRLrdPt/zILHxcDMYq7g32HlqOD99ATERzcWi3qW8zJ9bf
         /I1A==
X-Forwarded-Encrypted: i=1; AKwUvBy6chBW1XP6uQabBKL4tyYVvhjeqNqwnqhb5fNC5q/u5mr/13HRmKxDJAqoBGhspV1ByL5m17rxfmk=@vger.kernel.org
X-Gm-Message-State: AFuF++mBujhL8vNmeOttE/kWbZETMbHt6ROwQ9qRMF/XfMvBs8wfsXSw
	ycqroPf+VK8U5CUPudK02PVYJ9s4Z6F37yi+suzpIRV35Gz9SGPYf7Pw
X-Gm-Gg: AYBFou3P71ErGaZMPAmpXdMYdfDw2Ne5rHL7azAxlGJQ0U/NoQtXYwINIRQDCbU8+ZF
	r+cGcDnUV/IZi7THVBJyUU1CbvtOYPu9r6oN4MYJaQHivSxPzb0b/mhX5rRNpC64gl5MkDYTL49
	sAzLEd8oVDOusGJUsReqVJASOeQfm/SCn9jkoFzUlq1HvGqLoceHvj8ObjQBG34BqmNplKSN21U
	iaxFoQQY4slJCstkcqhEyRBpIKsiQUj97CsIoMn+dk2nmAgwFI7mNPFg/nOzHGfQhQa0g9GEbPU
	m1ogBfssHgeHKg9FALzvlj3IvL32/0SI/NHl4tVGzhaD690D4pdJjUyWYnNKlDBSqh/BffAxENw
	te0Nh0Vy52w0Bzy+dOl+HkgmINywodjmyMNVsGyctFDsdu++WBZigvi5VWKvaCDuE8F64OHexWo
	9X789gTstJaA/i9AmK36cm2rfgsjs8pvEHdYMYSWbIqFcg/bVpoVfwVjPT4XIv/fkJyrTagnfuX
	6xGlNxg0wc9wZY2I9DXag8IYHMI9YnY
X-Received: by 2002:a05:600c:609a:b0:49c:dca2:ac47 with SMTP id 5b1f17b1804b1-49ff06b2db4mr139499825e9.2.1790521952673;
        Sun, 27 Sep 2026 08:12:32 -0700 (PDT)
Received: from debian (ip-78-137-176-146.broadband.digiweb.ie. [78.137.176.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a746c57sm19764208f8f.35.2026.09.27.08.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 08:12:31 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Pablo Mazzini <pmazzini@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2 08/11] dt-bindings: mmc: sun4i-a10-mmc: add Allwinner B288
Date: Sun, 27 Sep 2026 16:10:13 +0100
Message-ID: <20260927151016.186493-9-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927151016.186493-1-pmazzini@gmail.com>
References: <20260927151016.186493-1-pmazzini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the MMC and eMMC compatibles.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
---
 .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
index 9e9610bb1eda..c2ec7151dccf 100644
--- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
@@ -32,10 +32,12 @@ properties:
       - items:
           - enum:
               - allwinner,sun8i-a83t-mmc
+              - allwinner,sun8i-b288-mmc
               - allwinner,suniv-f1c100s-mmc
           - const: allwinner,sun7i-a20-mmc
       - items:
           - enum:
+              - allwinner,sun8i-b288-emmc
               - allwinner,sun8i-r40-emmc
               - allwinner,sun50i-h5-emmc
               - allwinner,sun50i-h6-emmc
-- 
2.53.0

