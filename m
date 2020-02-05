Return-Path: <SRS0=4knG=3Z=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7217EC35254
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Feb 2020 12:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC2E2082E
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Feb 2020 12:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9cdohrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBEMvT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:51:19 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37053 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgBEMvT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Feb 2020 07:51:19 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so854247plz.4;
        Wed, 05 Feb 2020 04:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PXFvkiGRXuDhiJvcYc/Jk/zrUgQKIy7nBUfvFcGoJRk=;
        b=U9cdohrchImToTte6UIkVqRPyXjcmnCaDPkha+8rOGhUm2FlVecoLDxszkQhdUDlun
         BwtaKxndX+TbOMjEEmRNmKazySg4cl79JRjZybXu3FfeBM+Wyg/uqiGDEO2x9bCygMzM
         VvEfvqKRYBS7iWT5JzdV5DC4h7ZWjvwYaOQX7ypsCtWWnd1x8K/DADdftT2MfDSOxIGX
         gaYhkOTN3ECbLKyo3AagzoY90wqcQJZY9dYS3jzAAdGmNnP2vrA8M3zmhz1HgdYfg8hY
         SDf0hXSkZMy+vF2x3YvQvdsvi+QkBkSq437f2K3C5yS92Fl8vTdycE0RkvIeLPjCC6hD
         bJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PXFvkiGRXuDhiJvcYc/Jk/zrUgQKIy7nBUfvFcGoJRk=;
        b=Uqfsti/Oj6ShfcZ7gptmTdG3XCpM2/aIEPoI3O4T/9KZVsnaQQu2CTn9hcdekwadGJ
         yCRPtWccCnF4JAxdsH4Atluv888bvrFPOULaldEjcu8oeP0YQ2DzyAJREFbM/TWWk3Yf
         PddW+2SD6kRm9CC1KokIJax/7/NH8oA+IC0nqk4K45mRMjfqn7QMUOeAEEqAeYIK7Ovn
         QhGoWhp9LC9sbGkWAa/Siw6SBjbDWs3dA2iBPvKtWAHbJVp6Iea6py04o2TpCy74oXvj
         FkBDHwa9QJuHvff6zyMFz9/b968g0wOhAwb07Xr2xqGDEZmx1mN+c1BSW0kpeF6bQtcs
         jIdw==
X-Gm-Message-State: APjAAAUEzphnZK3b10ZuOvBLSq3yzedV3+v9RlsFOYjQaveiysJFGWtD
        1t+Jj1A8ASn2Q0wxopYkodo=
X-Google-Smtp-Source: APXvYqz4sd6fi573XbT5NcaZW+Sb0tSHSKJq5m6qBTIez9iu5vjhwO183Uck3jZcDScGo6lYpsQa1Q==
X-Received: by 2002:a17:902:bb83:: with SMTP id m3mr35458452pls.258.1580907078376;
        Wed, 05 Feb 2020 04:51:18 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y127sm22864784pfg.22.2020.02.05.04.51.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Feb 2020 04:51:17 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/5] Add MMC software queue support
Date:   Wed,  5 Feb 2020 20:50:27 +0800
Message-Id: <cover.1580894083.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi All,

Now the MMC read/write stack will always wait for previous request is
completed by mmc_blk_rw_wait(), before sending a new request to hardware,
or queue a work to complete request, that will bring context switching
overhead, especially for high I/O per second rates, to affect the IO
performance.

Thus this patch set will introduce the MMC software command queue support
based on command queue engine's interfaces, and set the queue depth as 64
to allow more requests can be be prepared, merged and inserted into IO
scheduler, but we only allow 2 requests in flight, that is enough to let
the irq handler always trigger the next request without a context switch,
as well as avoiding a long latency.

Moreover we can expand the MMC software queue interface to support
MMC packed request or packed command instead of adding new interfaces,
according to previosus discussion.

Below are some comparison data with fio tool. The fio command I used
is like below with changing the '--rw' parameter and enabling the direct
IO flag to measure the actual hardware transfer speed in 4K block size.

./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=1G --group_reporting --numjobs=20 --name=test_read

My eMMC card working at HS400 Enhanced strobe mode:
[    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
[    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB 
[    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
[    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
[    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)

1. Without MMC software queue
I tested 5 times for each case and output a average speed.

1) Sequential read:
Speed: 59.4MiB/s, 63.4MiB/s, 57.5MiB/s, 57.2MiB/s, 60.8MiB/s
Average speed: 59.66MiB/s

2) Random read:
Speed: 26.9MiB/s, 26.9MiB/s, 27.1MiB/s, 27.1MiB/s, 27.2MiB/s
Average speed: 27.04MiB/s

3) Sequential write:
Speed: 71.6MiB/s, 72.5MiB/s, 72.2MiB/s, 64.6MiB/s, 67.5MiB/s
Average speed: 69.68MiB/s

4) Random write:
Speed: 36.3MiB/s, 35.4MiB/s, 38.6MiB/s, 34MiB/s, 35.5MiB/s
Average speed: 35.96MiB/s

2. With MMC software queue
I tested 5 times for each case and output a average speed.

1) Sequential read:
Speed: 59.2MiB/s, 60.4MiB/s, 63.6MiB/s, 60.3MiB/s, 59.9MiB/s
Average speed: 60.68MiB/s

2) Random read:
Speed: 31.3MiB/s, 31.4MiB/s, 31.5MiB/s, 31.3MiB/s, 31.3MiB/s
Average speed: 31.36MiB/s

3) Sequential write:
Speed: 71MiB/s, 71.8MiB/s, 72.3MiB/s, 72.2MiB/s, 71MiB/s
Average speed: 71.66MiB/s

4) Random write:
Speed: 68.9MiB/s, 68.7MiB/s, 68.8MiB/s, 68.6MiB/s, 68.8MiB/s
Average speed: 68.76MiB/s

Form above data, we can see the MMC software queue can help to improve some
performance obviously for random read and write, though no obvious improvement
for sequential read and write.

Any comments are welcome. Thanks a lot.

Changes from v7:
 - Add reviewed tag from Arnd.
 - Use the 'hsq' acronym for varibles and functions in the core layer.
 - Check the 'card->ext_csd.cmdq_en' in cqhci.c to make sure the CQE
 can work normally.
 - Add a new patch to enable the host software queue for the SD card.
 - Use the default MMC queue depth for host software queue.

Changes from v6:
 - Change the patch order and set host->always_defer_done = true for the
 Spreadtrum host driver.

Changes from v5:
 - Modify the condition of defering to complete request suggested by Adrian.

Changes from v4:
 - Add a seperate patch to introduce a variable to defer to complete
 data requests for some host drivers, when using host software queue.

Changes from v3:
 - Use host software queue instead of sqhci.
 - Fix random config building issue.
 - Change queue depth to 32, but still only allow 2 requests in flight.
 - Update the testing data.

Changes from v2:
 - Remove reference to 'struct cqhci_host' and 'struct cqhci_slot',
 instead adding 'struct sqhci_host', which is only used by software queue.

Changes from v1:
 - Add request_done ops for sdhci_ops.
 - Replace virtual command queue with software queue for functions and
 variables.
 - Rename the software queue file and add sqhci.h header file.

Baolin Wang (5):
  mmc: Add MMC host software queue support
  mmc: core: Enable the MMC host software queue for the SD card
  mmc: host: sdhci: Add request_done ops for struct sdhci_ops
  mmc: host: sdhci: Add a variable to defer to complete requests if
    needed
  mmc: host: sdhci-sprd: Add software queue support

 drivers/mmc/core/block.c      |   61 ++++++++
 drivers/mmc/core/mmc.c        |   13 +-
 drivers/mmc/core/queue.c      |   22 ++-
 drivers/mmc/core/sd.c         |   10 ++
 drivers/mmc/host/Kconfig      |    8 +
 drivers/mmc/host/Makefile     |    1 +
 drivers/mmc/host/cqhci.c      |    3 +
 drivers/mmc/host/mmc_hsq.c    |  343 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmc_hsq.h    |   30 ++++
 drivers/mmc/host/sdhci-sprd.c |   28 ++++
 drivers/mmc/host/sdhci.c      |   14 +-
 drivers/mmc/host/sdhci.h      |    3 +
 include/linux/mmc/host.h      |    3 +
 13 files changed, 529 insertions(+), 10 deletions(-)
 create mode 100644 drivers/mmc/host/mmc_hsq.c
 create mode 100644 drivers/mmc/host/mmc_hsq.h

-- 
1.7.9.5

