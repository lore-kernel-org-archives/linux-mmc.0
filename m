Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108AEC6FD1D
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Mar 2023 09:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCQJZE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Mar 2023 05:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjCQJY7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Mar 2023 05:24:59 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2C8FF06
        for <linux-mmc@vger.kernel.org>; Fri, 17 Mar 2023 02:24:54 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a32so4377324ljr.9
        for <linux-mmc@vger.kernel.org>; Fri, 17 Mar 2023 02:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679045093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8MM6+PVvmNctKWRUEeKFo+Q7UBEhBwI3Y3kPxVWz3mQ=;
        b=UWAlgGtSiDeVy/+M72RpLqqMDEvcTiOhVZt8+EP6WOqov7RObi1ZUS5+/Bca/DAcJg
         sIAHvgoX4UwLVbmTO2G0/D4RI53zNZpD5ZDfnQKFBv40rtvzApPCLffEGwwUFnuifDFR
         7rzK/fHf8e78PwZjX9kswhFfGiMXFjKYa5YYSOX2snNA8D/4YCgt0n3bzj0jXmV6DWIW
         utssuqZ0kL6G99U/PjISyJCXWr3MsSxFprXN+thOpiJbwil0c/YqqtyLwkYbTX5xepPM
         wo4EmtUdwjFGBgtQlr5uK7hNkOQ/wpMHZe+Xb+Rt8qHItPp2S11RbR2FPF6YP6lio1d8
         C7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679045093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8MM6+PVvmNctKWRUEeKFo+Q7UBEhBwI3Y3kPxVWz3mQ=;
        b=6/UAncy0qSQuCPX5QwVz41UH8f+npuEFJ/93Qae6QosQCSzqsHTkpo/PMkmiRACTTh
         J2pQaAit/+ZhXhKbFUeRHok72Y15zCnm6C8P+pxULkMlcyzNKrSDtcPe6Gh0w76Gaf8Y
         1DR/puqsq2r2u2plh0q3yfX8gtzlQvd8dqCJlPxLV9STgtb6EzJnSzfHaF5/Y7dnMmzc
         P/0TRd13NU+BnEjSDBmxkNoTRSg3/dq3exL/nsSHH41IauFbURw9DsCx1G7flaECM0vu
         re5PtT3/zDUhfpSmdDoj0gVq/6gzsVPfNyn6w3R6LdLix8oRztOQTTnKdA2DjANwAiOC
         SMeA==
X-Gm-Message-State: AO0yUKWSYQWY8V4Qimggt0qX/UKVOyzGoMpjFrUXDgasNwZoweMVWc2B
        tDjp7EytTDwNoQAvdm+0KHZTww==
X-Google-Smtp-Source: AK7set8tsWcmrQBmVnRYk/PTEJDPWVrGYwgtzlLxYLNZxvANqSEgL3T4/ONo8ENL2VjImNR4KL3Gtg==
X-Received: by 2002:a2e:b8c4:0:b0:295:c455:1cea with SMTP id s4-20020a2eb8c4000000b00295c4551ceamr3812204ljp.49.1679045093088;
        Fri, 17 Mar 2023 02:24:53 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p4-20020a19f004000000b004db3890cb53sm281148lfc.223.2023.03.17.02.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 02:24:52 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.3-rc3
Date:   Fri, 17 Mar 2023 10:24:51 +0100
Message-Id: <20230317092451.1616451-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.3-rc3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.3-rc1

for you to fetch changes up to 92771cdd90de64b15e65f3c88d6c6199bd5f33f5:

  mmc: dw_mmc-starfive: Fix initialization of prev_err (2023-03-09 15:33:51 +0100)

----------------------------------------------------------------
MMC host:
 - dw_mmc-starfive: Fix initialization of the prev_err variable
 - sdhci_am654: Lower power-on failed message severity

----------------------------------------------------------------
Francesco Dolcini (1):
      mmc: sdhci_am654: lower power-on failed message severity

William Qiu (1):
      mmc: dw_mmc-starfive: Fix initialization of prev_err

 drivers/mmc/host/dw_mmc-starfive.c | 2 +-
 drivers/mmc/host/sdhci_am654.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
