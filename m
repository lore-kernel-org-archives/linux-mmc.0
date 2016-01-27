From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH 14/21] mmc: sdhci-esdhc-imx: remove
 SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date: Wed, 27 Jan 2016 14:58:06 +0800
Message-ID: <56A86A7E.6090602@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
 <1453871318-3888-1-git-send-email-shawn.lin@rock-chips.com>
 <DB3PR04MB05535012DD334E9A534407D390D90@DB3PR04MB0553.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:48812 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbcA0G6i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 01:58:38 -0500
In-Reply-To: <DB3PR04MB05535012DD334E9A534407D390D90@DB3PR04MB0553.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, "linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dong Aisheng <aisheng.dong@freescale.com>, Haibo Chen <haibo.chen@freescale.com>

On 2016/1/27 14:54, Haibo Chen wrote:
> Hi Shawn,
>
> Comments below.
>

[...]

>>   		return ret;
>>
>>   	if (!IS_ERR_VALUE(mmc_gpio_get_cd(host->mmc)))
>> -		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>> +		host->mmc->caps &= MMC_CAP_NEEDS_POLL;
>
> You miss ' ~', seems you need to change to:
> host->mmc->caps &=~ MMC_CAP_NEEDS_POLL;
>

Thanks for pointing out. I will fix this for the next version.

>>
>>   	return 0;
>>   }
>> @@ -1064,7 +1063,7 @@ static int sdhci_esdhc_imx_probe_nondt(struct
>> platform_device *pdev,
>>
>>   	case ESDHC_CD_CONTROLLER:
>>   		/* we have a working card_detect back */
>> -		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>> +		host->mmc->caps &= MMC_CAP_NEEDS_POLL;
>
> The same issue.
>
>>   		break;
>>
>>   	case ESDHC_CD_PERMANENT:
>> @@ -1104,6 +1103,8 @@ static int sdhci_esdhc_imx_probe(struct
>> platform_device *pdev)
>>   	if (IS_ERR(host))
>>   		return PTR_ERR(host);
>>
>> +	host->mmc->caps |= MMC_CAP_NEEDS_POLL;
>> +
>>   	pltfm_host = sdhci_priv(host);
>>
>>   	imx_data = devm_kzalloc(&pdev->dev, sizeof(*imx_data),
>> GFP_KERNEL);
>> --
>> 2.3.7
>>
>
>
>
>


-- 
Best Regards
Shawn Lin

