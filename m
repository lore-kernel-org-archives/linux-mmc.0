Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED23F9F5D
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469866; cv=none; b=Bv13/XUiPNQMC+TUIpy2DrhgVSFhwL/bGv/bdK9gDMeCoo27nPUDh9g55sNSKgIBm5nMOKtBE2e8a411oW7aQ6VC2b+92fsUe9ysT9awEpTKNPqq3jyXTpYPpbYHOIIUdxftqNA8st8leNH6g+uZFur5CRsCIXLpsLlWcN+5YsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469866; c=relaxed/simple;
	bh=C+h0Tj+r5ZWZxe+aF5lrXQrv+HoX58xjGfKt5zIrl6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgNeL1pieWASxgkbD1KCcdXeHzUeM68nvkYrYe/Ke9DsFdV8Dn15Y8zOzRP598tlv86YfyLIU5bsueW50WxfIiSl+7SSsZddq0DwZRZUlhfFtRUT9hM8mNDJCtU3+RQ1zNsFdaiAdVwFwSPuPYlLFpFaGjpwOjvlK9n0uuCCscE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oU4XkSKL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oU4XkSKL"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490ac10e337so17328515e9.3
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2026 23:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780469862; x=1781074662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzLfIvOTnyp3/lkEWcs7a45/5McjEOZmlv1uoXxXmBU=;
        b=oU4XkSKLO028nvqHI4YinIIH0aHY8cI8xzziCo4BTUX4letIS4qBr/Nu85sXqg6eaQ
         ku6mv1UzKo9StYariYtQ7VlTs8ABzAFu588lvY4IzUVKG3Zgq5EN/9EGbniITO3T0hnn
         Hl3d0r27WkcdEsJkRUAOr7G6vrZrej2KhjHAIHfbPLx1ZvhTtbkU/HPODeHx1en3pu3e
         ggjNF99bdbHJ1+/iL/PGnx1DWi7dE6fATVWUQzuYi2jZp4uhYx47ZvgLmybp0UrkUvnk
         LvfY6fufgGGj7Tr6+uPF+kbfxgiYxUl9FjPlwTXV3yqkRSwIwU54mCeqvAXD30OmDD0+
         7rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780469862; x=1781074662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JzLfIvOTnyp3/lkEWcs7a45/5McjEOZmlv1uoXxXmBU=;
        b=Q2/lrUwDsth/wcgw2n+ZYDRYskRx5y+R50MWhuQho4Nhc9VjcQPpgNSU/prVCQeDpQ
         +6d6nr7vTf/bbCyXf16k6Q/4Te9dLP6o7G+comp0hxohvn9dKRtfiKKe70neBzmHrewO
         sZq+LjVud1mSuUYRxz4PhyouRXfLRIRQNZdHEjkUgrgndE9Ipd6IJaIoRRUqLAkOy5R3
         oztxlxopYrUiuMC4nnCQzlYAeiX5PzVJH/xRgxn1NKYS3ddJjFn6Naq6KZStuw0ilgQZ
         DxyAqVjkS9UYg24SPOhgGXuNQtTEgplCs2wsLeKZXyE1fCf1TEoXeSwLgjPT1ZIjpDeD
         8Dzw==
X-Forwarded-Encrypted: i=1; AFNElJ/SFszmJVZhYTW04QVewWTpM3iz2aaMZ8FWcOrOUeYp/JXESARZHDIXYICcnTSig4eu+EbnEJoMRxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz99QDWK0baps9JvSnfYXZolsldqTN3DeWbaxpBQh7ZUK9Q8Q/x
	L+sBz0TZ2XNHFQm7TdUYvk/GWktM1Qouj/MYS9Cbeok2c/O8hMMN0hcM
X-Gm-Gg: Acq92OHTChWMlLnVny4lW11aBRc62b3lFPuKB/JXFgWX/hmxAhAYTFBBEsxVLJR2Ms0
	is9l+jHcDWQvBvtBxTVo5cO26ceOK1qPflkuXtd8c33kJleU4lF3H2HQcTw4ZqoiTJsvwgyUFDy
	DteReKTJS7uaLRgv+2YscIr6z2ZVsSMxyLoakXoSO+AZ46xR+vWzlF0F79FHaDQhU6ABre/bmLt
	1WC0dPWePzEtRr0CtE++Z23gZtcS8ZFbl6OxJL5oaKRiNfmsoIWNvm8uyzCYc7e8c/x8o9AP7I4
	4NMil0YiLvSfR9jCz3jH6E470HAl6Q5hXd7nMuwTbh+KohTyyrXpSMDxS/HbV2h76DxbXb1SY6a
	EFYEVLGRpVBCJH0WNji24QM2YMqjSvUW828pnAzTomO8mVRn7sF3IgmbpGuTzp5nO0c9EglyRCp
	IQqZHFp2YdHpwvRD8N3ySbEPVylDgu2Lsakt9hzHwZZp6B+DbpGPybTdwQmII=
X-Received: by 2002:a05:600c:4fcc:b0:490:59cc:999f with SMTP id 5b1f17b1804b1-490b5ea1016mr33443905e9.4.1780469861369;
        Tue, 02 Jun 2026 23:57:41 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:179c:89ab:19f6:9ba4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b79d90bdsm9001855e9.0.2026.06.02.23.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 23:57:41 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v17 05/17] mmc: renesas_sdhi_internal_dmac: Fix whitespace alignment in struct initializer
Date: Wed,  3 Jun 2026 07:57:05 +0100
Message-ID: <20260603065731.93243-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Remove extra tabs used to align .of_data and .quirks fields in the
of_rza2_compatible struct initializer, replacing them with single space,
consistent with kernel coding style.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 024edc4e5fe6..08cf1604ef1d 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -272,8 +272,8 @@ static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_nohs400_compat
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_rza2_compatible = {
-	.of_data	= &of_data_rza2,
-	.quirks		= &sdhi_quirks_fixed_addr,
+	.of_data = &of_data_rza2,
+	.quirks = &sdhi_quirks_fixed_addr,
 };
 
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
-- 
2.43.0

