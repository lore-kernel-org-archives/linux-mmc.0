Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992ACC43460
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Apr 2021 10:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6674D61427
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Apr 2021 10:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhDUKco (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbhDUKcl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Apr 2021 06:32:41 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7207C06138B
        for <linux-mmc@vger.kernel.org>; Wed, 21 Apr 2021 03:32:07 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u20so47098452lja.13
        for <linux-mmc@vger.kernel.org>; Wed, 21 Apr 2021 03:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fBQWyNtRNzkXZ2Gc9WUvzsz7njLiu60umO7wwJKluZY=;
        b=LKOFJpHSObmujmQdunPXOFFv/fgR3WYfzBlUopgCGKd3UJChtrfRG0BfGIocMOYwhy
         p+JGmUdiga+COnlSgspTSEEmLIIB851zeucmhnQ3rGwPYlLIJ3uJOJC6nybTICFpq9AT
         jRbghH9a23GbT/Brtcm9voCyswA0OIAvk3oWea5cq4SNq480J0zPKeHpm2sdppSPhW+8
         /0JPkyATAZa8OXpNB0ePQqks8jjWwnEWhWhmzVdTS4klK5r8bB6Wz6Fqee6Lf5FSEsGi
         ZKaAiXmU5O28U261JKx1Nf4k3+LQoLgDVYS07XXOuIaoJua9cwp2PZuJPo3OhSKNr0ns
         Vvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fBQWyNtRNzkXZ2Gc9WUvzsz7njLiu60umO7wwJKluZY=;
        b=Lw857m4sbuE7iCxwRPfQL8vDCKrh9cMKvn+XMmef5k10YMgJKg3y7wnsqh/sOZDq4E
         3k1FRBpklB+8SDH6mP1/HLSK/+vXHuk8qqurowSuFEgTzF9gYmKnrm+pq1MY3Ev0ECrG
         7nQR5umL8r+cwC//9FRpsD1p1u7otMcUpPoxSfC9gzJZlEfeBe2SQoNtXaV9NzrE35Wa
         S1FyQbGwITL5q15Ue/N778bszR9amJp20/n4OOnHImKevRDwXGxPFJM7JBE3VuVxaRoK
         T10mG1FpCyfPSeroiEATSd+hpwOW6IpOW+aKzmPTABK469zcrH5rgCQ/yeb+cRq5ifeb
         b7rw==
X-Gm-Message-State: AOAM532OC/BzQe5xYuKCCq4pEduLtI6DMtIh6DR4SG+o780M5CeijfS4
        MwRh19FQjGfKVw+O6WTo0FE4MaNLaTP0+VBf
X-Google-Smtp-Source: ABdhPJy2QAMm2KR9a2HuLbV6o3dBB1eV4thW4JJzL9UYl4tSBGf5+jl5vFKnquBcNTYNJBkExFvAfQ==
X-Received: by 2002:a2e:7817:: with SMTP id t23mr17354186ljc.240.1619001125567;
        Wed, 21 Apr 2021 03:32:05 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id u13sm170603lfg.139.2021.04.21.03.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:32:04 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] mmc: core: Read/parse SD function extension registers
Date:   Wed, 21 Apr 2021 12:31:50 +0200
Message-Id: <20210421103154.169410-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In the SD spec v4.x the SD function extension registers were introduced,
together with a new set of commands (CMD48/49 and CMD58/59) to read and write
to them.

Moreover, in v4.x a new standard function for power management features were
added, while in v6.x a new standard function for performance enhancements
features were added.

This series doesn't implement the complete support for any of the new
power/perf features, but starts out by reading and parsing the new registers
and stores the information in the struct mmc_card about what features the SD
card supports.

Note that, there are no HW updates need for the host to support reading/parsing
of the these new SD registers.

Tested with a 64GB Sandisk Extreme PRO UHS-I A2 card. Additional tests and
reviews are of course greatly appreciated.

Kind regards
Ulf Hansson


Ulf Hansson (4):
  mmc: core: Parse the SD SCR register for support of CMD48/49 and
    CMD58/59
  mmc: core: Prepare mmc_send_cxd_data() to be used for CMD48 for SD
    cards
  mmc: core: Read the SD function extension registers for power
    management
  mmc: core: Read performance enhancements registers for SD cards

 drivers/mmc/core/mmc_ops.c |  11 +-
 drivers/mmc/core/mmc_ops.h |   2 +
 drivers/mmc/core/sd.c      | 222 ++++++++++++++++++++++++++++++++++++-
 include/linux/mmc/card.h   |  21 ++++
 include/linux/mmc/sd.h     |   3 +
 5 files changed, 252 insertions(+), 7 deletions(-)

-- 
2.25.1

