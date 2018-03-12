From: Harish Jenny K N <harish_kandiga@mentor.com>
Subject: Re: [PATCH v9] mmc: Export host capabilities to debugfs.
Date: Mon, 12 Mar 2018 16:46:50 +0530
Message-ID: <540fef96-aa2f-e6c3-467d-bc1d021dd55b@mentor.com>
References: <1520829090-3567-1-git-send-email-harish_kandiga@mentor.com>
 <1520849262.10722.582.camel@linux.intel.com>
 <DM5PR04MB10854C79897A80023EF37F76FCD30@DM5PR04MB1085.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DM5PR04MB10854C79897A80023EF37F76FCD30@DM5PR04MB1085.namprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Avri Altman <Avri.Altman@wdc.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vladimir_Zapolskiy@mentor.com" <Vladimir_Zapolskiy@mentor.com>
List-Id: linux-mmc@vger.kernel.org



On Monday 12 March 2018 04:15 PM, Avri Altman wrote:
>
>> -----Original Message-----
>> From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
>> Sent: Monday, March 12, 2018 12:08 PM
>> To: Harish Jenny K N <harish_kandiga@mentor.com>; ulf.hansson@linaro.org;
>> linus.walleij@linaro.org; adrian.hunter@intel.com; shawn.lin@rock-
>> chips.com; Avri Altman <Avri.Altman@wdc.com>
>> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> Vladimir_Zapolskiy@mentor.com
>> Subject: Re: [PATCH v9] mmc: Export host capabilities to debugfs.
>>
>> On Mon, 2018-03-12 at 10:01 +0530, Harish Jenny K N wrote:
>>> This patch exports the host capabilities to debugfs
>>>
>>> This idea of sharing host capabilities over debugfs came up from Abbas
>>> Raza <Abbas_Raza@mentor.com> Earlier discussions:
>>> https://lkml.org/lkml/2018/3/5/357
>>> https://www.spinics.net/lists/linux-mmc/msg48219.html
>>>
>> Address below minors and, FWIW, take mine
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>>> +	for_each_set_bit(bit, (const unsigned long *)&caps,
>>> BITS_PER_LONG)
>>> +	for_each_set_bit(bit, (const unsigned long *)&caps2,
>>> BITS_PER_LONG)
>> Explicit casting is not needed anymore in both cases.
> Also maybe use sizeof(mmc_host_capabilities) instead of BITS_PER_LONG?

You mean sizeof(caps) and not sizeof(mmc_host_capabilities) . Right ?


Thanks,
Harish Jenny K N
