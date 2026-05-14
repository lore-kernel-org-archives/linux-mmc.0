Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262F53C3428
	for <linux-mmc@vger.kernel.org>; Thu, 14 May 2026 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793632; cv=none; b=WCteHSozaBuxjuJ8rLCgbeWfX6GRQjj37RT2zq110/OELiOTfxvNGvfhHqhYSkjW8ebvMgPxl6a7em23sEH3vrKf21wMPWbxb1LVqVJv8m4aU1yt13zRIb1x9TWWimP/MtsJis0p4anoJFdY/zB8utOLCL4zwfv8q37kMW+ozDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793632; c=relaxed/simple;
	bh=F7E1AyUKWuIn/QiVoKTLffZMRrUlmBr7M8fHP7P9SWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qn1gFIQjpliPk0k7qzrH1zxXRUnwGpHmdOEru7nXjB7KAXSUvw26mh1xCYOaXRUzJOnzSrNbj/DKubIMnIJc2P02YBxiq4xM49nSd2MEo5WyWTfH+qGTWs6P2NIHZKZZ0i9fsKIhzDXMmFRm1iXOxooJqJ6MbdVXApXaaIwG20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZyKrAM8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZyKrAM8"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so161834f8f.0
        for <linux-mmc@vger.kernel.org>; Thu, 14 May 2026 14:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778793630; x=1779398430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fbz4sXtDTlrKke797+KCoVnjqQN3kBHCXXyo4twm8ec=;
        b=CZyKrAM8VK8np9y+JpNnn7bA1Rlw52zbpBy0OdGGM+/IMEzddQsXqdi4gi+tzwxrri
         dIDG9s3txYM1HyMBwS4oOZcm7ZWDxEDmWJ87m6T2eg4clRWfoA3H6PzO7f35oi7Sj/xD
         a2oCjVrvgnzsbyFnXd7CvEGV/+GBYUdGLkef0CD23on+xNwafvx1Bu51tSFXQpj5Zp71
         P0W44Q+tM5CdlOIeAkzDua1CTvI986UpJ1GCKIbMWJwnR5MNh0aw6U15BHd1DPvEMc7i
         PxlMQsWR4Z7VZzTQLgXm6Lse78XZ9w7OXdm42NfwGzTgx9rzEvldHKnLT2a8v66iqDJG
         IMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778793630; x=1779398430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fbz4sXtDTlrKke797+KCoVnjqQN3kBHCXXyo4twm8ec=;
        b=GhQ4j0Iw5KAUimQ/pi4+/YgBaMj/Lkh5KaTMeCx/Hyxc5tizsnWITCsMGgWiDVXRhZ
         wlfSS4qwSbOx9AvfAydmijFbq//wJm4p2lCYFOwqVIwdVYESoSM10ndloJI7S2ZQO/+6
         fwup9tyqFUpuzbv6WBcQxYqEHMKBeMYIHSuFt7Z7TbMD2iOENpHy+mpoCvgqi5QuaG2h
         7YpJ0J1Gw3eIP3P2Rb/THU0QTRtK9NIPjElD14nb/n/gry85MDtoUt64UjJ87Yt0UP4h
         oTxbGK3RBSU0fwOmfazgAS3EjvpfK4ZCZzpvnvtMtcnblN8Z3R0FX05GSS+8W9woafxf
         Hd/A==
X-Gm-Message-State: AOJu0YzI0guuNAy7hB5Tu1+FPT+ZuooqQdKYmq1C9jyic0RjFGopYicV
	TOD9PkTRXcnG56118dZLKdcIL0hv9Boh9Pljj/UVGfny/+UEmkggTvAV
X-Gm-Gg: Acq92OFhBMoUAm/TEFx6w5f5ODDDGvqzzJs7tvW6VUaJxZ6yDKJgDR33GT4Kv+nEUH2
	QpWm3fk/E2hdcxYNYg5+gaoKQJUS42ouc8f8d0ujxQQS4f+udANrG/shmeRYr+6gk53P45ScwS3
	RQoqwok9jaTp+b+V4XS6p8L6HLOsESk6ljqoQ9emHS1GDk3tB3ZclUMP8/oKm7ETW0Eg/9YqKh3
	CIwk6CTXRi9GFaqXwbcm8XR8vnsbxn8y1LeS2PtQckz54LKm/YoWu27QWG0L694jbWYCYMPHy2T
	pmbsh7qN+ZOLqp6n2Hxvr9zFIs8Fdn2CwxliWHfuUZfzWsfONv6jkPKuYZCNjuswjAzFaeC52Hv
	eGXmo+b62lSQze0XpbHIXbEb0rCAgdjQ1KCrL71xsDxqJ9e3p/WSZsE7Wgsia1q+LG91WrQuW4L
	j7XaVWFVMRnkLfKLJoRkinOOjFJtdt6Cwzi/4c9MZla0Ir2tCzLeNWiDNHGVOe/Nv2YB24Hd28m
	JFwJWyy/N8ozxKj20iegDi1pW4WrERGyPa0CA==
X-Received: by 2002:a05:6000:46cf:b0:445:7f70:70d3 with SMTP id ffacd0b85a97d-45d901e0ff3mr5899089f8f.5.1778793629581;
        Thu, 14 May 2026 14:20:29 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:4d56:d792:6583:2fd5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13a7sm10216038f8f.29.2026.05.14.14.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 14:20:28 -0700 (PDT)
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] mmc: renesas_sdhi: Add SDHI quirk for RZ/G2E
Date: Thu, 14 May 2026 22:20:24 +0100
Message-ID: <20260514212024.1624517-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514212024.1624517-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260514212024.1624517-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RZ/G2E (R8A774C0) is identical to R-Car E3 (R8A77990), so apply
the same sdhi_quirks_r8a77965 quirk across all revisions, as is already
done for R-Car E3.

Fixes: ca804a5615a7 ("mmc: renesas_sdhi_internal_dmac: Whitelist r8a774c0")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index b915e2e11d04..393d1c2238bd 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -225,6 +225,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks_rzg2l = {
 static const struct soc_device_attribute sdhi_quirks_match[]  = {
 	{ .soc_id = "r8a774a1", .revision = "ES1.[012]", .data = &sdhi_quirks_4tap_nohs400 },
 	{ .soc_id = "r8a774b1", .data = &sdhi_quirks_r8a77965 },
+	{ .soc_id = "r8a774c0", .data = &sdhi_quirks_r8a77990 },
 	{ .soc_id = "r8a774e1", .data = &sdhi_quirks_bad_taps2367 },
 	{ .soc_id = "r8a7795", .revision = "ES2.0", .data = &sdhi_quirks_4tap },
 	{ .soc_id = "r8a7796", .revision = "ES1.0", .data = &sdhi_quirks_4tap_nohs400_one_rx },
-- 
2.54.0

