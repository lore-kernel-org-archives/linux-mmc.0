Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1AD3ED3BB
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198833; cv=none; b=uSvCzCXTD8kEs0LjipH4K7GHBtZMbF+box5vQTmeAgoVFM+plQOFU4pp/Uxu+MHmDBG7pnvqnSNh14fEsoRfXP88bZxefWyrCpgWHAthj3oyqtP7ru7XceB5E91mfkHXgkENI3SFYxs+bHTifKsw61nRMcUFi2esWeCgo3wGQDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198833; c=relaxed/simple;
	bh=+N/cTOh9PaLsivS583WGbxA3pgcSpJLIPQde1c/4q+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtlSt6pUmxM+jJmylvpizTpKj47xfBhlTCTxFxjD3bSa99Ylb06BTrcAqE4RAEOInLEqWu+BD0I4cOQPFdBiQQAL5xhDpVkte3pIuhdKb1UqZ/Dwea1q4kX166Ho2TAtdgCorGn4IFSnmTeVBzg3TUZbZj3mf1hJzPTwtA/13jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5WoMklK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5WoMklK"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44e5624c053so2137124f8f.2
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779198829; x=1779803629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHzAkzrfCiVchyzTJLUD/adMJOXHeiF4YfLqfQ5QQIQ=;
        b=q5WoMklKSBGv8RLK7KCrUg3SFwmjxdFOXFXEtcgT/iX7J3oigcgwfJMASOF8y8HZ+0
         2d2FBfJZfk/g5VTHDuwRyNxkx2M6WQtg38tnajmo3DsPeAn1T9EdsD0AFDzq9cFLTS7k
         n1Gsn43WYC2sy3G++xDiNl2gwMGMDVh8Knm8mrRgPjrHJmJVB+8VyYAgGjw0hCcMuNcF
         EYujheMA/dzGvD5mlAfHJoIwm2Jij0QcIpF1SNmOp93PHCuv7/GIJ5nX5U2vgcgW1O+P
         U+EGMyOYizImhzAdJRCAhElPrE/Mb05wu0o6kGwb+hHU6B4mbIaVBM5LCCjKGRDYtcec
         7G4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198829; x=1779803629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VHzAkzrfCiVchyzTJLUD/adMJOXHeiF4YfLqfQ5QQIQ=;
        b=ketFlhFGmQ52ExKryD//8huPtvy2hQhzscgiKIWdjn3PtXaqyOS2eLnOIbaQ/oeGO8
         Og/AomFFd7VZxBp77Vit5xCfzGIiu7XRDBWfgdjUbGQ9iLW8bxqg/XB+o2JJDhOV258F
         x4AXO1e8ZRr+bF+RSp2AU/beY5YK/YfcNLGLvmEp1QdwWMDYi4LVqQyDtFwE0kwNhTBc
         SsbiLv0eVyGvgwDBH/pwAfWSB5VMnCyDaV0re3/zYGvjInE9MG/CIWKvjsRpzyrXg7e8
         sVOXi9S3ZeLTJswH9qBLFVxDXOwwzEoExKTSwTEfejL731+jmKcq6oLGf9HxriAKYJ8n
         SoCg==
X-Gm-Message-State: AOJu0YxFtsk1bWuyPqhr4k0Mu4N7arPLWfBWk2z9PuGpa0bxmZsvB+ZN
	dwISAA143c1uGciSQDUuErndXgST5I0Bj5lYQRjci0GbDLf3lW2rrcfC
X-Gm-Gg: Acq92OHxGwd8WXS0EQi7QQQzjHLB5FlxW2xZObnPAyLXAxtVL1WZ25HuOlyM64tG3Qa
	ttxrin+BqlMShJ3Dc2q/h4QHSfEx1bYAqeMbIe5h7/y7AVuKShhQkb004KzvQ8hhu2bTy7Yi3yf
	J+xp5JOuO78ulsl/lYKSMuGxP7eq9ldHVdbJjuv2WgI7DVrB95bUaeJZm9ECeSx3VbO6pSKUuPK
	SOj2a4smG5WGhQW5iLFENnSCxjsho8YVYzC5UrsAcdQEVQndQQJNtw8gnwqQcGXrFEQ1v8eXrBO
	5K7ZR9AXTGT5xC61TaieJ/NUnJBnU5anG0STiTXyVENoBlykRq7UldtLeKe9dgsmE0+KBTEHQQJ
	XD6NZS5iX5Ey0jgWwmusIzjxdarMB/cHcZ/KFxGfrLACI97760BZYKCmW5bbFx6jz3fTq6ONw+e
	B4Jot17UyRSRDFlgjbZ+YxLMxvY49NnlvVFlcCIl+ELt3Fh/dE4DA/FywlpZ0zUgvPDZThLrxpG
	7zJNlUQ1JccB+bXjXLaen5L0/3Dw3+hZdJqqioEDb6wH9zi
X-Received: by 2002:a05:6000:4210:b0:43b:4f86:e985 with SMTP id ffacd0b85a97d-45e5c5dd47amr30667307f8f.33.1779198829241;
        Tue, 19 May 2026 06:53:49 -0700 (PDT)
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
Subject: [PATCH v2 3/3] mmc: renesas_sdhi: Add OF entry for RZ/G2E SoC
Date: Tue, 19 May 2026 14:53:42 +0100
Message-ID: <20260519135342.623943-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

The RZ/G2E (R8A774C0) SoC was previously handled via the generic
"renesas,rcar-gen3-sdhi" fallback compatible string. However, because
the SDHI IP on RZ/G2E is identical with the R-Car E3 (R8A77990), it
requires the specific quirks and configuration defined in
`of_r8a77990_compatible` rather than the generic Gen3 data.

Add the explicit "renesas,sdhi-r8a774c0" match entry to map it correctly.
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
index 93470aea21df..024edc4e5fe6 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -280,6 +280,7 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r7s9210", .data = &of_rza2_compatible, },
 	{ .compatible = "renesas,sdhi-mmc-r8a77470", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,sdhi-r8a774b1", .data = &of_r8a77965_compatible, },
+	{ .compatible = "renesas,sdhi-r8a774c0", .data = &of_r8a77990_compatible, },
 	{ .compatible = "renesas,sdhi-r8a774e1", .data = &of_r8a7795_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7795", .data = &of_r8a7795_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77961", .data = &of_r8a77961_compatible, },
-- 
2.54.0

