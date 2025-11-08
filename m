Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB2829D27E
	for <linux-mmc@vger.kernel.org>; Sat,  8 Nov 2025 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762643616; cv=none; b=TNkBTw/7/3xtM9ZXZgS8uKyOyXwPJ+pI8moxyadYXLE1GSJO83W+HveR0OsZ/eCjQ3PVf63O1wmm+Dh6+tnJ4a71/7bxEqonhr7e6xEwMzGpdLWUVRHxacuM6s+L2qFFJNuK8snuoQkGAbrt/o62d+IvJSqEOAjyyMnxP90c8So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762643616; c=relaxed/simple;
	bh=2sKf1rUf7Yyibfx/hY6iRlou4EFmIhXP3XoaRsvqQGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHtRum/Aq5bF/7/AKc8vr3I+CLrWOe65rrL5KJkZ6NSQqNgZWJETEIA2TlocUprnmg97/TWgWvKsEjoj0F36B69U8e3m95enRzJcmZ5herPZTN3NSXai4gi8Ee3owFF259TpqKTGYRtmzdpWpxySYp+TbZTbQvfJqRfhm0SNVKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hRDC9uU1; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hRDC9uU1"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so2875449a12.1
        for <linux-mmc@vger.kernel.org>; Sat, 08 Nov 2025 15:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762643613; x=1763248413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp3aBA3u4fWo7xiq7xdD0SMcDBXI+jskP2t4r2Vw08s=;
        b=hRDC9uU13Y+ZrcO4icz5roJCxCUEROE98mBcIdH//AQTN7CaWGWRcm+zC7TpCEs7U6
         uLKhhvclo14cf0I81Euo5QNfcG7Kh6Lgwe2UczskyKxsNuUqlyQuqWzAJJgQ+Rfx/fTN
         5frLrGIzt4n8Gk9M+6ycTlbZwmqbZ43Wlus2RKrfOCPIXOS9RBhOgEHY1XuQMrTHi6iz
         it+uLUsoALIs+yVBOyInDfAPmjP6LstpavisR6MsP8Dk3ZVGo618SO6s/xSsSd3O7LgJ
         Lm8tBuMMWjuxTZfW9Rxcm3UkUlyjYWUR3qfHhYHgeaoxDePQ8Uh5FqdVkryu3gSo/ZDR
         v5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762643613; x=1763248413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jp3aBA3u4fWo7xiq7xdD0SMcDBXI+jskP2t4r2Vw08s=;
        b=Z2Z00Nb05z3ZJkbwxLHi9RL+FqjDWXX7GPVGHMs/+gclXif7qvG7EZLxo2cY+E4yPn
         SqYwRXL+0JNUVQPlh9hrjHpEyZV4uqSW1R9OI4RUdqkzpBDz1pym4gvI7aEwlsX7XafL
         UAqFbyJY2H+GBt/D/A1LoI5QpyXmlZxcR0UiEqfMOl6agcjikGMb+xrx29xtA8h5hQV2
         2Y6ayYrSTycuA5z32hupzUjHH9SpusXfw/0g/1nRUAKHcYa8XY3Y2fWgad3uckKHW/j4
         gr+etZadoHl/cVE/zVN1V3G6mk7uFEuRX8LEiE30YBBXNI05ROkegwklnri2/rcpQjh7
         KvvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7rdOOfoS512JJw5HclxIss2hvt+fTP5cSE9aH+mfYRB7wsraPC6D8nuGyRVHhJAIDoWTDlTvuObQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFxy6EZroURXvuCXS7qa/ua4LnqUQtgeYZp9XhhperFrZkPEx0
	cfcIDkzIGaCNnunov8mvYR3lBGHa2Mdmq8FI2enp8wrpEnwOOueapNlnE9dGxA==
X-Gm-Gg: ASbGncsG5ohTVTkKX2xfheglvoE+ISFdUBVDsbIlJmv24kfe9XSIgYjQId3xIBTmjOL
	XAM0kkkLGauQVgRRDV1jyYuZaysTalLG3GYEZfaqHa2qzQNRb1e/dlkrTD5zuh24So2uILk62R8
	9jOh+QVV49eoocIKjYQhDYFVqGBC49END6bA5s2QrPJDyhciiZ6dRx4qaYvcqa/v4RmhGljOsyE
	d3jg/40kk/AVQw7vau17IaqamIgB1jU3Gjqd4HqTPuTli5Sxg31SkaOiJCPI3UEEnh2DFqCU3WW
	PyPB3wY/dndf1Nx9XWmRxlirMOU3IZ3lr+MqAi0xwmM4InsrOOOeyC0y65qg9IAr5gFBR1gMWfp
	SqWdPOVOkUsa69HPttIlN1OrHEo4CoNjXmiQ0Fl+r88vQ/haMjh9Ze9q/FqLMafWBwZt6UhGr96
	ZVMFfPuZVZ88SNp6yVokNJ6ld2OXh7utvbH1fJXHywSMKDUZGP3odVvWTmgD3HMbpgcH7wRys6v
	T5V4sFAgVJ7stjBvUgQZxJWsfiqRymW
X-Google-Smtp-Source: AGHT+IGemsR0OuxveqoCLuvT35vA4jAjT0f4VTJglt6MI1GNIHLfcz8g6Jk7qZLukmNg7JdbfDQkvg==
X-Received: by 2002:a05:6402:4415:b0:634:6d87:1d28 with SMTP id 4fb4d7f45d1cf-6415e856c10mr2612380a12.35.1762643612939;
        Sat, 08 Nov 2025 15:13:32 -0800 (PST)
Received: from blackbox (dynamic-2a02-3100-a9b3-6600-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:a9b3:6600:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6411f814164sm7642807a12.13.2025.11.08.15.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:13:31 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 7/7] mmc: meson-mx-sdio: Ignore disabled "mmc-slot" child-nodes
Date: Sun,  9 Nov 2025 00:12:53 +0100
Message-ID: <20251108231253.1641927-8-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
References: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The meson-mx-sdio (and mmc core) only support one MMC/SD/SDIO slot
(device) per host. Thus having multiple mmc-slot nodes (one for the up
to three supported slots with one device each on the meson-mx-sdio
hardware) can be problematic.

Allow specifying all slots (with their respective device) connected to
the meson-mx-sdio hardware in device-tree, while making sure that only
the enabled one(s) are actually considered by the driver.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdio.c | 37 ++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index e8b63dc45dd8..5921e2cb2180 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -493,23 +493,30 @@ static struct mmc_host_ops meson_mx_mmc_ops = {
 
 static struct platform_device *meson_mx_mmc_slot_pdev(struct device *parent)
 {
-	struct device_node *slot_node;
-	struct platform_device *pdev;
+	struct platform_device *pdev = NULL;
+
+	for_each_available_child_of_node_scoped(parent->of_node, slot_node) {
+		if (!of_device_is_compatible(slot_node, "mmc-slot"))
+			continue;
+
+		/*
+		 * TODO: the MMC core framework currently does not support
+		 * controllers with multiple slots properly. So we only
+		 * register the first slot for now.
+		 */
+		if (pdev) {
+			dev_warn(parent,
+				 "more than one 'mmc-slot' compatible child found - using the first one and ignoring all subsequent ones\n");
+			break;
+		}
 
-	/*
-	 * TODO: the MMC core framework currently does not support
-	 * controllers with multiple slots properly. So we only register
-	 * the first slot for now
-	 */
-	slot_node = of_get_compatible_child(parent->of_node, "mmc-slot");
-	if (!slot_node) {
-		dev_warn(parent, "no 'mmc-slot' sub-node found\n");
-		return ERR_PTR(-ENOENT);
+		pdev = of_platform_device_create(slot_node, NULL, parent);
+		if (!pdev)
+			dev_err(parent,
+				"Failed to create platform device for mmc-slot node '%pOF'\n",
+				slot_node);
 	}
 
-	pdev = of_platform_device_create(slot_node, NULL, parent);
-	of_node_put(slot_node);
-
 	return pdev;
 }
 
@@ -642,8 +649,6 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 	slot_pdev = meson_mx_mmc_slot_pdev(&pdev->dev);
 	if (!slot_pdev)
 		return -ENODEV;
-	else if (IS_ERR(slot_pdev))
-		return PTR_ERR(slot_pdev);
 
 	mmc = devm_mmc_alloc_host(&slot_pdev->dev, sizeof(*host));
 	if (!mmc) {
-- 
2.51.2

