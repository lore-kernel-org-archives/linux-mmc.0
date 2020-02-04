Return-Path: <SRS0=92ZL=3Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65479C2D0B1
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B48D21744
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ru9kADQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgBDIzX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Feb 2020 03:55:23 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38697 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgBDIzX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Feb 2020 03:55:23 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so17711266ljh.5
        for <linux-mmc@vger.kernel.org>; Tue, 04 Feb 2020 00:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PxbxjkKlNhhTJR8wRb3j/yvmTz9T7alicVi9qKEvd6o=;
        b=ru9kADQD0UXkQwACZ1GbT3/7W1cbzO3TD6QfNYomaEic6ZW8/P8bpbj/lQDza77mgj
         saohAAZU31Y25zx4SvlEShhJrwpWpH3KACfbY+YSNlCjrZqDt2/VXjA/kTrDci3R4Lkb
         4KMgVDun7UUS+70S52mzQgWv3q07xb8H8k6qk+mY8S+Z8eOJTj6niSB0wB9RqInRnfqm
         FL/K3avNb8/22wUk1TdX0Hs4bNabuaX9PNU1zeVNGFoFpu2EEuYo8aZO2gXuL9VRYKDA
         LFDTELOQn8Gnha2wzuoXcZly7kbC9iJgdqvbbGY9sIbwiqOi/IZYo57KL9vpoesoYvMu
         Y88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PxbxjkKlNhhTJR8wRb3j/yvmTz9T7alicVi9qKEvd6o=;
        b=JstS7p2l9N383SdCFPr61c04EQ3KdvbZ9bdi/3Yqz/mF0Z21nDxG4EghTtxiMgQzW/
         4/RSFIpWU4dRKRDShVoVY4IIKUC7ZavXjrlp1uNUlxtBQqbu4Uk/1OdMULOxCZ8XO3Is
         LBDAwakFMdy+1oMgeo8s5Sp3mp/6ZvkGLFrMVlGIvtCCv96cft48gEO3zQ1y5L8QyOvX
         EGKJXGel6019223PtpILMBeIkMD8ijNaHmyYuK8q9+4lf9K1YWWC8jSUmBEsXcxc0+68
         wz75G1gJm8COYTognUAc9OHfypF0hPSgvxjdx9c1wpDHfNhgRRMdK2cjD73EiZ+is68d
         VaYg==
X-Gm-Message-State: APjAAAUEIRjY3OMTaB37C9haaDloIM1Sj3pQGAoyO9YYn8LNIvKWo1vF
        48kda/y2nklZd9uSOvWq5odAAZMVLLI=
X-Google-Smtp-Source: APXvYqxBCaIkCrcu5yJjmmxvB9EeCOgJ6U/zMI4geDwFqG525WpbeRBDbVdUFdJRhrvZBnZgPwV8dQ==
X-Received: by 2002:a2e:9e19:: with SMTP id e25mr17858308ljk.179.1580806520658;
        Tue, 04 Feb 2020 00:55:20 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n2sm11156283ljj.1.2020.02.04.00.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 00:55:20 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: [PATCH 09/12] mmc: core: Drop redundant out-parameter to mmc_send_hpi_cmd()
Date:   Tue,  4 Feb 2020 09:54:46 +0100
Message-Id: <20200204085449.32585-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204085449.32585-1-ulf.hansson@linaro.org>
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The 'u32 *status' is unused by the caller, so let's drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 5643277a4eeb..4d8f90d01740 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -827,7 +827,7 @@ int mmc_bus_test(struct mmc_card *card, u8 bus_width)
 	return mmc_send_bus_test(card, card->host, MMC_BUS_TEST_R, width);
 }
 
-static int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
+static int mmc_send_hpi_cmd(struct mmc_card *card)
 {
 	struct mmc_command cmd = {};
 	unsigned int opcode;
@@ -849,8 +849,6 @@ static int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
 			err, cmd.resp[0]);
 		return err;
 	}
-	if (status)
-		*status = cmd.resp[0];
 
 	return 0;
 }
@@ -899,7 +897,7 @@ int mmc_interrupt_hpi(struct mmc_card *card)
 		goto out;
 	}
 
-	err = mmc_send_hpi_cmd(card, &status);
+	err = mmc_send_hpi_cmd(card);
 	if (err)
 		goto out;
 
-- 
2.17.1

