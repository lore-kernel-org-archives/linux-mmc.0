Return-Path: <SRS0=q/7Q=Z4=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E3EC2BD09
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Dec 2019 17:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BAB2466E
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Dec 2019 17:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UVN+/T66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfLFRIc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:08:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43656 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfLFRIc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Dec 2019 12:08:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so8395294ljm.10
        for <linux-mmc@vger.kernel.org>; Fri, 06 Dec 2019 09:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tc0ll2qvZbYOgB1NJXHvXGod64HQcRRr8FCccHB+Mbo=;
        b=UVN+/T663mUhqim4xp5tSzBrDpM4zamkdPd2rvkI7p0byDS105QidHpYzjZF9WTCIu
         2iZQ95AgneiQAgWZ3s+no2dI5E2eoQVv6oUallZjmhGSJwld85N5cGu+CfT06WkLA5nr
         qIW5tTZn1pINZ0OxEwutwT0W03C7jwLXn9QnJiPHcgKjU97/H1VzlQu7BjbLRhR8bIkN
         /95c2w8BEBDdbvSL+aHHvT6EWFf4qWcnEFWgYMWhi1mPKzRk2iDHDR4pDQL41Fesjjep
         ZdqqmjJ7dFyKNOFkdjj7lmX4iMoZzqm/mO1IDMH954dopApBaC8OYv70qsFzaWgDd2Wc
         Aunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tc0ll2qvZbYOgB1NJXHvXGod64HQcRRr8FCccHB+Mbo=;
        b=tIqRxOCEVsyZ6cwdoMtwsWkIeTYNRjxdLsDcEoYCLzHr7cF7UaIk6aoAfitwZM8DAm
         bWJ14UOjvMAo9xcKN4bSWpCBsQ1Tycx6bOsSVMsBp/V4RbPQFXfQKkC4ZTUXE45vPT2V
         l2tM3nhX7rO5KROKPGU6ygrvc4VV4OYO2hRLHEPKJ04GOMXRLmGlVnaPlBJYIwkhmV4L
         rHP+qNQdP12BKp6Fumu1/mNHs/YiN1oXL02FgYQ+RB9k7uSzezXzPkqLC2NTnBvw33rR
         /+ufsvoIh5oPo7UtHUxHOXBzFAjfPr2gSH6XmeI6m2DsTWPme0C9KZntkJPfILdgc3zE
         /prQ==
X-Gm-Message-State: APjAAAWEtX69xPrUqLDJrSyH+kz1yk0OevnWBnmh8ooQ81Nb2/q6ntvz
        znoauTgp7DRxMIyqZaSl1GHDsQ==
X-Google-Smtp-Source: APXvYqzIH2UOZMCFS0O7h7tlkyhvsc6gGyD9c/1FA0z09LKEVM71/em3Cz0KCi4ymObLcQ1Gvrb06w==
X-Received: by 2002:a2e:5304:: with SMTP id h4mr9565183ljb.75.1575652109117;
        Fri, 06 Dec 2019 09:08:29 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id z9sm6905283ljm.40.2019.12.06.09.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 09:08:28 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/9] pinctrl: core: Add pinctrl_select_default_state() and export it
Date:   Fri,  6 Dec 2019 18:08:13 +0100
Message-Id: <20191206170821.29711-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191206170821.29711-1-ulf.hansson@linaro.org>
References: <20191206170821.29711-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It has turned out that some mmc host drivers, but perhaps also others
drivers, needs to reset the pinctrl into the default state
(PINCTRL_STATE_DEFAULT). However, they can't use the existing
pinctrl_pm_select_default_state(), as that requires CONFIG_PM to be set.
This leads to open coding, as they need to look up the default state
themselves and then select it.

To avoid the open coding, let's introduce pinctrl_select_default_state()
and make it available independently of CONFIG_PM. As a matter of fact, this
makes it more consistent with the behaviour of the driver core, as it
already tries to looks up the default state during probe.

Going forward, users of pinctrl_pm_select_default_state() are encouraged to
move to pinctrl_select_default_state(), so the old API can be removed.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pinctrl/core.c           | 33 ++++++++++++++++++--------------
 include/linux/pinctrl/consumer.h |  6 ++++++
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 2bbd8ee93507..46600d9380ea 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1535,15 +1535,8 @@ int pinctrl_init_done(struct device *dev)
 	return ret;
 }
 
-#ifdef CONFIG_PM
-
-/**
- * pinctrl_pm_select_state() - select pinctrl state for PM
- * @dev: device to select default state for
- * @state: state to set
- */
-static int pinctrl_pm_select_state(struct device *dev,
-				   struct pinctrl_state *state)
+static int pinctrl_select_bound_state(struct device *dev,
+				      struct pinctrl_state *state)
 {
 	struct dev_pin_info *pins = dev->pins;
 	int ret;
@@ -1558,15 +1551,27 @@ static int pinctrl_pm_select_state(struct device *dev,
 }
 
 /**
- * pinctrl_pm_select_default_state() - select default pinctrl state for PM
+ * pinctrl_select_default_state() - select default pinctrl state
  * @dev: device to select default state for
  */
-int pinctrl_pm_select_default_state(struct device *dev)
+int pinctrl_select_default_state(struct device *dev)
 {
 	if (!dev->pins)
 		return 0;
 
-	return pinctrl_pm_select_state(dev, dev->pins->default_state);
+	return pinctrl_select_bound_state(dev, dev->pins->default_state);
+}
+EXPORT_SYMBOL_GPL(pinctrl_select_default_state);
+
+#ifdef CONFIG_PM
+
+/**
+ * pinctrl_pm_select_default_state() - select default pinctrl state for PM
+ * @dev: device to select default state for
+ */
+int pinctrl_pm_select_default_state(struct device *dev)
+{
+	return pinctrl_select_default_state(dev);
 }
 EXPORT_SYMBOL_GPL(pinctrl_pm_select_default_state);
 
@@ -1579,7 +1584,7 @@ int pinctrl_pm_select_sleep_state(struct device *dev)
 	if (!dev->pins)
 		return 0;
 
-	return pinctrl_pm_select_state(dev, dev->pins->sleep_state);
+	return pinctrl_select_bound_state(dev, dev->pins->sleep_state);
 }
 EXPORT_SYMBOL_GPL(pinctrl_pm_select_sleep_state);
 
@@ -1592,7 +1597,7 @@ int pinctrl_pm_select_idle_state(struct device *dev)
 	if (!dev->pins)
 		return 0;
 
-	return pinctrl_pm_select_state(dev, dev->pins->idle_state);
+	return pinctrl_select_bound_state(dev, dev->pins->idle_state);
 }
 EXPORT_SYMBOL_GPL(pinctrl_pm_select_idle_state);
 #endif
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 7f8c7d9583d3..019fecd75d0c 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -40,6 +40,7 @@ extern int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *s);
 
 extern struct pinctrl * __must_check devm_pinctrl_get(struct device *dev);
 extern void devm_pinctrl_put(struct pinctrl *p);
+extern int pinctrl_select_default_state(struct device *dev);
 
 #ifdef CONFIG_PM
 extern int pinctrl_pm_select_default_state(struct device *dev);
@@ -122,6 +123,11 @@ static inline void devm_pinctrl_put(struct pinctrl *p)
 {
 }
 
+static inline int pinctrl_select_default_state(struct device *dev)
+{
+	return 0;
+}
+
 static inline int pinctrl_pm_select_default_state(struct device *dev)
 {
 	return 0;
-- 
2.17.1

