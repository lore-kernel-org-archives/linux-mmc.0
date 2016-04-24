From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 08/23] mmc: sdhci: rename quirk SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12
Date: Sun, 24 Apr 2016 18:00:28 +0800
Message-ID: <CAA+hA=QtexWh4H_FvjajNqDskBTZxKJXsgkUaW-AoubgbbWnfQ@mail.gmail.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
	<1460741387-23815-9-git-send-email-aisheng.dong@nxp.com>
	<571A1A34.40004@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36406 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbcDXKA3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Apr 2016 06:00:29 -0400
Received: by mail-qk0-f196.google.com with SMTP id l68so8732676qkf.3
        for <linux-mmc@vger.kernel.org>; Sun, 24 Apr 2016 03:00:28 -0700 (PDT)
In-Reply-To: <571A1A34.40004@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, haibo.chen@nxp.com

On Fri, Apr 22, 2016 at 8:33 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 15/04/16 20:29, Dong Aisheng wrote:
>> Rename ACMD12 quirk to SDHCI_QUIRK_MULTIBLOCK_ACMD12 to avoid confusion
>> since it's needed for both read and write.
>
> I am not in favour of renaming unless the original name is really really
> bad.  In this case it is a quirk which we anyway expect to remove at some
> point, so let's leave it alone for now.
>

It is really confusing when i first see it. So i made this patch.
We could clear it later.
And i think it's more like a capability rather than a quirk.

Anyway, it's up to you whether we should pick it.

Regards
Dong Aisheng

>>
>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>> ---
>>  drivers/mmc/host/sdhci-pci-o2micro.c | 2 +-
>>  drivers/mmc/host/sdhci-pltfm.c       | 2 +-
>>  drivers/mmc/host/sdhci-s3c.c         | 2 +-
>>  drivers/mmc/host/sdhci.c             | 2 +-
>>  drivers/mmc/host/sdhci.h             | 2 +-
>>  5 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
>> index d48f031..1ed1f995 100644
>> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
>> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
>> @@ -162,7 +162,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>>       case PCI_DEVICE_ID_O2_FUJIN2:
>>               reg = sdhci_readl(host, O2_SD_VENDOR_SETTING);
>>               if (reg & 0x1)
>> -                     host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>> +                     host->quirks |= SDHCI_QUIRK_MULTIBLOCK_ACMD12;
>>
>>               if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
>>                       break;
>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
>> index 072bb27..206057a 100644
>> --- a/drivers/mmc/host/sdhci-pltfm.c
>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>> @@ -74,7 +74,7 @@ void sdhci_get_of_property(struct platform_device *pdev)
>>       u32 bus_width;
>>
>>       if (of_get_property(np, "sdhci,auto-cmd12", NULL))
>> -             host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>> +             host->quirks |= SDHCI_QUIRK_MULTIBLOCK_ACMD12;
>>
>>       if (of_get_property(np, "sdhci,1-bit-only", NULL) ||
>>           (of_property_read_u32(np, "bus-width", &bus_width) == 0 &&
>> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
>> index 70c724b..756b9bb 100644
>> --- a/drivers/mmc/host/sdhci-s3c.c
>> +++ b/drivers/mmc/host/sdhci-s3c.c
>> @@ -564,7 +564,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
>>       host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ;
>>
>>       /* This host supports the Auto CMD12 */
>> -     host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>> +     host->quirks |= SDHCI_QUIRK_MULTIBLOCK_ACMD12;
>>
>>       /* Samsung SoCs need BROKEN_ADMA_ZEROLEN_DESC */
>>       host->quirks |= SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC;
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 96ccb15..40e3551 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2988,7 +2988,7 @@ int sdhci_add_host(struct sdhci_host *host)
>>       mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
>>       mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
>>
>> -     if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
>> +     if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_ACMD12)
>>               host->flags |= SDHCI_AUTO_CMD12;
>>
>>       /* Auto-CMD23 stuff only works in ADMA or PIO. */
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 0f39f4f..afa4de8 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -379,7 +379,7 @@ struct sdhci_host {
>>  /* Controller is missing device caps. Use caps provided by host */
>>  #define SDHCI_QUIRK_MISSING_CAPS                     (1<<27)
>>  /* Controller uses Auto CMD12 command to stop the transfer */
>> -#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12           (1<<28)
>> +#define SDHCI_QUIRK_MULTIBLOCK_ACMD12                        (1<<28)
>>  /* Controller doesn't have HISPD bit field in HI-SPEED SD card */
>>  #define SDHCI_QUIRK_NO_HISPD_BIT                     (1<<29)
>>  /* Controller treats ADMA descriptors with length 0000h incorrectly */
>>
>
