From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci-msm: Add pm_runtime and system PM support
Date: Thu, 15 Sep 2016 19:28:30 +0530
Message-ID: <CANYu_0ugbBtXH8qna9FS=DpVXXRTJ3VErOwceFvg=scSOWHy_w@mail.gmail.com>
References: <20160901142335.2396-1-pramod.gurav@linaro.org>
 <a0e314de-3590-399c-27c7-ddd6461dee42@intel.com> <496321c5-24e7-3ac5-b3dd-7b7d5dc75536@linaro.org>
 <CANYu_0s=cyt52W2B5B=rUcx4O7Ms5kO2kBa2mw6JwWzCFTDw_A@mail.gmail.com> <CAPDyKFosg6pDjOPFkZ_xUP2vFRabD0W+CHzKokK73nDmnV_X3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yb0-f177.google.com ([209.85.213.177]:33493 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755495AbcION6b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Sep 2016 09:58:31 -0400
Received: by mail-yb0-f177.google.com with SMTP id i66so33169151yba.0
        for <linux-mmc@vger.kernel.org>; Thu, 15 Sep 2016 06:58:31 -0700 (PDT)
In-Reply-To: <CAPDyKFosg6pDjOPFkZ_xUP2vFRabD0W+CHzKokK73nDmnV_X3g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Ritesh Harjani <riteshh@codeaurora.org>
Cc: Georgi Djakov <georgi.djakov@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>

On 15 September 2016 at 15:49, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 15 September 2016 at 09:59, Pramod Gurav <pramod.gurav@linaro.org> wrote:
>> On 9 September 2016 at 15:48, Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>> On 09/08/2016 11:02 AM, Adrian Hunter wrote:
>>>>
>>>> On 01/09/16 17:23, Pramod Gurav wrote:
>>>>>
>>>>> Provides runtime PM callbacks to enable and disable clock resources
>>>>> when idle. Also support system PM callbacks to be called during system
>>>>> suspend and resume.
>>>>>
>>>>> Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
>>>>
>>>>
>>>> Can we get some Tested/Reviewed/Acked-by from people using this driver?
>>>>
>>>
>>> Hi Pramod,
>>> Thanks for the patch. Unfortunately, my db410c board fails to
>>> boot when i apply it.
>>>
>>
>> Thanks Georgi for testing the patch. Its my wrong I did not update my
>> kernel and continued fixing comments on old kernel.
>> After spending some time I came to know that below change is causing the issue:
>>
>> Author: Dong Aisheng <aisheng.dong@nxp.com>
>> Date:   Tue Jul 12 15:46:17 2016 +0800
>>
>>     mmc: sdhci: add standard hw auto retuning support
>>
>>     If HW supports SDHCI_TUNING_MODE_3 which is auto retuning, we won't
>>     retune during runtime suspend and resume, instead we use Re-tuning
>>     Request signaled via SDHCI_INT_RETUNE interrupt to do retuning and
>>     hw auto retuning during data transfer to guarantee the signal sample
>>     window correction.
>>
>>     This can avoid a mass of repeatedly retuning during small file system
>>     data access and improve the performance.
>>
>> Specially these lines that was added to suspend path:
>>
>> +       if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>> +               mmc_retune_needed(host->mmc);
>>
>> During sdhci setup in msm driver, the host returns the values to set
>> sdhci auto tuning as supported.
>> Hence host->tuning_mode is set to SDHCI_TUNING_MODE_3 during setup.
>> But some how the auto tuning is not happening.
>> Just to verify my case, I removed the 'if' part in above code and got
>> the FS mounted.
>>
>> Is there anything else needed in msm sdhci driver so that the auto
>> tuning is taken care of?
>
> I am not familiar with any other than sdhci-esdhc-imx which supports
> the SDHCI_TUNING_MODE_3. I may be wrong though.
>
> In the sdhci-esdhc-imx case, enabling of auto tuning seems to be done
> in esdhc_post_tuning(), where a vendor specific register
> (ESDHC_MIX_CTRL) is being written to. Perhaps something similar in
> your case?
>
Thanks Ulf for the comments. Will check this and see if there is
something of this sort we have to do to achieve auto tuning.
Adding Ritesh who has been posting some SDHCI MSM patches recently in
case he knows about this.

Regards,
Pramod
