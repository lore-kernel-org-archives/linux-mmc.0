Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F28C33CA1
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 08:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52BA24656
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 08:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgATI1O (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:27:14 -0500
Received: from mga17.intel.com ([192.55.52.151]:57862 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgATI1O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Jan 2020 03:27:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 00:27:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,341,1574150400"; 
   d="scan'208";a="274952626"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jan 2020 00:27:09 -0800
Subject: Re: [PATCH 0/6] mmc: sdhci-brcmstb: Driver updates
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Takao Orito <orito.takao@socionext.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
References: <20200113210706.11972-1-alcooperx@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8f0734fd-8ffb-75af-7e70-55453cd01923@intel.com>
Date:   Mon, 20 Jan 2020 10:26:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200113210706.11972-1-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/01/20 11:07 pm, Al Cooper wrote:
> The latest BRCMSTB SoC's now use a new Arasan controller along
> with a custom Broadcom PHY that supports HS200, HS400, SDR104,
> HS400E-ES and CQE. This series of commits adds support for these
> new features along with a few bug fixes. The 7216 is the first
> SoC to have this new hardware.
> 
> Al Cooper (6):
>   dt-bindings: mmc: brcm,sdhci-brcmstb: Add support for 7216b0
>   mmc: sdhci-brcmstb: Add ability to use HS400ES transfer mode
>   mmc: sdhci-brcmstb: Fix driver to defer on clk_get defer
>   mmc: sdhci-brcmstb: Add shutdown callback
>   mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)
>   mmc: sdhci-brcmstb: Fix incorrect switch to HS mode

For patches 2-5

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
>  .../bindings/mmc/brcm,sdhci-brcmstb.txt       |  41 ++-
>  drivers/mmc/host/Kconfig                      |   1 +
>  drivers/mmc/host/sdhci-brcmstb.c              | 270 +++++++++++++++++-
>  3 files changed, 284 insertions(+), 28 deletions(-)
> 

