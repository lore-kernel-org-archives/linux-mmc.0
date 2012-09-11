From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-pxav3: dt: Support "cd-gpios" property
Date: Tue, 11 Sep 2012 11:04:58 -0400
Message-ID: <878vcgy50l.fsf@octavius.laptop.org>
References: <87k3w3zycf.fsf@octavius.laptop.org>
	<CAN1soZzUZ6HiZFQ1JL-F3wU=f27dakz1HkzFRStbNP+YQ2PgWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60833 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752889Ab2IKPFE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 11 Sep 2012 11:05:04 -0400
In-Reply-To: <CAN1soZzUZ6HiZFQ1JL-F3wU=f27dakz1HkzFRStbNP+YQ2PgWw@mail.gmail.com>
	(Haojian Zhuang's message of "Tue, 11 Sep 2012 22:36:50 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Hi,

On Tue, Sep 11 2012, Haojian Zhuang wrote:
> On Sun, Sep 9, 2012 at 11:09 AM, Chris Ball <cjb@laptop.org> wrote:
>> Tested on OLPC XO-4/MMP3, where the card detection pin for one of the
>> controllers is a sideband GPIO.  The third cell in the power-gpios
>> property controls whether the GPIO is active high/active low.
>>
>> Signed-off-by: Chris Ball <cjb@laptop.org>
>> ---
>>  drivers/mmc/host/sdhci-pxav3.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
>> index 0bdb326..5427d52 100644
>> --- a/drivers/mmc/host/sdhci-pxav3.c
>> +++ b/drivers/mmc/host/sdhci-pxav3.c
>> @@ -211,6 +211,10 @@ static struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev)
>>         if (gpio_flags != OF_GPIO_ACTIVE_LOW)
>>                 pdata->host_caps2 |= MMC_CAP2_PWR_ACTIVE_HIGH;
>>
>> +       pdata->ext_cd_gpio = of_get_named_gpio_flags(np, "cd-gpios", 0, &gpio_flags);
>> +       if (gpio_flags != OF_GPIO_ACTIVE_LOW)
>> +               pdata->host_caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
>> +
>>         return pdata;
>>  }
>>  #else
>> @@ -292,6 +296,15 @@ static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
>>                                 goto err_power_req;
>>                         }
>>                 }
>> +
>> +               if (gpio_is_valid(pdata->ext_cd_gpio)) {
>> +                       ret = mmc_gpio_request_cd(host->mmc, pdata->ext_cd_gpio);
>> +                       if (ret) {
>> +                               dev_err(mmc_dev(host->mmc),
>> +                                       "failed to allocate card detect gpio\n");
>> +                               goto err_cd_req;
>> +                       }
>> +               }
>>         }
>>
>>         host->ops = &pxav3_sdhci_ops;
>> @@ -309,6 +322,8 @@ static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
>>  err_add_host:
>>         clk_disable_unprepare(clk);
>>         clk_put(clk);
>> +       mmc_gpio_free_cd(host->mmc);
>> +err_cd_req:
>>         mmc_gpio_free_pwr(host->mmc);
>>  err_power_req:
>>  err_clk_get:
>> @@ -331,6 +346,8 @@ static int __devexit sdhci_pxav3_remove(struct platform_device *pdev)
>>
>>         if (gpio_is_valid(pdata->power_gpio))
>>                 mmc_gpio_free_pwr(host->mmc);
>> +       if (gpio_is_valid(pdata->ext_cd_gpio))
>> +               mmc_gpio_free_cd(host->mmc);
>>
>>         sdhci_pltfm_free(pdev);
>>         kfree(pxa);
>> --
>> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
>> One Laptop Per Child
>
> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Thanks, pushed to mmc-next for 3.7 after rebasing to make this patch
precede the power_gpio patch (which isn't ready to merge).

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
