Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529113EC81D
	for <linux-mmc@vger.kernel.org>; Sun,  4 Oct 2026 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109762; cv=none; b=fe+AUjMdtXUAb3TlojisIwYoK+byuzMBr5chLWEEvfPbdmbjEiyATt4ICdkuh+ezr0vVanFFUzLPMVVEyIi4xuxNmUVN5y7Nc8ChjMarbIq8Z9rTfnTf1YxAuvFGtDIX95ugbxZLURZxwLpEQahKIgiCz+2G4wEYgx6RDeo2n+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109762; c=relaxed/simple;
	bh=qEEDNIIgAqO7jksfknN5V5LFPWfqIbRC22R80z62+D0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EqLoKfnBhSpqOeKCDI1eWrT9GtkLNV9ZwosRxPIgM13nFw4W0a0JjTeA1hsH4D7uSKNkNSk+T7J5bvnC+aRRdxg/YzyqpBg3BmNwE70SiOnlkY+kPl6IznCyIAok4owRynS1sM0OmrgBvef7WTIyMC/YE74fphIMwkVyiy4hC9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln74raXS; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln74raXS"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93a40a9a01aso51482185a.0
        for <linux-mmc@vger.kernel.org>; Sun, 04 Oct 2026 03:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791109760; x=1791714560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hW8RzTH4aLcm4TzCyMXmpOH+i9c92hojU2ChQeD95CA=;
        b=ln74raXSrVTesrfs7jlLnTNg92LxVg+/jDkDt8bGr+CDGUZ+649K6GtgaHBQjah22I
         QRKXjcsP6IP59LLQNfHYF+V4VD1L+1BQA+KAUvGWkInV5UWxRN5OBkYKOSc16TvKyFO8
         14ieVLdgSiqx50l3A8wjx4J5jdqSSu7gLTX22YBj9UJj4bNn/pV3J7Iy3g//IYg3wA2v
         TRoBfPW2/vDY1y9Ox0gLMG381X5CUqsID23lrU7B87aED4qqFLUv8+TtuZItYZ9FyGxc
         6bI6RTKncpBj5FIxXRkGbPAqtJW/Cu1DHTRWuHNtWS7TI+P81Ws0IdJqwE8VCMmbhVdR
         Ggjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791109760; x=1791714560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hW8RzTH4aLcm4TzCyMXmpOH+i9c92hojU2ChQeD95CA=;
        b=Ehy6jm1zg9hX2GstyDL/U6YJIvuzSAsnT42KLNmQu75di7dOf21JGFj9lWUV6CRtdn
         31TuZLAi43pKKYN5548576yrHHp3jQdMEPdBMg7bpm4pDAuzSblZiXwSHX8DPa7m7dE5
         cU8lW8uRFCJuaZv9gIvLwKxI7FMCbraYgjSu//MJP5rQqsQ8Kvs5QubzsDU0pwvk34hz
         e285bnTIYrPU+4mGaqDQaEFDdVNAJmFew3Yh5qIv72NLZgevqlBb4mafxQHpAHDNQb5i
         dh22ZT22oOiShLDX0FXzpntToRypDv21DDon2hWP3m91Ilz7KHuHBFYvMCqFWdf8yphm
         SDTg==
X-Forwarded-Encrypted: i=1; AKwUvBwpd7ltUNNmIa0syeakCn0rpAnxQhfy2SdT4tD4DAvAnjh2SKxDFTz8k1kH7GBn0/TmxJ2BHQGo3LE=@vger.kernel.org
X-Gm-Message-State: AFuF++mqOEgY08T/7p4etmjhPKll37kE+aot0C2wyZGTzBOmO96Wzg/7
	3TkWEYtZR3KC9JS6MFXZkgdr5Dvs7u1Z7Zi2IvUEVpBmRfSBzbxCHlYx
X-Gm-Gg: AYBFou1kXu9lcUiHdke6dXoJ6NCYLhBSHFsjZ4tiy0jTET4kV/AEW/EbQ5ALBwkLBww
	7cPTqnwfkghWNSHO48t4fUxkxHsZmGyvVnG+pbVYw4TREW0UoZBett4tDeVYaOke9RtnKf6cjr9
	K6sjpU1ksSwtccoVN0VNMqU32u5kN+UgBh5JCd/QFKPaq/7cs2kRQMKX5zITqJlxnsAgozhg3UT
	abEQAetshItdzRiJ7jtuy6UDNxc5Ur4quI1JyXKj/O9fmT2GiqrX6UQctr92sOcz+TIh9gLkx2M
	gTkvUMobcflgpWVWUm69Ra/W1vsz7LOGgAyuRe5SiO5nLbHtzEzzMSfvoJ9f5nV6GuheHGdpJw6
	1wBaIXuWC7cLIeVgtzDx5+nczq8x5BDYGAVdBwYW2RFgNofC+gkMP4HI7Gq4oU0hnIs4rHwH3Xt
	WeViAgAe2FGBkRDSYc0lYl+yZw+5xTonIaW1upa0yttYQCU/hLx8ka1YLIQ40K1KZ9QkwWGgZfN
	0fUUQFn+d7BuTX3th+4CW4j/DX8t2dcjcVaIT3PGEMapO4fRDrCfiUi79bQiA==
X-Received: by 2002:a05:620a:1a10:b0:93c:65e3:df81 with SMTP id af79cd13be357-93cb5a5be1bmr1958241885a.13.1791109760089;
        Sun, 04 Oct 2026 03:29:20 -0700 (PDT)
Received: from Precision-M6500.home.mulloy.xyz ([163.252.155.132])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca2b2413sm635381685a.41.2026.10.04.03.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 03:29:19 -0700 (PDT)
From: Joshua Mulloy <joshuamulloy@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Mulloy <joshuamulloy@gmail.com>
Subject: [PATCH] memstick: core: don't clear dev->driver in memstick_device_remove()
Date: Sun,  4 Oct 2026 06:28:48 -0400
Message-ID: <20261004102848.34563-1-joshuamulloy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memstick_device_remove() sets card->dev.driver to NULL after calling the
driver's remove() callback. Since commit a995fe1a3aa7 ("rust: driver:
drop device private data post unbind"), device_unbind_cleanup()
dereferences dev->driver after the bus remove() callback has returned,
so this should result in a NULL pointer dereference whenever a
MemoryStick card is removed or its driver is unbound.

The driver core clears dev->driver itself in device_unbind_cleanup(), so
there is no need for the bus code to do it. Remove the assignment.

This was found by code inspection, with the help of an AI coding
assistant, after hitting the same bug in the TI FlashMedia bus code
(drivers/misc/tifm_core.c), which oopsed on SD card removal. It has
only been compile-tested: no MemoryStick hardware was available.

Fixes: a995fe1a3aa7 ("rust: driver: drop device private data post unbind")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Joshua Mulloy <joshuamulloy@gmail.com>
---
Compile-tested only (W=1, no warnings, current mainline); not runtime-
tested. The same fix for drivers/misc/tifm_core.c, which was tested on
hardware, has been sent separately.

 drivers/memstick/core/memstick.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index e03989c4e..06ee6faed 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -100,7 +100,6 @@ static void memstick_device_remove(struct device *dev)
 
 	if (dev->driver && drv->remove) {
 		drv->remove(card);
-		card->dev.driver = NULL;
 	}
 
 	put_device(dev);

base-commit: 6addb4f385570ebc11c4eb499a4f1c149f313e84
prerequisite-patch-id: d9a5a385ce2ccea3eec18ee2168d603e951c6374
-- 
2.53.0

