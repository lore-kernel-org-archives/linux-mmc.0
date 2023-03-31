Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A1DC77B6C
	for <linux-mmc@archiver.kernel.org>; Fri, 31 Mar 2023 10:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjCaKiV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 31 Mar 2023 06:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjCaKh7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Mar 2023 06:37:59 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FC11FC1;
        Fri, 31 Mar 2023 03:37:58 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32VAbrpP026304;
        Fri, 31 Mar 2023 05:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680259073;
        bh=WhqNUIRAUX8Fkmfwx7CPznJSo5GTtSHTVG5SXlzXIdg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=LmNjjCQtaXZA5nZfvuENzvcI0Hjl6YpmswSB15nWjhLTHScsLGS3FBXEuLIF+qOhO
         HRYEXIcbTQzPks//vYsZ84o0zArJzUzprrIZ2Ir7FFlcNPCX1ZCf/VSHBnF7BmevL3
         0IHjWrN7jUNCWo1kjQFObvSm37Dw78xCcTmTiTwg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32VAbr0h091783
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Mar 2023 05:37:53 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 31
 Mar 2023 05:37:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 31 Mar 2023 05:37:53 -0500
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32VAbok0102018;
        Fri, 31 Mar 2023 05:37:51 -0500
Message-ID: <98d0bdf7-9b59-321c-8f1c-7823bca62375@ti.com>
Date:   Fri, 31 Mar 2023 16:07:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] mmc: sdhci_am654: Add support for PM suspend/resume
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230331101619.4117312-1-vigneshr@ti.com>
 <20230331101619.4117312-2-vigneshr@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230331101619.4117312-2-vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 31/03/23 15:46, Vignesh Raghavendra wrote:
> From: Aswath Govindraju <a-govindraju@ti.com>
> 
> Add support for suspend/resume and pm_runtime resume/suspend.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
> Since RFC v2:
> Address all comments around sdhci_am654_remove()
> Set autosuspend_delay to -1 as SDHCI will host rootfs via SD/eMMC and
> autosuspend can cause long latency for user interactive applications
> 
> RFC v2:
> https://lore.kernel.org/all/20220408124338.27090-1-a-govindraju@ti.com/

Oops, this is a stale patch. Please ignore this and consider [0] instead
Sorry for the noise

[0] lore.kernel.org/r/20230331101619.4117312-1-vigneshr@ti.com

-- 
Regards
Vignesh
