Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D458F26AC3
	for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2026 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776891107; cv=none; b=IJ7Db5JAODTWtiOAjzvYxgb89ejqFedDYur0osEKmB7YeZGCeZGKsQvIVjDwLdh2Hs67WBxGoUvqpXSZDeBA0gPxmSzH5y8loufw+uABhNk313fL8e9SeSbWX0cSrCKRvKE5W60Mp54qJxU+oVXf3cGjSkXA2HlZG3IPr4n/St8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776891107; c=relaxed/simple;
	bh=/MdM4zNAe9OF5GrxNEY8RmxmGrouru2IIXRBYOjHm/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jG65XkOlTgxvOTPzi5gNYgUXVvd3+ISGLwaikcYs5SKkssZfhA7/EpirKySEZ/bk/tFx354/YMtBwWTOKUiOOBI+D1MN+I8HS2Gpdu1H7i/sNoW2PudGCLawqW2MVM4SEFYHwxdA7ejjqjtfRQarKlaKCWThpBlK2yp0ZrQIt6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WhpbW/IL; arc=none smtp.client-ip=74.125.82.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WhpbW/IL"
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-2e622a9da9cso6763955eec.0
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2026 13:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776891105; x=1777495905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xzt41TVKCZouhZEgOjcyJjpqLbXJS5Htsy76dWc7j+k=;
        b=Vi0KGYv2LDJfncvcH2DSsBFDj2MwVZ7d0d7v8qytpPQXx3/gFEylnPk79O0lHzJfl2
         fk9kCCrl9/XOohfk4DBrwyB51nKoAIf5g3b9g4HQJ5P2uHG4+DAzJp+UiXi4Fppwwr8s
         4xQT0RzvAh4lspWERCzkYrZG90f0KorpIcYAtgQO5OOucZoHe0qQOIBtRc+k7krRUAQ4
         fcBBPOIRmRG6X4defMv6S6Nf1E20mvrGbfjM7MycS8quDmTqBLDnmzUbA38MOHqaFqH9
         IBLMLVZ4YtmxzN4HYGwxXCm6N2fvbml/Ba9PgpmvkKn8kf+AmDG0udfzjcS7G4U8rdN/
         9bNg==
X-Forwarded-Encrypted: i=1; AFNElJ+QqkxCRFoPEHJT7fLo6y92qgry4oRaF6ChRJIH0HvJlOALYLOzM87FiM5+7V3ZJtpRn6vTga2y9VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCIg9daNTm7CpIaX8KTfnUEXS64xAwYLTjHBRhFp+Lx+x/ag5M
	mRo18SS04QDNtxxoRTuW+0rnC1xOJe8oo5KFCmnJEei2QIhfWC18i71LL3jGVbaTR7NxMHHPNNa
	kNIeF8fPmgrk/sJr+PEK+2okcFhK8jRWmY3SCpzzUv1U8/HIlzBHVzZ8Z0oicrCFzB9WkHvOgUT
	yw6GeSvkQ+mOraO5sFgCjAgQM6CTwe3pyUZ2DQlBdPT2zoiY73Zh3yFSVO/UdkdvH23e4FWta2G
	5puFY20WWhM
X-Gm-Gg: AeBDievhNYCHgjibm12rlzzyDXEq8zKGpxGypE80Sjz1iTXoWbdQ7kOBY1ylCZjdJn+
	LCG3SgnqaQkMW6OZEkKEqgug5AwK2XfuEqQdjFRd0wOyF6F+7qBqZI87xkeMzzQqn0lBmVaMrd8
	yJTpjZGy0pqTQpbkdlR+xu7QG6KVsDGgj1WQ7Bvh/Avrboo0Bv94kF8aKGF4Z0gnNXvsEpJ/2bp
	Ts2+QtXeeCIgq5JabolvFu6V2UTUqwGaxzKE8bDAk6A33VyjMJaIWJLmRXDI379RvoIXC3cEZwt
	uh6NhedunJg54eghhsfUtRbaGW9w/ilcs3aJXTpjm8+pndfRHcaXVCwZhWY2Sr+tII4ms+bS7qn
	5DBPyxZ+N+apBA6s2mLhVqdmQRdD4cFffjEqvakr0b+H4O7yAKdGxI/YLJrx3d3omk01j1Dixhl
	IStkLMkMQc+wV9SY/tMOfNqOU8DzoD1Wl2q7oRdPfo2uH+mtEedligiu99LWak0xcO
X-Received: by 2002:a05:7301:9f12:b0:2e1:e3e6:2910 with SMTP id 5a478bee46e88-2e46577039dmr15590342eec.9.1776891104943;
        Wed, 22 Apr 2026 13:51:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2e7025cf2ebsm934771eec.1.2026.04.22.13.51.44
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2026 13:51:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8acb85a973cso84045916d6.3
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2026 13:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776891103; x=1777495903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xzt41TVKCZouhZEgOjcyJjpqLbXJS5Htsy76dWc7j+k=;
        b=WhpbW/IL8W4Np7Q/f8TBL00cXGGbpqsLUMv5+bQgLmE+Mtjv9MigwvWjv5BIgpjZ9I
         o67dpEJVyQxxeN/Nrh7Q8ITbnF7TSYLl1HmJ82VXJSj4rr3sAlAsN5z4OrXfWlMlXnAz
         2FvfQ9aH1ZMuIykA4AsCy9A6G9TU96YJYV7mA=
X-Forwarded-Encrypted: i=1; AFNElJ9MMxhso/9DKDVdTtrk19m3LHsHELysPoYVsevpbNlLcq7C+BSzVKHyv8+GJAb5PzLL1ltZyssAO/U=@vger.kernel.org
X-Received: by 2002:a05:6214:da8:b0:8ac:82f8:369c with SMTP id 6a1803df08f44-8b0280ecc7fmr412678926d6.29.1776891103558;
        Wed, 22 Apr 2026 13:51:43 -0700 (PDT)
X-Received: by 2002:a05:6214:da8:b0:8ac:82f8:369c with SMTP id 6a1803df08f44-8b0280ecc7fmr412678546d6.29.1776891102978;
        Wed, 22 Apr 2026 13:51:42 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae88d5fsm171453486d6.39.2026.04.22.13.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 13:51:42 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	William Zhang <william.zhang@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v5 3/4] mmc: block: Add helper to look up mmc_card by device name
Date: Wed, 22 Apr 2026 16:50:52 -0400
Message-Id: <20260422205053.3392395-4-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422205053.3392395-1-kamal.dasu@broadcom.com>
References: <20260422205053.3392395-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add mmc_blk_get_card_by_name() which resolves an MMC block device
name (e.g., "mmcblk1") to its associated struct mmc_card by opening
the block device and traversing gendisk to the mmc_blk_data private
data.

This is needed by the mmcpstore backend driver to find the card
associated with a given pstore_blk block device path. When mmcpstore
is built as a module, the eMMC card is already probed by the time the
module loads, so the helper can look it up directly.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/core/block.c | 54 ++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/block.h |  4 +++
 2 files changed, 58 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0274e8d07660..61cab04f7dfe 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -3381,6 +3381,60 @@ static void __exit mmc_blk_exit(void)
 	bus_unregister(&mmc_rpmb_bus_type);
 }
 
+/**
+ * mmc_blk_get_card_by_name - Get mmc_card from device name
+ * @device_name: Name of the MMC device (e.g., "mmcblk1")
+ *
+ * Resolves an MMC block device name to its associated struct mmc_card.
+ * Used by the mmcpstore backend driver (when built as a module) to find
+ * the card associated with a given pstore_blk block device path.
+ *
+ * Returns: mmc_card pointer on success, NULL on failure
+ */
+struct mmc_card *mmc_blk_get_card_by_name(const char *device_name)
+{
+	struct file *bdev_file;
+	struct block_device *bdev;
+	struct gendisk *disk;
+	struct mmc_blk_data *md;
+	struct mmc_card *card = NULL;
+	char dev_path[32];
+
+	if (!device_name)
+		return NULL;
+
+	snprintf(dev_path, sizeof(dev_path), "/dev/%s", device_name);
+
+	bdev_file = bdev_file_open_by_path(dev_path, BLK_OPEN_READ, NULL, NULL);
+	if (IS_ERR(bdev_file)) {
+		pr_debug("mmc_blk: Failed to open block device %s: %ld\n",
+			 dev_path, PTR_ERR(bdev_file));
+		return NULL;
+	}
+	bdev = file_bdev(bdev_file);
+
+	disk = bdev->bd_disk;
+	if (!disk) {
+		pr_err("mmc_blk: No gendisk found for %s\n", dev_path);
+		goto out_put_bdev;
+	}
+
+	md = disk->private_data;
+	if (!md) {
+		pr_debug("mmc_blk: No mmc_blk_data found for %s\n", dev_path);
+		goto out_put_bdev;
+	}
+
+	card = md->queue.card;
+	if (!card)
+		pr_err("mmc_blk: No mmc_card found for %s\n", dev_path);
+
+out_put_bdev:
+	fput(bdev_file);
+	return card;
+}
+EXPORT_SYMBOL_GPL(mmc_blk_get_card_by_name);
+
 module_init(mmc_blk_init);
 module_exit(mmc_blk_exit);
 
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 31153f656f41..08798c56dcce 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -17,4 +17,8 @@ struct work_struct;
 
 void mmc_blk_mq_complete_work(struct work_struct *work);
 
+/* MMC block device helper for mmcpstore */
+struct mmc_card;
+struct mmc_card *mmc_blk_get_card_by_name(const char *device_name);
+
 #endif
-- 
2.34.1

