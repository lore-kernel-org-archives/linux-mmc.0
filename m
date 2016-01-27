From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH 10/21] mmc: sdhci: remove
 SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date: Wed, 27 Jan 2016 15:20:24 +0800
Message-ID: <56A86FB8.5030006@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
 <1453871283-3724-1-git-send-email-shawn.lin@rock-chips.com>
 <DB3PR04MB055320DCE3EED80B3837D0C190D90@DB3PR04MB0553.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:40166 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbcA0HUu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 02:20:50 -0500
In-Reply-To: <DB3PR04MB055320DCE3EED80B3837D0C190D90@DB3PR04MB0553.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, "linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2016/1/27 15:11, Haibo Chen wrote:
>
>
> Hi Shawn,
>
>

[...]

>> @@ -1618,7 +1618,8 @@ static int sdhci_do_get_cd(struct sdhci_host *=
host)
>>   		return 0;
>>
>>   	/* If nonremovable, assume that the card is always present. */
>> -	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
>> +	if (host->mmc->caps & MMC_CAP_NONREMOVABLE ||
>> +	    host->mmc->caps & MMC_CAP_NEEDS_POLL)
>>   		return 1;
>>
>>   	/*
>> @@ -1628,10 +1629,6 @@ static int sdhci_do_get_cd(struct sdhci_host =
*host)
>>   	if (!IS_ERR_VALUE(gpio_cd))
>>   		return !!gpio_cd;
>>
>> -	/* If polling, assume that the card is always present. */
>> -	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
>> -		return 1;
>
> Why simply  remove these code rather than use this:
> If(host->mmc->caps & MMC_CAP_NEEDS_POLL)
>         Return 1;
>
> According to the comment, if polling, need to return 1,
> But if you just simply remove this code, it will read the sdhci regis=
ter SDHCI_PRESENT_STATE

Hi Haibo

I have combine this check with "host->mmc->caps & MMC_CAP_NONREMOVABLE"=
=20
above. =EF=BC=9A=EF=BC=89

Thanks

>
>
> Best Regards
>
> Haibo Chen
>
>> -
>>   	/* Host native card detect */
>>   	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
>> SDHCI_CARD_PRESENT);  } @@ -2658,7 +2655,7 @@ void
>> sdhci_enable_irq_wakeups(struct sdhci_host *host)
>>   	val =3D sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
>>   	val |=3D mask ;
>>   	/* Avoid fake wake up */
>> -	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
>> +	if (host->mmc->caps & MMC_CAP_NEEDS_POLL)
>>   		val &=3D ~(SDHCI_WAKE_ON_INSERT |
>> SDHCI_WAKE_ON_REMOVE);
>>   	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);  } @@ -3112,8
>> +3109,7 @@ int sdhci_add_host(struct sdhci_host *host)
>>   	if (caps[0] & SDHCI_CAN_DO_HISPD)
>>   		mmc->caps |=3D MMC_CAP_SD_HIGHSPEED |
>> MMC_CAP_MMC_HIGHSPEED;
>>
>> -	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
>> -	    !(mmc->caps & MMC_CAP_NONREMOVABLE) &&
>> +	if (!(mmc->caps & MMC_CAP_NONREMOVABLE) &&
>>   	    IS_ERR_VALUE(mmc_gpio_get_cd(host->mmc)))
>>   		mmc->caps |=3D MMC_CAP_NEEDS_POLL;
>>
>> --
>> 2.3.7
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


--=20
Best Regards
Shawn Lin

