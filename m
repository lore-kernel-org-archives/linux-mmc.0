From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [PATCH-v2 5/7] mmc: sdhci-pxav3: Fix HS200 mode support
Date: Tue, 8 Sep 2015 15:05:51 +0530
Message-ID: <55EEABF7.5010407@linaro.org>
References: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441624721-15612-6-git-send-email-vaibhav.hiremath@linaro.org>
 <20150908145348.6ce640b1@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34093 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbbIHJf5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2015 05:35:57 -0400
Received: by padhy16 with SMTP id hy16so117573037pad.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2015 02:35:56 -0700 (PDT)
In-Reply-To: <20150908145348.6ce640b1@xhacker>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, Tim Wang <wangtt@marvell.com>, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Liu <kliu5@marvell.com>



On Tuesday 08 September 2015 12:23 PM, Jisheng Zhang wrote:
> On Mon, 7 Sep 2015 16:48:39 +0530
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:
>
>> From: Kevin Liu <kliu5@marvell.com>
>>
>> IN case of MMC HS200 mode, current code does not enable
>> SD_CE_ATA_2.MMC_HS200 & SD_CE_ATA_2.MMC_CARD bit configurations.
>>
>> So this patch updates the above bit fields correctly.
>>
>> Signed-off-by: Tim Wang <wangtt@marvell.com>
>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>> Note: Unfortunately I do not have access to any other datasheets
>> which uses sdhci-pxav3 driver, so quite not sure whether this would
>> break any existing platform, probably NOT, as I do not see any
>> references for this change.
>> If anyone can confirm that would be really great.
>>
>>   drivers/mmc/host/sdhci-pxav3.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
>> index d933f75..6978810 100644
>> --- a/drivers/mmc/host/sdhci-pxav3.c
>> +++ b/drivers/mmc/host/sdhci-pxav3.c
>> @@ -57,6 +57,8 @@
>>   #define SD_CE_ATA_1			0x10C
>>
>>   #define SD_CE_ATA_2			0x10E
>> +#define  SD_CE_ATA2_HS200_EN		BIT(10)
>> +#define  SD_CE_ATA2_MMC_MODE		BIT(12)
>>   #define  SDCE_MISC_INT			BIT(2)
>>   #define  SDCE_MISC_INT_EN		BIT(1)
>>
>> @@ -330,6 +332,17 @@ static int pxav3_select_pinstate(struct sdhci_host *host, unsigned int uhs)
>>   	return pinctrl_select_state(pxa->pinctrl, pinctrl);
>>   }
>>
>> +static int pxav3_select_hs200(struct sdhci_host *host)
>
> I didn't see why we need the return value, make it void would be better?
>

Fair enough.
Will fix it in next version.


Thanks,
Vaibhav
