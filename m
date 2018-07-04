From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V2 5/7] mmc: sdhci: add CMD23 support for v4 mode
Date: Wed, 4 Jul 2018 11:03:20 +0800
Message-ID: <CAAfSe-uzbnfAgN6hPhJo39POOOqbz6Ac+2b5B6gnpe7ZeAW3HQ@mail.gmail.com>
References: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
 <1529028255-6022-6-git-send-email-zhang.chunyan@linaro.org> <2c91af23-da14-ed70-91b3-d7bfb06f3141@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2c91af23-da14-ed70-91b3-d7bfb06f3141@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@spreadtrum.com>
List-Id: linux-mmc@vger.kernel.org

On 23 June 2018 at 03:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 06/15/2018 05:04 AM, Chunyan Zhang wrote:
>> Host Driver Version 4.10 adds a new bit in Host Control 2 Register
>> for selecting Auto CMD23 or Auto CMD12 for ADMA3 data transfer.
>
> We don't support ADMA3.  It would require changes to the block driver.
> So is this change needed?
>
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 16 +++++++++++++++-
>>  drivers/mmc/host/sdhci.h |  1 +
>>  2 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index b8ee124..3b2af7e 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -954,6 +954,20 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>>              !mrq->cap_cmd_during_tfr;
>>  }
>>
>> +static inline void sdhci_set_auto_cmd23(struct sdhci_host *host,
>> +                                     struct mmc_command *cmd)
>> +{
>> +     u16 ctrl2;
>> +
>> +     if (host->v4_mode) {
>
> Isn't this only for a V4.1 controller, and doesn't the mode have to be "Auto
> Cmd Auto Select"?

I will send another version of changes for this new mode "Auto Cmd
Auto Select", let's see if the next iteration gets better then.

Thanks for your review,
Chunyan

>
>
>> +             ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> +             ctrl2 |= SDHCI_CMD23_ENABLE;
>> +             sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
>> +     } else {
>> +             sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>> +     }
>> +}
>> +
>>  static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>       struct mmc_command *cmd)
>>  {
>> @@ -989,7 +1003,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>                       mode |= SDHCI_TRNS_AUTO_CMD12;
>>               else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
>>                       mode |= SDHCI_TRNS_AUTO_CMD23;
>> -                     sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>> +                     sdhci_set_auto_cmd23(host, cmd);
>>               }
>>       }
>>
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 1e84539..d5e1c10 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -185,6 +185,7 @@
>>  #define   SDHCI_CTRL_DRV_TYPE_D              0x0030
>>  #define  SDHCI_CTRL_EXEC_TUNING              0x0040
>>  #define  SDHCI_CTRL_TUNED_CLK                0x0080
>> +#define  SDHCI_CMD23_ENABLE          0x0800
>>  #define  SDHCI_CTRL_V4_MODE          0x1000
>>  #define  SDHCI_CTRL_64BIT_ADDR               0x2000
>>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE        0x8000
>>
>
