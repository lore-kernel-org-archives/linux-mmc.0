Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D809C3ED3A3
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198832; cv=none; b=SjRBI/275TDDlBJvsuBr6QrzPnZIBWes+b25INmvrWjzwwsTkKODtLd4bOGVSlXZmj5qurSkqZnxCOZv4F+MXYcMt+95y7/CQeQS+FhQA/6nd+2N1aKIUO5X6Cju+tU7Hj2xEfU4wCtrVQKeRpHwWWwkDrNzcuPDRV9PGSNMRjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198832; c=relaxed/simple;
	bh=sH5CAXuX43myBAnxxruPGpAWjzBS8NW4KkHXNjYDiac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrxNEgp5K6AI8qGqPAgBq3sjgLfXx9lEacsQEHzLCxk1a7A1tM8hVjsJZu7q34Wx2bdRwxFCyGXVqdD9BTkamALy8geuFNstzmHSxf16ROTQ8lnaEgMyVkFTUrYeenNmrAYGIFGObVnk8q5dy27HQDAO2XYqRTH44BMbUUauZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH83+fwQ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH83+fwQ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d734223e4so2302463f8f.0
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 06:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779198828; x=1779803628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBE0iiYvBm5N+5+htIhA2pkzu0VOJpuxuzRwd/BpEvQ=;
        b=bH83+fwQY8o3JL+MI0OGq7U2ktU67YffxzYQhwglaRJ4v/4Bha8X/hQlx1AtRvxoET
         V0gtd9GAKQTME0I8AR+/0dHuTL85WnRRBQ/RTLAvhwIV/AKUGvp/Kx/gdFCxpZkNwlz6
         Vzw3hni0ud3JtAvPtBieBynxAKRpzESVRwnNvVuFjAC22sbhImcKDAl3cpkzr1+o3mqy
         0Eda14Kk3fSg3l6Bubb0PC+lf0A0mFu/UH3asvqSxxTTdaP4QbhNVkFXTd6mjx5IDhUh
         EmLuY48vscmEYLEBthJJumEN9DOgkNLPlytm3Bla4G8rpnx2AbSKP1Lov4+bRU4Yp+By
         nSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198828; x=1779803628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wBE0iiYvBm5N+5+htIhA2pkzu0VOJpuxuzRwd/BpEvQ=;
        b=WGP3s6eg6i6yDN348qu44naLd5DN4EeFM1d7glH0wvDUieCJcIth8zIoZYOsza6bRQ
         6Xw1Bm2MSVBNacRxddhILmXmxWCsOBRa9ga73IVhIf5hSBImQcx0pLiIXD/yrW6k7XZh
         66NE3s2Ak4rsXNv+W4JYTbT9Ko5fpwNWIj5o0jJDNmQfzzBishNZdWibTg5LJ11PKMXp
         VC7n/jR92Gq5Uomd4ZihEZ7fssxYVahP8HzpPOAdsSFrnOHO7y3ZnMQi+tns5XXWDbN6
         xblt5RCMghpCTyv4GN/WEyZv7Hkut8dAiDOeoRHaQoGZCov+QnofOC6In6PTbiY/EDjB
         yx2w==
X-Gm-Message-State: AOJu0YxWtRECjQfXprNi8Y9xsMbOrswfrA6pxvbeSFtoV+914hZt6SNg
	ZiAhQJKAXi+Trx/xKqt1Kb383MIxqjjJMlzG0LLYIUYLgfMuYa+jZ+U1
X-Gm-Gg: Acq92OEcDii4JRCWEnO4q8umMJQSlKTbcncYQBuQQNobahjJCFxDk+VILm3wG+vyOud
	1usveeaXpyfUn7Na+irtg4yqXTjSeSiTiSNMTlqB3t3XZS2BEZXNxzH2F1uHIdeHRgGpWM1dxki
	2GAJymGkCvwY2eGBR0JG1+2sfa5xcrUSsN1+PdO9OOyGlI6+J0c4LiFkQGb2O3aKSY8ngD2PA8p
	SxlMOdKxwdjq+3FWkcezqbTp46HZa/K/RqCCLtS+bB74J0nWwYwjlKYwXqQk9C7moERglyJw+cJ
	HQUgROF2wKSwHtt7WXmltTsOxvG0Guoxc81yZX2x65Le1XiyElxtDSSEqcC3rvAq4zyp4ak839K
	7i9wlAJxrfOiJG0XPzMmoM7GK14DNRp3AJ4tjesryXzK+Aqj9+0x4eOJysBItJzqnaWUco6uxJx
	C0eWm7z2WTKYZZq5JmQTLfioYHXXIyk3odmNJlMhoeYTPe924K8vgHdRNyAGtj7kwBPPF+1N3t1
	O00Eer9YJsMi0lqy4K7x2NT+STeRRB7tc+8LiwqzXbdovAo
X-Received: by 2002:a05:6000:21c3:b0:44f:b82f:2d18 with SMTP id ffacd0b85a97d-45d90f619eemr24723326f8f.11.1779198828040;
        Tue, 19 May 2026 06:53:48 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:3f5e:825d:a98f:fd29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1a22csm44964358f8f.19.2026.05.19.06.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:53:47 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] mmc: renesas_sdhi: Add OF entry for RZ/G2H SoC
Date: Tue, 19 May 2026 14:53:40 +0100
Message-ID: <20260519135342.623943-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519135342.623943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260519135342.623943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RZ/G2H (R8A774E1) SoC was previously handled via the generic
"renesas,rcar-gen3-sdhi" fallback compatible string. However, because
the SDHI IP on RZ/G2H is identical with the R-Car H3-N (R8A77951), it
requires the specific quirks and configuration defined in
`of_r8a7795_compatible` rather than the generic Gen3 data.

Add the explicit "renesas,sdhi-r8a774e1" match entry to map it correctly.
Note that the DT binding file renesas,sdhi.yaml does not need an update
as the entry for this SoC is already present.

Fixes: 31941342888d ("arm64: dts: renesas: r8a774e1: Add SDHI nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- Dropped adding entry in the quirk list instead added entry
  in the OF match table to map the SoCs to the existing quirks.
- Updated commit messages to reflect the above change.
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index b716a518f265..1d3cd4c3da1f 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -279,6 +279,7 @@ static const struct renesas_sdhi_of_data_with_quirks of_rza2_compatible = {
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r7s9210", .data = &of_rza2_compatible, },
 	{ .compatible = "renesas,sdhi-mmc-r8a77470", .data = &of_rcar_gen3_compatible, },
+	{ .compatible = "renesas,sdhi-r8a774e1", .data = &of_r8a7795_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7795", .data = &of_r8a7795_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77961", .data = &of_r8a77961_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77965", .data = &of_r8a77965_compatible, },
-- 
2.54.0

