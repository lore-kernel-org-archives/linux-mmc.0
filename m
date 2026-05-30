Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5B433F8AD
	for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157316; cv=none; b=rKrxfxjqcETWzR0Pi2elXajLe21PCdFi4eiutaSw5HgCxw+SCOvUSnJ/K9fG0ZitmBXJhrvln4Tv+u8ru/j3jpx2v0i8TlhyDsyNlXDaq1h2p2SJYl28O5YuKIJEDPeLJPoBqoE/9Yp3PywTLUWJTAH4Pcn7qxzkgbkGzCC0iwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157316; c=relaxed/simple;
	bh=SYztovYTTqiV+u0BtE2Wzg9/qtD3Gvz1IsbvkrjW9Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwPSFxNE2w76SvhIQ2rZ/am2oVPFfqz/ln8DqHLPztr2s3a6l4yonqknPrkr9BakLpQGMfFB9vN7OaMQ/0TnTDorrbUXyfKpR0tNPAZhblawsJpai4LRJmbqnGwA+k0mW3XPFmyszYTp3OgmnwxEJZlwed/bUbCng8OJsEeNk1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ta/dvyDU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ta/dvyDU"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45efa80e0afso271859f8f.2
        for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780157313; x=1780762113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQM9T3pZW6lWQbyMq8N6ExK734KBfMavqxmApPQ5V14=;
        b=Ta/dvyDULHUV5NoJFd6VJVKsy9+Rqd0dHX/JUzsOU3MJT4zXNEWFYepLPuzsaumSCh
         yyKcZC3RokTB8fCmzAJE39WwLU6oAE0k+EP/P2buFJAv712nXpdR2+aMMWsqwyqcurJZ
         pHOmtzgoYRayILcMqK3HsfRA3Rv26T1iKCW7+wXARCP5J14GVsy/xZr2tRi8ymaDsdjm
         yRFysgzH24cSKN5AJ8CwQTApKeoUVp7FEwuk5upJuUtqEukXCduI+/1WVjUIeDEzI4TF
         F7+xJaP55KhhijV8Z5MjcCU8g1S0dEh76ylV8d28ZWQB5gBOPyTDqQrZA8Sa66/Kp1jy
         J19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780157313; x=1780762113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UQM9T3pZW6lWQbyMq8N6ExK734KBfMavqxmApPQ5V14=;
        b=gJjQnu5ynL/wVsgzZtFs8OcBb3weiEGXXDOCw4Zk7RCQ/+OBfFkWjMFwSVhHTYc0Hf
         xMWCGL1NGXU7ZPhx27Ki8Au5UPAGBTMckzpEbag34yNLQsRqlWIrkjDTGhCoAudILCpg
         ASgBsJDC8woBkMs/n2IXAdtbLzGbQDDXQcpHAGbrG/D1GRmo7QK5U3bUXOWOyqHMUzuc
         ctj5I9F3Jv0k+73tTdaDetOTYeGu6X08X7TiQ/ylM+PXyVJdX18/Xsq7slkt67AhvOiz
         o8zCPD4N2bpk1czvZrldLFz/t0M7v9CU2SmPlCXOvW2PMDE8FXIGiLz+9zN6j9KZQlMz
         Y/mA==
X-Forwarded-Encrypted: i=1; AFNElJ+A6jtFioISk1qwXDDmVHpFBwzIbQnzkhlariJQlYF1s8lCFiFgo3I6opxdhAeQbFDgSzaZKyz55Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy01aGpeVMT+3VYeWUXn4VojjXHEmkkFOrawmI9oaKzAZPb2kwX
	vtAtvjE7iWhmJt6AwWvGchJ8uEcD62GxJGtLX3zX0XPGS67q7yRlW0H7
X-Gm-Gg: Acq92OGsL1zxrrR/GFMEEUraWY/g1HrhXFZtcPtJPSMtyoxcCLUBBawEJGZXeZnp3rQ
	t8NCJhj5ua8Slt7voSGyYZgqBwCCE97L8mOBQzC+J0apGOWLHCUfYKsSC5tQkHyJHdYlMtXV2Pd
	LylMzL7Su9VOUkrz61D0GTZrUHGCT5se0jFvUEH+PDRbsd0JZBxeyP5uxnw+bNB6WRxoRkc4Ij0
	tqZb1znJcPdimOGVsINjjd9aR5LNqevIv6L52GcJLOCSMPPfofLcTFu0QQr5qVl4afONe0FlvVs
	ospG1drNEKFYB3UxR4Ro2s65ivOiWG8ubDsMW9bJiF4+0QykCsilSRDO2GcTSdeBuUVVdPALO6k
	rTLaWheLHA8pKmKrAvciihnJb+QUpyyjFR4x9xSbyeDuuCNb5GX3hbBpdn40QPDuuQau8SZEVG3
	5HgWFw40ouFt4705D5taT1KTtt3pm3WeWP5r7Qb/8JwfXhEdX5JAFhh4oCWKe1YEWyUPAI4g==
X-Received: by 2002:a05:6000:c11:b0:45e:edcc:f6dc with SMTP id ffacd0b85a97d-45ef6b028ccmr6224994f8f.6.1780157312835;
        Sat, 30 May 2026 09:08:32 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:5db6:a512:6ab4:aa07])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35874b7sm12170799f8f.35.2026.05.30.09.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 09:08:32 -0700 (PDT)
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
Subject: [PATCH 04/17] mmc: renesas_sdhi: Fix whitespace alignment in struct renesas_sdhi_of_data
Date: Sat, 30 May 2026 17:07:58 +0100
Message-ID: <20260530160823.130907-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530160823.130907-1-biju.das.jz@bp.renesas.com>
References: <20260530160823.130907-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Remove extra spaces in the renesas_sdhi_of_data struct definition,
replacing the tab/space mix used to align tmio_ocr_mask with a single
space, consistent with kernel coding style.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index afc36a407c2c..09bf9b24a8c3 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -25,7 +25,7 @@ struct renesas_sdhi_scc {
 
 struct renesas_sdhi_of_data {
 	unsigned long tmio_flags;
-	u32	      tmio_ocr_mask;
+	u32 tmio_ocr_mask;
 	unsigned long capabilities;
 	unsigned long capabilities2;
 	enum dma_slave_buswidth dma_buswidth;
-- 
2.43.0

