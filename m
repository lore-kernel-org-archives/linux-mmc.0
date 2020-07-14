Return-Path: <SRS0=QsjN=AZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08422C433E5
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jul 2020 14:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA2D22515
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jul 2020 14:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="bf8ZFTYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgGNOMV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:12:21 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59271 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728284AbgGNOMV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 14 Jul 2020 10:12:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594735939; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=LifGDoeYgM0/BIMJoOe/jlyiprSOFmQ7YDZTpHWYu0g=; b=bf8ZFTYdfxgfCEFteEnKzMvwmWP3cPPCMn6dGkf+3sIpbaUIR8S9gNzUosekZE+EIa9tDtIU
 Azd3jMTI4pjRJ0YTX9XLyEMm7Ba9luFT/Nh0V52MN5CC1XX7y7A4P40RIXQWYTxmmLHI66Fj
 Ua0/jKFzhEv7XN1hXjg7AAWUp/U=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n17.prod.us-east-1.postgun.com with SMTP id
 5f0dbd4265270fa595cd4cf3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 14:12:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D6B65C433CB; Tue, 14 Jul 2020 14:12:17 +0000 (UTC)
Received: from [192.168.0.103] (unknown [183.83.69.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C746C43391;
        Tue, 14 Jul 2020 14:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C746C43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: [PATCH V1] mmc: sdhci-msm: Set IO pins in low power state during
 suspend
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>
References: <1594213888-2780-1-git-send-email-vbadigan@codeaurora.org>
 <1594213888-2780-2-git-send-email-vbadigan@codeaurora.org>
 <20200710005233.GN3191083@google.com>
 <63323fe2-e3a3-030f-5275-01fa6b04e23b@codeaurora.org>
 <20200711001948.GO3191083@google.com>
 <2c322fe1-6a86-43c9-11f3-387b917836ed@codeaurora.org>
Message-ID: <406769f7-2282-d658-5573-3a510d256eee@codeaurora.org>
Date:   Tue, 14 Jul 2020 19:42:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2c322fe1-6a86-43c9-11f3-387b917836ed@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 7/13/2020 9:26 PM, Veerabhadrarao Badiganti wrote:
>
> On 7/11/2020 5:49 AM, Matthias Kaehlcke wrote:
>> Hi,
>>
>> On Fri, Jul 10, 2020 at 04:28:36PM +0530, Veerabhadrarao Badiganti 
>> wrote:
>>> Hi Mathias,
>>>
>>> On 7/10/2020 6:22 AM, Matthias Kaehlcke wrote:
>>>> Hi,
>>>>
>>>> On Wed, Jul 08, 2020 at 06:41:20PM +0530, Veerabhadrarao Badiganti 
>>>> wrote:
>>>>> Configure SDHC IO pins with low power configuration when the driver
>>>>> is in suspend state.
>>>>>
>>>>> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>>>>> ---
>>>>>    drivers/mmc/host/sdhci-msm.c | 17 +++++++++++++++++
>>>>>    1 file changed, 17 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mmc/host/sdhci-msm.c 
>>>>> b/drivers/mmc/host/sdhci-msm.c
>>>>> index 392d41d57a6e..efd2bae1430c 100644
>>>>> --- a/drivers/mmc/host/sdhci-msm.c
>>>>> +++ b/drivers/mmc/host/sdhci-msm.c
>>>>> @@ -15,6 +15,7 @@
>>>>>    #include <linux/iopoll.h>
>>>>>    #include <linux/regulator/consumer.h>
>>>>>    #include <linux/interconnect.h>
>>>>> +#include <linux/pinctrl/consumer.h>
>>>>>    #include "sdhci-pltfm.h"
>>>>>    #include "cqhci.h"
>>>>> @@ -1352,6 +1353,19 @@ static void 
>>>>> sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
>>>>>            sdhci_msm_hs400(host, &mmc->ios);
>>>>>    }
>>>>> +static int sdhci_msm_set_pincfg(struct sdhci_msm_host *msm_host, 
>>>>> bool level)
>>>>> +{
>>>>> +    struct platform_device *pdev = msm_host->pdev;
>>>>> +    int ret;
>>>>> +
>>>>> +    if (level)
>>>>> +        ret = pinctrl_pm_select_default_state(&pdev->dev);
>>>>> +    else
>>>>> +        ret = pinctrl_pm_select_sleep_state(&pdev->dev);
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>>    static int sdhci_msm_set_vmmc(struct mmc_host *mmc)
>>>>>    {
>>>>>        if (IS_ERR(mmc->supply.vmmc))
>>>>> @@ -1596,6 +1610,9 @@ static void sdhci_msm_handle_pwr_irq(struct 
>>>>> sdhci_host *host, int irq)
>>>>>                ret = sdhci_msm_set_vqmmc(msm_host, mmc,
>>>>>                        pwr_state & REQ_BUS_ON);
>>>>>            if (!ret)
>>>>> +            ret = sdhci_msm_set_pincfg(msm_host,
>>>>> +                    pwr_state & REQ_BUS_ON);
>>>>> +        if (!ret)
>>>>>                irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
>>>>>            else
>>>>>                irq_ack |= CORE_PWRCTL_BUS_FAIL;
>>>> I happened to have a debug patch in my tree which logs when regulators
>>>> are enabled/disabled, with this patch I see the SD card regulator
>>>> toggling constantly after returning from the first system suspend.
>>>>
>>>> I added more logs:
>>>>
>>>> [ 1156.085819] DBG: sdhci_msm_set_pincfg: level = 0 (ret: 0)
>>>> [ 1156.248936] DBG: sdhci_msm_set_pincfg: level = 1 (ret: 0)
>>>> [ 1156.301989] DBG: sdhci_msm_set_pincfg: level = 0 (ret: 0)
>>>> [ 1156.462383] DBG: sdhci_msm_set_pincfg: level = 1 (ret: 0)
>>>> [ 1156.525988] DBG: sdhci_msm_set_pincfg: level = 0 (ret: 0)
>>>> [ 1156.670372] DBG: sdhci_msm_set_pincfg: level = 1 (ret: 0)
>>>> [ 1156.717935] DBG: sdhci_msm_set_pincfg: level = 0 (ret: 0)
>>>> [ 1156.878122] DBG: sdhci_msm_set_pincfg: level = 1 (ret: 0)
>>>> [ 1156.928134] DBG: sdhci_msm_set_pincfg: level = 0 (ret: 0)
>>>>
>>>> This is on an SC7180 platform. It doesn't run an upstream kernel 
>>>> though,
>>>> but v5.4 with plenty of upstream patches.
>>> I have verified this on couple of sc7180 targets (on Chrome platform 
>>> with
>>> Chrome kernel).
>>> But didn't see any issue. Its working as expected.
>> Did you test system suspend too? At least in the Chrome OS kernel 
>> tree system
>> suspend is not supported yet in the main branch, you'd need a pile of 
>> 30+
>> extra patches to get it to work. This is expected to change soon 
>> though :)
> Yes. I have verified with system  suspend-resume scenario.
> Sorry forgot to mention this point explicitly in last response.
>
> I believe all the needed patches were present on qcom internal tree.
> Suspend-resume is working fine on sc7180 qcom chrome tree.
>
Thanks Matthias. I cloud reproduce the issue on device without SDcard.

Without SDcard inserted, cd-gpio (SD card detect GPIO) is getting read 
as active HIGH
(as if card is inserted) during system-resume, resulting SDcard probe/scan.

After that its triggering interrupt again when pinctrl config is applied 
during SDcard
power-up sequence (as part of probe/scan) which is again triggering 
sdcard scan.

I will have to change SDcard cd-gpio sleep config to fix this issue like 
below:

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi 
b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index e2230f47a17d..9266d514e163 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2447,7 +2447,7 @@

                                 pinconf-sd-cd {
                                         pins = "gpio69";
-                                       bias-disable;
+                                       bias-pull-up;
                                         drive-strength = <2>;

I will check more on why its getting read as active HIGH during resume.


>>> Let me know if you are observing this issue constantly on multiple 
>>> boards, I
>>> will share you
>>> a debug patch to check it further.
>> I currently have only one board with the SD card slot populated, I might
>> get another one next week.
>>
>> The toggling occurs only when no SD card is inserted.

Thanks

Veera

