Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5E5EB64DA
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 20:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjFMUee (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjFMUec (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 16:34:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06DD199C
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:29 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f62b552751so7453450e87.3
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686688468; x=1689280468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEWZ3mk4O5IbHesXExTqQF3woZXVOofkrFDb7Wvq9pM=;
        b=O3GqsVFjd8mTLVD5WMmFXeH/dZGabEKtmTTLdPUlcbL6BI4/+J3hsqPTuDlIz9BAzg
         +cg7hXy+74KOIH8eCT2LGEieWXtZCLlQGgVtf81BgpZljJ/Mq4hlGUn1fFDWvPQ9qkAU
         UfJBeXE7AJl/Mq+Xl6WWc4TNju3HUX04vcK6G/Q6MFXEDqXvnpC1pfB+xamyJOY1D3/x
         RIUwjQZe9Smvndk1o1K5kKJH09osYlWsc+2PBcT4FsMJsKbLcGJkNCib+LeE9cwNANNP
         FmH75hPPyCgE/cW4lesnquNjqourWLSiHJ9XsP1ucIOkA4WFNH3YVWYrTMmmk5ubewj3
         tmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688468; x=1689280468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEWZ3mk4O5IbHesXExTqQF3woZXVOofkrFDb7Wvq9pM=;
        b=bx140xYdwKSWIlk8P5VuKD2foeRFq9KFe9FoHhDjOTsq9d1i9TP+0EmjxeM0FzPldV
         6G6icJZl02VWAALu1jrHbuobXUs8A17cTYAjnTdgx2pikDU/7mkfTyoO8UCk13rHzPTK
         uCLvGuKu92Nlr8Vxy/eve5gmYJQGVWc1S63954ngrBvZMF43WEf1y84wBXjz5Lnw/q4J
         +W6xeVRj3fP1yTEn5E0zLAVrwR6IdiiXXfw3KafmD8RGZF7E6MY15ZSxhRTLTlPAY+UX
         6sR9Z0rrhr64Illl5xtdA0M3qCY6hu/Crqg/gUbzrCD9Q48euJzMXuEV2bNGvxv2PV5s
         4BPg==
X-Gm-Message-State: AC+VfDzYsqihvI7aeYfyNhcmSWfoOwA4XAcg9siNGY7R8hn39QgAZ/AZ
        sN8+3d3G+DgXQH8cexJyu3kK8Q==
X-Google-Smtp-Source: ACHHUZ4MJ1g+3kaOn/hlXnU8wnvFYa+Alm2v+9RG63pXCADxF8i/SEE0xuvW94dag0BU0pXA4yYBfw==
X-Received: by 2002:ac2:5b5b:0:b0:4f3:a9d3:4893 with SMTP id i27-20020ac25b5b000000b004f3a9d34893mr7278345lfp.35.1686688468189;
        Tue, 13 Jun 2023 13:34:28 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id l12-20020a19c20c000000b004f26f699e9dsm1897813lfc.184.2023.06.13.13.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:34:27 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Jun 2023 22:34:19 +0200
Subject: [PATCH v4 03/10] mmc: mmci: Stash status while waiting for busy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v4-3-df9c8c504353@linaro.org>
References: <20230405-pl180-busydetect-fix-v4-0-df9c8c504353@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v4-0-df9c8c504353@linaro.org>
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some interesting flags can arrive while we are waiting for
the first busy detect IRQ so OR then onto the stashed
flags so they are not missed.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- No changes.
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index eee449f90915..47b306e45f78 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -703,6 +703,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 */
 	if (host->busy_status &&
 	    (status & host->variant->busy_detect_flag)) {
+		host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 		return false;
 	}

-- 
2.40.1

