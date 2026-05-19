Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CCC3ED3AA
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198832; cv=none; b=LtH0dgKcIUBvXx0oD6vRLlu6o4aPMa3IX0wPhSoJsBPFUsP4xSwMrX5eA5mpYV5bzEsvmhiHf1eL1nrxFGx9ZEG4J3cTz7ZHNdw1g1NPU4CoEojycD5+OiC0mNhhD8NwBq0p8FB+v20WwmhkxJOp5Qr5kCufr4008lmxtpoR/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198832; c=relaxed/simple;
	bh=xJpuMTaDbA9LXDWF/oGtQaPWOiaWcrGe4Ff+XI4HlSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMS71c6LHxfOQOYdTrrBxPRL1z8VT3UO909Aw9WVglfCJswKF24irXAfKpXTZ9G0N/S3nAZJMY7PZsp38EhRZuAuo0rMCihiH1W3Yd+DMYb82FbwBDIalpMpuWd/5SSjQT4i51RXOA85/QhFMOqo0bOCV8Z98oesqVKR6ClZtfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lE+0/lPq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lE+0/lPq"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso20527865e9.3
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779198829; x=1779803629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HR2OQSk/qx2maEw4uKeRFFzQuuuI1K0XxJerSkSW2y8=;
        b=lE+0/lPq4wwxNIBa9n7+qr09kOyvxuT/22NnGA5JKd8Qy6kXqMjWi4ADhN9xc8+aar
         fzM6SuOND/5+ffoAF6oP1Kr6dSdFOtNYb3ty3yExJUecHZlMRBRyOdwTwTQGbjtE6tG/
         xSRJT168nHCnnuyqypX0XcoLBbaY8JNKS/VmjeYZacT6+SCbU2wfE9b+4N5enVMDounD
         d6PAdqElV6jWvAlflmR1WGQu+H31ypWw5WFdCH8RdA1aFrRMbjr1mvUlIA3bNLKliQtZ
         O3jFV8gZRu2guM62lL5z1xOyCn3hVA6/65wH1ZB7qAen0heS8/Ohgf2wKM1luxisdOn4
         nQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198829; x=1779803629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HR2OQSk/qx2maEw4uKeRFFzQuuuI1K0XxJerSkSW2y8=;
        b=ORGnQ8TLWUOdJEfrvj4+Alfx2mtEM8pynAjbbGaf71nKzBS30PEUtd2so51IljmWGg
         awvm9ayHHGgUHGEoxhKJU8BGLxzku1CUoVtm/+Zg1CK0bxwHXSFODrm5HVnThuUB58H5
         azunQywdqAYmaFElTheA5ZnIEdyBLnGN/CnHgiFf0yP9LBAJqEjrOcZM9QKUrkOG+5R4
         OEEgV+L7TRDakt3Tpw9ZkK+9MbSbVr0hbUrS7w+m+OLh2EV6LQ1yxaLMsQ8sJ+nd6CmU
         XQyIT6VsmHPvIAijBzxKOk7LYEiOatyA+u3FpkeoWrsm+WSnaHFzKr1uzxPmiw6DgL+5
         ArMw==
X-Gm-Message-State: AOJu0YyZIzMjxh02BsjzVe5KYBDTv43Eq/vduW5JmjFZnnVrrRttZ4gQ
	ngeh4N5VI1qBJg/oEAcHoTJzdxGos56i2Qu/QqMVSw+iEA911f+Ld0pM
X-Gm-Gg: Acq92OGsNz6GGBbwnhHqkz/vNt5W6EsUYq1YuiyG2MqxlBmJUyny+5ao0s6ZqQ+qoY5
	87CuQzbH0XaB63fSi8bDvnYLsQy4HZMHh608HWTk67HMqbgGYoRT9e7a7xd8PBI6xAJCUcFkZb2
	BiG0lB85c6t+Wy86v5BDL+04EblBndbjUhEiGrGlXDn/a8evO0riUtpgHmH8XLb3d4/PCcZ2nUu
	hRNVx8JWlaj+7Xf/J3tJvxgDiuc4iCReREOvfANrfma/wjvPSVHyRGZKXhWHMkj7/ZRzid5cb9T
	yQXeOH0CVlJupUcyNqHQckfxo45QDrn12Og5wxP5IUugEp2YivyfORh5EXUqmDuLJD4/6b/7nI/
	sMtmaIO7/jkWbH5x8kWLZKVqC5l33SP6AqCqa6bgsIa+NZwwWeOad7DQftd+rgfK5knlmXY8fN7
	Ym72JL/m3sG+51gJwb52dQGQ1Qu5NOoyHtj5gvxxQNDyejoRr3GF9uHc0DJ/1+MUz/Opy3eBrC2
	1XJ3U76GSN5DSiaRjCXx/PKcnV+BDn0D9YHcFaaFrLbnNMD6oJUwHurNjQ=
X-Received: by 2002:a05:600c:c10c:b0:48d:35e:84a0 with SMTP id 5b1f17b1804b1-48fe651cc11mr221487455e9.28.1779198828695;
        Tue, 19 May 2026 06:53:48 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:3f5e:825d:a98f:fd29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1a22csm44964358f8f.19.2026.05.19.06.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:53:48 -0700 (PDT)
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/3] mmc: renesas_sdhi: Add OF entry for RZ/G2N SoC
Date: Tue, 19 May 2026 14:53:41 +0100
Message-ID: <20260519135342.623943-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

The RZ/G2N (R8A774B1) SoC was previously handled via the generic
"renesas,rcar-gen3-sdhi" fallback compatible string. However, because
the SDHI IP on RZ/G2N is identical with the R-Car M3-N (R8A77965), it
requires the specific quirks and configuration defined in
`of_r8a77965_compatible` rather than the generic Gen3 data.

Add the explicit "renesas,sdhi-r8a774b1" match entry to map it correctly.
Note that the DT binding file renesas,sdhi.yaml does not need an update
as the entry for this SoC is already present.

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
index 1d3cd4c3da1f..93470aea21df 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -279,6 +279,7 @@ static const struct renesas_sdhi_of_data_with_quirks of_rza2_compatible = {
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r7s9210", .data = &of_rza2_compatible, },
 	{ .compatible = "renesas,sdhi-mmc-r8a77470", .data = &of_rcar_gen3_compatible, },
+	{ .compatible = "renesas,sdhi-r8a774b1", .data = &of_r8a77965_compatible, },
 	{ .compatible = "renesas,sdhi-r8a774e1", .data = &of_r8a7795_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7795", .data = &of_r8a7795_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77961", .data = &of_r8a77961_compatible, },
-- 
2.54.0

