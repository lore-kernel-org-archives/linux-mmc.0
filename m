Return-Path: <SRS0=4vPn=2G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BBEC43603
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Dec 2019 08:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB87A206A5
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Dec 2019 08:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PkkVrt+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfLPIlY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:41:24 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54592 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfLPIlY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2019 03:41:24 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBG8fDeg028547;
        Mon, 16 Dec 2019 02:41:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576485673;
        bh=GQ0EO7q8Lqa3xSoXIC84Xc5lNVaeufWJSswA3pvWUWg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PkkVrt+qL5LYRULFUkL/FepG6A+SwwwgV1+hEB3D2vdHT4J0FnY40thn6e3ldQL83
         fL0RiSuSxSfae81A/YqNCD7fhto9Y+DCHgoZ/h4ie8tvj1E7I7n9DwJUnlLNXEJ0v8
         hbWrUrv6+uYtVoE+gw5wDHcJuaK06IysXhoZ6ctw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBG8fDx6008225
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Dec 2019 02:41:13 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Dec 2019 02:41:13 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Dec 2019 02:41:13 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBG8f9Sv078293;
        Mon, 16 Dec 2019 02:41:10 -0600
Subject: Re: [PATCH v3 4/7] mmc: sdhci: Add quirk for disabling DTO during
 erase command
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <kishon@ti.com>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>, <zhang.chunyan@linaro.org>,
        <tony@atomide.com>
References: <20191210095151.15441-1-faiz_abbas@ti.com>
 <20191210095151.15441-5-faiz_abbas@ti.com>
 <003f7e7a-a762-5355-9404-4a6655754fb0@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <09bb8f31-534d-c278-45c3-e0314286819c@ti.com>
Date:   Mon, 16 Dec 2019 14:12:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <003f7e7a-a762-5355-9404-4a6655754fb0@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,


On 13/12/19 3:10 pm, Adrian Hunter wrote:
> On 10/12/19 11:51 am, Faiz Abbas wrote:
>> Some controllers might prematurely issue a data timeout during an erase
>> command. Add a quirk to disable the interrupt when an erase command is
>> issued.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 5 +++++
>>  drivers/mmc/host/sdhci.h | 2 ++
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 6f3d4991bee1..b8934c50b9c4 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1532,6 +1532,11 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>>  	/* Initially, a command has no error */
>>  	cmd->error = 0;
>>  
>> +	if (cmd->opcode == MMC_ERASE &&
>> +	    (host->quirks2 & SDHCI_QUIRK2_DISABLE_DTO_FOR_ERASE)) {
>> +		sdhci_set_data_timeout_irq(host, false);
>> +	}
> 
> If you factor out __sdhci_set_timeout() like below then
> you could implement ->set_timeout() to do this.
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ad6d2f93aa0b..389e3239eadc 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1002,27 +1002,28 @@ static void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable)
>  	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>  }
>  
> -static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
> +void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  {
> -	u8 count;
> -
> -	if (host->ops->set_timeout) {
> -		host->ops->set_timeout(host, cmd);
> -	} else {
> -		bool too_big = false;
> -
> -		count = sdhci_calc_timeout(host, cmd, &too_big);
> +	bool too_big = false;
> +	u8 count = sdhci_calc_timeout(host, cmd, &too_big);
> +
> +	if (too_big && host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) {
> +		sdhci_calc_sw_timeout(host, cmd);
> +		sdhci_set_data_timeout_irq(host, false);
> +	} else if (!(host->ier & SDHCI_INT_DATA_TIMEOUT)) {
> +		sdhci_set_data_timeout_irq(host, true);
> +	}
>  
> -		if (too_big &&
> -		    host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) {
> -			sdhci_calc_sw_timeout(host, cmd);
> -			sdhci_set_data_timeout_irq(host, false);
> -		} else if (!(host->ier & SDHCI_INT_DATA_TIMEOUT)) {
> -			sdhci_set_data_timeout_irq(host, true);
> -		}
> +	sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
> +}
> +EXPORT_SYMBOL_GPL(__sdhci_set_timeout);
>  
> -		sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
> -	}
> +static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +	if (host->ops->set_timeout)
> +		host->ops->set_timeout(host, cmd);
> +	else
> +		__sdhci_set_timeout(host, cmd);
>  }

Ok. I'll add the refactoring as a separate patch.

Thanks,
Faiz
