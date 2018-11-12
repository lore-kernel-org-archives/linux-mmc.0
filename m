From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: Re: [PATCH V3 1/3] mmc: sdhci: Allow platform controlled voltage
 switching
Date: Mon, 12 Nov 2018 22:49:36 +0530
Message-ID: <dcb4a579-b308-76c0-7cc3-22bb95147470@codeaurora.org>
References: <1539004739-32060-1-git-send-email-vbadigan@codeaurora.org>
 <1539004739-32060-2-git-send-email-vbadigan@codeaurora.org>
 <CAE=gft631u+ie3PRFkc5t1f3iYwuhbxDbxKUqvdZS5cFJaJbsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft631u+ie3PRFkc5t1f3iYwuhbxDbxKUqvdZS5cFJaJbsA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>, robh+dt@kernel.org, Doug Anderson <dianders@google.com>, asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayali <sayalil@codeaurora.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, vviswana@codeaurora.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


On 10/17/2018 3:39 AM, Evan Green wrote:
> On Mon, Oct 8, 2018 at 6:22 AM Veerabhadrarao Badiganti
> <vbadigan@codeaurora.org> wrote:
>> From: Vijay Viswanath <vviswana@codeaurora.org>
>>
>> Some controllers can have internal mechanism to inform the SW that it
>> is ready for voltage switching. For such controllers, changing voltage
>> before the HW is ready can result in various issues.
>>
>> During setup/cleanup of host, check whether regulator enable/disable
>> was already done by platform driver.
>>
>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>> ---
>>   drivers/mmc/host/sdhci.c | 32 +++++++++++++++++++-------------
>>   drivers/mmc/host/sdhci.h |  1 +
>>   2 files changed, 20 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 99bdae5..ea7ce1d 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -3616,6 +3616,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>>          unsigned int override_timeout_clk;
>>          u32 max_clk;
>>          int ret;
>> +       bool enable_vqmmc = false;
>>
>>          WARN_ON(host == NULL);
>>          if (host == NULL)
>> @@ -3629,9 +3630,12 @@ int sdhci_setup_host(struct sdhci_host *host)
>>           * the host can take the appropriate action if regulators are not
>>           * available.
>>           */
>> -       ret = mmc_regulator_get_supply(mmc);
>> -       if (ret)
>> -               return ret;
>> +       if (!mmc->supply.vqmmc) {
>> +               ret = mmc_regulator_get_supply(mmc);
>> +               if (ret)
>> +                       return ret;
>> +               enable_vqmmc  = true;
>> +       }
> Did you not like my suggestion in the previous patch of changing
> mmc_regulator_get_supply to only get supplies that were not set
> previously? What you have here is almost the same, except you've got
> this weird coupling where if vqmmc is already present, you implicitly
> skip looking at vmmc entirely (since mmc_regulator_get_supply does
> more than just get vqmmc).

sure. Will update mmc_regulator_get_supply() as you suggested.

>>          DBG("Version:   0x%08x | Present:  0x%08x\n",
>>              sdhci_readw(host, SDHCI_HOST_VERSION),
>> @@ -3880,7 +3884,15 @@ int sdhci_setup_host(struct sdhci_host *host)
>>                  mmc->caps |= MMC_CAP_NEEDS_POLL;
>>
>>          if (!IS_ERR(mmc->supply.vqmmc)) {
>> -               ret = regulator_enable(mmc->supply.vqmmc);
>> +               if (enable_vqmmc) {
>> +                       ret = regulator_enable(mmc->supply.vqmmc);
>> +                       if (ret) {
>> +                               pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
>> +                                       mmc_hostname(mmc), ret);
>> +                               mmc->supply.vqmmc = ERR_PTR(-EINVAL);
>> +                       }
>> +                       host->vqmmc_enabled = !ret;
>> +               }
>>
>>                  /* If vqmmc provides no 1.8V signalling, then there's no UHS */
>>                  if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
>> @@ -3893,12 +3905,6 @@ int sdhci_setup_host(struct sdhci_host *host)
>>                  if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 2700000,
>>                                                      3600000))
>>                          host->flags &= ~SDHCI_SIGNALING_330;
>> -
>> -               if (ret) {
>> -                       pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
>> -                               mmc_hostname(mmc), ret);
>> -                       mmc->supply.vqmmc = ERR_PTR(-EINVAL);
>> -               }
>>          }
>>
>>          if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
>> @@ -4136,7 +4142,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>>          return 0;
>>
>>   unreg:
>> -       if (!IS_ERR(mmc->supply.vqmmc))
>> +       if (host->vqmmc_enabled)
>>                  regulator_disable(mmc->supply.vqmmc);
>>   undma:
>>          if (host->align_buffer)
>> @@ -4154,7 +4160,7 @@ void sdhci_cleanup_host(struct sdhci_host *host)
>>   {
>>          struct mmc_host *mmc = host->mmc;
>>
>> -       if (!IS_ERR(mmc->supply.vqmmc))
>> +       if (host->vqmmc_enabled)
>>                  regulator_disable(mmc->supply.vqmmc);
>>
>>          if (host->align_buffer)
>> @@ -4287,7 +4293,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>>
>>          tasklet_kill(&host->finish_tasklet);
>>
>> -       if (!IS_ERR(mmc->supply.vqmmc))
>> +       if (host->vqmmc_enabled)
>>                  regulator_disable(mmc->supply.vqmmc);
>>
>>          if (host->align_buffer)
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index b001cf4..3c28152 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -524,6 +524,7 @@ struct sdhci_host {
>>          bool pending_reset;     /* Cmd/data reset is pending */
>>          bool irq_wake_enabled;  /* IRQ wakeup is enabled */
>>          bool v4_mode;           /* Host Version 4 Enable */
>> +       bool vqmmc_enabled;     /* Vqmmc is enabled */
> I still don't love this, since it doesn't mean what it says. Everyone
> else that has a vqmmc_enabled member uses it to actually mean "vqmmc
> is enabled", but this doesn't mean that. For example, you don't clear
> this when you disable the regulator in patch 3, so this would be set
> even if the regulator is disabled, and you don't set it when sdhci
> enables the regulator, so the regulator is on when this flag is not
> set.
>
> At the very least, I think a rename is in order. I'm struggling with
> the rename, since
> "vqmmc_pltfrm_enable_but_feel_free_to_call_set_voltage_anywhere" is
> too long. I guess vqmmc_pltfrm_enabled is the best I've got for now.

Sure. Will rename it.

>>          struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];  /* Requests done */
>>          struct mmc_command *cmd;        /* Current command */
>> --
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>>
