Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C8F39A047
	for <linux-mmc@vger.kernel.org>; Thu, 21 May 2026 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348127; cv=none; b=ufzqohlrX9qUPlzc02In5fX+N01tcpeW+rFZ6j7DuMT5j03XjTgAw5WoBHdXtKkBS6p1/rEZQ+rABcx4rjL87x2ubKOT8k4oMMKnG5gm4OJOleoOl5qmQaozf0roVfGs2YkFQK/JO1HemWQ5TmVoBcvreU/u6SfU3mFb1yGYGsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348127; c=relaxed/simple;
	bh=s4R2Qr199Q0coUmKNOJQZtFnltSpVGAoB1aOSOudBX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcFGl1N6nZKRGqhyl36LRuSHUzU9rpeai6/18eNDScE0/AJt4jdpItZAe8h929Pkhui8u5Nb36bq78CEkWNtGtMAQR7Jdrp7/CK4gRMHCap8UevhXnhV9hdHzmIfohKVy3gPftDSjRRvba47f4qmLvpVAUxCACvMhvIBgtc2kBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oj+XH5aE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oj+XH5aE"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82f8893bff3so2650818b3a.2
        for <linux-mmc@vger.kernel.org>; Thu, 21 May 2026 00:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779348125; x=1779952925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxmsocRTSr0oM4XOAp/+uZK3GT7M6xq1xF4d1oUBSdc=;
        b=oj+XH5aEab6/JiVapGJmdZwtDx7qoS8mUMgzc7fj8vbbBZ3QvpYG5aTvJo4mhtTzm6
         ZtIyXnK+LWqEbput21K0qJi2KoEeRNSD5HDCSTGYokbt+EUsF7k9yzl70BEduJ3aIgxd
         yK7Y0LKq1zJBSwb0AVOp598aziGSabm1fv/8Gwqo3s3sFUI54DvN3I54w0rwlLuEgISf
         6TmzhA4lL/mWENAgAq3GOWmXho1vRi/ZwsjjtX9u0ZWQPtrUSgPLx+Oiob5fY/w40QOR
         D8pT1PrxkfFgYaGq4M9DVNLy0I3d0c/zc3Qt+jjGDdiTxM+a06eJJFcNVIpWgD5QuJRT
         oa6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779348125; x=1779952925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mxmsocRTSr0oM4XOAp/+uZK3GT7M6xq1xF4d1oUBSdc=;
        b=Sj6SBPVJCbyUbOPbTQPlvtWZLX5sdTB4ZO9/k9FHXVF3Xa3noYW8EdU5RlRybiv4YH
         6GSbwGoZk7324Woy2EIwEHBEzEwO7KVINlyXeB7nL58x5iIDH638yDs0W3hRWRprg4zo
         RIZak4doRotSNKwwucI3XhBMCqMlvSv4PaGH6ofOzjU1neAHHYiEAidFjWu4r7Ep1wC5
         F+KBEunmPWNQB7fwwDu5n3gYuH2XDU0Wgv9sz4wijVVFvO4P8+x/C6kObXqjO78D6rCH
         QgrSmk6M30b2TDIFwD5FaFpGH9psMBekW6xMAzSNhjJVlmEguwejgBylYAJmdLH96PjW
         V0Jw==
X-Forwarded-Encrypted: i=1; AFNElJ/9QahOMc++J7sfJ2ZMrZuYpBssldrBHoV+6p/XwabtNzmHfpyOS3IlCoFxNkfdRUM9brxmf93Frno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQtq/ANURbPXndec/O2ZF69leRxkMXU/TKhysFFM/4fsnHtLgp
	4xMbZYhIE9ujP6x0iNhVC1uE/MUqBX7lRCJABFXBLBL8MVdJe2+6Cajs
X-Gm-Gg: Acq92OH41r8zZPdBSntFMvcIPKMdWOFD26j+yzD7U61Wz7xRPjMMrN9BaGlxfvAqtdR
	BnWuUq4YwGRLxX1Hmf5JmwyP+N5+LZxEi0OZZL+8TJpZt3kuMoCdK8z0Ce3T+stOBAaMYCEoMSM
	KidW8T3yz1Lu99jq7Dd6zPZ4ddGG1ddsk/GBbGOdpVuy0rQB9XcrpbrPRK4h14Wa2JPAHTyBUvV
	o56eRpB0FnBfzth45djnD0UF8n5yCsXxzlpcp1PVZq9bhBY4e6j9HfuliUf7mZTwlZzFmQOdYt7
	f6qfqizrpqKL8pGQupcYJl9uHNecBTvAEDevVrAGm2vPqxsjlHbi/KAiWRwD+X5frOPUVfpThkX
	dBVcyVawuqVq3eE8hzDaOhojxdS4oF1ytp3tNwKl9eqBRKWbdRtNbuVZLr0vZLD6OhK1jVNqfJ6
	WM0TGD9HildPlDa7w7AxljDCc=
X-Received: by 2002:a05:6a00:4501:b0:83f:250d:5ab with SMTP id d2e1a72fcca58-8414ac7a05emr1801583b3a.7.1779348125528;
        Thu, 21 May 2026 00:22:05 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84154a00089sm306760b3a.20.2026.05.21.00.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 00:22:05 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Maciej Dudek <mdudek@internships.antmicro.com>,
	Paul Mackerras <paulus@ozlabs.org>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v5 1/2] mmc: litex_mmc: Use DIV_ROUND_UP for more accurate clock calculation
Date: Thu, 21 May 2026 15:21:20 +0800
Message-ID: <20260521072122.1601215-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521072122.1601215-1-inochiama@gmail.com>
References: <20260521072122.1601215-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous clock uses roundup_pow_of_two() to calculate the core
clock frequency. It does not meet the actual hardware meaning.
The actual frequency is calculated by "ref_clk / ((div >> 1) << 1)".

Fix the clock divider calculation.

Fixes: 92e099104729 ("mmc: Add driver for LiteX's LiteSDCard interface")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/mmc/host/litex_mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index d2f19c2dc673..52571bb17c61 100644
--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/litex.h>
+#include <linux/math.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -436,11 +437,10 @@ static void litex_mmc_setclk(struct litex_mmc_host *host, unsigned int freq)
 	struct device *dev = mmc_dev(host->mmc);
 	u32 div;
 
-	div = freq ? host->ref_clk / freq : 256U;
-	div = roundup_pow_of_two(div);
+	div = freq ? DIV_ROUND_UP(host->ref_clk, freq) : 256U;
 	div = clamp(div, 2U, 256U);
 	dev_dbg(dev, "sd_clk_freq=%d: set to %d via div=%d\n",
-		freq, host->ref_clk / div, div);
+		freq, host->ref_clk / ((div + 1) & ~1U), div);
 	litex_write16(host->sdphy + LITEX_PHY_CLOCKERDIV, div);
 	host->sd_clk = freq;
 }
-- 
2.54.0

