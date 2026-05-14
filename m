Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518783B2FCE
	for <linux-mmc@vger.kernel.org>; Thu, 14 May 2026 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793631; cv=none; b=KOu7FTiLArDkN7CzKbAAsgrdykdfl/2ukLsM3PZZaKyXGYTe2SxPBv3gYmyZhwRqZL0L/ihOBOMB4a+akf6RZ6kiibVOhmGkuvvv7WhBaH+taX53Bfuf4cL9HdwxT1LJjouxm89bQ7gNgFS/rFHF5rV3nbEXuSSCHM5QKeB5IKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793631; c=relaxed/simple;
	bh=GQ8KFtIPt1cBh3YWlA+1MNGvUA29zra7wGm26s9hJeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChUKTqaO2KVnitpQ7YqH9Dg23js33hUx6gHTb1Gm+QviRdRxqI5TavoR55LKe7Vo8agvz5N92WqYIQj0dhqJlaBFuT71X7Dx/fJ6x9TAHGZmiN5bRFVrRGqOf98g0/LFzkpdbSS3yWhx4EoRK8nIXIaVa8S0uKrJd7NRJvu4B+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eb5PJTr2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eb5PJTr2"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso2031925e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 14 May 2026 14:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778793629; x=1779398429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fE/j4rv7wciqnS+bDA3iYPyjHebH0y7y55zTma9ff+Q=;
        b=Eb5PJTr2uzr6RSY8x/jFYliqNs4QfkN1pG0Zj5LzYtsusLgF1eMZPGQo67o/alJLSX
         VuZioO3pYZHy27WpKJ5Tw4bqjOXHm9iAIQPblbJyNqwex8TW2aZcHYg12uChIeVcUkXN
         gdH1dlaPNju2Gz3yc6M9HdYxe2XFyOjLS7iq9fj1sxffHUNtibPl9BAF8wdYeYnLWUDG
         vprt0tkR0DchrxrL+WBp7WAIRl/XzeW73yY5X4fDDn8VTvNb3Rv3KdHNuSKjwENmLvMX
         Mnt/F4zQbLYJtwEZpke7PMxlEoCWE78NsfT/D3X2kXejus2NIYIGcXD4RcdccX0iayae
         olQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778793629; x=1779398429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fE/j4rv7wciqnS+bDA3iYPyjHebH0y7y55zTma9ff+Q=;
        b=qPILZQGDcq7QtgNJumDvHWHlr6uukbSvr8BTei9hnt/IoEIrr46GYezEIJBTPIDBWz
         2njZimx6EbS9+YibstlUbOtNUs6AqtZUr1KMNM+uCCY+0qze8q+yqe09ca3aqWmFx2Lv
         C3q8whxEab159AB4dhfjHj3Ii96GAZ9LYtHDE5P+KOJoSvs9L+lBF0KjSWvpixF2IVyY
         PQWqR2klwSNLd2NtlnsRYqSxs/tQSLrmzgs9KpvTJVOjsqfuoOlZXG/JKMMjeakYATlB
         hS0TvQgTdI+86rdJ9Oe3vzqt3BsC524l54yFeU8jyKWRjL+BLgmRzgJE/KgZVnF3o/Nc
         hIVQ==
X-Gm-Message-State: AOJu0YwvwBZrj+qMVD7P3ptoFKJeTE447pW5GiBKg5kQx4hYLbO9CN8u
	0hJiSDCWLiE+dtF4PhnsAU3n2JML5EZXEkv3dJfqP5y2KlDkDVJXd9aH
X-Gm-Gg: Acq92OFRSRjDw2bRxHdFwIu5Y64Gwb/mYUuxNLVBTL00oRooRbH2xH4UgxPughI1zXE
	ZDZVpGGa01pDULIoIDl2YKQE9NQz1ugqUr70ljSXKtCUxUiNwXNogRpVuGJt/mb4GpkQ3MaIWRs
	EeC+9mTLuiP7J/Lqc5Ht6OJWCxSyHBJwgFI8JG5X/AOLA31FcpQAxK6so7xyxIRC6eaZHzYkPZf
	UxGinu2REXQpjFXfIPI3MUpcduvvqcHJlLJHVxrS5U/tn6m6lfgvJjMZMk9m69pxr4ZE3e/UvsK
	uulGN7WppytqWkZP38t6VeEird05G0+TuL2DhLaTjwe1cHcBY7YdSbwx0YeqiLqAzHFLwCXafL/
	9c3q/uMqnHBkUPdb5rPCOOmwcuRMjVToziA5TlOwnpDK1lkcOs6RHWn+VqP9N4tBZBUG4pmmPgv
	dj5qfkXI96CSTifFBi3ejWWXmAd1SKhTwUYSc5syvw6I8u99LCjnPgLAfb01E+HP6zABK6zqrVp
	rro2etfXifTjeG2tjhkrEuCDySGkLBh7FkYdA==
X-Received: by 2002:a05:600c:6d83:b0:486:fcc7:6811 with SMTP id 5b1f17b1804b1-48fd635966cmr61352925e9.10.1778793628752;
        Thu, 14 May 2026 14:20:28 -0700 (PDT)
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
Subject: [PATCH 2/3] mmc: renesas_sdhi: Add SDHI quirk for RZ/G2N
Date: Thu, 14 May 2026 22:20:23 +0100
Message-ID: <20260514212024.1624517-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

The RZ/G2N (r8a774b1) is identical to R-Car M3-N (r8a77965), so apply
the same sdhi_quirks_r8a77965 quirk across all revisions, as is already
done for R-Car M3-N.

Fixes: c9af138c42f0 ("mmc: renesas_sdhi_internal_dmac: Add r8a774b1 support")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index e5aae7fce1cb..b915e2e11d04 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -224,6 +224,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks_rzg2l = {
  */
 static const struct soc_device_attribute sdhi_quirks_match[]  = {
 	{ .soc_id = "r8a774a1", .revision = "ES1.[012]", .data = &sdhi_quirks_4tap_nohs400 },
+	{ .soc_id = "r8a774b1", .data = &sdhi_quirks_r8a77965 },
 	{ .soc_id = "r8a774e1", .data = &sdhi_quirks_bad_taps2367 },
 	{ .soc_id = "r8a7795", .revision = "ES2.0", .data = &sdhi_quirks_4tap },
 	{ .soc_id = "r8a7796", .revision = "ES1.0", .data = &sdhi_quirks_4tap_nohs400_one_rx },
-- 
2.54.0

