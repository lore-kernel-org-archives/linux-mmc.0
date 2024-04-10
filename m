Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43AE17BB2D
	for <linux-mmc@vger.kernel.org>; Wed, 10 Apr 2024 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776612; cv=none; b=oRhLTeQb/mgoecf2y6KpNPQKerlvxtrY6Yq5mZkXq3Oih6i5N18cxEPSPXHhZYaJEhTConsqfaWit6mecv05jF7qm+1Z5i/c7OeyqqGE6WlWeRqa6sBmhJvBJoZ7makD3LY4O6I24hbHeyBLkherKiox+G81t37Nh+ChmabvAis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776612; c=relaxed/simple;
	bh=erJ5V4AEq9kOBuy+ykQ1O00z8l7mTBVCWc0yL6DBaS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClPIZKjXK63jhW5VkI45HvLw8dNhp3HxrgUAQ4HgzoFOlUqVMbSdqH8Xa+kwbFMGOWLgE1hC2PHamh5zNWG8nDoSUtYuCK+QPU8BwU2NS7Xik+mgpjyWMPzzcQr2YNnjv8r4pjcQDgLK8vybgF1RK+tJX+5+1E0IyGimBCEH6fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEzU8LgH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEzU8LgH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712776609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bx2XDbPzp2AfqZX+T1+85Iiv5NmDhmS7mUqjJ8NOCFI=;
	b=iEzU8LgH47f/ZfjuGJ8EBbbreCbTx1ypwS4Pyz8y5f3B65yBFqR3pPa5dTu2AiJCGvyF7B
	9yGbQ8w6uaC67bb0dFMrYXEj2MlLFfZgMXJjpVtspGrl2g3eAlEP0F00BqWbzP6xagbhRD
	WpWU6cLL+oolvbGb6+LRehYmzr+GjwI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-OzTem-HPPFqKcAQUF1MLnA-1; Wed,
 10 Apr 2024 15:16:46 -0400
X-MC-Unique: OzTem-HPPFqKcAQUF1MLnA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43B833C367E8;
	Wed, 10 Apr 2024 19:16:46 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.79])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4BB3B44434D;
	Wed, 10 Apr 2024 19:16:45 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-mmc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v3 1/6] mmc: core: Add mmc_gpiod_set_cd_config() function
Date: Wed, 10 Apr 2024 21:16:34 +0200
Message-ID: <20240410191639.526324-2-hdegoede@redhat.com>
In-Reply-To: <20240410191639.526324-1-hdegoede@redhat.com>
References: <20240410191639.526324-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Some mmc host drivers may need to fixup a card-detection GPIO's config
to e.g. enable the GPIO controllers builtin pull-up resistor on devices
where the firmware description of the GPIO is broken (e.g. GpioInt with
PullNone instead of PullUp in ACPI DSDT).

Since this is the exception rather then the rule adding a config
parameter to mmc_gpiod_request_cd() seems undesirable, so instead
add a new mmc_gpiod_set_cd_config() function. This is simply a wrapper
to call gpiod_set_config() on the card-detect GPIO acquired through
mmc_gpiod_request_cd().

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Group mmc_gpiod_set_cd_config() prototype in slot-gpio.h together
  with mmc_gpiod_set_cd_config()
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
index 5d3d15e97868..66272fdce43d 100644
--- a/include/linux/mmc/slot-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -21,6 +21,7 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 			 unsigned int debounce);
 int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
 			 unsigned int idx, unsigned int debounce);
+int mmc_gpiod_set_cd_config(struct mmc_host *host, unsigned long config);
 void mmc_gpio_set_cd_isr(struct mmc_host *host,
 			 irqreturn_t (*isr)(int irq, void *dev_id));
 int mmc_gpio_set_cd_wake(struct mmc_host *host, bool on);
-- 
2.44.0

