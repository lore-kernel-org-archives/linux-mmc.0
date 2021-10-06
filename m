Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24075C433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Oct 2021 03:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F7D561248
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Oct 2021 03:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbhJFD4y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Oct 2021 23:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbhJFD4J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Oct 2021 23:56:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4283AC061762
        for <linux-mmc@vger.kernel.org>; Tue,  5 Oct 2021 20:54:17 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id r19so4458967lfe.10
        for <linux-mmc@vger.kernel.org>; Tue, 05 Oct 2021 20:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xiLuOKz2kvk1cz4G50uNXXciKxmoQzaWMMylpBwCLy8=;
        b=polX0w89CVBCN2mcuowNKfbRPyuzDIzwQxcUMvp3pSgIs1y7JVQpWtngRvq+waMU7b
         YNbLlO3w4Xb2/8f6XEubs/qJUOtQznrQBL7S2ecUcLV70S99fUjf2ZLGhnphtztogFJD
         w2ISSBLMGCOuMxGu1HjknOvyTtLj1b6S+cTqqBQr2EFtcwZaBnukHF8D0cMZM0tnx0nI
         uCV3MQ398im1coHH4Usy3IV2fXVi0Fbt1Xaj7AZyBH+aVkmKGsxd3nbtmF9TFr7DYgvV
         K4jnBP31CLG9cegrjQl9fWMYbNN4TUdiby8W9Rl0yr8BmdtlXAb9MIJWsfalRQ0iUxqQ
         XBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xiLuOKz2kvk1cz4G50uNXXciKxmoQzaWMMylpBwCLy8=;
        b=b+9zUA9FQRAOejxhL1Y+ONpmbcAaHRN4irPQxFt75msBpvEaBGo5CSBhVui0pbWMN7
         pPhoW6r1+cgbFLxLftrcPSvqfJPngd6thwwYEqmsJFVrkML6L+G1a1scjM7bhi19CM37
         xUS8RhYVNC6tDIkkASHaS5vEzvk7n2CNMfWTkZZuMe6Ov0hQmZXGX0bAalnvg1+Jrbc8
         +BgiVg34bhZNTZR5RM+XqMk48U59y3aq1vFa/PQSfTZxUTA6CoPH2RkB95W+pwB+7FG8
         552tqC1J68R5UD0lrycrnNNmiSzQ3jJMyg5T6cvme1gaReSFk96fIuO3SbvP72Yjx2Q2
         v/LA==
X-Gm-Message-State: AOAM5315CwBssSNTfYv/lWBCSCi4enpVPmJnFnliogB9SBbZAO0j/eso
        4SLRJ53rNdqNZRq4j0qVn7Enr6OFEO6NPg==
X-Google-Smtp-Source: ABdhPJzlegaIltE1SIs8lAxvicfs57o+JcqU51cspIdlK5w/V62EiVjwgLcERznirqVXN7f7frEROg==
X-Received: by 2002:ac2:4e0d:: with SMTP id e13mr7012924lfr.560.1633492455635;
        Tue, 05 Oct 2021 20:54:15 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s4sm2142967lfd.103.2021.10.05.20.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:54:15 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v1 05/15] pwrseq: implement onecell helper
Date:   Wed,  6 Oct 2021 06:53:57 +0300
Message-Id: <20211006035407.1147909-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
References: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Provide of_pwrseq_xlate_onecell() - a helper easing implementation of
power sequencers using one cell to determine pwrseq instance to return.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/power/pwrseq/core.c   | 26 ++++++++++++++++++++++++++
 include/linux/pwrseq/driver.h | 12 ++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/power/pwrseq/core.c b/drivers/power/pwrseq/core.c
index 0aaba4e79a44..3dffa52f65ee 100644
--- a/drivers/power/pwrseq/core.c
+++ b/drivers/power/pwrseq/core.c
@@ -449,6 +449,32 @@ struct pwrseq_provider *__devm_of_pwrseq_provider_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__devm_of_pwrseq_provider_register);
 
+/**
+ * of_pwrseq_xlate_single() - returns the pwrseq instance from pwrseq provider using single index
+ * @data: the pwrseq provider data, struct pwrseq_onecell_data
+ * @args: of_phandle_args containing single integer index
+ *
+ * Intended to be used by pwrseq provider for the common case where
+ * #pwrseq-cells is 1. It will return corresponding pwrseq instance.
+ */
+struct pwrseq *of_pwrseq_xlate_onecell(void *data, struct of_phandle_args *args)
+{
+	struct pwrseq_onecell_data *pwrseq_data = data;
+	unsigned int idx;
+
+	if (args->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	idx = args->args[0];
+	if (idx >= pwrseq_data->num) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return pwrseq_data->pwrseqs[idx];
+}
+EXPORT_SYMBOL_GPL(of_pwrseq_xlate_onecell);
+
 static int __init pwrseq_core_init(void)
 {
 	return class_register(&pwrseq_class);
diff --git a/include/linux/pwrseq/driver.h b/include/linux/pwrseq/driver.h
index 0ca1d0311ab6..8d46940981bf 100644
--- a/include/linux/pwrseq/driver.h
+++ b/include/linux/pwrseq/driver.h
@@ -157,4 +157,16 @@ static inline struct pwrseq *of_pwrseq_xlate_single(void *data,
 	return data;
 }
 
+/**
+ * struct pwrseq_onecell_data - pwrseq data for of_pwrseq_xlate_onecell
+ * @num: amount of instances in @owrseqs
+ * @pwrseqs: array of pwrseq instances
+ */
+struct pwrseq_onecell_data {
+	unsigned int num;
+	struct pwrseq *pwrseqs[];
+};
+
+struct pwrseq *of_pwrseq_xlate_onecell(void *data, struct of_phandle_args *args);
+
 #endif /* __LINUX_PWRSEQ_DRIVER_H__ */
-- 
2.33.0

