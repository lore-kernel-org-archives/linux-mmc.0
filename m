From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci-msm: Add pm_runtime and system PM support
Date: Fri, 23 Sep 2016 12:07:37 +0200
Message-ID: <CAPDyKFpVEYz+sGNHG_z2AwXuiDe9kSRk1sh8_p4V3m7FpwPOSg@mail.gmail.com>
References: <20160901142335.2396-1-pramod.gurav@linaro.org>
 <a0e314de-3590-399c-27c7-ddd6461dee42@intel.com> <496321c5-24e7-3ac5-b3dd-7b7d5dc75536@linaro.org>
 <CANYu_0s=cyt52W2B5B=rUcx4O7Ms5kO2kBa2mw6JwWzCFTDw_A@mail.gmail.com>
 <CAPDyKFosg6pDjOPFkZ_xUP2vFRabD0W+CHzKokK73nDmnV_X3g@mail.gmail.com>
 <CANYu_0ugbBtXH8qna9FS=DpVXXRTJ3VErOwceFvg=scSOWHy_w@mail.gmail.com> <ffaebf0e-9338-3bda-b45d-16ad76b4f586@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ffaebf0e-9338-3bda-b45d-16ad76b4f586@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: Pramod Gurav <pramod.gurav@linaro.org>, Georgi Djakov <georgi.djakov@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>>>> Is there anything else needed in msm sdhci driver so that the auto
>>>> tuning is taken care of?
>>>
>>>
>>> I am not familiar with any other than sdhci-esdhc-imx which supports
>>> the SDHCI_TUNING_MODE_3. I may be wrong though.
>>>
>>> In the sdhci-esdhc-imx case, enabling of auto tuning seems to be done
>>> in esdhc_post_tuning(), where a vendor specific register
>>> (ESDHC_MIX_CTRL) is being written to. Perhaps something similar in
>>> your case?
>>>
>> Thanks Ulf for the comments. Will check this and see if there is
>> something of this sort we have to do to achieve auto tuning.
>> Adding Ritesh who has been posting some SDHCI MSM patches recently in
>> case he knows about this.
>
>
> Internally, we don't use this Auto re-tuning and rely on explicit re-tune by
> host driver.
>
> Question though -
> 1. why do we need to call sdhci_runtime_resume/suspend from
> sdhci_msm_runtime_suspend/resume?
> From what I see is, sdhci_runtime_susend/resume will do reset and re-program
> of host->pwr and host->clk because of which a retune will be required for
> the next command after runtime resume.
>
> We can *only* disable and enable the clocks in
> sdhci_msm_runtime_suspend/resume?
> Thoughts? With this, I suppose you would not see any issue.

I see.

I assumes that means saving/restoring register context will
automatically handled by some other outer logic, when doing clock
gating/ungating?

In other words, if the controller has valid tuning values, those will
be re-used and restored when clock ungating happens?

>
>
> Though for this issue, since internally also auto retuning is never used, we
> can have this mode disabled. I can once again check with HW team to get more
> details about this mode for MSM controller.
>
>>
>> Regards,
>> Pramod
>>
>

Kind regards
Uffe
