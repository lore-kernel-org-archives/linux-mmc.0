From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [PATCH 3/3] mmc: sdhci-s3c: Add clk_(enable/disable) in runtime suspend/resume
Date: Wed, 19 Sep 2012 19:42:56 +0530
Message-ID: <CANuQgHEv58-s9UN92QVD=7oF4RoaEsLNYPtcYcF85Khqf-tXAA@mail.gmail.com>
References: <1347613731-29428-1-git-send-email-chander.kashyap@linaro.org>
	<1347613731-29428-4-git-send-email-chander.kashyap@linaro.org>
	<m3fw6eilnk.fsf@pullcord.laptop.org>
	<505977BF.1010305@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52365 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab2ISOM4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Sep 2012 10:12:56 -0400
Received: by pbbrr13 with SMTP id rr13so2552864pbb.19
        for <linux-mmc@vger.kernel.org>; Wed, 19 Sep 2012 07:12:56 -0700 (PDT)
In-Reply-To: <505977BF.1010305@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, ben@simtec.co.uk, broonie@opensource.wolfsonmicro.com, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, patches@linaro.org

Hi Chris,

On 19 September 2012 13:13, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Looks good to me.
>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>
> On 09/19/2012 03:14 PM, Chris Ball wrote:
>> Hi Jaehoon, Girish,
>>
>> On Fri, Sep 14 2012, Chander Kashyap wrote:
>>> Perform clock disable/enable in runtime suspend/resume.
>>>
>>> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
>>> ---
>>>  drivers/mmc/host/sdhci-s3c.c |   25 +++++++++++++++++++++++--
>>>  1 file changed, 23 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
>>> index 3f4518d..ffffd51 100644
>>> --- a/drivers/mmc/host/sdhci-s3c.c
>>> +++ b/drivers/mmc/host/sdhci-s3c.c
>>> @@ -513,7 +513,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>>              goto err_no_busclks;
>>>      }
>>>
>>> +#ifndef CONFIG_PM_RUNTIME
>>>      clk_enable(sc->clk_bus[sc->cur_clk]);
>>> +#endif
>>>
>>>      res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>      host->ioaddr = devm_request_and_ioremap(&pdev->dev, res);
>>> @@ -620,10 +622,13 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>>          gpio_is_valid(pdata->ext_cd_gpio))
>>>              sdhci_s3c_setup_card_detect_gpio(sc);
>>>
>>> +    clk_disable(sc->clk_io);
This should be in #ifndef CONFIG_PM_RUNTIME check
>>>      return 0;
>>>
>>>   err_req_regs:
>>> +#ifndef CONFIG_PM_RUNTIME
>>>      clk_disable(sc->clk_bus[sc->cur_clk]);
>>> +#endif
>>>      for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
>>>              if (sc->clk_bus[ptr]) {
>>>                      clk_put(sc->clk_bus[ptr]);
>>> @@ -656,12 +661,15 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>>>      if (gpio_is_valid(sc->ext_cd_gpio))
>>>              gpio_free(sc->ext_cd_gpio);
>>>
>>> +    clk_enable(sc->clk_io);
This should be in #ifndef CONFIG_PM_RUNTIME check
>>>      sdhci_remove_host(host, 1);
>>>
>>>      pm_runtime_dont_use_autosuspend(&pdev->dev);
>>>      pm_runtime_disable(&pdev->dev);
>>>
>>> +#ifndef CONFIG_PM_RUNTIME
>>>      clk_disable(sc->clk_bus[sc->cur_clk]);
>>> +#endif
>>>      for (ptr = 0; ptr < 3; ptr++) {
>>>              if (sc->clk_bus[ptr]) {
>>>                      clk_put(sc->clk_bus[ptr]);
>>> @@ -696,15 +704,28 @@ static int sdhci_s3c_resume(struct device *dev)
>>>  static int sdhci_s3c_runtime_suspend(struct device *dev)
>>>  {
>>>      struct sdhci_host *host = dev_get_drvdata(dev);
>>> +    struct sdhci_s3c *ourhost = to_s3c(host);
>>> +    struct clk *busclk = ourhost->clk_io;
>>> +    int ret;
>>> +
>>> +    ret = sdhci_runtime_suspend_host(host);
>>>
>>> -    return sdhci_runtime_suspend_host(host);
>>> +    clk_disable(ourhost->clk_bus[ourhost->cur_clk]);
>>> +    clk_disable(busclk);
>>> +    return ret;
>>>  }
>>>
>>>  static int sdhci_s3c_runtime_resume(struct device *dev)
>>>  {
>>>      struct sdhci_host *host = dev_get_drvdata(dev);
>>> +    struct sdhci_s3c *ourhost = to_s3c(host);
>>> +    struct clk *busclk = ourhost->clk_io;
>>> +    int ret;
>>>
>>> -    return sdhci_runtime_resume_host(host);
>>> +    clk_enable(busclk);
>>> +    clk_enable(ourhost->clk_bus[ourhost->cur_clk]);
>>> +    ret = sdhci_runtime_resume_host(host);
>>> +    return ret;
>>>  }
>>>  #endif
>>
>> Could I get an ACK on this patch from one of you, please?
>>
>> - Chris.
>>
>
I will resend this patch after fixing the issue.


-- 
with warm regards,
Chander Kashyap
