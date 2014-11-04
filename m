From: Vincent Wan <vincent.wan@amd.com>
Subject: Re: [PATCH] mmc: Add a quirk for AMD SDHC transfer mode register
 need to be cleared for cmd without data
Date: Tue, 4 Nov 2014 15:37:20 +0800
Message-ID: <54588230.1080601@amd.com>
References: <541A7F3D.70909@amd.com>	<5451B943.3060104@amd.com>
 <CAPDyKFoaN3WoYhsMoA1LRmOoyBpMdmX+ShzdD4ObKcFVTBbkFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoaN3WoYhsMoA1LRmOoyBpMdmX+ShzdD4ObKcFVTBbkFw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Huang, Ray" <Ray.Huang@amd.com>, Wan Zongshun <mcuos.com@gmail.com>, Arindam Nath <arindam.nath@amd.com>
List-Id: linux-mmc@vger.kernel.org

On 2014=E5=B9=B411=E6=9C=8804=E6=97=A5 15:51, Ulf Hansson wrote:
> On 30 October 2014 05:06, Vincent Wan <vincent.wan@amd.com> wrote:
>> SDHC controller in AMD chipsets require SDHC transfer mode
>> register to be cleared for commands without data. The issue was
>> uncovered during testing eMMC cards on KB/ML based platforms.
>>
>> Signed-off-by: Vincent Wan <vincent.wan@amd.com>
>> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
>> Tested-by: Vikram B <vikram.b@amd.com>
>> Tested-by: Raghavendra Swamy <raghavendra.swamy@amd.com>
>
> Hi Vincent,
>
> This looks good to me, but the patch has checkpatch errors.
>
> Could you check at your side and re-send?
>
> Kind regards
> Uffe
>

Hi Ulf,

My email tool causes this issue, so I have already sent patch v2 to you=
=2E

Thanks!
Vincent Wan.
>>
>> ---
>>   drivers/mmc/host/sdhci-pci.c | 27 +++++++++++++++++++++++++++
>>   drivers/mmc/host/sdhci.c     | 11 ++++++++---
>>   include/linux/mmc/sdhci.h    |  2 ++
>>   3 files changed, 37 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-p=
ci.c
>> index 6119297..8f5c998 100644
>> --- a/drivers/mmc/host/sdhci-pci.c
>> +++ b/drivers/mmc/host/sdhci-pci.c
>> @@ -645,6 +645,23 @@ static const struct sdhci_pci_fixes sdhci_rtsx =
=3D {
>>          .probe_slot     =3D rtsx_probe_slot,
>>   };
>>
>> +static int amd_probe(struct sdhci_pci_chip *chip)
>> +{
>> +       struct pci_dev  *smbus_dev;
>> +
>> +       smbus_dev =3D pci_get_device(PCI_VENDOR_ID_AMD,
>> +                       PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, NULL);
>> +
>> +       if (smbus_dev && (smbus_dev->revision < 0x51))
>> +               chip->quirks2 |=3D
>> SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD;
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct sdhci_pci_fixes sdhci_amd =3D {
>> +       .probe          =3D amd_probe,
>> +};
>> +
>>   static const struct pci_device_id pci_ids[] =3D {
>>          {
>>                  .vendor         =3D PCI_VENDOR_ID_RICOH,
>> @@ -1045,6 +1062,16 @@ static const struct pci_device_id pci_ids[] =3D=
 {
>>                  .driver_data    =3D (kernel_ulong_t)&sdhci_o2,
>>          },
>>
>> +       {
>> +               .vendor         =3D PCI_VENDOR_ID_AMD,
>> +               .device         =3D PCI_ANY_ID,
>> +               .class          =3D PCI_CLASS_SYSTEM_SDHCI << 8,
>> +               .class_mask     =3D 0xFFFF00,
>> +               .subvendor      =3D PCI_ANY_ID,
>> +               .subdevice      =3D PCI_ANY_ID,
>> +               .driver_data    =3D (kernel_ulong_t)&sdhci_amd,
>> +       },
>> +
>>          {       /* Generic SD host controller */
>>                  PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xF=
=46FF00)
>>          },
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index ada1a3e..8085f26 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -889,10 +889,15 @@ static void sdhci_set_transfer_mode(struct sdh=
ci_host
>> *host,
>>          struct mmc_data *data =3D cmd->data;
>>
>>          if (data =3D=3D NULL) {
>> -               /* clear Auto CMD settings for no data CMDs */
>> -               mode =3D sdhci_readw(host, SDHCI_TRANSFER_MODE);
>> -               sdhci_writew(host, mode & ~(SDHCI_TRNS_AUTO_CMD12 |
>> +               if (host->quirks2 &
>> +                       SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_C=
MD) {
>> +                       sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE)=
;
>> +               } else {
>> +                       /* clear Auto CMD settings for no data CMDs =
*/
>> +                       mode =3D sdhci_readw(host, SDHCI_TRANSFER_MO=
DE);
>> +                       sdhci_writew(host, mode & ~(SDHCI_TRNS_AUTO_=
CMD12 |
>>                                  SDHCI_TRNS_AUTO_CMD23),
>> SDHCI_TRANSFER_MODE);
>> +               }
>>                  return;
>>          }
>>
>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
>> index dba793e..0a287aa 100644
>> --- a/include/linux/mmc/sdhci.h
>> +++ b/include/linux/mmc/sdhci.h
>> @@ -100,6 +100,8 @@ struct sdhci_host {
>>   #define SDHCI_QUIRK2_BROKEN_DDR50                      (1<<7)
>>   /* Stop command (CMD12) can set Transfer Complete when not using
>> MMC_RSP_BUSY */
>>   #define SDHCI_QUIRK2_STOP_WITH_TC                      (1<<8)
>> +/* need clear transfer mode register before send cmd */
>> +#define SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD (1<<9)
>>
>>          int irq;                /* Device IRQ */
>>          void __iomem *ioaddr;   /* Mapped address */
>> --
>> 1.8.1.2
>>
