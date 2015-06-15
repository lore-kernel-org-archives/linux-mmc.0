From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 1/3] pci_ids: Add AMD KERNCZ device ID support
Date: Mon, 15 Jun 2015 11:54:51 +0200
Message-ID: <CAPDyKFqKbqeWT+mLOur=FypjSOzr6c-4EPL9CC2jo7brkucbww@mail.gmail.com>
References: <1434024707-6245-1-git-send-email-Vincent.Wan@amd.com>
	<20150612203418.GJ23119@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150612203418.GJ23119-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wan ZongShun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>
Cc: linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ZongShun Wan <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 12 June 2015 at 22:34, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> On Thu, Jun 11, 2015 at 08:11:45PM +0800, Wan ZongShun wrote:
>> The KERNCZ is new AMD SB/FCH generation name, like HUDSON2.
>> We will adopt 0x790b as device ID since from this gereration.
>
> s/We will adopt 0x790b as device ID since from/0x790b is the device ID for/
> s/gereration/generation/
>
>> Signed-off-by: Wan ZongShun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>
>
> Acked-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

Thanks, applied with Bjorn's ack and his suggested changes.

Kind regards
Uffe

>
>> ---
>>  include/linux/pci_ids.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 2f7b9a4..cb63a7b 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -579,6 +579,7 @@
>>  #define PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE   0x7800
>>  #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS              0x780b
>>  #define PCI_DEVICE_ID_AMD_HUDSON2_IDE                0x780c
>> +#define PCI_DEVICE_ID_AMD_KERNCZ_SMBUS  0x790b
>>
>>  #define PCI_VENDOR_ID_TRIDENT                0x1023
>>  #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX      0x2000
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
