Return-Path: <SRS0=tKpl=5S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4195DC43331
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 10:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AA62077D
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 10:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbgDBKKt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:10:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:63197 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgDBKKt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Apr 2020 06:10:49 -0400
IronPort-SDR: itD9wn6NT9hQTs06qiPP5xWpqwNStMIhZ2ulF/mt1UjyFqqI+UAw3t4fKFH43dy1OzUlVOhkXV
 D2Ac5qwFqFqg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 03:10:49 -0700
IronPort-SDR: njxA74UT8UgCTr4f31WYvi5VZ8n3XwFBOeGjrjpoMPE0vVi9/PUO6Oa+Zpjxqi6qZ9pVEIc+un
 fVuUyfb2/ITQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,335,1580803200"; 
   d="scan'208";a="240782454"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga007.fm.intel.com with ESMTP; 02 Apr 2020 03:10:46 -0700
Subject: Re: [PATCH v2 3/4] mmc: sdhci-of-arasan: Modify clock operations
 handling
To:     Manish Narani <manish.narani@xilinx.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
References: <1585546879-91037-1-git-send-email-manish.narani@xilinx.com>
 <1585546879-91037-4-git-send-email-manish.narani@xilinx.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <34dffb3a-aa90-db27-7465-df840d148658@intel.com>
Date:   Thu, 2 Apr 2020 13:10:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1585546879-91037-4-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/03/20 8:41 am, Manish Narani wrote:
> The SDHCI clock operations are platform specific. So it better to define
> them separately for particular platform. This will prevent multiple
> if..else conditions and will make it easy for user to add their own
> clock operations handlers.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 208 +++++++++++++++++------------
>  1 file changed, 119 insertions(+), 89 deletions(-)

Would you mind splitting this into a patch that moves the existing
structures first, and then a second patch to make the changes.

Also, I notice there is 'struct sdhci_arasan_data' but also
'struct sdhci_arasan_of_data sdhci_arasan_data'.  This is confusing, so
perhaps a preparatory patch that renames the latter from sdhci_arasan_data
to somethine else e.g. sdhci_arasan_generic_data
