From: "Shah, Nehal-bakulchandra" <Nehal-Bakulchandra.shah@amd.com>
Subject: Re: [PATCH] mmc: sdhci-acpi: Add support for ACPI HID of AMD
 Controller with HS400
Date: Tue, 17 Oct 2017 00:52:42 +0530
Message-ID: <c9b0d31f-8560-ec28-b16e-f1fc52ea2ede@amd.com>
References: <1507803468-26313-1-git-send-email-Nehal-bakulchandra.Shah@amd.com>
 <83dfe4d0-8084-e1b5-0d87-ff42c3e5ca4c@amd.com>
 <CAPDyKFqK9qBCh-prF17F56MEyqFSm22aO_y7d9bZnOXz0gD1EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-cys01nam02on0078.outbound.protection.outlook.com ([104.47.37.78]:30658
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752841AbdJPTXG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Oct 2017 15:23:06 -0400
In-Reply-To: <CAPDyKFqK9qBCh-prF17F56MEyqFSm22aO_y7d9bZnOXz0gD1EA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, sandeep.singh@amd.com, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>

Hi Ulf

Thanks for your review comments.
On 10/16/2017 1:56 PM, Ulf Hansson wrote:
> On 12 October 2017 at 12:32, Shah, Nehal-bakulchandra
> <Nehal-Bakulchandra.shah@amd.com> wrote:
>> From: Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>
>>
>> This patch supports HS400 for AMD upcoming emmc 5.0 controller.The
>> HS400 and HS200 mode requires hardware work around also. This patch
>> adds the quirks for the same.
> 
> By looking at the changes in the patch, obviously you make changes to
> the core, but I think the reasons to why explicitly needs to be stated
> also in the change log.
I will update the change log with detailed description.
>>
>> Signed-off-by: Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>
>> ---
>>  drivers/mmc/core/mmc.c        |  6 +--
>>  drivers/mmc/host/sdhci-acpi.c | 89 +++++++++++++++++++++++++++++++++++++++++++
>>  drivers/mmc/host/sdhci.c      |  3 +-
>>  drivers/mmc/host/sdhci.h      |  5 +++
>>  include/linux/mmc/host.h      |  6 +++
>>  5 files changed, 105 insertions(+), 4 deletions(-)
> 
> Please split the core changes into a separate patch.

Sure i will split the core changes into a separate patch.

>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 4ffea14..7bf3736 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1164,7 +1164,7 @@ static int mmc_select_hs400(struct mmc_card *card)
>>
>>         /* Set host controller to HS timing */
>>         mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
>> -
>> +       host->ios.transition = HS200_TO_HS_TO_HS400;
>>         /* Reduce frequency to HS frequency */
>>         max_dtr = card->ext_csd.hs_max_dtr;
>>         mmc_set_clock(host, max_dtr);
>> @@ -1196,7 +1196,7 @@ static int mmc_select_hs400(struct mmc_card *card)
>>                          mmc_hostname(host), err);
>>                 return err;
>>         }
>> -
>> +       host->ios.transition = SWITCHING_TO_HS400;
>>         /* Set host controller to HS400 timing and frequency */
>>         mmc_set_timing(host, MMC_TIMING_MMC_HS400);
>>         mmc_set_bus_speed(card);
>> @@ -1204,7 +1204,7 @@ static int mmc_select_hs400(struct mmc_card *card)
>>         err = mmc_switch_status(card);
>>         if (err)
>>                 goto out_err;
>> -
>> +       host->ios.transition = SWITCHED_TO_HS400;
>>         return 0;
> 
> We have some other host drivers that also needs to follow a specific
> sequence while switching to HS400. Those drivers makes use of the
> ->prepare_hs400_tuning() callback. Have you explored that option, and
> if so, why exactly doesn't it work for you?
> 
> [...]
> 
I am aware about prepare_hs400_tuning(), however in AMD Platform case, some settings are required after it switches to HS400. HS400 switching is also
required intermediate transition, so in past i discussed with Adrian ( very initial patch ) and he suggested to use ios with transition.
>>  /*
>>   * End of controller registers.
>>   */
>> @@ -571,6 +574,8 @@ struct sdhci_ops {
>>         void            (*set_bus_width)(struct sdhci_host *host, int width);
>>         void (*platform_send_init_74_clocks)(struct sdhci_host *host,
>>                                              u8 power_mode);
>> +       /* ios for transiton phase for going to hs400 */
>> +       void (*set_platform_hs400_transition)(struct sdhci_host *host);
> 
> In general we avoid adding new sdhci callbacks, but instead we try to
> use the sdhci core as a set of library functions.
> 
> However, I leave this to managed by Adrian, as we decide this on case
> by case basis.
> 
I will wait for Adrian's comments also. Based on that will submit the new patch.
>>         unsigned int    (*get_ro)(struct sdhci_host *host);
>>         void            (*reset)(struct sdhci_host *host, u8 mask);
>>         int     (*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index ebd1ceb..0d0d5d3 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -77,6 +77,12 @@ struct mmc_ios {
>>  #define MMC_SET_DRIVER_TYPE_D  3
>>
>>         bool enhanced_strobe;                   /* hs400es selection */
>> +
>> +       unsigned int transition;      /* track transition modes (hs200 hs400) */
>> +
>> +#define HS200_TO_HS_TO_HS400   1
>> +#define SWITCHING_TO_HS400     2
>> +#define SWITCHED_TO_HS400      3
>>  };
>>
>>  struct mmc_host;
>> --
>> 1.9.1
>>
> 
> Kind regards
> Uffe
> 

Regards
Nehal Shah
