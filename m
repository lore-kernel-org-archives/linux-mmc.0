From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 2/3] i2c-piix4: Use Macro for AMD CZ SMBus device ID
Date: Mon, 15 Jun 2015 11:55:00 +0200
Message-ID: <CAPDyKFopmbRr1LsDvPe01PUDgMcYC5ExyqZGdPn_cRaWUZg5rg@mail.gmail.com>
References: <1434024707-6245-1-git-send-email-Vincent.Wan@amd.com>
	<1434024707-6245-2-git-send-email-Vincent.Wan@amd.com>
	<20150611130734.GA1510@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20150611130734.GA1510@katana>
Sender: linux-pci-owner@vger.kernel.org
To: Wan ZongShun <Vincent.Wan@amd.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, bp@alien8.de, Jean Delvare <jdelvare@suse.de>, Linux PCI <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ZongShun Wan <mcuos.com@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 11 June 2015 at 15:07, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Jun 11, 2015 at 08:11:46PM +0800, Wan ZongShun wrote:
>> Change AMD CZ SMBUS device ID from 0x790b to
>> use Macro definition
>>
>> Signed-off-by: Wan ZongShun <Vincent.Wan@amd.com>
>
> I think it makes sense that this patch goes in via MMC. This I2C change
> is trivial, but for MMC there is more to handle. I don't expect
> conflicts. So:
>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>

Thanks, applied!

Kind regards
Uffe

>
>> ---
>>  drivers/i2c/busses/i2c-piix4.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
>> index 67cbec6..630bce6 100644
>> --- a/drivers/i2c/busses/i2c-piix4.c
>> +++ b/drivers/i2c/busses/i2c-piix4.c
>> @@ -245,7 +245,7 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
>>            PIIX4_dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS &&
>>            PIIX4_dev->revision >= 0x41) ||
>>           (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD &&
>> -          PIIX4_dev->device == 0x790b &&
>> +          PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
>>            PIIX4_dev->revision >= 0x49))
>>               smb_en = 0x00;
>>       else
>> @@ -545,7 +545,7 @@ static const struct pci_device_id piix4_ids[] = {
>>       { PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS) },
>>       { PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS) },
>>       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) },
>> -     { PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x790b) },
>> +     { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) },
>>       { PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
>>                    PCI_DEVICE_ID_SERVERWORKS_OSB4) },
>>       { PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
