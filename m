Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B5CC12002
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 13:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C121A61245
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 13:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbhGUMqO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 08:46:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41802 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhGUMqN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 08:46:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B127B20343;
        Wed, 21 Jul 2021 13:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626874009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=GyBfcSpuRK/8K+7VnMA4jL07BgVrLh1UAPQebBr9BSg=;
        b=c79xdP4g94d3YJX/yNaGrfkEJD98Qa87usuBkLJUmAI41Me7YFKAdoUEOTfYqpmF2WcCHe
        HSVuLWnqF5jU+InYdnmhPSqkoW6RrL4nFQpXkAFLJPPxTKGimIoqyjJwX9pWTMnU0h5i4b
        ao8ihnoemLEawg2E3M826L+NerYtmfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626874009;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=GyBfcSpuRK/8K+7VnMA4jL07BgVrLh1UAPQebBr9BSg=;
        b=cM01NsJLDX6EVlY+JAe4KFtzLA5yQUVgPgLjYEg+edRU/Ojnj82ChUI/tqBWZpsFePROvy
        BzewXWrD4HwDuICA==
Received: from hawking.suse.de (hawking.suse.de [10.160.4.0])
        by relay2.suse.de (Postfix) with ESMTP id A93D2A3BA1;
        Wed, 21 Jul 2021 13:26:49 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 878E0446119; Wed, 21 Jul 2021 15:26:49 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: mmc_spi: add spi:mmc-spi-slot alias
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Yow:  ONE:  I will donate my entire ``BABY HUEY'' comic book collection
 to the downtown PLASMA CENTER..
 TWO:  I won't START a BAND called ``KHADAFY & THE HIT SQUAD''..
 THREE:  I won't ever TUMBLE DRY my FOX TERRIER again!!
Date:   Wed, 21 Jul 2021 15:26:49 +0200
Message-ID: <mvmtukn6bmu.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This allows the driver to be auto loaded.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 drivers/mmc/host/mmc_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 65c65bb5737f..103c450773df 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1542,3 +1542,4 @@ MODULE_AUTHOR("Mike Lavender, David Brownell, Hans-Peter Nilsson, Jan Nikitenko"
 MODULE_DESCRIPTION("SPI SD/MMC host driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("spi:mmc_spi");
+MODULE_ALIAS("spi:mmc-spi-slot");
-- 
2.32.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
