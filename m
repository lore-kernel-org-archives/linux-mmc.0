Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C30AC7112B
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Aug 2023 09:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359073AbjHRJ31 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Aug 2023 05:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359086AbjHRJ3V (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Aug 2023 05:29:21 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78ED30E6
        for <linux-mmc@vger.kernel.org>; Fri, 18 Aug 2023 02:29:19 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9c0391749so11251191fa.0
        for <linux-mmc@vger.kernel.org>; Fri, 18 Aug 2023 02:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692350958; x=1692955758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pe6dUrFf2OfRIze9u6TiWKYUZqpOSPeSgcea4E9pAH8=;
        b=HcV4CGUqJf+tkyUDdlqSRPJ//Tt6+qta265+7O+KsSD4apqVlf/G3swEE3+9K/5lpa
         q33ilqddz9zpfy/7CJyHqPx1xAWaxYoigj+hqynMgLzzb3XW9dP6FFct1EFIOMdjjZgO
         EsP+gUkvbQ5Fs2lDBw7dg8C/dRmatpSs4zf9xBWxHWBZevhgUf4JH7cFX9sfISpYRJao
         NbVTdttNyLfqAWRJzSW7eD1KLGku4f5eM6FtO9mftV7NlsyXuJa23i1jqixOzEI3eHE8
         4f0aPm92MvmZaWZj+FvrQh4g+Aa8KzHYDxHDLeatnDeZSiZjU30ZUuvwp0OmnoEq5C+C
         vorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692350958; x=1692955758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pe6dUrFf2OfRIze9u6TiWKYUZqpOSPeSgcea4E9pAH8=;
        b=hQEsdKr6yOlZ95C1v2c94fj/bzkaWSNkhBda39mx5+4dXqSjxgT5k1aYO1l0jHsj9W
         uH3SrRdvnafuD9WkO+DxicJ7AeQ2uGCGrtm6uzS8Al+RQo5oAh0spvN5Y4/iRYv73NtE
         ntZKEXE5nignE6EvGPbZi6Nil4+shFBHKAmzuLFitZfFz++uzbFpXjKWzsc12zB1Zy0+
         YcbwpSGFhNz3bwejwP1xZDHD5rf2/duMqUBcf/iHK1D1nc3rFZQ7GyRI2p9Y9YXpudk6
         8T8DBF1B/K3OZ0t1FY+81Mo4cmTfkfxxyvLG4pOHMXHPInv+KMYvGraYF7tYlEYr6sli
         GwDg==
X-Gm-Message-State: AOJu0YwLvQe6oYgGCxLPy2/KTlCxf+YpKi3XL4W1jB2S8HlgKlBj2bFC
        FVLTRq51lBJ+NDlK4BKbL3P2nw==
X-Google-Smtp-Source: AGHT+IGovJeuyXXZM0SAAt+XnpR6ZkzwKHmLu3sqae8E8VhNrzYrIWkUAVTMWyFKYbISCtCzDHpAHA==
X-Received: by 2002:a2e:9d55:0:b0:2b6:e96c:5414 with SMTP id y21-20020a2e9d55000000b002b6e96c5414mr1215354ljj.52.1692350958052;
        Fri, 18 Aug 2023 02:29:18 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p17-20020a2e9ad1000000b002bbacc6c523sm333546ljj.49.2023.08.18.02.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 02:29:17 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.5-rc7
Date:   Fri, 18 Aug 2023 11:29:16 +0200
Message-Id: <20230818092916.38330-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.5-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5def5c1c15bf22934ee227af85c1716762f3829f:

  mmc: sdhci-f-sdh30: Replace with sdhci_pltfm (2023-07-14 11:28:55 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.5-rc1-2

for you to fetch changes up to 58abdd80b93b09023ca03007b608685c41e3a289:

  mmc: f-sdh30: fix order of function calls in sdhci_f_sdh30_remove (2023-08-15 13:24:29 +0200)

----------------------------------------------------------------
MMC core:
 - Fix in_flight[issue_type] value error to properly manage requests

MMC host:
 - wbsd: Fix double free in the probe error path
 - sunplus: Fix error path in probe
 - sdhci_f_sdh30: Fix order of function calls in sdhci_f_sdh30_remove

----------------------------------------------------------------
Harshit Mogalapalli (1):
      mmc: sunplus: Fix error handling in spmmc_drv_probe()

Wei Chen (1):
      mmc: sunplus: fix return value check of mmc_add_host()

Yang Yingliang (1):
      mmc: wbsd: fix double mmc_free_host() in wbsd_init()

Yangtao Li (1):
      mmc: f-sdh30: fix order of function calls in sdhci_f_sdh30_remove

Yibin Ding (1):
      mmc: block: Fix in_flight[issue_type] value error

 drivers/mmc/core/block.c         |  7 ++++---
 drivers/mmc/host/sdhci_f_sdh30.c | 11 +++++++----
 drivers/mmc/host/sunplus-mmc.c   | 26 +++++++++++++-------------
 drivers/mmc/host/wbsd.c          |  2 --
 4 files changed, 24 insertions(+), 22 deletions(-)
