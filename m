Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92760C55179
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B28C221F8
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ip+Jsw2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgKFC3O (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgKFC3O (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 21:29:14 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B56C0613D3
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 18:29:14 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 13so2943822pfy.4
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 18:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9wzRP1xFBhaZ7hkzZhizDzTNThTBUuNYKfhyIeI3kwA=;
        b=ip+Jsw2GHN9BWtwUEYwpCCONZlTDlDg7sduezAJccplVibKcxo/vRz6YQSqG8QyGGK
         tZSIoM6dsGgn4EDB5Pqg25NsuwMljpo/gqmg0ouDknVBpT9c2ryN2MQdVVE4Hi6te4y1
         64XWcpVPPjDh04JpFhZhqHBM8XGVCyjFIUkKNnaUjpDWUz6vkk36L3yv+t7GUi3mx9DU
         vXTUydZbMqt3dJUrxjhZVl0oyaUoal1fwOTQvwoNYLVCH1W6NJrrQzt2ZBF2A4FFugEv
         7/xdNgzEQ4hoy7r0qBXpR3LU1x2DWWeKQbLYHHaExjV4WayUyvzXfkUPvhyB71JhC+CK
         A2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9wzRP1xFBhaZ7hkzZhizDzTNThTBUuNYKfhyIeI3kwA=;
        b=J7uox3D2ECivvlTQRAKFWuIKreqdGioRma/F4nsvVUsDwhjSp5yYSMrJxZVJL7bfIA
         FJO+6usoWsVgRm0daqOcHNlN6pjRSWy5rk3t7WnA2uNee/azEl1+AcU27hs30J/6Qfly
         q6E5oyaY6M/UJTHhsvfFzalHc3LAHjk/L327X8LD66UEQ99rdrlgxqs1HdRR0yzjV/2w
         xyX5dUGcnv565XQPqw4+AGgE062+eopSgXdzIbV/jcns7Hw6sqvXjzuE5iRlOJyOrE8w
         QOCMU7VeHLqBiUTtO7nKIVkKU9jqFTTwN2LZwXN4Ez8lZqRHGVg725QpER2pTjjXaPLP
         pIeA==
X-Gm-Message-State: AOAM531ujsVjEshp9Wd+ZYBdUdP3/5twptMxKh8FRgeMuK9jeNjEmJxe
        gj0/oo4o69VL8cc5AYwC7qi2cgP4OvCJvg==
X-Google-Smtp-Source: ABdhPJwKAVVPR2Cgpl/Qgt4qKkHmcxtVBDKuEazmOL09edA9alJqrdTutqE+GwB8uj4IrovFY8sEJA==
X-Received: by 2002:a17:90a:8b93:: with SMTP id z19mr5414102pjn.123.1604629754058;
        Thu, 05 Nov 2020 18:29:14 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:29:13 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 25/27] mmc: sdhci-uhs2: add post-mmc_attach_sd hook
Date:   Fri,  6 Nov 2020 11:27:24 +0900
Message-Id: <20201106022726.19831-26-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

This "post" hook for mmc_attach_sd(), uhs2_post_attach_sd, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 4e2cb73a63bd..b85d9d077c61 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -724,6 +724,7 @@ struct sdhci_ops {
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
 	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
+	void    (*uhs2_post_attach_sd)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.28.0

