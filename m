From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V7 2/5] mmc: sdhci: Change O2 Host HS200 mode clock
 frequency to 200MHz
Date: Fri, 27 Jul 2018 09:58:27 +0300
Message-ID: <a56c0e30-cf71-5294-bc3a-1179808bd85b@intel.com>
References: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
 <20180716062655.24703-2-ernest.zhang@bayhubtech.com>
 <06a9dcec-846e-495c-4519-4af13549fe0e@intel.com>
 <BYAPR04MB4760BF8783C0E58A75D00F25E52A0@BYAPR04MB4760.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BYAPR04MB4760BF8783C0E58A75D00F25E52A0@BYAPR04MB4760.namprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Ernest Zhang(WH)" <ernest.zhang@bayhubtech.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Chuanjin Pang (WH)" <chuanjin.pang@bayhubtech.com>, "Mike Li (WH)" <mike.li@bayhubtech.com>, "Chevron Li (WH)" <chevron.li@bayhubtech.com>, "Shirley Her (SC)" <shirley.her@bayhubtech.com>, "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>, "Bobby Wu (WH)" <bobby.wu@bayhubtech.com>
List-Id: linux-mmc@vger.kernel.org

On 27/07/18 09:49, Ernest Zhang(WH) wrote:
> Hi Adrian,
> 	Do I need re-submit all 5 patches after fix that and change the version to v8?

You can reply to this email with PATCH V8 2/5 that has my Ack and the
comment fixed.

> BR
> 
> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@intel.com] 
> Sent: 2018年7月25日 15:45
> To: Ernest Zhang(WH); Ulf Hansson; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Chuanjin Pang (WH); Mike Li (WH); Chevron Li (WH); Shirley Her (SC); Xiaoguang Yu (WH); Bobby Wu (WH)
> Subject: Re: [PATCH V7 2/5] mmc: sdhci: Change O2 Host HS200 mode clock frequency to 200MHz
> 
> On 16/07/18 09:26, ernest.zhang wrote:
>> O2 SD Host HS200 mode clock frequency current is 208MHz, should be 
>> changed to 200MHz to meet specification.
>>
>> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
> 
> You left in the misleading comment.  Fix that and add:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
>> ---
>> Change in V7:
>> 	Change HS200 mode clock frequency from 208MHz to 200MHz to meet
>> 	Specification.
>>
>> Change in V1~V6:
>> 	N/A
>> ---
>>  drivers/mmc/host/sdhci-pci-o2micro.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c 
>> b/drivers/mmc/host/sdhci-pci-o2micro.c
>> index ba59db6a126c..94cf3cd75dd3 100644
>> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
>> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
>> @@ -311,7 +311,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip 
>> *chip)
>>  
>>  			/* Check Whether subId is 0x11 or 0x12 */
>>  			if ((scratch_32 == 0x11) || (scratch_32 == 0x12)) {
>> -				scratch_32 = 0x2c280000;
>> +				scratch_32 = 0x25100000;
>>  
>>  				/* Set Base Clock to 208MZ */
> 
> That comment is misleading now.
> 
>>  				o2_pci_set_baseclk(chip, scratch_32); @@ -406,7 +406,7 @@ int 
>> sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>>  					       O2_SD_PLL_SETTING, scratch_32);
>>  		} else {
>>  			scratch_32 &= 0x0000FFFF;
>> -			scratch_32 |= 0x2c280000;
>> +			scratch_32 |= 0x25100000;
>>  
>>  			pci_write_config_dword(chip->pdev,
>>  					       O2_SD_PLL_SETTING, scratch_32);
>>
> 
