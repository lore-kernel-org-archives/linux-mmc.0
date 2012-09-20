From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v6 8/9] mmc: dw_mmc: add support for implementation
 specific callbacks
Date: Thu, 20 Sep 2012 10:08:46 +0530
Message-ID: <CAJuYYwRUhK858ixLfZPz9UVmqJBe0=LdgjhLfazPNHE3zckDjQ@mail.gmail.com>
References: <1347905803-22742-1-git-send-email-thomas.abraham@linaro.org>
	<1347905803-22742-9-git-send-email-thomas.abraham@linaro.org>
	<001401cd966c$5fe94590$1fbbd0b0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60941 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab2ITEir (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Sep 2012 00:38:47 -0400
Received: by lbbgj3 with SMTP id gj3so1887269lbb.19
        for <linux-mmc@vger.kernel.org>; Wed, 19 Sep 2012 21:38:46 -0700 (PDT)
In-Reply-To: <001401cd966c$5fe94590$1fbbd0b0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, will.newton@imgtec.com, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, patches@linaro.org

On 19 September 2012 19:10, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Tuesday, September 18, 2012, Thomas Abraham <thomas.abraham@linaro.org> wrote:
>> -int dw_mci_pltfm_register(struct platform_device *pdev)
>> +int dw_mci_pltfm_register(struct platform_device *pdev,
>> +                             struct dw_mci_drv_data *drv_data)
>>  {
>>       struct dw_mci *host;
>>       struct resource *regs;
>> @@ -41,6 +42,7 @@ int dw_mci_pltfm_register(struct platform_device *pdev)
>>       if (host->irq < 0)
>>               return host->irq;
>>
>> +     host->drv_data = drv_data;
>>       host->dev = &pdev->dev;
>>       host->irq_flags = 0;
>>       host->pdata = pdev->dev.platform_data;
>> @@ -48,6 +50,12 @@ int dw_mci_pltfm_register(struct platform_device *pdev)
>>       if (!host->regs)
>>               return -ENOMEM;
>>
>> +     if (host->drv_data->init) {
> In non-Exynos platform, host->drv_data has NULL.

Yes, sorry, I missed that.

Chris, should I fix this and send the updated patch or shall I send a
separate fix patch.

Thanks,
Thomas.

[...]
