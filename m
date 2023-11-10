Return-Path: <linux-mmc+bounces-4-linux-mmc=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477DCC4167B
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Nov 2023 17:47:22 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17EF1C20C4B
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Nov 2023 17:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC33031A63;
	Fri, 10 Nov 2023 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SuHXJkIc"
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734B82230C
	for <linux-mmc@vger.kernel.org>; Fri, 10 Nov 2023 17:46:34 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C49133676
	for <linux-mmc@vger.kernel.org>; Fri, 10 Nov 2023 04:26:42 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507cd62472dso3428074e87.0
        for <linux-mmc@vger.kernel.org>; Fri, 10 Nov 2023 04:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699619200; x=1700224000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vbt3drzH6qk5bCWArsPemY04IIl/cwsmy/leESa8QcA=;
        b=SuHXJkIcrLQjvNsTMmhw/YnHSw9Lp0TiM9rYq0lLffTZATc/Rore3icDkMYLfgx/Rn
         YYeO72nbh/XgarKv3jHX4Yt3CTaM6tL3yQnKUv4RlE57PF2TijhuiLqTyroS53r2R5xc
         5yuDoEgoaAHIDwPFio5/wpAgkDeS0EWyyGSHhmvS25PtUYXm7qL4zSmn4Fx7qbKOSq3b
         4T0Kt5shjvyDVxLSZxZI5CQgK1HTp4XebzmytEy21PGlmgwCwA4TX6u4n+2IDrgHKu0X
         ZrI1HXfRKjf8iwtC42ghVOLJSga1o9OpeClItAid97iOI0RapSN8xWd/rxg0GCsRaJZO
         7GPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699619200; x=1700224000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbt3drzH6qk5bCWArsPemY04IIl/cwsmy/leESa8QcA=;
        b=Jo7qStD5g4TEn4YcR7BWhpNYB9hOsHtuNzOlE0Y6usVM5USkxIfhnxE83tEewHE5+p
         33Nfxj6la68F9WSTxQtQeGybhiV3K5hB7gK4Nk399AVxsfoFVOEVAX0wr9cG2G0Q5rFS
         zHdqz+IrvmS5ZRWV93T1IAD7aqReqGSHRJBIZB80F348UK82nYYQRETCI4sSXo71LxLY
         HqHmp4nXyE6laLftdN2VWagWN4uz2TB+5tgxoK56MbQBYC5RgeB7ZYXF0Gj4SAl7HCw2
         JPGl42WTO58ji0TrchGFxfdUFPjX5MKKFVuJowGchxxRBs9ggzdIe0GIAZfadC1UFkEA
         F2WA==
X-Gm-Message-State: AOJu0YzjRThC7uulTP925bTidmLN6fHUYarw93LYtArfluDfKHSpiF85
	5CnnZQ8FDcUISbTLuJ8BCqMdwA==
X-Google-Smtp-Source: AGHT+IFo23qlHctwNYuSs93xlQPGA1oCz5oMynSoQzr47pICWmuEFh+5o92Fz7jLKHrPH/3TRo/4eg==
X-Received: by 2002:ac2:44ac:0:b0:504:b84f:7b19 with SMTP id c12-20020ac244ac000000b00504b84f7b19mr770535lfm.20.1699619200440;
        Fri, 10 Nov 2023 04:26:40 -0800 (PST)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id f19-20020a2e9193000000b002c0055834b3sm257685ljg.4.2023.11.10.04.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 04:26:40 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.7-rc1
Date: Fri, 10 Nov 2023 13:26:38 +0100
Message-Id: <20231110122638.21897-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.7-rc1. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8f6f76a6a29f36d2f3e4510d0bde5046672f6924:

  Merge tag 'mm-nonmm-stable-2023-11-02-14-08' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2023-11-02 20:53:31 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7-2

for you to fetch changes up to 015c9cbcf0ad709079117d27c2094a46e0eadcdb:

  mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of AER (2023-11-07 13:08:12 +0100)

----------------------------------------------------------------
MMC core:
 - Fix broken cache-flush support for Micron eMMCs
 - Revert "mmc: core: Capture correct oemid-bits for eMMC cards"

MMC host:
 - sdhci_am654: Fix TAP value parsing for legacy speed mode
 - sdhci-pci-gli: Fix support for ASPM mode for GL9755/GL9750
 - vub300: Fix an error path in probe

----------------------------------------------------------------
Bean Huo (1):
      mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron eMMC Q2J54A

Dan Carpenter (1):
      mmc: vub300: fix an error code

Dominique Martinet (1):
      Revert "mmc: core: Capture correct oemid-bits for eMMC cards"

Nitin Yadav (1):
      mmc: sdhci_am654: fix start loop index for TAP value parsing

Victor Shih (2):
      mmc: sdhci-pci-gli: GL9755: Mask the replay timer timeout of AER
      mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of AER

 drivers/mmc/core/block.c         |  4 +++-
 drivers/mmc/core/card.h          |  4 ++++
 drivers/mmc/core/mmc.c           | 10 +++++++---
 drivers/mmc/core/quirks.h        |  7 ++++---
 drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
 drivers/mmc/host/sdhci_am654.c   |  2 +-
 drivers/mmc/host/vub300.c        |  1 +
 include/linux/mmc/card.h         |  2 ++
 8 files changed, 38 insertions(+), 8 deletions(-)

