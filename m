Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DCBC07E96
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jul 2021 14:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B89261493
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jul 2021 14:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhGHOOA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Jul 2021 10:14:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60440 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhGHOOA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jul 2021 10:14:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DEBC922277;
        Thu,  8 Jul 2021 14:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625753477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=1N/reUsLeZKLGDwD3Bs0QRIIYMaSHgj6eG6/MqcnweM=;
        b=i91DsQb7krT0Mx0l9l2Gp5oZ9tFtUnzffqsqjyeLmkJQGtfKFCMxsTio3D6Rh++LWOSKxa
        9q5/2opOK6R4QJJAh4vdkHARhUwxfRT9hTzbtphnRQ2jDoxBUJmsu7MPPVcCwQT6swszuj
        fyw60zr/S7VjuvbT82+Ww6DEOFfmJyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625753477;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=1N/reUsLeZKLGDwD3Bs0QRIIYMaSHgj6eG6/MqcnweM=;
        b=uZPgZ4SO/ByQQdux5ClIRcxgll97WoKY/o1GqyV3hg9unpzwpoOAn9rA9IZ/6pr8eLa25o
        zkqqcAR6wIqeZVBw==
Received: from hawking.suse.de (hawking.suse.de [10.160.4.0])
        by relay2.suse.de (Postfix) with ESMTP id D7D25A3B87;
        Thu,  8 Jul 2021 14:11:17 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id BFC4D446184; Thu,  8 Jul 2021 16:11:17 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: mmc_spi: add spi:mmc-spi-slot alias
CC:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Yow:  Has everybody got HALVAH spread all over their ANKLES??...
 Now, it's time to ``HAVE A NAGEELA''!!
Date:   Thu, 08 Jul 2021 16:11:17 +0200
Message-ID: <mvm4kd499q2.fsf@suse.de>
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
index 9776a03a10f5..a5f318b70057 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1544,3 +1544,4 @@ MODULE_AUTHOR("Mike Lavender, David Brownell, Hans-Peter Nilsson, Jan Nikitenko"
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
