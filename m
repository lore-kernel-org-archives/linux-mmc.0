Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A811C433FE
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Feb 2022 11:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243703AbiBGLqY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Feb 2022 06:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384387AbiBGL2C (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Feb 2022 06:28:02 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA44C03E946
        for <linux-mmc@vger.kernel.org>; Mon,  7 Feb 2022 03:26:09 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id o17so19088723ljp.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Feb 2022 03:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77jDirKALASyuRe4H7SNos8+ceiZ5NwhVHAmzpu0zXA=;
        b=YPG3HSxJDHKgSkLNtEZkTejuMRlS5t3d0YDL/GSegkBzscg/AzU0bbVAoAAIj2jYRj
         aESr+4jgMaypMMIwM0Ho5vk5lfe7AUCINgESqbh1fjUuJHPGg3TszyV9MJG6Lsx9dlG3
         lCaRevSAg68VQeJAGT8TYNZOWHv6gIYm98eYHsENIigae8mIHGqX3XT+TvMmFQm0D9fW
         /EE7CB+EcTk3UXcfQR7OYRRuguM8pdwxYbFoHj/sP2ROwqrJ3r8MCdyqv+9f9NO1uHKL
         /AqLLS18OjZzcg8UtTf+WhTvI7hSJ77JkNZ/92/dzIGYzYoMqlbKlUrJU0TXu15+UwRl
         zg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77jDirKALASyuRe4H7SNos8+ceiZ5NwhVHAmzpu0zXA=;
        b=f9CQZdywbdnelx2uZ8/UkFPQ3iASeKeJ3FDOBWqFqmzlMvwPNxkCI7uwEVedvd42M1
         wQoLfkDWWxQOYpXjLYD2kiYoMCZ60EavCqdS0n1mjE32GGC8/98B6twu/cUR+DFpF8W8
         12Ee9F1XYfL+pxgoksK/s2VwMMaFkheDMKYDl6rYv1TgEUTQLDw7ReJeDNDGBRS1N9Pl
         +OvEBxZ0cvZSVUr8AkYAOJ47sE5GZA+vf5GEmvWWEfmyLSZbfMEV4SpMFYvwTv4AnEeV
         XQHOcRSnJvvF94LK1v+aWXIqKx/8NyL7h4MShhK2RQ0r9gNU673lAz5wNu4sinUMvRs3
         Ya9Q==
X-Gm-Message-State: AOAM532HVJrRtwzMESm6Vg3vh7diWdsKEcBf/gU5WicGRdh3Afhr9BUe
        sHNbTPbad2LYpilKxfttLOVX5A==
X-Google-Smtp-Source: ABdhPJx1YHEx8hiT2J0YS7cHvuzQ34b5CoCNxheFV1HDcYv0oDChcf6LpLrWcy+v2YVfAhzHSCjOWg==
X-Received: by 2002:a05:651c:d4:: with SMTP id 20mr8530119ljr.132.1644233168232;
        Mon, 07 Feb 2022 03:26:08 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-21.NA.cust.bahnhof.se. [155.4.129.21])
        by smtp.gmail.com with ESMTPSA id z20sm1530066ljj.103.2022.02.07.03.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 03:26:07 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.17-rc4
Date:   Mon,  7 Feb 2022 12:26:05 +0100
Message-Id: <20220207112605.246647-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.17-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.17-rc1

for you to fetch changes up to bd2db32e7c3e35bd4d9b8bbff689434a50893546:

  moxart: fix potential use-after-free on remove path (2022-01-31 15:36:34 +0100)

----------------------------------------------------------------
MMC core:
 - Fix support for SD Power off notification

MMC host:
 - moxart: Fix potential use-after-free on remove path
 - sdhci-of-esdhc: Fix error path when setting dma mask
 - sh_mmcif: Fix potential NULL pointer dereference

----------------------------------------------------------------
Andrey Skvortsov (1):
      mmc: core: Wait for command setting 'Power Off Notification' bit to complete

Greg Kroah-Hartman (1):
      moxart: fix potential use-after-free on remove path

Jiasheng Jiang (2):
      mmc: sdhci-of-esdhc: Check for error num after setting mask
      mmc: sh_mmcif: Check for null res pointer

 drivers/mmc/core/sd.c             | 8 +++++++-
 drivers/mmc/host/moxart-mmc.c     | 2 +-
 drivers/mmc/host/sdhci-of-esdhc.c | 8 ++++++--
 drivers/mmc/host/sh_mmcif.c       | 3 +++
 4 files changed, 17 insertions(+), 4 deletions(-)
