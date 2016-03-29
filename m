From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: Warnings for invalid VDD (sdhci-s3c)
Date: Tue, 29 Mar 2016 12:39:50 +0300
Message-ID: <56FA4D66.3030109@intel.com>
References: <CAJKOXPcGDnPm-Ykh6wHqV1YxfTaov5E8iVqBoBn4OJc7BnhgEQ@mail.gmail.com>
 <20160324155840.50474b98@xhacker> <56F3A0B7.4050509@samsung.com>
 <20160324162449.29c9cf78@xhacker> <56F3A88F.50603@samsung.com>
 <56F3E77D.7030201@intel.com> <56F3E9EB.3090207@intel.com>
 <56F8CA0C.2080908@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:54792 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752005AbcC2Jnd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 29 Mar 2016 05:43:33 -0400
In-Reply-To: <56F8CA0C.2080908@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Jisheng Zhang <jszhang@marvell.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, ludovic.desroches@atmel.com, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org

On 28/03/16 09:07, Krzysztof Kozlowski wrote:
> On 24.03.2016 22:21, Adrian Hunter wrote:
>> On 24/03/16 15:11, Adrian Hunter wrote:
>>> On 24/03/16 10:42, Krzysztof Kozlowski wrote:
>>>> On 24.03.2016 17:24, Jisheng Zhang wrote:
>>>>> Hi,
>>>>>
>>>>> On Thu, 24 Mar 2016 17:09:27 +0900 Jaehoon Chung wrote:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 03/24/2016 04:58 PM, Jisheng Zhang wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Thu, 24 Mar 2016 16:28:56 +0900 Krzysztof Kozlowski wrote:
>>>>>>>   
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> After 918f4cbd4340 ("mmc: sdhci: restore behavior when setting VDD via
>>>>>>>> external regulator") On Trats2 board I see warnings for invalid VDD
>>>>>>>> value (2.8V):
>>>>>>>>
>>>>>>>> [    3.119656] ------------[ cut here ]------------
>>>>>>>> [    3.119666] WARNING: CPU: 3 PID: 90 at
>>>>>>>> ../drivers/mmc/host/sdhci.c:1234 sdhci_do_set_ios+0x4cc/0x5e0
>>>>>>>> [    3.119669] mmc0: Invalid vdd 0x10  
>>>>>>>
>>>>>>> Per my understanding, the wrong vdd indicates a wrong ocr, what's the voltage of
>>>>>>> this host's vmmc regulator?  
>>>>>>
>>>>>> As i know, it's fixed-voltage with gpio on trats2. It's 2.8V.
>>>>>> I didn't check this entirely..need to check ocr value.
>>>>>>
>>>>>
>>>>> I may know the reason. the vmmc is 2.8v, then mmc_regulator_get_supply() convert
>>>>> the value to a ocr as 0x10. The key here is that the 2.8v is invalid in SDHCI
>>>>> case and isn't accepted by current sdhci driver.
>>>>
>>>> Yeah, I already wrote that. It is the part of the warning and my email.
>>>> Our regulator is fixed at 2.8 which is 0x10. :)
>>>>
>>>>> I dunno the elegant solution to handle this case, let's wait for sdhci maintainers
>>>>> idea.
>>>>
>>>> Hmm...
>>>
>>> I haven't tested it, but what about this:
>>
>> And now with checkpatch complaints fixed:
>>
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Date: Thu, 24 Mar 2016 14:29:24 +0200
>> Subject: [PATCH V2] mmc: sdhci: Fix regression setting power on Trats2 board
>>
>> Several commits relating to setting power have been introducing
>> problems by putting driver-specific rules into generic SDHCI code.
>>
>> Fix by adding a 'set_power' callback and restoring the default
>> behaviour prior to commit 918f4cbd4340 ("mmc: sdhci: restore
>> behavior when setting VDD via external regulator").  The desired
> 
> s/behavior/behaviour/

It seems checkpatch insists the commit message must be identical to the
original, so I am leaving it that way.

> 
>> behaviour of that commit is gotten by having sdhci-pxav3 provide
>> its own set_power callback.
>>
>> Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Fixes: 918f4cbd4340 ("mmc: sdhci: restore behavior when setting VDD...)
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> Cc: stable@vger.kernel.org # v4.5+
>> ---
>>  drivers/mmc/host/sdhci-pxav3.c | 17 +++++++++++++++++
>>  drivers/mmc/host/sdhci.c       | 38 ++++++++++++++++++++++++++++++--------
>>  drivers/mmc/host/sdhci.h       |  4 ++++
>>  3 files changed, 51 insertions(+), 8 deletions(-)
>>
> 
> Works for me (sdhci-s3c, Exynos4412 on Trats2 board):
> Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

I made a V3 which has a couple of minor changes for pxav3_set_power()
and consequently have not added the Reviewed/Tested-by Jisheng Zhang.

