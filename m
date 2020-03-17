Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A51C10F29
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 08:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2394206EC
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 08:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgCQISG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:18:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:17694 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQISG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Mar 2020 04:18:06 -0400
IronPort-SDR: 7WlmVo2EjHtlr7/gehbOxTqHUTwcd8LEWZlkhPeZHY8xr7xM337aFXtadJgzID3jn+Q0s9HYt5
 yzeKLEYiWlIQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 01:18:05 -0700
IronPort-SDR: 8EI90Sa/Fl8A8OtrjnDeo/65QBPfPQaXLft94/WT65VrNZbsN3ntTX8TazKrkktJRaag3j25Ex
 B+G400bZ+sBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; 
   d="scan'208";a="443671941"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga005.fm.intel.com with ESMTP; 17 Mar 2020 01:18:04 -0700
Subject: Re: [RFC PATCH v2 3/6] mmc: host: Add UHS-II support in host layer
To:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw
References: <cover.1578560282.git.benchuanggli@gmail.com>
 <9f861920380df9d7a6d52c905fc47643eb25f33f.1578560282.git.benchuanggli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <add27a04-e018-d050-4d42-4fb5c532df8c@intel.com>
Date:   Tue, 17 Mar 2020 10:17:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9f861920380df9d7a6d52c905fc47643eb25f33f.1578560282.git.benchuanggli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 9/01/20 11:14 am, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> Add UHS-II support in host layer

Split host layer changes from sdhci changes.

> 
> Reported-by: kbuild test robot <lkp@intel.com>

Drop "Reported-by: kbuild test robot <lkp@intel.com>"

> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/Makefile                  |   1 +
>  drivers/mmc/host/{sdhci.c => sdhci-core.c} | 276 ++++++--
>  drivers/mmc/host/sdhci-milbeaut.c          |   4 +-
>  drivers/mmc/host/sdhci-of-arasan.c         |   4 +-
>  drivers/mmc/host/sdhci-of-at91.c           |   4 +-
>  drivers/mmc/host/sdhci-omap.c              |   2 +-
>  drivers/mmc/host/sdhci-pci-core.c          |   4 +-
>  drivers/mmc/host/sdhci-pxav3.c             |   4 +-
>  drivers/mmc/host/sdhci-uhs2.c              | 751 +++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h              |  34 +
>  drivers/mmc/host/sdhci-xenon.c             |   4 +-
>  drivers/mmc/host/sdhci.h                   | 284 +++++++-
>  drivers/mmc/host/sdhci_am654.c             |   4 +-
>  include/linux/mmc/uhs2.h                   | 270 ++++++++
>  14 files changed, 1583 insertions(+), 63 deletions(-)
>  rename drivers/mmc/host/{sdhci.c => sdhci-core.c} (94%)
>  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
>  create mode 100644 drivers/mmc/host/sdhci-uhs2.h
>  create mode 100644 include/linux/mmc/uhs2.h

Please make sdhci-uhs2 a module and do not rename sdhci.c.

References in sdhci.c to sdhci-uhs2.c will need to be enclosed by
#if IS_REACHABLE(CONFIG_SDHCI_UHS2)

Move all UHS-II definitions into sdhci-uhs2.h.  Things that are for V4 but
not necessarily UHS-II can be in sdhci.h

Make the set_power parameter change into a separate patch

Fix all spelling mistakes

Make comment style correct.

Review all checkpatch warnings and checks (i.e. --strict option)

If possible provide a link to a tree that contains the patches.

Re-base on Ulf's next branch

The patch set could use an overview of how UHS-II is different from regular SD.

In other patches there are a bunch of memory allocations on the I/O path.
That is a problem.  Memory needed should be allocated in advance.
