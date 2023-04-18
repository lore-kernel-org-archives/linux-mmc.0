Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A5DC77B75
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Apr 2023 08:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjDRIng (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Apr 2023 04:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjDRInf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Apr 2023 04:43:35 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7185255
        for <linux-mmc@vger.kernel.org>; Tue, 18 Apr 2023 01:43:33 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id q5so15109820wmo.4
        for <linux-mmc@vger.kernel.org>; Tue, 18 Apr 2023 01:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681807412; x=1684399412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RztuTVR7hw4raAhfT6J3TalLtZ06SVk+SHPhqyQqZnI=;
        b=TZJlsIiH1GcjTN0yoC70fqOWoGMlBXmcZwfl4fL841T36S2Vs6hFhyK/Hc7TdlM9ts
         Lc2V93Lm/mCmDN/cTI4XC1w6OybBDbBQLDk7vCsRCFW3cZL+KdS/p3VehZu85wf7NrYc
         9M3kI3wh+nRSInh2d6a8e1TnXHaqqXsjBYATrX8uqV67M7aigikku5EEjulT6oZElLSJ
         dhMqpm8ixvwXCe1M1VG9Imkat/3whSIun1si4RcSCBcwzMwNbRUBzdmLbOUox4lAZ6d1
         o6Ijr4ujgogLUTnxZGxd0wa03GrD0Jh7CPWw9vqW2G8H7EqKrLQSgZMHXZP/x8eyuCQq
         defw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681807412; x=1684399412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RztuTVR7hw4raAhfT6J3TalLtZ06SVk+SHPhqyQqZnI=;
        b=RbVrf+4JY4Y6e1/K6Nzfr34JJ020PDTMB4SYPxozepiMoFxyVigPJX6w7a26QnuvKd
         wsAkTFoGxlnrHdYCUYKm3vHEvoSTT7WCjKFYHPUkcc6Nus6Qs/VahFua9kxLNmtpopwz
         P0BrVoU5pGSVVeGp1cSWN78Iq7dB5KzlYbVDbIypVLZwgb+IhTGrgccYhhkhL/59GKYf
         UUC0XxG/edI/Mc7NIoowqQSvbpc18fDFTqooPuW3AorCy6r5pICzmYeyQ/4aNb8ISRkb
         7AJ9PTS49hP4gIpvpEqa+t8AP1MCcq2Q8/a0fthBv1UJQQQjXoJONUhHA5nTtHoXoEeo
         qsZw==
X-Gm-Message-State: AAQBX9fK0OjiLiwFZ6M99FrRl3MiTashyOelwwc3NhY4xVkmkLxC71rZ
        C+PpOCHNdj65wAbPLV2L0xLA3z1iWXwLa0iDHkoEoQ==
X-Google-Smtp-Source: AKy350Z3/trX/Rd8oXcBkZKmyT2S3M2AuEUAKSjvLdnk/WnkHVS3TD6y8ujzGaXiwosvQkHCJAmg5Q==
X-Received: by 2002:a1c:790e:0:b0:3f0:7f70:d67d with SMTP id l14-20020a1c790e000000b003f07f70d67dmr13423703wme.12.1681807411927;
        Tue, 18 Apr 2023 01:43:31 -0700 (PDT)
Received: from uffe-XPS13.. ([193.205.131.2])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c215500b003f17a00c214sm1147654wml.16.2023.04.18.01.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 01:43:31 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK fixes for v6.3-rc8
Date:   Tue, 18 Apr 2023 10:43:29 +0200
Message-Id: <20230418084329.12066-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC and MEMSTICK fixes intended for v6.3-rc8.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.3-rc3

for you to fetch changes up to 4b6d621c9d859ff89e68cebf6178652592676013:

  memstick: fix memory leak if card device is never registered (2023-04-05 11:43:51 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci_am654: Fix support for UHS-I SDR12 and SDR25 speed modes

MEMSTICK:
 - Fix memory leak if card device never gets registered

----------------------------------------------------------------
Bhavya Kapoor (1):
      mmc: sdhci_am654: Set HIGH_SPEED_ENA for SDR12 and SDR25

Greg Kroah-Hartman (1):
      memstick: fix memory leak if card device is never registered

 drivers/memstick/core/memstick.c | 5 ++++-
 drivers/mmc/host/sdhci_am654.c   | 2 --
 2 files changed, 4 insertions(+), 3 deletions(-)
