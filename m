Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F8DEB64DA
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 20:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjFPUmf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 16:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjFPUme (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 16:42:34 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9203A91
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f76a4c211dso1647024e87.3
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686948151; x=1689540151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9t6pgncZlYopzh3WmgICbr64f7ZfnkyzvZkpH3TsLrY=;
        b=joNZ39NmzIwO0y7dgE/UoRyr2pCDbczmTjtEenUcQYNFut+RFfugo7RFrfXYtn1z22
         2iC8EtKicSQVU45V61HhmR6Zr3KMkRRJCegZXu4VojgHJSfiR0CRSUXeKu1obT7Lhj98
         RUaB6oxmf+dhdvd1B6jkFPeBH3x8dU8qQT0b3v3zwxJksRD3q9zNyr+8bxn0arKiVNE1
         CaoX7KHLssNQyFaNhCsyZxOlEsIw0vbYPByAHS0NbpgTKEcPFwPBCOopBmZtCejBNL2e
         fqxfHnOXmNxEuIEKNuKrCtGMJiNSvpm/YkeFrrZrjfb2w46Z4sLH431kl4k6pWCDfOd8
         uKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686948151; x=1689540151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9t6pgncZlYopzh3WmgICbr64f7ZfnkyzvZkpH3TsLrY=;
        b=cyl64kTRfGhx5HkYsmQiLubFklfMrvkh4+rrR3FPE2aqskMhYsPLYE1NBeQgSeAB/o
         zNiqfg3B3XxiX0N8KqZM4nT+AuJN+1iKcQinxqRip5PG8ZCXxZ1oabDzyD/4AxIp0lUN
         2ZO7g2pIbM0QPXP7qQC7godsx7BWmfuI5wtstxY3HPMeEXtqQCn6Fo0AEKDmlECfk5sY
         DjH38IZb2GPhsHg6B/5ItWmuh0pjbVbkazYpN/kjyZWMVSKwKT/oCyEET5K0Dq0TRy76
         RePiNTKELSAdXpU2XngPThTahPcB799OYeP4oF37ryPK1FmDkTcnHwnJiY3BTfWtajG2
         8sjw==
X-Gm-Message-State: AC+VfDz1jV9WfxrIMjPMjTSqt8Zj2AfSdPfFEdh3Je/uY65aUzilYlx5
        06AiiTwDnvZoOKP/3GzKZFlqQA==
X-Google-Smtp-Source: ACHHUZ5wuDlFmsGGNMNksjY0h2w+P+KhrCvN7EqX361uupuau7Bm/InRm2H3RKVU6ZFB93vboNtPRQ==
X-Received: by 2002:a19:4419:0:b0:4e9:cfd2:e2d with SMTP id r25-20020a194419000000b004e9cfd20e2dmr2293131lfa.65.1686948151542;
        Fri, 16 Jun 2023 13:42:31 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id d22-20020ac244d6000000b004f845907454sm770981lfm.232.2023.06.16.13.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 13:42:31 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 22:42:19 +0200
Subject: [PATCH v7 1/9] mmc: mmci: Clear busy_status when starting command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v7-1-69a7164f2a61@linaro.org>
References: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
To:     Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If we are starting a command which can generate a busy
response, then clear the variable host->busy_status
if the variant is using a ->busy_complete callback.

We are lucky that the member is zero by default and
hopefully always gets cleared in the ->busy_complete
callback even on errors, but it's just fragile so
make sure it is always initialized to zero.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v6->v7:
- No changes.
ChangeLog v4->v6:
- No changes.
ChangeLog v3->v4:
- Fix the oneline stray change to semantic order of busy
  flag so the patch is the oneliner it's supposed to be.
ChangeLog v2->v3:
- Clear host->busy_status no matter if the MMC_RSP_BUSY flag
  is set or not.
- Now we have an if inside an if left, so combine these into
  one singel conditional.
- Resulting re-flow the if-clause.
ChangeLog v1->v2:
- Unconditionally clear host->busy_status if we get a
  busy response.
---
 drivers/mmc/host/mmci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 97a77eefb11a..0a4b6b6e0f03 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1238,6 +1238,7 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 			c |= host->variant->cmdreg_srsp;
 	}
 
+	host->busy_status = 0;
 	if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
 		if (!cmd->busy_timeout)
 			cmd->busy_timeout = 10 * MSEC_PER_SEC;

-- 
2.40.1

