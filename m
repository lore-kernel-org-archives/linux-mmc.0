From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH v9 05/10] mmc: sdhci: introduce signal_voltage_switch
 callback function
Date: Fri, 7 Dec 2012 18:35:42 +0800
Message-ID: <CADz5_gL6DPR9ygPGTfRzJxF9FPH-dUjMfs=doC4uWsB-O6JOMA@mail.gmail.com>
References: <1354847790-18690-1-git-send-email-kliu5@marvell.com>
	<1354847790-18690-6-git-send-email-kliu5@marvell.com>
	<F2FC4FCA-47C4-421E-86E9-292BE6648DA0@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:65021 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932644Ab2LGKfp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Dec 2012 05:35:45 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so280368wib.1
        for <linux-mmc@vger.kernel.org>; Fri, 07 Dec 2012 02:35:43 -0800 (PST)
In-Reply-To: <F2FC4FCA-47C4-421E-86E9-292BE6648DA0@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@nvidia.com>
Cc: Kevin Liu <kliu5@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "arindam.nath@amd.com" <arindam.nath@amd.com>, "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "haojian.zhuang@gmail.com" <haojian.zhuang@gmail.com>, "cxie4@marvell.com" <cxie4@marvell.com>, Bin Wang <binw@marvell.com>, Philip Rakity <prakity@marvell.com>

2012/12/7 Philip Rakity <prakity@nvidia.com>:
>
> On Dec 7, 2012, at 2:36 AM, Kevin Liu <kliu5@marvell.com> wrote:
>
>> Some soc/platform need specific handling for signal voltage
>> switch. For example, mmp2/mmp3 need to set the AIB IO domain
>> control register accordingly.
>>
>> Signed-off-by: Bin Wang <binw@marvell.com>
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>> ---
>> drivers/mmc/host/sdhci.c |   17 +++++++++++++++++
>> drivers/mmc/host/sdhci.h |    1 +
>> 2 files changed, 18 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 50d0382..10d06fd 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1687,6 +1687,15 @@ static int sdhci_do_3_3v_signal_voltage_switch(struct sdhci_host *host,
>>                       return -EIO;
>>               }
>>       }
>> +
>> +     /*
>> +      * May need to apply soc/platfrom settings for the
>> +      * voltage switch
>> +      */
>> +     if (host->ops->signal_voltage_switch)
>> +             host->ops->signal_voltage_switch(host,
>> +                             host->mmc->ios.signal_voltage);
>> +
>>       /* Wait for 5ms */
>>       usleep_range(5000, 5500);
>>
>> @@ -1729,6 +1738,14 @@ static int sdhci_do_1_8v_signal_voltage_switch(struct sdhci_host *host,
>>                       ret = 0;
>>
>>               if (!ret) {
>> +                     /*
>> +                      * May need to apply soc/platfrom settings for the
>> +                      * voltage switch
>> +                      */
>> +                     if (host->ops->signal_voltage_switch)
>> +                             host->ops->signal_voltage_switch(host,
>> +                                     host->mmc->ios.signal_voltage);
>> +
>>                       ctrl |= SDHCI_CTRL_VDD_180;
>>                       sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>
>
> I am wondering if this is needed.
>
> A better way would be to install a notifier for voltage switch notification from the regulator in the platform code for sdhci-pxav2 or -pxav3.
> When the regulator changes the voltage the notifier is called and one can tell
> a) The new voltage
> b) The device asking for the voltage switch (passed in via the void data parameter on the request notitifer)
>

Good idea! I will change the patch.

> The only issue I can see is for voltage changes that occur via a SD Host Controller that handles voltage changes.
>

I think we can ignore this issue. If the SD host controller can do the
voltage change without external regulator, then it means it don't need
to do specific soc/platform handling either.  The reason why we need
to do this is because we change the voltage outside of SD host
controller.

Thanks
Kevin
