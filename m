Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC82BC05027
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Feb 2023 00:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjBOAvI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Feb 2023 19:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjBOAvH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2023 19:51:07 -0500
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4917630E93
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2023 16:50:58 -0800 (PST)
Received: from [172.16.12.69] (unknown [58.22.7.114])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id 3904C2801A4;
        Wed, 15 Feb 2023 08:50:54 +0800 (CST)
Message-ID: <c0f5f292-f639-1f7c-3d12-2c80015c67fc@rock-chips.com>
Date:   Wed, 15 Feb 2023 08:50:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 2/3] mmc: sdhci-of-dwcmshc: Add runtime PM support
To:     Ulf Hansson <ulf.hansson@linaro.org>
References: <1675298118-64243-1-git-send-email-shawn.lin@rock-chips.com>
 <1675298118-64243-3-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFoN3GDRYRJep1ARf8rSftZRBUceda92OPuDQLvG3dVhhQ@mail.gmail.com>
 <a336a9ef-77e9-fa1d-ad95-805a8b5a89cb@rock-chips.com>
 <CAPDyKFrpv+DoqMK9cLrYMBk1m6dXoDXu40xSJ_UMVK8O+=Ud6A@mail.gmail.com>
Content-Language: en-GB
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPDyKFrpv+DoqMK9cLrYMBk1m6dXoDXu40xSJ_UMVK8O+=Ud6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRpDT1YdGUNMGUkfS0lMGk1VEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSkpLSEpMVUpLS1VLWQ
        Y+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OE06LTo5Iz0XIhw6ET8#Tg8w
        AjIKCSpVSlVKTUxNT0lJSU5PQ0pLVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU1DQ083Bg++
X-HM-Tid: 0a86528d8f2e2eb1kusn3904c2801a4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf

On 2023/2/14 18:41, Ulf Hansson wrote:
> On Tue, 14 Feb 2023 at 04:36, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> Hi Ulf,
>>
>> On 2023/2/14 7:45, Ulf Hansson wrote:
>>> On Thu, 2 Feb 2023 at 01:35, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>>>
>>>> This patch adds runtime PM support.
>>>>
>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>> ---
>>>>
>>>> Changes in v2: None
>>>>
>>>>    drivers/mmc/host/sdhci-of-dwcmshc.c | 51 ++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 50 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>> index 46b1ce7..fc917ed 100644
>>>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>> @@ -15,6 +15,7 @@
>>>>    #include <linux/module.h>
>>>>    #include <linux/of.h>
>>>>    #include <linux/of_device.h>
>>>> +#include <linux/pm_runtime.h>
>>>>    #include <linux/reset.h>
>>>>    #include <linux/sizes.h>
>>>>
>>>> @@ -551,6 +552,13 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>>>           if (err)
>>>>                   goto err_setup_host;
>>>>
>>>> +       pm_runtime_get_noresume(&pdev->dev);
>>>> +       pm_runtime_set_active(&pdev->dev);
>>>> +       pm_runtime_enable(&pdev->dev);
>>>> +       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
>>>> +       pm_runtime_use_autosuspend(&pdev->dev);
>>>> +       pm_runtime_put_autosuspend(&pdev->dev);
>>>> +
>>>>           return 0;
>>>>
>>>>    err_setup_host:
>>>> @@ -580,6 +588,11 @@ static int dwcmshc_remove(struct platform_device *pdev)
>>>>           if (rk_priv)
>>>>                   clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>>>>                                              rk_priv->rockchip_clks);
>>>> +
>>>> +       pm_runtime_get_sync(&pdev->dev);
>>>> +       pm_runtime_disable(&pdev->dev);
>>>> +       pm_runtime_put_noidle(&pdev->dev);
>>>> +
>>>>           sdhci_pltfm_free(pdev);
>>>>
>>>>           return 0;
>>>> @@ -638,7 +651,43 @@ static int dwcmshc_resume(struct device *dev)
>>>>    }
>>>>    #endif
>>>>
>>>> -static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_resume);
>>>> +#ifdef CONFIG_PM
>>>> +static int dwcmshc_runtime_suspend(struct device *dev)
>>>> +{
>>>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>>>> +       u16 data;
>>>> +       int ret;
>>>> +
>>>> +       ret = sdhci_runtime_suspend_host(host);
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       data = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>>>> +       data &= ~SDHCI_CLOCK_CARD_EN;
>>>> +       sdhci_writew(host, data, SDHCI_CLOCK_CONTROL);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int dwcmshc_runtime_resume(struct device *dev)
>>>> +{
>>>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>>>> +       u16 data;
>>>> +
>>>> +       data = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>>>> +       data |= SDHCI_CLOCK_CARD_EN;
>>>> +       sdhci_writew(host, data, SDHCI_CLOCK_CONTROL);
>>>> +
>>>> +       return sdhci_runtime_resume_host(host, 0);
>>>> +}
>>>> +#endif
>>>> +
>>>> +static const struct dev_pm_ops dwcmshc_pmops = {
>>>> +       SET_SYSTEM_SLEEP_PM_OPS(dwcmshc_suspend,
>>>> +                               dwcmshc_resume)
>>>
>>> I have looked at dwcmshc_suspend(), which calls sdhci_suspend_host().
>>> As sdhci_suspend_host() will write to internal registers of the IP
>>> block, it's recommended to make sure the device's runtime resumed
>>> before doing that call. So that needs to be added along with $subject
>>> patch.
>>>
>>
>> Yep, let me add a check here.
>>
>>> There is also another option that may better for you, which is to use
>>> the pm_runtime_force_suspend|resume() helpers. There should be plenty
>>> of references to look at, but don't hesitate to ask around that, if
>>> you need some more help to get that working.
>>
>> If I understand correctly,  pm_runtime_force_suspend|resume() helpers
>> would use runtime PM ops for suspend/resume routine. In this case, the
>> main issue is the handling of clock is quite different. In suspend we
>> need to gate all clocks but in rpm case, it shouldn't.
> 
> I see, but let me then ask, what's the point of keeping the clocks
> ungated at runtime suspend?
> 
> That sounds like wasting energy to me - but maybe there are good reasons for it?

The point to keep the clocks ungated at runtime suspend is that if they
are gated,  the DLL would lost its locked state which causes retuning
every time. It's quite painful for performance. However, if we just gate
output clock to the device, the devices(basically I refer to eMMC) will 
get into power-save status by itself. That helps us too keep balance
between power & performance during runtime. ：）

> 
> [...]
> 
> Kind regards
> Uffe
