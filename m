Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ECEC433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jan 2021 14:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82DAA2311D
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jan 2021 14:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbhALOSu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jan 2021 09:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbhALOSu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jan 2021 09:18:50 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328D2C061575
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jan 2021 06:18:10 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id j1so1475943pld.3
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jan 2021 06:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U/FOHxwIw3HVpW/GXNTzZPAMWanmn/ezG2bU3puOLvk=;
        b=A7Rlzb3vHUU3yVjvXzyNBXFkscn1V0W5vuQR4T78oUcNAiw2rhx/4RFQHdSiCep7Ga
         RGMxrwz7hrQ1EzXMDIeKhwlZBMOy2wMT8oCJqWIDURhqiQ/FuWJcFdqeV4bsSILU8ROL
         wyZQHp6ci5afkThLjD7hpG5tIWBvOTud1E7zfdSkLN6Fg+eA2gTAwgyxmsaQW/dwIqBu
         YrPT65gDKqTnAq8yawLdBQzLPsOKZrheu76ZqDJnw8ONh3HVtU5W673e1AhWsSDyZ/41
         0mAThSevEkz5SWzf1ug14BUgvnJRQzs0mHzijIcufuSvltQNk3Aj9eYpgmDolVzl3VgW
         K/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U/FOHxwIw3HVpW/GXNTzZPAMWanmn/ezG2bU3puOLvk=;
        b=VMbPQHhmLuC4JJtEraKFHJ+7W8hs22Wfw5kCjQJxdma3FwCHQ74P9fpzV+mpjkGyMb
         8SYd/JfSO9K5qoE/MMvtPpSRrlLyxMBtsYUHRDQgtCV3VqPUuPsehJ+enIX6iusOn2ck
         adnN4B+07mq4GWqKKEFqxZDTVPwWMwZ6JP76JBg1extsk/15dvU3KGEnZaCbOnGrwhM2
         IGFDsbFRdn481NizLltfe1jglc14NMuUrwhYpa80b8NPBZQQ6dINK+am8AU9bvc0Yafu
         TV4XnGGqsw1AK3oDU4PSXDGF00h+bnxjsQWuBr+tyQqWkfF7CiqW+tPaTKFsSAqt822R
         WQrQ==
X-Gm-Message-State: AOAM533xOCNjlW7Ynsdqo0tcIz0M94DO8vOBJDbqzcIWBKbt/FYvv/v1
        3GPxGjtCTX5fI4bfK1JnHKb/PGmzuJhceA==
X-Google-Smtp-Source: ABdhPJzunK96JyrQcuOmBw5BPNoXJJQxpTokxu2SuOEtd9gglfJQNfsWl4NgnBlZvawKBH7qiZTNPA==
X-Received: by 2002:a17:902:ac93:b029:db:c725:e321 with SMTP id h19-20020a170902ac93b02900dbc725e321mr4951151plr.41.1610461089727;
        Tue, 12 Jan 2021 06:18:09 -0800 (PST)
Received: from localhost.localdomain ([210.0.158.164])
        by smtp.googlemail.com with ESMTPSA id f7sm3555041pjs.25.2021.01.12.06.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:18:08 -0800 (PST)
From:   Fengnan Chang <fengnanchang@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, Fengnan Chang <fengnanchang@gmail.com>
Subject: [PATCH] mmc: limit the number of retries when analyse tuples failed
Date:   Tue, 12 Jan 2021 22:17:54 +0800
Message-Id: <20210112141754.76539-1-fengnanchang@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

when analyse tuples failed, may enter an endless loop，so limit the number of retries.

Signed-off-by: Fengnan Chang <fengnanchang@gmail.com>
---
 drivers/mmc/core/sdio_cis.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index dcb3dee59fa5..a3f0c3cc0c2c 100644
--- a/drivers/mmc/core/sdio_cis.c
+++ b/drivers/mmc/core/sdio_cis.c
@@ -266,6 +266,7 @@ static int sdio_read_cis(struct mmc_card *card, struct sdio_func *func)
 
 	do {
 		unsigned char tpl_code, tpl_link;
+		int  tries = 100;
 
 		ret = mmc_io_rw_direct(card, 0, 0, ptr++, 0, &tpl_code);
 		if (ret)
@@ -318,6 +319,9 @@ static int sdio_read_cis(struct mmc_card *card, struct sdio_func *func)
 			prev = &this->next;
 
 			if (ret == -ENOENT) {
+				tries--;
+				if (!tries)
+					break;
 				/* warn about unknown tuples */
 				pr_warn_ratelimited("%s: queuing unknown"
 				       " CIS tuple 0x%02x (%u bytes)\n",
-- 
2.25.1

