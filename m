From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH v2 1/8] mmc: sdhci-msm: Update DLL reset sequence
Date: Wed, 17 Aug 2016 14:28:01 +0530
Message-ID: <271d9cb6-3a9e-a206-48a8-c487fbf68ea5@codeaurora.org>
References: <1471347668-22978-1-git-send-email-riteshh@codeaurora.org>
 <1471347668-22978-2-git-send-email-riteshh@codeaurora.org>
 <CAOCOHw4ZZNv+WhioE=zk26uJyJh24+op0rJPjU_hv_A1qqPtEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAOCOHw4ZZNv+WhioE=zk26uJyJh24+op0rJPjU_hv_A1qqPtEg@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, shawn.lin@rock-chips.com, jh80.chung@samsung.com, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

Hi Bjorn,

Thanks for the review -

On 8/17/2016 12:01 AM, Bjorn Andersson wrote:
> On Tue, Aug 16, 2016 at 4:41 AM, Ritesh Harjani <riteshh@codeaurora.org> wrote:
> [..]
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> [..]
>> @@ -316,6 +325,15 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>>         writel_relaxed((readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC)
>>                         & ~CORE_CLK_PWRSAVE), host->ioaddr + CORE_VENDOR_SPEC);
>>
>> +       if (msm_host->use_updated_dll_reset) {
>> +               writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
>> +                               & ~CORE_CK_OUT_EN),
>> +                               host->ioaddr + CORE_DLL_CONFIG);
>> +               writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2)
>> +                               | CORE_DLL_CLOCK_DISABLE),
>> +                               host->ioaddr + CORE_DLL_CONFIG_2);
>
> I know that this follows the pattern of this function, but it's
> terrible to read. Please unroll each one of these to:
>
> val = readl();
> val &= ~mask;
> val |= new-bits;
> writel(val);

Sure.

>
> To not mix the style I would suggest that you inject a patch in your
> series before this one that unrolls the exiting code and then add
> this.

Ok. I think mostly it is only this function which is suffering from the 
poor style issue which you mentioned.
Will make the relevant changes in the next spin.

>
>> +       }
>> +
>>         /* Write 1 to DLL_RST bit of DLL_CONFIG register */
>>         writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
>>                         | CORE_DLL_RST), host->ioaddr + CORE_DLL_CONFIG);
>> @@ -325,6 +343,22 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>>                         | CORE_DLL_PDN), host->ioaddr + CORE_DLL_CONFIG);
>>         msm_cm_dll_set_freq(host);
>>
>> +       if (msm_host->use_updated_dll_reset) {
>> +               u32 mclk_freq = 0;
>> +
>> +               if ((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2)
>> +                                       & CORE_FLL_CYCLE_CNT))
>> +                       mclk_freq = (u32) ((host->clock / TCXO_FREQ) * 8);
>> +               else
>> +                       mclk_freq = (u32) ((host->clock / TCXO_FREQ) * 4);
>> +
>> +               writel_relaxed(((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2)
>> +                               & ~(0xFF << 10)) | (mclk_freq << 10)),
>> +                               host->ioaddr + CORE_DLL_CONFIG_2);
>
> Dito
Ok.

>
>> +               /* wait for 5us before enabling DLL clock */
>> +               udelay(5);
>> +       }
>> +
>>         /* Write 0 to DLL_RST bit of DLL_CONFIG register */
>>         writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
>>                         & ~CORE_DLL_RST), host->ioaddr + CORE_DLL_CONFIG);
>> @@ -333,6 +367,14 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>>         writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
>>                         & ~CORE_DLL_PDN), host->ioaddr + CORE_DLL_CONFIG);
>>
>> +       if (msm_host->use_updated_dll_reset) {
>> +               msm_cm_dll_set_freq(host);
>> +               /* Enable the DLL clock */
>> +               writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2)
>> +                               & ~CORE_DLL_CLOCK_DISABLE),
>> +                               host->ioaddr + CORE_DLL_CONFIG_2);
>
> Dito
Ok.

>
>> +       }
>> +
>>         /* Set DLL_EN bit to 1. */
>>         writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
>>                         | CORE_DLL_EN), host->ioaddr + CORE_DLL_CONFIG);
>> @@ -631,6 +673,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>         dev_dbg(&pdev->dev, "MCI Version: 0x%08x, major: 0x%04x, minor: 0x%02x\n",
>>                 core_version, core_major, core_minor);
>>
>> +       if ((core_major == 1) && (core_minor >= 0x42))
>> +               msm_host->use_updated_dll_reset = true;
>> +
>
> Is it possible to come up with a better name than the "updated DLL
> sequence", just in case there are future updates to this sequence.
Sure, will try and change the flag name too.

>
> Regards,
> Bjorn
>
