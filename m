Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4823D971
	for <linux-mmc@vger.kernel.org>; Sun,  7 Apr 2024 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712520304; cv=none; b=q5hFUK1HviJMw2jE2vwjIugvyRvz+6cdf5YmREQ/u18t2/nrCRA1bvNsvldNwy4xzKlwfxuf1bTpy97+Xxu+GyMaxXEx61/1mRIclkEat23U/C7YrOlcOJylNo+KiaYptqk3nc9qYU2KqNd8GLMM+79xyvvotZ9wjxxiNAY/I28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712520304; c=relaxed/simple;
	bh=hCMJGweq7tU8hlD93B81yze3RHJwnGhyXr4H8YVnHpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FzlCfulpvEu3jwqFDTgF/JBNyqRU0Ypx2Rpvo4GtSpWgJFiQMIg6SgDUIgGRQLMZKYJtxueI056bsKJ9/77oA/3wayRCdtjBLQE7Lj+euYZCvMVxOXwuGb/S88BTya0ZPgIRjnJfTZfxUOHH7jPE8cD+Amnb2YONZ+POEwa49q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATAnZjfM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATAnZjfM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712520301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3gzJ7EXt9VdeENWzxJbek4ko1lyMTZTDhIdMsRvzgb0=;
	b=ATAnZjfMq7Y3UdZ0O4hwerBMqeQzTH7m2U254w94U5zr0p+41DO3KRiKJoMTJBw9vIogIA
	RXZiNZ4oU8+H0ArXSOaNMq6FFTTWNQV5iROo5UDPuD/tuhWdYo5305+resPyehulBQoQDJ
	b2poXWadC03lwSSnTR1EjKOHqy420bk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-KHysgD97NAajQV0jKLuNmQ-1; Sun, 07 Apr 2024 16:04:59 -0400
X-MC-Unique: KHysgD97NAajQV0jKLuNmQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22C87101150C;
	Sun,  7 Apr 2024 20:04:59 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D3207112132A;
	Sun,  7 Apr 2024 20:04:57 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-mmc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH 1/6] mmc: core: Add mmc_gpiod_set_cd_config() function
Date: Sun,  7 Apr 2024 22:04:48 +0200
Message-ID: <20240407200453.40829-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Some mmc host drivers may need to fixup a card-detection GPIO's config
to e.g. enable the GPIO controllers builtin pull-up resistor on devices
where the firmware description of the GPIO is broken (e.g. GpioInt with
PullNone instead of PullUp in ACPI DSDT).

Since this is the exception rather then the rule adding a config
parameter to mmc_gpiod_request_cd() seems undesirable, so instead
add a new mmc_gpiod_set_cd_config() function. This is simply a wrapper
to call gpiod_set_config() on the card-detect GPIO acquired through
mmc_gpiod_request_cd().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/core/slot-gpio.c  | 20 ++++++++++++++++++++
 include/linux/mmc/slot-gpio.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 39f45c2b6de8..8791656e9e20 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -221,6 +221,26 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 }
 EXPORT_SYMBOL(mmc_gpiod_request_cd);
 
+/**
+ * mmc_gpiod_set_cd_config - set config for card-detection GPIO
+ * @host: mmc host
+ * @config: Generic pinconf config (from pinconf_to_config_packed())
+ *
+ * This can be used by mmc host drivers to fixup a card-detection GPIO's config
+ * (e.g. set PIN_CONFIG_BIAS_PULL_UP) after acquiring the GPIO descriptor
+ * through mmc_gpiod_request_cd().
+ *
+ * Returns:
+ * 0 on success, or a negative errno value on error.
+ */
+int mmc_gpiod_set_cd_config(struct mmc_host *host, unsigned long config)
+{
+	struct mmc_gpio *ctx = host->slot.handler_priv;
+
+	return gpiod_set_config(ctx->cd_gpio, config);
+}
+EXPORT_SYMBOL(mmc_gpiod_set_cd_config);
+
 bool mmc_can_gpio_cd(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
index 5d3d15e97868..748ab7a88e78 100644
--- a/include/linux/mmc/slot-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -19,6 +19,7 @@ void mmc_gpio_set_cd_irq(struct mmc_host *host, int irq);
 int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 			 unsigned int idx, bool override_active_level,
 			 unsigned int debounce);
+int mmc_gpiod_set_cd_config(struct mmc_host *host, unsigned long config);
 int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
 			 unsigned int idx, unsigned int debounce);
 void mmc_gpio_set_cd_isr(struct mmc_host *host,
-- 
2.44.0

