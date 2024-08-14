Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3D51B5830
	for <linux-mmc@vger.kernel.org>; Wed, 14 Aug 2024 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649771; cv=none; b=lLxAPfnDc++dqjXiQRlFI3etDkYBq8CDOrAie2RLf5KSZ45MxrPM0V34Bn9HMi9ZDGXDHmcuKEpmyI5tNFItvpZ7PpCO7zJWfUL+BwC5YkBcx535c6ZxpoO67A0iMU46aSmzIk3XCbqorFJP6e2glDNIse/PfFfplKCB/zALDpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649771; c=relaxed/simple;
	bh=TLTnACuF6zUxOrMx1fl47TmKuK1MR4tFwBHrYvWTXJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sVj/I5b9qY/Qo+S/Rn8jacR/DdDbNdFOnfdmf5To6Ni83Fn8y61hyFvgVb4OeG9FzEhen4a4+JKKawKNDj+NW61GcHObSVsbOBkHLsOcfuACniHzIAs/NfIkpHx/zzLIf2UF3SVrAEH1wgsK7mm3RZby0L0SRD4hQBTedkFHH1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BJEwBaAJ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJEwBaAJ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso1601266b.3
        for <linux-mmc@vger.kernel.org>; Wed, 14 Aug 2024 08:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723649768; x=1724254568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+aryMasYs/gXqwtFFpVZSSI/5hoMDFrBKm2XkRANNE=;
        b=BJEwBaAJbb2X51LAXRSFLJFQisaeWQX5pkf9b1sn71MLxYNrZc+E0ZhvVqmHmtdS0q
         sCRRZ6xwRtWQ5E+omdvciRJfPC9N1ZwoxFgPTU2g3i7NiDuBcKGOhwIlzFsqimAV6Y1R
         yTL68XI6DUPNByKSnza7IiefUTgAWk6HJpknoSzr+OsysFO3jZuqcn7cW2DJ7Pj4EgYX
         BtdOmf/FKhwep4DX+7uC3DnFmeUaqed78GlQNsR24+PNPbXd6D9c/8tkmoUiTy2jF24w
         97Q6yeSSMRzoLxSvkAYb7J59TjDlhmBW/VbcMGLtFdpsisLGd0EgKezKfypIF3ibXvDX
         HgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723649768; x=1724254568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+aryMasYs/gXqwtFFpVZSSI/5hoMDFrBKm2XkRANNE=;
        b=geSbP+mhPZFsrk2hn01Jk4hb49AQDis4Iagv8gQh1aDLHa7X30imQ7+aOm2vf7St8L
         HQK34uxGlr1thzjFrMzFNoUiscnWHbRj2y+KExWN4RcWf0ITOLpb0CXYMJJ1u2oTcLvw
         sQO4xcyJoMlSXuOuW32g8HNZ2kSE6yt7ylAMOalwV8PoOJNVA1Vk4f3oHaofdssQsu2V
         OZF8yqZUNXYnvKvFdz9R762DvAFtexve8PEEpgoCxhS054ZTXGaJMNimGFGPPsUWfvOB
         xUHrx69yys1iG5jgURR5Yc1zT8AshMTUIm3AbuB6OopyPr+oKfhdQGJyxR8HHSCMy344
         Sk2A==
X-Forwarded-Encrypted: i=1; AJvYcCWlNx2LZNJaHuspQleQgd++l7NLFQgL59guIBrbM2S9doHzj4ZddBMs1kOa+4ENO+nPrlNUrazHEoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSaRq5zs8tS90Tw7aVw7dGWQ2LuLnvvKm5nR30B3SEYUuJbi6h
	KVwcEYa5Y6LryEMdavOaCOr94gCUYeipS6xQnf1dsLo+CJkfUX518EspfQxgW3A=
X-Google-Smtp-Source: AGHT+IGNPXH0NWxB5KcPqbGxLZAlM/yW4TrYXNEvxLP+us9l0gcJDQM4e13qYHjm7k1KboJ3AMaDWA==
X-Received: by 2002:a17:907:efc7:b0:a7d:2fb2:d852 with SMTP id a640c23a62f3a-a8366feef14mr207952966b.52.1723649767657;
        Wed, 14 Aug 2024 08:36:07 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f41849cesm185532566b.199.2024.08.14.08.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:36:06 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Manuel Traut <manut@mecka.net>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v9 3/4] tee: add tee_device_set_dev_groups()
Date: Wed, 14 Aug 2024 17:35:57 +0200
Message-Id: <20240814153558.708365-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814153558.708365-1-jens.wiklander@linaro.org>
References: <20240814153558.708365-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tee_device_set_dev_groups() to TEE drivers to supply driver specific
attribute groups. The class specific attributes are from now on added
via the tee_class, which currently only consist of implementation_id.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_core.c   | 19 +++++++++++++------
 include/linux/tee_core.h | 12 ++++++++++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index d52e879b204e..d113679b1e2d 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -40,10 +40,7 @@ static const uuid_t tee_client_uuid_ns = UUID_INIT(0x58ac9ca0, 0x2086, 0x4683,
 static DECLARE_BITMAP(dev_mask, TEE_NUM_DEVICES);
 static DEFINE_SPINLOCK(driver_lock);
 
-static const struct class tee_class = {
-	.name = "tee",
-};
-
+static const struct class tee_class;
 static dev_t tee_devt;
 
 struct tee_context *teedev_open(struct tee_device *teedev)
@@ -965,6 +962,13 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 }
 EXPORT_SYMBOL_GPL(tee_device_alloc);
 
+void tee_device_set_dev_groups(struct tee_device *teedev,
+			       const struct attribute_group **dev_groups)
+{
+	teedev->dev.groups = dev_groups;
+}
+EXPORT_SYMBOL_GPL(tee_device_set_dev_groups);
+
 static ssize_t implementation_id_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
@@ -983,6 +987,11 @@ static struct attribute *tee_dev_attrs[] = {
 
 ATTRIBUTE_GROUPS(tee_dev);
 
+static const struct class tee_class = {
+	.name = "tee",
+	.dev_groups = tee_dev_groups,
+};
+
 /**
  * tee_device_register() - Registers a TEE device
  * @teedev:	Device to register
@@ -1001,8 +1010,6 @@ int tee_device_register(struct tee_device *teedev)
 		return -EINVAL;
 	}
 
-	teedev->dev.groups = tee_dev_groups;
-
 	rc = cdev_device_add(&teedev->cdev, &teedev->dev);
 	if (rc) {
 		dev_err(&teedev->dev,
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index efd16ed52315..a38494d6b5f4 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -154,6 +154,18 @@ int tee_device_register(struct tee_device *teedev);
  */
 void tee_device_unregister(struct tee_device *teedev);
 
+/**
+ * tee_device_set_dev_groups() - Set device attribute groups
+ * @teedev:	Device to register
+ * @dev_groups: Attribute groups
+ *
+ * Assigns the provided @dev_groups to the @teedev to be registered later
+ * with tee_device_register(). Calling this function is optional, but if
+ * it's called it must be called before tee_device_register().
+ */
+void tee_device_set_dev_groups(struct tee_device *teedev,
+			       const struct attribute_group **dev_groups);
+
 /**
  * tee_session_calc_client_uuid() - Calculates client UUID for session
  * @uuid:		Resulting UUID
-- 
2.34.1

