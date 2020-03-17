Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AAAC10F29
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 13:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B84920757
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 13:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgCQNZr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:25:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:19749 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgCQNZr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Mar 2020 09:25:47 -0400
IronPort-SDR: ue1rbw7J6dlN0MKVJ8tC/i7b9daFjn9iMkxUOg/PBvySRYZYs7IrAThp9/R8i/19DX+M7ohNkM
 r9n1XTudgvow==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 06:25:46 -0700
IronPort-SDR: L28m/kiwhYUy/mfnSa8h9loV0UoWrxrfnkyDYHyqd3wPWXkLjk7UEfYgIBStmQe/HZfHyQJlK7
 T0gq/Gov4yQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="244476497"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2020 06:25:44 -0700
Subject: Re: [PATCH v2 0/3] Introduce the request_atomic() for the host
To:     Baolin Wang <baolin.wang7@gmail.com>, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1584428736.git.baolin.wang7@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <7866e519-80ad-8678-6708-7726a53ea4f5@intel.com>
Date:   Tue, 17 Mar 2020 15:25:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cover.1584428736.git.baolin.wang7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/03/20 12:14 pm, Baolin Wang wrote:
> This patch set introduces a new request_atomic() interface for the
> MMC host controller, which is used to submit a request to host in
> the atomic context, such as in the irq hard handler, to reduce the
> request latency.
> 
> Any comments are welcome. Thanks.
> 
> Note: Adrian pointed out that it is not good if moving the polling of
> inhibit bits in sdhci_send_command() into the interrupt context, but
> now I have not found a better way to address Adrian's concern. Moveover
> this is an unusual abnormal case and the original code has the same
> problem, so I plan to create another patch set to talk about and fix
> this issue.

I tend to think the API requires the possibility for host controllers to
return "busy", so that should be sorted out first.

> 
> Changes from v1:
>  - Re-split the changes to make them more clear suggested by Ulf.
>  - Factor out the auto CMD23 checking into a separate function.
> 
> Baolin Wang (3):
>   mmc: host: Introduce the request_atomic() for the host
>   mmc: host: sdhci: Implement the request_atomic() API
>   mmc: host: sdhci-sprd: Implement the request_atomic() API
> 
>  drivers/mmc/host/mmc_hsq.c    |  5 ++++-
>  drivers/mmc/host/sdhci-sprd.c | 23 ++++++++++++++++++++---
>  drivers/mmc/host/sdhci.c      | 27 +++++++++++++++++++--------
>  drivers/mmc/host/sdhci.h      |  1 +
>  include/linux/mmc/host.h      |  3 +++
>  5 files changed, 47 insertions(+), 12 deletions(-)
> 

