From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci-msm: Add pm_runtime and system PM support
Date: Fri, 23 Sep 2016 11:56:48 +0530
Message-ID: <CANYu_0t5uRk0p=+4S9e3oCOy=gQ6rS2bqmAUqmkd7FVxsxywJw@mail.gmail.com>
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Georgi Djakov <georgi.djakov@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ritesh,

Thanks for the inputs.

On 22 September 2016 at 20:02, Ritesh Harjani <riteshh@codeaurora.org> wrote:
> Hi Pramod,

<snip>

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

Honestly I took reference from existing SDHCI HC driver which
implement the runtime PM and each one uses this function.

>
> We can *only* disable and enable the clocks in
> sdhci_msm_runtime_suspend/resume?
> Thoughts? With this, I suppose you would not see any issue.
This should work as I did not have this funtion call in my V1 but
later included when I referred the other sdhci drivers.

>
>
> Though for this issue, since internally also auto retuning is never used, we
> can have this mode disabled. I can once again check with HW team to get more
> details about this mode for MSM controller.
This seems a read only register. And I could not find any other
reference of this mode in any of the docs.
>
>>
>> Regards,
>> Pramod
>>
>
