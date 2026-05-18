Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320BB3F1645
	for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102049; cv=none; b=aUxodWwp9F3nIsQiebsWDepD7Kec1KdWGTqhyrBkoGgx78X8ZhUTo9bm/84UQ0JHKf6u8p/SXz+tyFv+GMATEkP/G5rb6GSAsznroz2isVqIdqyZ+BVZ92cRqxR7I0Snc+SuciS2j0C3zAZKJFGOTJBQJVDXQEYfCUKI+f7akGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102049; c=relaxed/simple;
	bh=MSyEDhlSoU8Puzubbj6qEaJ+2TU2CVDNruRtvJm6Lis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwpw44baAz8DGW0dQx0/vNudGQYeCVXkDefHf/T2bZN9allalUTbqGBcB06QFQL4OessnCKAAiLP3phuPFQaJM80JpPN7Hkd63bD7jnqwutM+OGd+OwHp0Aiuy0Tn68iP6PNBZCznt1QMpPfiOij5sNjzRA4tAl1TAOhkT8gyus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUBF7MHc; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUBF7MHc"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39394e1e8f3so22925961fa.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 04:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779102042; x=1779706842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xskhRMwYt31YiznnIqsP+p3rukkWTePKX8/4DT9Rytk=;
        b=dUBF7MHcAPVERjG94lZstniKLwoLdsmRDmMIiYpQqD42Xfy8Da47uNiFD0IFMM44fN
         a+bW4lm50Ku1+ZDvhnJG96Wf+ZMI/ibK2u3B+RpnejKoBm8t1B4CYwuVUeiYr+sAfS3K
         74hnPd14YFsPTCtfaCgIn1Hpn3xT9alqsL/D04l/ZObx+gfvq5YLOLQPBJQk+TH410/J
         PqbHv5HnPSTECsaIKHOtspNzJF+yXa0VKMY2GLw8h0ar67gKEGG8lx8KFCkEStAU7gtN
         lrqEqdD7pDUuMqYixSMr+S+ae1U756aB5SJCWWf5dcENE8ZN4OXDq7MBw+3hRO7QoWQ8
         5izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779102042; x=1779706842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xskhRMwYt31YiznnIqsP+p3rukkWTePKX8/4DT9Rytk=;
        b=ZpuKhWU0YJKJuaGDeufNvV/1HlyXNMqRaFOA0/x4Ca+v4W1+rWz9j15RGCceV8b5Sk
         MnL4pGui7qd/tq7BjzP5r5bBhM9uTajrRCcVVFMvXx3UuQ7WcJy3TCbxm8kUJnT1AIvj
         2o3NhqxJoFCf2hSVr8oY1WbMTYAQu+5QlYCMuU9drBTFjH7Zbq1ppQAkSTPqP2gsecck
         rTCCMUWAGwv44s3SwIMM2YvejLIh4cvGb5hQo/GASKBCLlomHt/0X3jyJQo56UBVesv6
         6ODnhhn2o/xMfUme47GIMrLNZDkxSI9M0UfvPlq76kV/sAycQPVkoNXfxQtKHUNs9TO7
         TrRw==
X-Forwarded-Encrypted: i=1; AFNElJ8TgRQws7SZbjTX7bSq9QIgcSzEXAGBj64KQTVd7bqo73UmKvPDXTFJ4Zd09ZQaFsOSUG//+FG17I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDjiycG9OMR6y/hLkeKhOwNwOOrLFRM5WAvrHhQfPCKXpIcdGQ
	my/fzR3qhV3ict3sLsuwtS1cETIwDr4mSBOR4aL56QZ8LJ2XOYxpFmwr
X-Gm-Gg: Acq92OEGKyVx3eHs4FaISn/4hAiUnZv2+NX5+FMRdZ9+LfmgYnDnhjW2LfRW0ZVPK29
	ZaQOCyYLwVIfNmjY86dhajfQHbNqp+/oMTuX9xE4GTperfp7HmHezlOabjbW5sddtUGiLlP9+ni
	hTPcho/jsIebosDLWIdY9FZGkhb95tSw+7NKd0ZCDwelyG+QL3/xglXHH+frPhSk1CwbnfCcDio
	+TCA/JI3ETf5fXEAvU0yVh+ByLaY+CZAIMw7Gp+dzL3xC16WDm4FB5u01S9f6wVGnI2IaZwo5AS
	7Mrk2ycAD09zGCx8y0r/oGGvfc0iHOCMUnuAGMWmObY7bzhkFRTzyJz37wzXgqwOWSL7PrMd3RZ
	jrUe/81nVY9vWXr3evxEACvZmn6/pr2qhdr8TiBwMuIw2Tl19wngZOeqgGXSassMeAy4OLk9gQe
	WyDONSOwSF9T/85RZURM0qtJtUdDefhoOKIpA=
X-Received: by 2002:a05:6512:2301:b0:5a8:f8b3:6c8 with SMTP id 2adb3069b0e04-5aa0e7714ccmr4197260e87.37.1779102041544;
        Mon, 18 May 2026 04:00:41 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.222])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc462sm3239263e87.45.2026.05.18.04.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:00:41 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andriy.shevchenko@intel.com,
	adrian.hunter@intel.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mmc: sdhci-of-dwcmshc: improve delay handling with fsleep()
Date: Mon, 18 May 2026 14:00:31 +0300
Message-ID: <20260518110034.142587-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518110034.142587-1-a.shimko.dev@gmail.com>
References: <20260518110034.142587-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently uses udelay() for short delays, which performs
busy-waiting and may not be optimal even for very short durations.
While udelay() is appropriate for atomic context, these specific delays
occur in non-atomic contexts where sleeping is allowed.

Replace udelay(1) with fsleep(1) in dwcmshc_rk3568_set_clock() and
rk35xx_sdhci_reset(). The fsleep() function automatically selects the
optimal delay mechanism based on the requested duration - for
delays <= 10 microseconds it will use udelay() internally, but provides
better flexibility for future adjustments and makes the code more
consistent with kernel best practices. No functional change is intended.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 0b2158a7e409..8c3ca47c8060 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -816,7 +816,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 
 	/* Reset DLL */
 	sdhci_writel(host, BIT(1), DWCMSHC_EMMC_DLL_CTRL);
-	udelay(1);
+	fsleep(1);
 	sdhci_writel(host, 0x0, DWCMSHC_EMMC_DLL_CTRL);
 
 	/*
@@ -895,7 +895,7 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 
 	if (mask & SDHCI_RESET_ALL && priv->reset) {
 		reset_control_assert(priv->reset);
-		udelay(1);
+		fsleep(1);
 		reset_control_deassert(priv->reset);
 	}
 
-- 
2.43.0

