Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F89C71156
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 18:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C520422248
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 18:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389545AbgLBSwf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 13:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbgLBSwf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2020 13:52:35 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A06C0613CF
        for <linux-mmc@vger.kernel.org>; Wed,  2 Dec 2020 10:51:55 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id s30so6405202lfc.4
        for <linux-mmc@vger.kernel.org>; Wed, 02 Dec 2020 10:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uCMRWJFHgW0epDmnZ3QZT3N00+SWcEpcWOZCRs/w+/Q=;
        b=BgeVDYkgUd3FtfoBxcBxfhoLaDwKbwMlfZDnj8LU8hy5khXtx6UnsnK55wR8xgxbu9
         rOIEqZl98VeqvIlqRhAbVkJRsxzuY3ciDcfQXO/YJ+7oOf7gA2ghOZX6DFLzuStvJD5u
         INb+Nsqo+DkNYSuINFNITtPAiGUlLwLuC7NWrReICLZ7KsDW14AUaTMwUy0pFPSXwEM/
         am42OH91QT5EcBo7jKX4diYfLJ5JlMb7RuajKnNKHjoS2zZfoPtuh4BzVVrdgQv9Ccdc
         HsyoBo/YhJfPE6QzIUKK2EcgOcOgP/EAx/kWYMoIplS+Zih8Hb7ecE7qfE+kCCF2sI6+
         Q35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uCMRWJFHgW0epDmnZ3QZT3N00+SWcEpcWOZCRs/w+/Q=;
        b=BYuhOeJSuEA9EECI5rVyw7cWGnX7/XFw+0Kv59TOd5G4WVYDI7pdTLruxQ3WVd3tC7
         NYdIVl495lAOTAO7sKczBK7/lvIbEKYL+gNMVpSrx0PKNaJICs4R4mCKoMVs49w39tt5
         D+17Vg6oZkwk68J+1sETJr2jf1TEFwx1Nnyx+r8A+FhOjwQMFVUJ9CHdAv1ZkmvFkdQt
         PkPf+PUZ27/9oPMDbqZvVAlVkVZshOkSGDrRfm4d/hfy6cNX/EmErJUA8DQp6F1Ctph4
         qpd2ATVD8oCqFJIxG2R/7FLWOSxqsWQcrqrKVlzaNDqXkHv09loQhiA/2+uylLPhIFGB
         egcw==
X-Gm-Message-State: AOAM530lM+Ie4OODn5tYhPRkIH+/OuTSSxGwDgSdUQXPViKI4eoPJiHD
        3AYuIs13TXLkFMvO81xdaZynYg==
X-Google-Smtp-Source: ABdhPJx/tUZbr/lJ1lUD7HYMEzn6WHkSqY94xkZWmEGzXgjf+VUa7NZMiEeFAEj+ZCS4mCzSiIQC1Q==
X-Received: by 2002:a19:3c2:: with SMTP id 185mr1955420lfd.403.1606935113021;
        Wed, 02 Dec 2020 10:51:53 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id y134sm666365lff.162.2020.12.02.10.51.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:51:52 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com,
        adrian.hunter@intel.com, jaz@semihalf.com, tn@semihalf.com,
        ard.biesheuvel@arm.com, kostap@marvell.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v3 0/4] sdhci-xenon ACPI support
Date:   Wed,  2 Dec 2020 19:51:14 +0100
Message-Id: <20201202185118.29076-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

The third version of the sdhci-xenon ACPI support
addresses a comment regarding clk_disable_unprepare
dependency on DT.

The MacchiatoBin firmware for testing can be obtained from:
https://drive.google.com/file/d/1Y8BhyaCrksQgT_GPfpqqiYHpQ41kP8Kp

Changelog:
v2->v3
  * Call clk_disable_unprepare unconditionally.
  * Add Adrian's Acked-by to all patches.

v1->v2
  * Split single commit to 4
  * Use device_match_data and dedicated ACPI ID's per controller
    variant


Marcin Wojtas (4):
  mmc: sdhci-xenon: use match data for controllers variants
  mmc: sdhci-xenon: switch to device_* API
  mmc: sdhci-xenon: use clk only with DT
  mmc: sdhci-xenon: introduce ACPI support

 drivers/mmc/host/sdhci-xenon.h     |  12 ++-
 drivers/mmc/host/sdhci-xenon-phy.c |  40 ++++----
 drivers/mmc/host/sdhci-xenon.c     | 101 +++++++++++++-------
 3 files changed, 97 insertions(+), 56 deletions(-)

-- 
2.29.0

