From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH 1/3] mmc: sdhci-pci: Add AMD HS200 mode tuning function
Date: Wed, 23 Dec 2015 08:40:23 +0800
Message-ID: <CAKT61h-CK6egUGG=eKj5wHJ1GTkXFaqQpu2dLpJnBJF_vGfEpw@mail.gmail.com>
References: <1450802408-16354-1-git-send-email-vincent.wan@amd.com> <CAHp75Vf2TJLXNcBfNkDHuZ9OjE9=EpQgz3pHJabPim2g63AfPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33636 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbbLWAkn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Dec 2015 19:40:43 -0500
In-Reply-To: <CAHp75Vf2TJLXNcBfNkDHuZ9OjE9=EpQgz3pHJabPim2g63AfPQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wan Zongshun <vincent.wan@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Borislav Petkov <bp@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>

2015-12-22 17:52 GMT+08:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> On Tue, Dec 22, 2015 at 6:40 PM, Wan Zongshun <vincent.wan@amd.com> wrote:
>> From: Wan Zongshun <Vincent.Wan@amd.com>
>>
>> This patch is to add software tuning functions for AMD hs200
>> mode.
>>
>> Signed-off-by: Wan Zongshun <Vincent.Wan@amd.com>
>> ---
>>  drivers/mmc/host/sdhci-pci-core.c | 146 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 146 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>> index 08f4a9f..01c5723 100644
>> --- a/drivers/mmc/host/sdhci-pci-core.c
>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>> @@ -729,6 +729,152 @@ enum amd_chipset_gen {
>>         AMD_CHIPSET_UNKNOWN,
>>  };
>>
>> +struct tuning_descriptor {
>> +       unsigned char tune_around;
>> +       bool this_tune_ok;
>> +       bool last_tune_ok;
>> +       bool valid_front_end;
>> +       unsigned char valid_front;
>> +       unsigned char valid_window_max;
>> +       unsigned char tune_low_max;
>> +       unsigned char tune_low;
>> +       unsigned char valid_window;
>> +       unsigned char tune_result;
>> +};
>> +
>> +#define AMD_EMMC_TUNE_REG 0xb8
>> +static struct tuning_descriptor tdescriptor;
>
> Global variable?!

Okay, will change it to local.

>
>> +
>> +static int tuning_reset(struct sdhci_host *host)
>
> Better prefixes?

Do you mean I should not name this function to tuning reset?

>
>> +{
>> +       unsigned int val;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&host->lock, flags);
>> +
>> +       val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> +       val |= SDHCI_CTRL_PRESET_VAL_ENABLE | SDHCI_CTRL_EXEC_TUNING;
>> +       sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
>> +
>> +       val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> +       val &= ~SDHCI_CTRL_EXEC_TUNING;
>> +       sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
>> +
>> +       spin_unlock_irqrestore(&host->lock, flags);
>> +
>> +       return 0;
>> +}
>> +
>> +static int config_tuning_phase(struct sdhci_host *host, unsigned char phase)
>> +{
>> +       struct sdhci_pci_slot *slot = sdhci_priv(host);
>> +       struct pci_dev *pdev = slot->chip->pdev;
>> +       unsigned int val;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&host->lock, flags);
>> +
>> +       pci_read_config_dword(pdev, AMD_EMMC_TUNE_REG, &val);
>> +       val &= ~0xf;
>> +       val |= (0x10800 | phase);
>
> Magic.

Okay, I will make 0x10800 to be see more clearly, will define each bit
Macro for it.

>
>> +       pci_write_config_dword(pdev, AMD_EMMC_TUNE_REG, val);
>> +
>> +       spin_unlock_irqrestore(&host->lock, flags);
>> +
>> +       return 0;
>> +}
>> +
>> +static int find_good_phase(struct sdhci_host *host)
>> +{
>> +       struct tuning_descriptor *td = &tdescriptor;
>> +       struct sdhci_pci_slot *slot = sdhci_priv(host);
>> +       struct pci_dev *pdev = slot->chip->pdev;
>> +       unsigned int val;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&host->lock, flags);
>> +
>> +       if (td->this_tune_ok == false)
>> +               td->valid_front_end = 1;
>> +
>> +       if (td->valid_front_end)
>> +               td->valid_front = td->valid_front;
>> +       else if (td->this_tune_ok)
>> +               td->valid_front = td->valid_front + 1;
>> +
>> +       if ((!td->this_tune_ok && td->last_tune_ok) ||
>> +                                       (td->tune_around == 11)) {
>
> Magic.
>
>> +               if (td->valid_window > td->valid_window_max) {
>> +                       td->valid_window_max = td->valid_window;
>> +                       td->tune_low_max = td->tune_low;
>> +               }
>> +       }
>> +
>> +       if (td->this_tune_ok) {
>> +               if (!td->last_tune_ok)
>> +                       td->tune_low = td->tune_around;
>> +               td->valid_window = td->valid_window + 1;
>> +       } else {
>> +               if (td->last_tune_ok)
>> +                       td->valid_window = 0x0;
>> +       }
>> +
>> +       td->last_tune_ok = td->this_tune_ok;
>> +
>> +       if (td->tune_around == 11) {
>> +               if ((td->valid_front + td->valid_window) >
>> +                                               td->valid_window_max) {
>> +                       if (td->valid_front > td->valid_window)
>> +                               td->tune_result =
>> +                               ((td->valid_front - td->valid_window) >> 1);
>> +                       else
>> +                               td->tune_result = td->tune_low +
>> +                               ((td->valid_window + td->valid_front) >> 1);
>> +               } else {
>> +                       td->tune_result =
>> +                               td->tune_low_max + (td->valid_window_max >> 1);
>> +               }
>> +
>> +               if (td->tune_result > 0x0b)
>> +                       td->tune_result = 0x0b;
>> +
>> +               pci_read_config_dword(pdev, AMD_EMMC_TUNE_REG, &val);
>> +               val &= ~0xf;
>> +               val |= (0x10800 | td->tune_result);
>
> Magic.
>
>> +               pci_write_config_dword(pdev, AMD_EMMC_TUNE_REG, val);
>> +       }
>> +
>> +       spin_unlock_irqrestore(&host->lock, flags);
>> +
>> +       return 0;
>> +}
>> +
>> +static int amd_execute_tuning(struct sdhci_host *host, u32 opcode)
>> +{
>> +       struct tuning_descriptor *td = &tdescriptor;
>> +
>> +       tuning_reset(host);
>> +
>> +       for (td->tune_around = 0; td->tune_around < 12; td->tune_around++) {
>
> Magic.
>
> Why loop is done with non-local variable?

It will be changed at next version.
thanks!

>
>> +
>> +               config_tuning_phase(host, td->tune_around);
>> +
>> +               if (mmc_send_tuning(host->mmc, opcode, NULL)) {
>> +                       td->this_tune_ok = false;
>> +                       host->mmc->need_retune = 0;
>> +                       mdelay(4);
>> +               } else {
>> +                       td->this_tune_ok = true;
>> +               }
>> +
>> +               find_good_phase(host);
>> +       }
>> +
>> +       host->mmc->retune_period = 0;
>> +
>> +       return 0;
>> +}
>> +
>>  static int amd_probe(struct sdhci_pci_chip *chip)
>>  {
>>         struct pci_dev  *smbus_dev;
>
> No users for such code. I don't think it makes sense to push it separately.

Since I am not sure the patch 2/3 is ok to every body, so it just is my try.
If we can make decision for patch2/3, I can integrate them into one
patch per your suggestion.

Thanks Andy.

>
> --
> With Best Regards,
> Andy Shevchenko



-- 
---
Vincent Wan(Zongshun)
www.mcuos.com
