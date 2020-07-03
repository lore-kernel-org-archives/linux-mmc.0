Return-Path: <SRS0=EnCU=AO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E44C433DF
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Jul 2020 07:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD01A20890
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Jul 2020 07:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qq2T15TP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgGCH1Y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:27:24 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50578 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgGCH1Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jul 2020 03:27:24 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0637R6X8008612;
        Fri, 3 Jul 2020 02:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593761226;
        bh=JAgfQZyZ5OCclljqyFUtrQi+fTILtIzhg4LOfF6ffNg=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=qq2T15TP8855E5+LM7HzRbH6C9+JEVm70rVxuj2SW/sudOvyVS7UL+qdm4YLdl9N6
         ckrL7qObLBsqCSce5xhNyZNi+vTrwNEzo3Xo6vWYMms5ojoX+BJfHSyeMj4f8Ff8Tg
         hd2086CZRwGgXUIcTV4FvgxwaHrFDLJRt8GkY2K0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0637R6if050745
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Jul 2020 02:27:06 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 3 Jul
 2020 02:27:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 3 Jul 2020 02:27:05 -0500
Received: from [10.250.232.87] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0637R1SF002523;
        Fri, 3 Jul 2020 02:27:02 -0500
Subject: Re: [PATCH 0/7] Add support for SD card in AM654x-evm
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <adrian.hunter@intel.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>
References: <20200619125801.9530-1-faiz_abbas@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <10f765e4-d9ac-324d-623f-83720c997042@ti.com>
Date:   Fri, 3 Jul 2020 12:57:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619125801.9530-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 19/06/20 6:27 pm, Faiz Abbas wrote:
> The following patches add driver support for SD card on the
> am654x-evm. It only enables high speed mode with UHS mode
> support coming in a future series.
> 
> DTS support will be added in another series as well.
> 
> Faiz Abbas (7):
>   dt-bindings: mmc: sdhci-am654: Add ti,clkbuf-sel binding
>   mmc: sdhci_am654: Add flag for PHY calibration
>   mmc: sdhci_am654: Add Support for SR2.0
>   mmc: sdhci_am654: Fix conditions for enabling dll
>   mmc: sdhci_am654: Update delay chain configuration
>   mmc: sdhci_am654: Add support for clkbuf_sel property
>   arm64: defconfig: Enable AM654x SDHCI controller
> 
>  .../devicetree/bindings/mmc/sdhci-am654.txt   |  1 +
>  arch/arm64/configs/defconfig                  |  1 +
>  drivers/mmc/host/sdhci_am654.c                | 86 ++++++++++++++-----
>  3 files changed, 65 insertions(+), 23 deletions(-)
> 

Gentle ping.

Thanks,
Faiz
