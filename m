From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-msm: Add sdhci_reset() implementation
Date: Mon, 28 Nov 2016 17:51:05 +0200
Message-ID: <df2a5586-0cd3-d744-d490-fa24c7e385a3@linaro.org>
References: <20161122155005.16910-1-georgi.djakov@linaro.org>
 <95ef8403-5e3c-4219-f45e-e289cf59f1b8@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <95ef8403-5e3c-4219-f45e-e289cf59f1b8@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 11/24/2016 06:06 PM, Ritesh Harjani wrote:
> Hi Georgi,
>
> I collected some info on this problem. May be below info might help you.
>
> I think "Reset 0x1" problem is occurring because of below call stack.
> SDHCI_RESET_ALL to SDHCI_SOFTWARE_RESET register will anyway trigger the
> sdhci_msm_pwr_irq.
>
> But I think the problem is that the above occurs in spinlock context
> and because of only one core the IRQ will never be serviced, hence you
> were seeing (Reset 0x1) error.
>

Hi Ritesh,
Thanks for looking into this. So yes, its called in spinlock context and 
what we need to do is just handle the power irq after writing to reset 
register.

[..]
>
> To prove above I tried this and the problem goes away. But I still dont
> think that the below approach is correct. As it will still trigger a
> pwr_irq as well.
>
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 62aedf1..01e611c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -174,6 +174,8 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
>                 /* Reset-all turns off SD Bus Power */
>                 if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
>                         sdhci_runtime_pm_bus_off(host);
> +               if (host->ops->voltage_switch)
> +                       host->ops->voltage_switch(host);
>         }
>

Yes, our own reset() function that additionally handles the irq will work.

Thanks,
Georgi
