From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH 4/6 v2] mmc: sdhci-spear: Handle return value of
 platform_get_irq
Date: Mon, 20 Nov 2017 12:15:35 +0530
Message-ID: <477653f9-5263-678a-fa26-498d744a8639@gmail.com>
References: <130df0c2c60ed6a0f460b68c586cc0a4167aed0b.1510997223.git.arvind.yadav.cs@gmail.com>
 <d8fc48bacf7cc153d806e10bc39ab507534f4691.1510997223.git.arvind.yadav.cs@gmail.com>
 <20171120054415.GC6125@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:38770 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdKTGpm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Nov 2017 01:45:42 -0500
In-Reply-To: <20171120054415.GC6125@vireshk-i7>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: ben-linux@fluff.org, ulf.hansson@linaro.org, adrian.hunter@intel.com, vireshk@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org, linux@armlinux.org.uk, carlo@caione.org, khilman@baylibre.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org

Hi viresh,

Could you please acknowledge a latest version(v3) of this patch.

Thanks,


On Monday 20 November 2017 11:14 AM, Viresh Kumar wrote:
> On 18-11-17, 15:03, Arvind Yadav wrote:
>> platform_get_irq() can fail here and we must check its return value.
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>> changes in v2 :
>>                Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
>>
>>   drivers/mmc/host/sdhci-spear.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
>> index 8c0f884..900838b 100644
>> --- a/drivers/mmc/host/sdhci-spear.c
>> +++ b/drivers/mmc/host/sdhci-spear.c
>> @@ -82,6 +82,10 @@ static int sdhci_probe(struct platform_device *pdev)
>>   	host->hw_name = "sdhci";
>>   	host->ops = &sdhci_pltfm_ops;
>>   	host->irq = platform_get_irq(pdev, 0);
>> +	if (host->irq <= 0) {
>> +		ret = host->irq;
>> +		goto err_host;
>> +	}
>>   	host->quirks = SDHCI_QUIRK_BROKEN_ADMA;
>>   
>>   	sdhci = sdhci_priv(host);
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>

