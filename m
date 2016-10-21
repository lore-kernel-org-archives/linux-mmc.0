From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: Re: [PATCH v4] mmc: sdhci-msm: Add pm_runtime and system PM support
Date: Fri, 21 Oct 2016 09:48:54 +0530
Message-ID: <CANYu_0sPmHUtDbRJU_k4fV=cDVxNbbhm6HpsZTeDgnNTpiYyDg@mail.gmail.com>
References: <20161018101624.27946-1-pramod.gurav@linaro.org> <e203153c-da0a-d450-3471-9d0dabf0a2ed@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:33741 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbcJUES4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2016 00:18:56 -0400
Received: by mail-yw0-f172.google.com with SMTP id t192so80381724ywf.0
        for <linux-mmc@vger.kernel.org>; Thu, 20 Oct 2016 21:18:56 -0700 (PDT)
In-Reply-To: <e203153c-da0a-d450-3471-9d0dabf0a2ed@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, linux-pm@vger.kernel.org, Ritesh Harjani <riteshh@codeaurora.org>

Thanks Georgi for the review.

On 20 October 2016 at 18:38, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> Hi Pramod,
>
> Thanks for the patch!
>
> On 10/18/2016 01:16 PM, Pramod Gurav wrote:
>>
>> Provides runtime PM callbacks to enable and disable clock resources
>> when idle. Also support system PM callbacks to be called during system
>> suspend and resume.
>>
>> Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
>> ---
>>
>> Tested on DB410C.
>>
>
> [..]
>
>> +static int sdhci_msm_runtime_resume(struct device *dev)
>> +{
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +       int ret;
>> +
>> +       ret = clk_prepare_enable(msm_host->clk);
>> +       if (ret) {
>> +               dev_err(dev, "clk_enable failed: %d\n", ret);
>> +               return ret;
>> +       }
>> +       ret = clk_prepare_enable(msm_host->pclk);
>> +       if (ret) {
>> +               dev_err(dev, "clk_enable failed: %d\n", ret);
>
>
> Nit: Maybe mention in the prints which clock failed - core or peripheral.

Agree. Will add in v5.

>
>> +               clk_disable_unprepare(msm_host->clk);
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +#endif
>> +
>> +static const struct dev_pm_ops sdhci_msm_pm_ops = {
>> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> +                                       pm_runtime_force_resume)
>
>
> Nit: Please align with the parenthesis.
>
>> +       SET_RUNTIME_PM_OPS(sdhci_msm_runtime_suspend,
>> sdhci_msm_runtime_resume,
>> +                               NULL)
>
>
> Ditto.
Yes. Will take care of this as well.
>
> Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>

Thanks again. :)
>
> BR,
> Georgi
