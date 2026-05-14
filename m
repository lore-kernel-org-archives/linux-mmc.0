Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8A43A452A
	for <linux-mmc@vger.kernel.org>; Thu, 14 May 2026 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793630; cv=none; b=BAQqfHqh1I3R7uTAZz78nvtMNSTIVjyy0s0QOzwxIH0J8PY8lTtvKMJ75xSOuyXmQcUw/inU4fQm0VaNFzzdJPT81Bc2v+SzlwmMmxsSr0dZdDCysGt6tWpJpLSOGmgBbF4bxivx7z6q7AJbn1Odb62a0pYMW8A1dOE9uYBXqKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793630; c=relaxed/simple;
	bh=XPrW+LN3Qu1mBubr+kS6ch2XZNoo58CFw8wcZXn4OOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UsG6nUHTfVruxuz4+ZzBFMARS5v5mwT0Ce6b3svy74pzaSpS60+c3RaDlzQi3tZFw6NCLpfLHGmsziDZtK7HMOTwlLitsrGemiggBRu3zJZ7vxq3rQKN6W2nMsUr9Kxno+DMPvSw98Djt00egvyrEQviTHh1gxe+y+KVZmiBXFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c75OmXFZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c75OmXFZ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso4984608f8f.0
        for <linux-mmc@vger.kernel.org>; Thu, 14 May 2026 14:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778793628; x=1779398428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lx+wfWkAhI1VCh8VDA1mDnreR/0Zt4DovZ/nCSUjjYs=;
        b=c75OmXFZ3L+FOntgkkGKJRUIHLb34cVy1igs+H1oYrcDmL0ojnDWt4RcRDoieGnapG
         uJvvHpE+PMPaoXaUudL5c3Q6JLg+tWwbZDcZcTFtrIw5oKG3VCPO0fZnxPrGnr++1Ymt
         DEZ5iymyWAlsZbPPBEyraEXaNzLsV0dazy+QT9x8wAXd/NqQwT4KyQAGFLRmiNel1IcX
         zgHOg66+o3u8EgLBjSOK26Fl3t5Gm+ttT7Ox7zfOKvWeLjCF4P5Ut+q/WeC7/7bWJSmz
         B8OJD4eGPPVtGD/vMf7BNkGa5d9VSfRSAgPm4/dEu1+VPqZerZNuetF8ZsOztyFxgVyH
         z/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778793628; x=1779398428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lx+wfWkAhI1VCh8VDA1mDnreR/0Zt4DovZ/nCSUjjYs=;
        b=Qixbg4mRfwVI+dE/YRw9/sTZjNvt7FGHOFbb1m6dlTZ3sTxl7jXlY4ZPWTDGpZ+wbg
         a2cZO2yMXaKZ/XJ7WP9ftQJOFR7oyBV64/j3bAaWdOmJq/HB+JcDXXc9V0qjt47vs7q1
         ss6S82/Yb1CUoVAd+hZRr0b1mlfovZ6JaL+WxGEbg97cGYkcTSwWXhoak5A1+ANGUVGb
         WsCIeq5J1q75+piKBFcCD0KS5P7e4SFdeaeF1OvSAm/rXXLa/Bo6ZPPhQtxy1pkaGqCX
         /gU+OKGDp7AgmLEs9dvfGTiC8KqL1m7If8uV+NIn0zMly7/WZtquxXz0OkbNlbgG9kmn
         wlqA==
X-Gm-Message-State: AOJu0YzEu+OV87QIZV2icqixONf9K1/FcxOxgU3S6FnDn3gEFzBoTPDB
	YewecLpExTIZkQJ2YyhEMz65q+Q5k3NtR88j/Htpp89Gmwd5dzM/F5RB
X-Gm-Gg: Acq92OFSNQOyPrifJS/B+FuYDH27+vNc1/vGMYU4hz7JgCtL7wVngpBqc4mHhK88Hn2
	tNkDAzkUvhlCJ7v0djkh3GqoEnDTfvJh0rJ2qfq0lQwjNeTz5vMTIGyAcbsGLOo0rPOAeJwf+SN
	QiVWLaNnI46IAkCQxMIu3okmhIg4tR+iE5u5WhFT2mPX1QQW2tS7o/STz7b4DyVdyY3Fvg4Au1k
	eKwE1qVI0MTG5Oq+83BkqkJLdcH/LNWHJvosNhnL6zj4QIgKcptTRoj1sWncSEWa4dxNUrPprWH
	ZUp3hkBJHDDvQO0jc8FTHtLqCR5c6jiHAX9jyxX8PZQ9NB9Ev71FSzbG+9RMxwJzvEWWDYWEAOM
	pipY157zk/Rp/cOIXKYylSeV3+fa2DGagWpWJt59njAB6Uqdujm6cNJgiNz24albshv436+gseP
	oeaRS8KoFM66Nmhyhlt+dytwlosin/h91ZYY7g8H2pgxXGO3cjWdIb/fw4r1ewbNizxL/75hqCf
	kga94d6KfDfoh2f8uXHj2Zkd+GQek8M19FlGNd3oE/2YPVo
X-Received: by 2002:a05:6000:4021:b0:45a:c97a:905e with SMTP id ffacd0b85a97d-45e5c35db40mr973342f8f.1.1778793627421;
        Thu, 14 May 2026 14:20:27 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:4d56:d792:6583:2fd5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13a7sm10216038f8f.29.2026.05.14.14.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 14:20:27 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/3] mmc: renesas_sdhi: Apply tuning quirks for RZ/G2H, RZ/G2N and RZ/G2E SoCs
Date: Thu, 14 May 2026 22:20:21 +0100
Message-ID: <20260514212024.1624517-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

This series applies existing SDHI tuning quirks to the Renesas RZ/G2 
family (RZ/G2H, RZ/G2N, and RZ/G2E).

The RZ/G2 series SoCs are functionally equivalent to their R-Car Gen3 
counterparts regarding the SDHI controller logic. Specifically:
- RZ/G2H (r8a774e1) matches R-Car H3-N (r8a77951)
- RZ/G2N (r8a774b1) matches R-Car M3-N (r8a77965)
- RZ/G2E (r8a774c0) matches R-Car E3 (r8a77990)

By applying the relevant bad tap quirks already used by the R-Car 
variants, we avoid unreliable tuning positions and significantly 
improve data throughput stability and performance.

The following performance improvements were observed during testing,
on eMMC with HS400 mode, using the mmc_test module for 1000 iterations
on each SoC:

SoC      |  READ BANDWIDTH (KB/s) | WRITE BANDWIDTH (KB/s) |
         |     Before -> After    |     Before -> After    |
------------------------------------------------------------
RZ/G2H   |     42500  -> 100744   |    70109 -> 72594      |
RZ/G2N   |     46680  -> 104731   |    73393 -> 74298      |
RZ/G2E   |     159472 -> 180781   |    126355 -> 127725    |

Cheers,
Prabhakar

Lad Prabhakar (3):
  mmc: renesas_sdhi: Apply bad taps quirk to RZ/G2H
  mmc: renesas_sdhi: Add SDHI quirk for RZ/G2N
  mmc: renesas_sdhi: Add SDHI quirk for RZ/G2E

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.54.0

