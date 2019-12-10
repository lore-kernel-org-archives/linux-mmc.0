Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D994C2D0CA
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 09:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531D720836
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 09:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cy5BJsHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfLJJgQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:36:16 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45254 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfLJJgP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 04:36:15 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBA9aCG4130984;
        Tue, 10 Dec 2019 03:36:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575970572;
        bh=WGtf1IKDe8ENBK+5xcPhUCNaggU+OnMoFiPYYV9HOwg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cy5BJsHXeyVzi7MYSE4OakI/GqWb15wr0Ov94TLB8vvbrvqe/ox0y75fFCIA1WEB6
         HY6itZpz6VA7moWHJvTNC6P0D0Vhx6JGtn55Nj81PdJAZnpuuhXsRK5mWvJTXg2g2R
         OQgxsTPZPFbYPId+LeHCUqFxh1TTH40CG6jw2ENc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBA9aCAi124687
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Dec 2019 03:36:12 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Dec 2019 03:36:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Dec 2019 03:36:11 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBA9a9qj023647;
        Tue, 10 Dec 2019 03:36:10 -0600
Subject: Re: [PATCH] mmc: sdhci: Update the tuning failed messages to pr_debug
 level
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>
References: <20191206114326.15856-1-faiz_abbas@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <9199c781-399b-8b7e-8454-6d67f41f48bb@ti.com>
Date:   Tue, 10 Dec 2019 15:07:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191206114326.15856-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 06/12/19 5:13 pm, Faiz Abbas wrote:
> Tuning support in DDR50 speed mode was added in SD Specifications Part1
> Physical Layer Specification v3.01. Its not possible to distinguish
> between v3.00 and v3.01 from the SCR and that is why since
> commit 4324f6de6d2e ("mmc: core: enable CMD19 tuning for DDR50 mode")
> tuning failures are ignored in DDR50 speed mode.
> 
> Cards compatible with v3.00 don't respond to CMD19 in DDR50 and this
> error gets printed during enumeration and also if retune is triggered at
> any time during operation. Update the printk level to pr_debug so that
> these errors don't lead to false error reports.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 296d955ede59..42a9c8179da7 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2417,8 +2417,8 @@ static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>  		sdhci_send_tuning(host, opcode);
>  
>  		if (!host->tuning_done) {
> -			pr_info("%s: Tuning timeout, falling back to fixed sampling clock\n",
> -				mmc_hostname(host->mmc));
> +			pr_debug("%s: Tuning timeout, falling back to fixed sampling clock\n",
> +				 mmc_hostname(host->mmc));
>  			sdhci_abort_tuning(host, opcode);
>  			return -ETIMEDOUT;
>  		}
> 

Gentle ping.

Thanks,
Faiz
