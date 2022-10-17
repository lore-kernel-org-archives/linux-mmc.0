Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DFCC4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Oct 2022 09:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiJQJOx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Oct 2022 05:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiJQJOB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2022 05:14:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5694F184;
        Mon, 17 Oct 2022 02:13:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c24so10197389pls.9;
        Mon, 17 Oct 2022 02:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlEORPHGXzxv44xyQoYwE+VyJB+0P99hwxAci/rfmuQ=;
        b=JJa3+An1YKZPwvgwqCBMpwHnO+29pqTfXC3Q83G+n/93npi6xwJKQsAygzOeAfpLbJ
         8HXUuBTP3StBXAd7XvRwGCd+5OIdmgTgYt71d8nhwANHSf65RF4WMPm/Ue4FK6N6QXeu
         etsOcZDK/H54PSjYf67HT0iWKBGVuPyw81xzhat5qNGOUWN5FxIvRdn9yumw5rpzSWan
         gIztkEA6NxvKc4xA7OslS32zMmshnN+FVbX/G3c9CIK15hD1Hf1a/wg0bWmY5FovJ/hP
         c/ARbFfGtHkiz3aDUbDbJdcPo9h0tXQKwe/pCrAp17kkM7Kc35VKac8592CRMLFahomq
         Kkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlEORPHGXzxv44xyQoYwE+VyJB+0P99hwxAci/rfmuQ=;
        b=L/oS1r8eO6UQpQ0BxuR1c017UNqacdKDsaxS3SY4bRHQ6MVbRHHm19NVmhJqU0hTF6
         /EGoW0vefsiLC5Q92smLjWLo/0n46Ie+G1G2/4to7froZfvXpUftRl0r/HUWIY7FdngA
         4GE5XIcbnSXAIVcB2xMvtckR9J3n3gC+vzsAbgZTZjETFK43yS4JntzwLLgq9S2mUarl
         oyqn2YW4T1AU4OQzDPJbNk5qLiWWPfNrnePZIK7fQ1WkJHXaPtmJZ+5gbLBC5qi9ZWRl
         VeATDYIuuBsZTKAeisPNCELLe7LuVBYFbl5wuzAY9bp/m9RGIUhpns+osr/4uN7bJuyT
         CNGA==
X-Gm-Message-State: ACrzQf2H6oxA4EADk3pcs8Y4lgiCLZuT+Hondy6WrOS/zBzE/u6y0Js+
        +hhH/uIrL7kNcwXwhmHJwdM=
X-Google-Smtp-Source: AMsMyM4EzpiiKWxQNFXn6Gun2haOAd+LmIvUnLdgkLpgkqkaIxooXWIP7ooRDBr8IbZxBN2nkg7RkA==
X-Received: by 2002:a17:90a:1785:b0:20a:6162:2b6a with SMTP id q5-20020a17090a178500b0020a61622b6amr12469731pja.180.1665997998126;
        Mon, 17 Oct 2022 02:13:18 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-4ca3-4989-34c1-7890.emome-ip6.hinet.net. [2001:b400:e258:8c34:4ca3:4989:34c1:7890])
        by smtp.gmail.com with ESMTPSA id t22-20020a170902b21600b0017f75bc7a61sm6091996plr.166.2022.10.17.02.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:13:17 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 22/26] mmc: sdhci-uhs2: add pre-detect_init hook
Date:   Mon, 17 Oct 2022 17:11:49 +0800
Message-Id: <20221017091153.454873-23-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221017091153.454873-1-victor.shih@genesyslogic.com.tw>
References: <20221017091153.454873-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Victor Shih <Victor.Shih@genesyslogic.com.tw>

This "pre" hook for detect_init(), uhs2_pre_detect_init, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 8e547b672574..88decfba1880 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -1570,6 +1570,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 
 	DBG("%s: begin UHS2 init.\n", __func__);
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n",
 			mmc_hostname(host->mmc));
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index bc4be80bf0af..943701aef22a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -745,6 +745,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

