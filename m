Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D580C47089
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Dec 2022 00:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiLFAEg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Dec 2022 19:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiLFAEf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2022 19:04:35 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAD51D64B
        for <linux-mmc@vger.kernel.org>; Mon,  5 Dec 2022 16:04:32 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 82so11954581pgc.0
        for <linux-mmc@vger.kernel.org>; Mon, 05 Dec 2022 16:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Du9fC8uNx8ue3fvIkuE2kVsiCyslxGafpD/Atw5Se3c=;
        b=dVrWEz+M2VbizK97uaojc0bn58XNs+jECIOm4Dk4fuhywQcVIsQVd6m7RXVPtwsL8m
         ga6n0cdybF4Sh/FS6pqSX36CNLgxugRZ74aKcrmpBhw/lymbZwnHdW5+zTwgAZhesOFX
         P77S7byXu92e/BpKcIVT+gkAcCOPiTUr9HXqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Du9fC8uNx8ue3fvIkuE2kVsiCyslxGafpD/Atw5Se3c=;
        b=RDdvz2ona/g+OsluyAbrTsvrTamKvYoVQhB8sztP0HuCciFHLnj1O/Xpdbn1BCH+Q0
         UQwIlHR0qf0U0oklb6W2v5vXcVqu8D4p5BQcHiPPkZylWRrNnfZ+ylXg5igpMtEubMyA
         T0cCKx4hT1iBr411NxRm2XeU63a+5J23AmJThUqNySvRkfJvVxzwcs/EdC5HPr40VBP7
         5o6hmCMfWLUbSCpEjU6MDZHxsisugAHbN9ShuAFN69TiMwYSHJSv4cV2lAG5R9iPoqdo
         hTJ9kehKwEpwv24vOyqUIfNeLfCpBEjM3M53Ssdwyo397gSiKe40MFC4GH2MU2xnNgsw
         fJ8Q==
X-Gm-Message-State: ANoB5plTb5VX0//9UR+npjdyg17HvVuirECTkB4o8BohfbaduY1TXNex
        BEna2eBMO6RSFaFQxyBGOn0bxg==
X-Google-Smtp-Source: AA0mqf6cuyzm+Fr2zJihuS/WC3/UZVnopQl0riVV+wrA94t5wzAD8Eq3DBs/aDN9xSvKEHFXMqaDCg==
X-Received: by 2002:a63:de4a:0:b0:429:983d:22f8 with SMTP id y10-20020a63de4a000000b00429983d22f8mr56608777pgi.165.1670285072207;
        Mon, 05 Dec 2022 16:04:32 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:9b83:ae6f:f47b:bb4d])
        by smtp.gmail.com with UTF8SMTPSA id z27-20020aa79e5b000000b00576f9773c81sm2382267pfq.211.2022.12.05.16.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 16:04:31 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Brian Norris <briannorris@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mmc: sdhci-brcmstb: Resolve "unused" warnings with CONFIG_OF=n
Date:   Mon,  5 Dec 2022 16:04:06 -0800
Message-Id: <20221205160353.1.I5fa28f1045f17fb9285d507accf139f8b2a8f4b5@changeid>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

With W=1, we can see this gcc warning:

drivers/mmc/host/sdhci-brcmstb.c:182:34: warning: ‘sdhci_brcm_of_match’ defined but not used [-Wunused-const-variable=]
  182 | static const struct of_device_id sdhci_brcm_of_match[] = {
      |                                  ^~~~~~~~~~~~~~~~~~~

Rather than play around more with #ifdef's, the simplest solution is to
just mark this __maybe_unused.

Fixes: 1fad8422c989 ("mmc: sdhci-brcmstb: Allow building with COMPILE_TEST")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202212060700.NjMecjxS-lkp@intel.com/
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/mmc/host/sdhci-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 55d8bd232695..f2cf3d70db79 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -179,7 +179,7 @@ static const struct brcmstb_match_priv match_priv_7216 = {
 	.ops = &sdhci_brcmstb_ops_7216,
 };
 
-static const struct of_device_id sdhci_brcm_of_match[] = {
+static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
 	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
 	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
 	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

