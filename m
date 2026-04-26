Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DE8346AC4
	for <linux-mmc@vger.kernel.org>; Sun, 26 Apr 2026 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777202427; cv=none; b=LT6NFXUhXy3/EsRZT9qF4rgqS7gBUMw5yiubYBG4xff7ncE71qcKVf1di823JMv+dJAMN083T4CJ/SNj3zGX1i3zVSmfQHgj3xjnLpgcay0uvoHFr2kHYzuh34WgbUNCEKlQsA10eGc7aNFRpqZLDd8W70kTQWKtDMO2ztHK2GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777202427; c=relaxed/simple;
	bh=bG2zBrY3qw0s2P1gYnpnNoX+lHQeviL5Du1IZaWyE3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzhTUC9gKf9yqx1g6GIEXZKcN+AT43t/tWQs2XIW65LA7kS++mtyfQQ+DYiR6uZhuON80gyl/LFnQ2rkeZk6oGmKeA9nZ0LnOSvJlGpyGbzopqWWgX9AdJ6jgEb2yuNwYfOj3W0w+8wTJOZX1ZiqnBLgIgCVTl4YR87RvjPHotc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfXOMUPR; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfXOMUPR"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so7437780a91.0
        for <linux-mmc@vger.kernel.org>; Sun, 26 Apr 2026 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777202425; x=1777807225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wdo3ksYthQDcmZhSVKG64aQtgARx5zLRRRD/vMA4ac=;
        b=OfXOMUPRH7M4KQjzUWWeqPPODQsGGNVv9t0JDnrA3v91Xjm7of2+Mm9STuh/VjJTHt
         5vBF6NnWcitavjFvI0ZUBOw42fhzQmMKkLK4G22XBZt9q5syYRmx23jk9Ody/rwHvXJf
         rpxCZwyFccml+C3sSp6o/n0ncZ0alc3Ma+9/aaFkMO/8xAgt7m8niVuPQZAGW1qMGilf
         vT6fStcoOOuVkS6hOuos4KIQHU36+RFsueUxTN3Yhx5boLi+l2YVHwx/JGJzthe7vC5+
         Wbp9coh6F0k63bVec067Bs5LOndobri4tuGt+6nLOjALbzAavndT+CbyKr5S5Dgoxgmf
         B7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777202425; x=1777807225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4wdo3ksYthQDcmZhSVKG64aQtgARx5zLRRRD/vMA4ac=;
        b=oQ4/Fq/pR3hF23M8fAK3JoPMgOF/sf8/K4AdoFhqep1z2vXlPckW1J7eZ5YNXF08F7
         qYz2BXLChuC5DulOIZNhvlb/NubfjRDAuFh5WE+T854aMlEAbR/SQZEGOtKF15Ojf8xZ
         IGAdwKgzDt4j/olosmswfSztzeiwzd5Nfe7mC7jiRxAuQ1wL4vH0SnEv546McC73t08X
         5XkxhkjMc3dfnoRRzN7FCYv3I1AH+ectesEA0d5gvOyv9h5keN6VX2/Fp45EIPDGL9/Z
         Wba+Au01qM3csgAFFZqeQPNNsOXn4JqvOBbx5QclyNwigUZ+zjqrJctQJOuSkEmlFC/y
         vpdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9d/jThSlvAH/j5w0cNrI4kvHRCo4jqXcJdUqF93cHKds0ayu7LlBISO2n6nmJ3XuCkzD8WSJHwsd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt2PSkeP7iyHRSeH2pSVsPe+JRADPRZ6Hm/9p89iO2gXw1Ix7C
	aD/2MgMiw+qyA9QNk9CU1G5hgJhlDvEKRfaOjzCUo3NX7/nph/FaTgcw
X-Gm-Gg: AeBDiesVlkon8r2OwtkVwr2aRDR1mrJn/Iviqilwz6hvm4MOwIemB4nv+IZAZ+K2mrP
	FUPQ+Kq7Dlv4Gj/0YXs0gZKi7sE1XdW8EN4pAnB1gR/2N0CKI3vskq27v4NAku5VSYl6TqHJu1G
	Jit0JRAOEulI8Kxt72nfjx2fD+apmZ/CAYSDyANQ1I0qAuA5pvzvrbIFtQsYSD0pxwAurnB2BY5
	7IE0qZUEg0xa/+6YcgGP9j2nSTRJW0RRJNZmx4ORBNAYolrkJBWYKwHO0yR3AW74oFuwKr8u97n
	CRC/EdPb3MhCOMvLBelv/u9T62ivGf2yY3OLzdZs+G4fLYbWqILIEKV8+AsCXuZp/8RmCSmrF4e
	DCnOE5drJqWOzHQbZumA5UCe80yiyWfdDrK4qii5XIuil/io2bHZvA0it7/SuHcZW4sSUIRrRcy
	fAtGL1EfRcAbH/QqkjT/Xk0z42X2D/zVPbkw==
X-Received: by 2002:a17:90b:4b44:b0:361:3224:2f65 with SMTP id 98e67ed59e1d1-361403bdd07mr39297040a91.3.1777202425203;
        Sun, 26 Apr 2026 04:20:25 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410bac6dsm28298544a91.14.2026.04.26.04.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:20:24 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Paul Mackerras <paulus@ozlabs.org>,
	Maciej Dudek <mdudek@internships.antmicro.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 1/2] mmc: litex_mmc: Move litex_mmc_setclk() to bottom for reuse
Date: Sun, 26 Apr 2026 19:20:14 +0800
Message-ID: <20260426112016.1370929-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260426112016.1370929-1-inochiama@gmail.com>
References: <20260426112016.1370929-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the litex_mmc_setclk() to the bottom of the driver, this
function is needed to set the idle clock for CMD0

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/mmc/host/litex_mmc.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index d2f19c2dc673..a8d9c0ece16a 100644
--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -99,6 +99,20 @@ struct litex_mmc_host {
 	bool app_cmd;
 };
 
+static void litex_mmc_setclk(struct litex_mmc_host *host, unsigned int freq)
+{
+	struct device *dev = mmc_dev(host->mmc);
+	u32 div;
+
+	div = freq ? host->ref_clk / freq : 256U;
+	div = roundup_pow_of_two(div);
+	div = clamp(div, 2U, 256U);
+	dev_dbg(dev, "sd_clk_freq=%d: set to %d via div=%d\n",
+		freq, host->ref_clk / div, div);
+	litex_write16(host->sdphy + LITEX_PHY_CLOCKERDIV, div);
+	host->sd_clk = freq;
+}
+
 static int litex_mmc_sdcard_wait_done(void __iomem *reg, struct device *dev)
 {
 	u8 evt;
@@ -431,20 +445,6 @@ static void litex_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	mmc_request_done(mmc, mrq);
 }
 
-static void litex_mmc_setclk(struct litex_mmc_host *host, unsigned int freq)
-{
-	struct device *dev = mmc_dev(host->mmc);
-	u32 div;
-
-	div = freq ? host->ref_clk / freq : 256U;
-	div = roundup_pow_of_two(div);
-	div = clamp(div, 2U, 256U);
-	dev_dbg(dev, "sd_clk_freq=%d: set to %d via div=%d\n",
-		freq, host->ref_clk / div, div);
-	litex_write16(host->sdphy + LITEX_PHY_CLOCKERDIV, div);
-	host->sd_clk = freq;
-}
-
 static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct litex_mmc_host *host = mmc_priv(mmc);
-- 
2.54.0

