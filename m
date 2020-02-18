Return-Path: <SRS0=YSSR=4G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F0EC3404C
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 23:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BF224655
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 23:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="octol1EC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgBRXi5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:38:57 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35323 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgBRXi4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2020 18:38:56 -0500
Received: by mail-vs1-f68.google.com with SMTP id x123so14280960vsc.2
        for <linux-mmc@vger.kernel.org>; Tue, 18 Feb 2020 15:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lb9j5BvCKP6IR8rXHRKqQO+ukZBQ0kqE300SYxo00gs=;
        b=octol1ECsjjbv+KS71aAvXBmXTRdQGpvn/CLgZoyiuFlReuFMWr93V4dOsSRUjrxIS
         KpyP5RhUX3M5i7+yj6V+gc095UvzcU8kO5rbCMWBIaJqoFZBCEM9IixQcHBjg80uh7RZ
         bKq5lBjssgv5vDFezblrFjg/tCvZa0DIJV+Q6ODL1exae4cTzdyYltgA22iVNkkPoI//
         k+vNDV/XBWvPPUdbSkcDJfdhyLgorZCe5Yy75IH0FubvHOM4XjAzO0fsLYeA4yfkJluJ
         EtOHbZYhIxYBZM4sNeBuXvxrfLOrD7S68OB8GzmMeJq72qS1E1U4rb8IaieQCwyTD3DX
         CaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lb9j5BvCKP6IR8rXHRKqQO+ukZBQ0kqE300SYxo00gs=;
        b=DE0frMVOd+3ua6VeEKfHlO9wJgGhXr9HKJ/dtm3WYGP6VsMblPUAB7nP3YBs0aWF+Y
         ohnaak5/WyBW2DkpSgb+3a9BzxJnrXzY+LEVuQXn8mKf0IIKc75ucG9UKP3zjOXSAGPz
         xbtDbhUXeR5wwHqAw4OhdcnTgRl9rT9SHVbIm0GcJ+58Y2Xgysx+D0nlXcBCRbz+fMSX
         he2E1BTRc/QwEfccf5uKZdMcMBzJqb0sSfhm1LOjE7PIDy0gvfd96ng91nuw6WBQkvGx
         6QVaZI1AP1pAJgIjk5xIp5rNo91ZoEF7B3ibzj6LD6AIcQ9pO6fbQqoBM/cxkExshrZa
         g88Q==
X-Gm-Message-State: APjAAAVmoS4B37OtVhrjKHC1SkOl19ImWSqKcprYKt/vsNbvNVCPikfB
        sItb8K/NqM524bh9AlwQ0eJJ4fUXPleQKPHtYg8HYg==
X-Google-Smtp-Source: APXvYqykN4+m5WXUSM4zFMnIBcKZYKnhYd6qncA/WfRn46TLyXFJJS9intk2UdEtNliqSlcHcCQDbSc5YcfHwNoBvVw=
X-Received: by 2002:a05:6102:22d6:: with SMTP id a22mr12171355vsh.191.1582069135123;
 Tue, 18 Feb 2020 15:38:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581478568.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1581478568.git.baolin.wang7@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Feb 2020 00:38:19 +0100
Message-ID: <CAPDyKFppDWKqCKPcLGC-0daihDZmv=1jBagTMV=4zSGGnoX12A@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] Add MMC software queue support
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 12 Feb 2020 at 05:14, Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Hi All,
>
> Now the MMC read/write stack will always wait for previous request is
> completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> or queue a work to complete request, that will bring context switching
> overhead, especially for high I/O per second rates, to affect the IO
> performance.
>
> Thus this patch set will introduce the MMC software command queue support
> based on command queue engine's interfaces, and set the queue depth as 64
> to allow more requests can be be prepared, merged and inserted into IO
> scheduler, but we only allow 2 requests in flight, that is enough to let
> the irq handler always trigger the next request without a context switch,
> as well as avoiding a long latency.
>
> Moreover we can expand the MMC software queue interface to support
> MMC packed request or packed command instead of adding new interfaces,
> according to previosus discussion.
>
> Below are some comparison data with fio tool. The fio command I used
> is like below with changing the '--rw' parameter and enabling the direct
> IO flag to measure the actual hardware transfer speed in 4K block size.
>
> ./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=1G --group_reporting --numjobs=20 --name=test_read
>
> My eMMC card working at HS400 Enhanced strobe mode:
> [    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> [    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
> [    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
> [    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
> [    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)
>
> 1. Without MMC software queue
> I tested 5 times for each case and output a average speed.
>
> 1) Sequential read:
> Speed: 59.4MiB/s, 63.4MiB/s, 57.5MiB/s, 57.2MiB/s, 60.8MiB/s
> Average speed: 59.66MiB/s
>
> 2) Random read:
> Speed: 26.9MiB/s, 26.9MiB/s, 27.1MiB/s, 27.1MiB/s, 27.2MiB/s
> Average speed: 27.04MiB/s
>
> 3) Sequential write:
> Speed: 71.6MiB/s, 72.5MiB/s, 72.2MiB/s, 64.6MiB/s, 67.5MiB/s
> Average speed: 69.68MiB/s
>
> 4) Random write:
> Speed: 36.3MiB/s, 35.4MiB/s, 38.6MiB/s, 34MiB/s, 35.5MiB/s
> Average speed: 35.96MiB/s
>
> 2. With MMC software queue
> I tested 5 times for each case and output a average speed.
>
> 1) Sequential read:
> Speed: 59.2MiB/s, 60.4MiB/s, 63.6MiB/s, 60.3MiB/s, 59.9MiB/s
> Average speed: 60.68MiB/s
>
> 2) Random read:
> Speed: 31.3MiB/s, 31.4MiB/s, 31.5MiB/s, 31.3MiB/s, 31.3MiB/s
> Average speed: 31.36MiB/s
>
> 3) Sequential write:
> Speed: 71MiB/s, 71.8MiB/s, 72.3MiB/s, 72.2MiB/s, 71MiB/s
> Average speed: 71.66MiB/s
>
> 4) Random write:
> Speed: 68.9MiB/s, 68.7MiB/s, 68.8MiB/s, 68.6MiB/s, 68.8MiB/s
> Average speed: 68.76MiB/s
>
> Form above data, we can see the MMC software queue can help to improve some
> performance obviously for random read and write, though no obvious improvement
> for sequential read and write.
>
> Any comments are welcome. Thanks a lot.
>
> Changes from v8:
>  - Add more description in the commit message.
>  - Optimize the failure log when calling cqe_enable().
>
> Changes from v7:
>  - Add reviewed tag from Arnd.
>  - Use the 'hsq' acronym for varibles and functions in the core layer.
>  - Check the 'card->ext_csd.cmdq_en' in cqhci.c to make sure the CQE
>  can work normally.
>  - Add a new patch to enable the host software queue for the SD card.
>  - Use the default MMC queue depth for host software queue.
>
> Changes from v6:
>  - Change the patch order and set host->always_defer_done = true for the
>  Spreadtrum host driver.
>
> Changes from v5:
>  - Modify the condition of defering to complete request suggested by Adrian.
>
> Changes from v4:
>  - Add a seperate patch to introduce a variable to defer to complete
>  data requests for some host drivers, when using host software queue.
>
> Changes from v3:
>  - Use host software queue instead of sqhci.
>  - Fix random config building issue.
>  - Change queue depth to 32, but still only allow 2 requests in flight.
>  - Update the testing data.
>
> Changes from v2:
>  - Remove reference to 'struct cqhci_host' and 'struct cqhci_slot',
>  instead adding 'struct sqhci_host', which is only used by software queue.
>
> Changes from v1:
>  - Add request_done ops for sdhci_ops.
>  - Replace virtual command queue with software queue for functions and
>  variables.
>  - Rename the software queue file and add sqhci.h header file.
>
> Baolin Wang (5):
>   mmc: Add MMC host software queue support
>   mmc: core: Enable the MMC host software queue for the SD card
>   mmc: host: sdhci: Add request_done ops for struct sdhci_ops
>   mmc: host: sdhci: Add a variable to defer to complete requests if
>     needed
>   mmc: host: sdhci-sprd: Add software queue support
>
>  drivers/mmc/core/block.c      |   61 ++++++++
>  drivers/mmc/core/mmc.c        |   18 ++-
>  drivers/mmc/core/queue.c      |   22 ++-
>  drivers/mmc/core/sd.c         |   10 ++
>  drivers/mmc/host/Kconfig      |    8 +
>  drivers/mmc/host/Makefile     |    1 +
>  drivers/mmc/host/cqhci.c      |    8 +-
>  drivers/mmc/host/mmc_hsq.c    |  343 +++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/mmc_hsq.h    |   30 ++++
>  drivers/mmc/host/sdhci-sprd.c |   28 ++++
>  drivers/mmc/host/sdhci.c      |   14 +-
>  drivers/mmc/host/sdhci.h      |    3 +
>  include/linux/mmc/host.h      |    3 +
>  13 files changed, 534 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/mmc/host/mmc_hsq.c
>  create mode 100644 drivers/mmc/host/mmc_hsq.h
>
> --
> 1.7.9.5
>

Applied for next, thanks! Also, thanks for your patience while moving
forward during the reviews!

Note, I did some amending of patch1 to resolve some checkpatch
warnings. SPDX licence and Kconfig help texts, please have a look and
tell if there are something that doesn't look good.

Kind regards
Uffe
