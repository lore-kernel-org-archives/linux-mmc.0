Return-Path: <SRS0=1974=Z2=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9939CC43603
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Dec 2019 15:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68184207DD
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Dec 2019 15:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wieo/eEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfLDP35 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:29:57 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33714 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfLDP34 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Dec 2019 10:29:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id 21so8643085ljr.0
        for <linux-mmc@vger.kernel.org>; Wed, 04 Dec 2019 07:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hh+2OcavXB15OGxTYL4jecF4eOIrv2i3m1HUxqh0x6s=;
        b=wieo/eEhlMvYs5dl90GYC772puj0todz8UmUA4dxHFb80RN0va4xTredLrqntb6oFp
         qZ1mcbzC7XaPVkF3kxOleDQPxvX6HbEpSfz1075Y2kK/tKMu6e8LDJ90ipS4kkFrZb/x
         Sab1ghDVsWYwIJG8qfjP7HvD6XXCUm6IA9qh5XgGVhL4Ro24ViG3KDCa36uquqzJE60t
         76hBpikCAQvBtG750EBpq92sStHPSmnNr7rgWEN5+W15v+G7kXhNjGaOqXoC5P42wKD/
         rtTUuKq+bmjqX128T/haMQ6J0dQTXNSYcSyYNz4qD7PIkLS4uZlQ9gjQHgva7zihq4yr
         aunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hh+2OcavXB15OGxTYL4jecF4eOIrv2i3m1HUxqh0x6s=;
        b=DvOMsF4qowQcXwzo5doZYPMVhchqmp0rsB+qoDgbNDJ6JjRaxjEkh1+WpqjsMfG7LT
         Ad3IoL/c+TySl19rscvaEBJc1L7ya1jyHvPnVVaFgh5R+5+5jBvhPgSF1Mz1KAARsa/y
         s0+KMGPDrwxN7OSelJWTqTxkA2BiWO+AuWutW8+O21GK8JvdXH8hPTGctEtaARCQExpp
         Tfoeisye2kYAEjkWtFBKUZYHkDJC7Nq0VsxHmhAC2nTD8I0Mfu92qZOzws0FWe+vB5Gf
         BZ8ginq+Dfr6KJr+ONNkw33DNPTSyV3vVyV7cfntuKJsSQjrSElF1bJWfH+xfstIiB4/
         tVzw==
X-Gm-Message-State: APjAAAWFDm3ckzZvqk8QTJzZLguTDmrG71uHpc7mNF9ruvOyFiA91Rl0
        w3Ks1c16MWoNOsBBITFg9fHOQb5U4VgP9g==
X-Google-Smtp-Source: APXvYqzwLHH0D87hVccEGtWNh8+ho11OqUSZPZNWwimK4/DeGCRy5U5KYE2ffrjtJXhMDPgPHXl8wA==
X-Received: by 2002:a2e:3312:: with SMTP id d18mr2425332ljc.222.1575473393209;
        Wed, 04 Dec 2019 07:29:53 -0800 (PST)
Received: from localhost.localdomain (c-21cd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.33])
        by smtp.gmail.com with ESMTPSA id u7sm3516856lfn.31.2019.12.04.07.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:29:51 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Phil Elwell <phil@raspberrypi.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] mmc: spi: Toggle SPI polarity, do not hardcode it
Date:   Wed,  4 Dec 2019 16:27:49 +0100
Message-Id: <20191204152749.12652-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The code in mmc_spi_initsequence() tries to send a burst with
high chipselect and for this reason hardcodes the device into
SPI_CS_HIGH.

This is not good because the SPI_CS_HIGH flag indicates
logical "asserted" CS not always the physical level. In
some cases the signal is inverted in the GPIO library and
in that case SPI_CS_HIGH is already set, and enforcing
SPI_CS_HIGH again will actually drive it low.

Instead of hard-coding this, toggle the polarity so if the
default is LOW it goes high to assert chipselect but if it
is already high then toggle it low instead.

Cc: Phil Elwell <phil@raspberrypi.org>
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmc_spi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 74c6cfbf9172..1f02f54f09c0 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1134,17 +1134,22 @@ static void mmc_spi_initsequence(struct mmc_spi_host *host)
 	 * SPI protocol.  Another is that when chipselect is released while
 	 * the card returns BUSY status, the clock must issue several cycles
 	 * with chipselect high before the card will stop driving its output.
+	 *
+	 * SPI_CS_HIGH means "asserted" here. In some cases like when using
+	 * GPIOs for chip select, SPI_CS_HIGH is set but this will be logically
+	 * inverted by gpiolib, so if we want to ascertain to drive it high
+	 * we should toggle the default with an XOR as we do here.
 	 */
-	host->spi->mode |= SPI_CS_HIGH;
+	host->spi->mode ^= SPI_CS_HIGH;
 	if (spi_setup(host->spi) != 0) {
 		/* Just warn; most cards work without it. */
 		dev_warn(&host->spi->dev,
 				"can't change chip-select polarity\n");
-		host->spi->mode &= ~SPI_CS_HIGH;
+		host->spi->mode ^= SPI_CS_HIGH;
 	} else {
 		mmc_spi_readbytes(host, 18);
 
-		host->spi->mode &= ~SPI_CS_HIGH;
+		host->spi->mode ^= SPI_CS_HIGH;
 		if (spi_setup(host->spi) != 0) {
 			/* Wot, we can't get the same setup we had before? */
 			dev_err(&host->spi->dev,
-- 
2.23.0

