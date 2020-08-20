Return-Path: <SRS0=808J=B6=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6F6C433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Aug 2020 07:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A8F9206DA
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Aug 2020 07:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tYRgP1lx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgHTHHD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:07:03 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47984 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgHTHHB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Aug 2020 03:07:01 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07K76xpd071021;
        Thu, 20 Aug 2020 02:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597907219;
        bh=tO+VmcwGzpBAIWcmRdVeBCzVCyQm0H4wa4UHvBG9D+Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tYRgP1lxTqSSsoBQmaZaLB3lby6SAxbEVI5POeoZVoBmdVfpDna5PbzzEhnRlW3c0
         n//ew1gyeK57A4vXjFfDGTsRq7UADufcjWA7tFOpiivfLwkQbt/+IjOGpQkjSLi/cd
         F23FF+zI7CxGA3+MdZt3Xnd7TxBbHAVUO0r+Py74=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07K76xSV114742
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Aug 2020 02:06:59 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 20
 Aug 2020 02:06:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 20 Aug 2020 02:06:59 -0500
Received: from [10.250.232.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07K76tC2095200;
        Thu, 20 Aug 2020 02:06:56 -0500
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-am654: Document bindings for the
 host controllers on TI's J7200 devices
To:     Rob Herring <robh@kernel.org>
CC:     <ulf.hansson@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
References: <20200802070114.9624-1-faiz_abbas@ti.com>
 <20200817211727.GA1578682@bogus>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <30d40498-847b-add7-d209-020d2ae00805@ti.com>
Date:   Thu, 20 Aug 2020 12:36:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817211727.GA1578682@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On 18/08/20 2:47 am, Rob Herring wrote:
> On Sun, 02 Aug 2020 12:31:14 +0530, Faiz Abbas wrote:
>> Add binding documentation for mmc host controllers present on
>> TI's J7200 SOC
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/sdhci-am654.txt | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

Can you pick this up now or should I rebase to latest?

Thanks,
Faiz
