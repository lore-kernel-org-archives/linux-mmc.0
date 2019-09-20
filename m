From: Denis Efremov <efremov@linux.com>
Subject: Re: [PATCH v3 23/26] memstick: use PCI_STD_NUM_BARS
Date: Fri, 20 Sep 2019 11:05:00 +0300
Message-ID: <1bbe2bb0-1d3a-9151-eb2a-d2bb2c79250e@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
 <20190916204158.6889-24-efremov@linux.com>
 <CAPDyKFoVEMex2_p1M-cFZnGLuwgK0wZk-kL_eZ=eDiT1tjvDGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoVEMex2_p1M-cFZnGLuwgK0wZk-kL_eZ=eDiT1tjvDGA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Andrew Murray <andrew.murray@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>
List-Id: linux-mmc@vger.kernel.org



On 20.09.2019 10:42, Ulf Hansson wrote:
> On Mon, 16 Sep 2019 at 22:47, Denis Efremov <efremov@linux.com> wrote:
>>
>> Use define PCI_STD_NUM_BARS instead of PCI_ROM_RESOURCE for the number of
>> PCI BARs.
>>
>> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
>> Cc: Alex Dubov <oakad@yahoo.com>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Denis Efremov <efremov@linux.com>
> 
> Assuming this depends on other changes in the series?

Yes, the first patch introduce define PCI_STD_NUM_BARS.

> Thus this is
> probably for PCI maintainers to pick up?

Yes, this is for Bjorn's tree.

> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Kind regards
> Uffe
> 
>> ---
>>  drivers/memstick/host/jmb38x_ms.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
>> index 32747425297d..fd281c1d39b1 100644
>> --- a/drivers/memstick/host/jmb38x_ms.c
>> +++ b/drivers/memstick/host/jmb38x_ms.c
>> @@ -848,7 +848,7 @@ static int jmb38x_ms_count_slots(struct pci_dev *pdev)
>>  {
>>         int cnt, rc = 0;
>>
>> -       for (cnt = 0; cnt < PCI_ROM_RESOURCE; ++cnt) {
>> +       for (cnt = 0; cnt < PCI_STD_NUM_BARS; ++cnt) {
>>                 if (!(IORESOURCE_MEM & pci_resource_flags(pdev, cnt)))
>>                         break;
>>
>> --
>> 2.21.0
>>
