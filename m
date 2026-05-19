Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B70340402
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198830; cv=none; b=Rz5XwckuY/IXz9Kv5nit2ib/rhH6o0T6F4ZWds+dJF6WTM/JvA8Q8yzujeC53blHRaduy4HvST/hcCQ+NkBSqOmEZGfidkTcJ+A/0NiSBxypz0dTdso712RtcPghV5CJC5oJaOjZXtN2ZOMNbtFMMKTkbOm/8miPCn1dkma1GaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198830; c=relaxed/simple;
	bh=efMC9iHH5jBQ/HnjbZ7E3waUmvQi9RozSyYhZOA4z2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ffKmJW4Wh833/RBSfAOFXyQt5egfhpO5W+/CV4SLnAFaa3arWINrrf2eq1RDdnHiDmr2fIOGUqEcHaS05JablN4gFldDaoPH10KLWIkHQ71F0CQhdhHoeOn//TtOu6HmVWs8E6tmsRkSW/3VdTGSqX/fVw2WMJE1SuzTp3/GHh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nfb0Y8oN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nfb0Y8oN"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48fde648a71so26252275e9.0
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779198827; x=1779803627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SodPtCl5az/xxqbvvCj+dXcI10ggdbsgQro2yt5ReF8=;
        b=Nfb0Y8oN9M8zGfAXWSdfiPm08kH1cU+a1MDsOWavrUt3Lk8nOQU4FSU8pFSEot8vBI
         O4PJWxG9nmKhPMyKBXtG0F090GajWCl9pTcrH9SM2lAelLS5fMei2bvSAJfPxX0YRH9b
         OTe3SNigVXASEcw9gDUa6hmL378hVJo7/hk3wsQADEkjVU8O+pVjKk481l3Rg5ALtK/4
         3rFgSRu9KjFF+Td821Ig9f2Bj8TO61ujE3UihST7tjZsLu07QaJ+fvEJhg9uYRwV2vyw
         WHxSntZfuCzZ+ogOSrU4T1UTAGQ+IvsrQ0YvDaOj/KzpNL5+t5Cdqkw+HTenFc53dyps
         BMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198827; x=1779803627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SodPtCl5az/xxqbvvCj+dXcI10ggdbsgQro2yt5ReF8=;
        b=oOXZ99xtv/yfN7lj5QNc3cj6WWkgvR/Npv2jbHZcwGOckBw85oEut2PfSMl0TCmAag
         FRuHfnoR4VUMiOQ2M6/GA37GBAXy0pCHkNYBSoYkbOEnpMFJGjse7dV6uV2GJ67Fp1/5
         6ZxIDX3WSt/YJ+ptEdFaVWcjw9S1gI2ge+MGObbEij2ouPAzQG/ZHn7rUvQCi0sGWWLH
         XtzzM6q3nI1Rz6pVA98oLVwzABgQ/EBMMyo7QaEM7GIWPlSFRub+31Hlfsu4dpk3wOkF
         GAyrRDmcnv4pT8CdT8GJTloD2Geamx3N4WsxR/9C0aBB/4CCEY4Pch/dnGc457U7hFtw
         3tCA==
X-Gm-Message-State: AOJu0Yx8JhZKQ66gVVGgk9AoIdbF8swkQP2IPKZrCK2cvVog9uzENiii
	zNpPUYsR/yCcga7umbttUWCav32YUIm5Yry4f6oFU0+yF38mu7NfeOph
X-Gm-Gg: Acq92OH6jRiJXGEndXbixo1I6/WTvHyfNYU60LLhDdpiF2bz4d/KsAzYPjk35jda0k2
	un7IRtZir/MZHWRIgRcOWIB685nX1Y5djzs/wNFC/dVJ73cYYfWqcwsWhVcgLayqFwUKlwNHhOC
	uo7w0mVeqayq7N3RgMjNK8MAw9EtSW75heT0gNiNRKJ4vuca+kODccBSgSP6W6/aV7KvWruRGhU
	T2w3KTJD7Wep8VCVmBaIOkZIx0Z28Tfa0SJ8uqRuUyyMpTjjZ6Vg6D5xZOen8kKmkdL2IdW7DI3
	eO/mbfPumBX/W/YR79USPKVQgY3wKuyOzGdclfU4bnMRAUXp4zkFFc5XJBLDUat/OXuhQ9jhkwI
	wD2O+eougMuVmoWIM899f2c6NlSBHGPplPNAvysmIghMfA6D2ixwUsvUhVYzIljXAsErkngXfzB
	ieIONnvyesdI1IeJ3Rtz7CqvULBwjQ3Ptqk/iiS4t6l5PmUhYcq6qhKuu5st/J+qqSmTaYd7L5K
	KvYW+Uejw4KBgUCf09yCNWymVzhlKLh8U/CfXbHIvwFe6q7EfZn6Qm02PU=
X-Received: by 2002:a05:600c:8905:b0:48e:89fa:9811 with SMTP id 5b1f17b1804b1-48fd6361dc2mr303020975e9.13.1779198827492;
        Tue, 19 May 2026 06:53:47 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:3f5e:825d:a98f:fd29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1a22csm44964358f8f.19.2026.05.19.06.53.46
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/3] mmc: renesas_sdhi: Add OF entries for RZ/G2H, RZ/G2N, and RZ/G2E SoCs
Date: Tue, 19 May 2026 14:53:39 +0100
Message-ID: <20260519135342.623943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This series adds OF match entries for the Renesas RZ/G2 family of SoCs
(RZ/G2H, RZ/G2N, and RZ/G2E) in the renesas_sdhi driver. By doing so,
it ensures that the existing SDHI tuning quirks are correctly applied
to these SoCs, which share the same SDHI IP as their R-Car Gen3
counterparts.

The RZ/G2 series SoCs are functionally equivalent to their R-Car Gen3
counterparts regarding the SDHI controller logic. Specifically:
- RZ/G2H (r8a774e1) matches R-Car H3-N (r8a77951)
- RZ/G2N (r8a774b1) matches R-Car M3-N (r8a77965)
- RZ/G2E (r8a774c0) matches R-Car E3 (r8a77990)

The following performance improvements were observed during testing,
on eMMC with HS400 mode, using the mmc_test module for 1000 iterations
on each SoC:

SoC      |  READ BANDWIDTH (KB/s) | WRITE BANDWIDTH (KB/s) |
         |     Before -> After    |     Before -> After    |
------------------------------------------------------------
RZ/G2H   |     42500  -> 100744   |    70109 -> 72594      |
RZ/G2N   |     46680  -> 104731   |    73393 -> 74298      |
RZ/G2E   |     159472 -> 180781   |    126355 -> 127725    |

v1-v2:
- Dropped adding entries in the quirk list instead added entry
  in the OF match table to map the SoCs to the existing quirks.
- Updated commit messages to reflect the above change.
- Rebased on latest linux-next (next-20260518)

v1: https://lore.kernel.org/all/20260514212024.1624517-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (3):
  mmc: renesas_sdhi: Add OF entry for RZ/G2H SoC
  mmc: renesas_sdhi: Add OF entry for RZ/G2N SoC
  mmc: renesas_sdhi: Add OF entry for RZ/G2E SoC

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.54.0

