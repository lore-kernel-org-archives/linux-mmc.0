From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 2/7] mmc: sdhci-pxav3: Fix Armada 38x controller's caps
 according to erratum ERR-7878951
Date: Wed, 21 Jan 2015 15:58:58 +0100
Message-ID: <54BFBEB2.4070801@free-electrons.com>
References: <1421832726-21656-1-git-send-email-gregory.clement@free-electrons.com>	<1421832726-21656-3-git-send-email-gregory.clement@free-electrons.com> <CAPv3WKeCPRoZCMP+PJoUqi_Nq85s+-5YwWm5EovDio1OQ-d3zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAPv3WKeCPRoZCMP+PJoUqi_Nq85s+-5YwWm5EovDio1OQ-d3zA@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, stable@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Marcin,

On 21/01/2015 15:52, Marcin Wojtas wrote:
> Hi Gregory,
> 
> 2015-01-21 10:32 GMT+01:00 Gregory CLEMENT <gregory.clement@free-electrons.com>:
>> According to erratum 'ERR-7878951' Armada 38x SDHCI controller has
>> different capabilities than the ones shown in its registers:
>>
>> - it doesn't support the voltage switching: it can work either with
>>   3.3V or 1.8V supply
>> - it doesn't support the SDR104 mode
>> - SDR50 mode doesn't need tuning
>>
>> The SDHCI_QUIRK_MISSING_CAPS quirk is used for updating the
>> capabilities accordingly.
>>
>> Fixes: 5491ce3f79ee ("mmc: sdhci-pxav3: add support for the Armada 38x SDHCI controller")
>> Cc: <stable@vger.kernel.org> # v3.15+
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  drivers/mmc/host/sdhci-pxav3.c | 21 +++++++++++++++++++--
>>  1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
>> index 7b07325b4fba..4daa47a53a62 100644
>> --- a/drivers/mmc/host/sdhci-pxav3.c
>> +++ b/drivers/mmc/host/sdhci-pxav3.c
>> @@ -118,8 +118,11 @@ static int mv_conf_mbus_windows(struct platform_device *pdev,
>>         return 0;
>>  }
>>
>> -static int armada_38x_quirks(struct sdhci_host *host)
>> +static int armada_38x_quirks(struct platform_device *pdev,
>> +                            struct sdhci_host *host)
>>  {
>> +       struct device_node *np = pdev->dev.of_node;
>> +
>>         host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
>>         /*
>>          * According to erratum 'FE-2946959' both SDR50 and DDR50
>> @@ -129,6 +132,20 @@ static int armada_38x_quirks(struct sdhci_host *host)
>>          */
>>         host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>>         host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
>> +
>> +       /*
>> +        * According to erratum 'ERR-7878951' Armada 38x SDHCI
>> +        * controller has different capabilities than the ones shown
>> +        * in its registers
>> +        */
>> +       host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>> +       if (of_get_property(np, "no-1-8-v", NULL)) {
>> +               host->caps &= ~SDHCI_CAN_VDD_180;
>> +               host->mmc->caps &= ~MMC_CAP_1_8V_DDR;
>> +       } else
>> +               host->caps &= ~SDHCI_CAN_VDD_330;
>> +       host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_USE_SDR50_TUNING);
>> +
>>         return 0;
>>  }
>>
>> @@ -333,7 +350,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>>                 clk_prepare_enable(pxa->clk_core);
>>
>>         if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
>> -               ret = armada_38x_quirks(host);
>> +               ret = armada_38x_quirks(pdev, host);
>>                 if (ret < 0)
>>                         goto err_quirks;
>>                 ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
>> --
> 
> Right here there are lines:
> /* enable 1/8V DDR capable */
> host->mmc->caps |= MMC_CAP_1_8V_DDR;
> 
> Which make a possible opposite change from armada_38x_quirks cacelled.

Good catch!

I will remove it in the v2.

Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
