Return-Path: <SRS0=IHUQ=Z7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B036C43603
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Dec 2019 21:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5E2206D5
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Dec 2019 21:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="dt2FTeNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLIVJj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:09:39 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:13966 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfLIVJi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 9 Dec 2019 16:09:38 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47Wwjz3FfCzKW;
        Mon,  9 Dec 2019 22:07:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1575925623; bh=mP4IVsF26GolA/qoisGsW9KuB5321gAdX6Kb63gtye0=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=dt2FTeNtLn5SzVmT4ac/2vCOJvqgwYdnvgjwIvJsvwGIqGB8HHrMqq6Ov40eT3kZa
         RlYcwgkz/4h78c5S+IEvEe3yAxHqRiQrsP/KgKyvpjJ/vreTkv1655RVB2QrILVdvB
         pgGDVz99iez3X6+pGrtlMoUoBABIpSPBKlktGNSBGi7Aql1dBaCer7Y/36jhkAHE9w
         2h/TPpP0K01fKGuL9oaPm7MTVXMO3Dgl71D6lj5A0HyDyIeq6PKvVnmlTx425rbrnP
         OBramOobh/Sk4+2K3AjVO3nP7F9voOyAX4wXLblSXnZRGEtSwMypVSED23kRPP9Azg
         4B3u+DL9nBtAw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Mon, 09 Dec 2019 22:09:35 +0100
Message-Id: <56d2568cd45a13c738e2804d04348566a8ee8d03.1575925023.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1575925023.git.mirq-linux@rere.qmqm.pl>
References: <cover.1575925023.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/4] gpio: add gpiod_toggle_active_low()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add possibility to toggle active-low flag of a gpio descriptor. This is
useful for compatibility code, where defaults are inverted vs DT gpio
flags or the active-low flag is taken from elsewhere.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/gpio/gpiolib.c        | 11 +++++++++++
 include/linux/gpio/consumer.h |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9913886ede90..6130691e2047 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3363,6 +3363,17 @@ int gpiod_is_active_low(const struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(gpiod_is_active_low);
 
+/**
+ * gpiod_toggle_active_low - toggle whether a GPIO is active-low or not
+ * @desc: the gpio descriptor to change
+ */
+void gpiod_toggle_active_low(struct gpio_desc *desc)
+{
+	VALIDATE_DESC_VOID(desc);
+	change_bit(FLAG_ACTIVE_LOW, &desc->flags);
+}
+EXPORT_SYMBOL_GPL(gpiod_toggle_active_low);
+
 /* I/O calls are only valid after configuration completed; the relevant
  * "is this a valid GPIO" error checks should already have been done.
  *
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 5215fdba6b9a..bf2d017dd7b7 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -158,6 +158,7 @@ int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 
 int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce);
 int gpiod_set_transitory(struct gpio_desc *desc, bool transitory);
+void gpiod_toggle_active_low(struct gpio_desc *desc);
 
 int gpiod_is_active_low(const struct gpio_desc *desc);
 int gpiod_cansleep(const struct gpio_desc *desc);
@@ -483,6 +484,12 @@ static inline int gpiod_set_transitory(struct gpio_desc *desc, bool transitory)
 	return -ENOSYS;
 }
 
+static inline void gpiod_toggle_active_low(struct gpio_desc *desc)
+{
+	/* GPIO can never have been requested */
+	WARN_ON(desc);
+}
+
 static inline int gpiod_is_active_low(const struct gpio_desc *desc)
 {
 	/* GPIO can never have been requested */
-- 
2.20.1

