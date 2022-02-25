Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE55C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Feb 2022 20:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbiBYUlf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiBYUle (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Feb 2022 15:41:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42190214F99;
        Fri, 25 Feb 2022 12:41:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01AA7B83363;
        Fri, 25 Feb 2022 20:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB20C340E7;
        Fri, 25 Feb 2022 20:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645821659;
        bh=HE8061LF/iGlGPikfhtbvjKwTHd7MrtYrRbVauGucKk=;
        h=From:To:Cc:Subject:Date:From;
        b=p1fVqOO/4teZOpAH/ugmrKB7ZJeG0J4pG1tth3XNCRtbdkF7vXE5d3pUJi+DzPm8u
         i0ISzk+WNMwe1woR2UxwcRzkEL8yxQBaoiXm09MvY096J7S5RE1hbEKYRww4IbkKwD
         p3JPKcwFLQUXYhxfsY7AyyFFlxa2DgYB/lrVdgw1ng7Pbyxt58oaaHzjhWTcM7u/h8
         Ys9LgtK9IHDOQJlSwG3oxIdxtRsG4s3NxoLy54nQsPDPIyMv2aDxLWG4Hbt/b7WOnt
         /vlLjEUoheH8f6zw5GGpyR2jIh43nxliyJteIEbmrfWb288JpylDo3Aa1yeJ4/IpI1
         yhRaXZbAXJGVg==
From:   broonie@kernel.org
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-mmc@vger.kernel.org
Subject: linux-next: build failure after merge of the char-misc tree
Date:   Fri, 25 Feb 2022 20:40:55 +0000
Message-Id: <20220225204055.3899986-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi all,

After merging the char-misc tree, today's linux-next build (x86
allmodconfig) failed like this:

/tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sd_request':
/tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:809:17: error: unused variable 'dev' [-Werror=unused-variable]
  809 |  struct device *dev = &host->pdev->dev;
      |                 ^~~
/tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_set_ios':
/tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1084:17: error: unused variable 'dev' [-Werror=unused-variable]
 1084 |  struct device *dev = &host->pdev->dev;
      |                 ^~~
/tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_get_ro':
/tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1133:17: error: unused variable 'dev' [-Werror=unused-variable]
 1133 |  struct device *dev = &host->pdev->dev;
      |                 ^~~
/tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_get_cd':
/tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1159:17: error: unused variable 'dev' [-Werror=unused-variable]
 1159 |  struct device *dev = &host->pdev->dev;
      |                 ^~~
/tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_switch_voltage':
/tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1258:17: error: unused variable 'dev' [-Werror=unused-variable]
 1258 |  struct device *dev = &host->pdev->dev;
      |                 ^~~
/tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_execute_tuning':
/tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1311:17: error: unused variable 'dev' [-Werror=unused-variable]
 1311 |  struct device *dev = &host->pdev->dev;
      |                 ^~~
cc1: all warnings being treated as errors

Caused by commit

  7570fb41e450ba37 ("mmc: rtsx: Let MMC core handle runtime PM")

I have used the char-misc tree from yesterday instead.
