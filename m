From: Harish Jenny K N <harish_kandiga@mentor.com>
Subject: Re: [PATCH v9] mmc: Export host capabilities to debugfs.
Date: Mon, 12 Mar 2018 19:37:12 +0530
Message-ID: <9923a92c-f76d-ad87-a648-da212b6b39de@mentor.com>
References: <1520829090-3567-1-git-send-email-harish_kandiga@mentor.com>
 <1520849262.10722.582.camel@linux.intel.com>
 <DM5PR04MB10854C79897A80023EF37F76FCD30@DM5PR04MB1085.namprd04.prod.outlook.com>
 <540fef96-aa2f-e6c3-467d-bc1d021dd55b@mentor.com>
 <DM5PR04MB10859F389CA2D1F2370C02CFFCD30@DM5PR04MB1085.namprd04.prod.outlook.com>
 <329d521d-1776-43ee-2f0e-e9690c29a693@mentor.com>
 <1520859807.10722.591.camel@linux.intel.com>
 <5e038945-a09c-5c64-2152-5d2783a249ec@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5e038945-a09c-5c64-2152-5d2783a249ec@mentor.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Avri Altman <Avri.Altman@wdc.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vladimir_Zapolskiy@mentor.com" <Vladimir_Zapolskiy@mentor.com>
List-Id: linux-mmc@vger.kernel.org



On Monday 12 March 2018 07:04 PM, Harish Jenny K N wrote:
>
> On Monday 12 March 2018 06:33 PM, Andy Shevchenko wrote:
>> On Mon, 2018-03-12 at 18:00 +0530, Harish Jenny K N wrote:
>>
>>
>>>>>>>> +	for_each_set_bit(bit, (const unsigned long *)&caps,
>>>>>>>> BITS_PER_LONG)
>>>>>>>> +	for_each_set_bit(bit, (const unsigned long
>>>>>>>> *)&caps2,
>>>>>>>> BITS_PER_LONG)
>>>>>>> Explicit casting is not needed anymore in both cases.
>>>>>> Also maybe use sizeof(mmc_host_capabilities) instead of
>>>>>> BITS_PER_LONG?
>>>>> You mean sizeof(caps) and not sizeof(mmc_host_capabilities) .
>>>>> Right ?
>>>> meant ARRAY_SIZE(mmc_host_capabilities)
>>> ARRAY_SIZE(mmc_host_capabilities) will be 32 and this will be my old
>>> change for which I got a comment from Andy Shevchenko asking me to
>>> replace u32 with unsigned long.
>>>
>>> This is the old comment:
>>>
>>>>> +    int size = sizeof(u32) * BITS_PER_BYTE;
>>>> This is redundant. Use BITS_PER_LONG (why's that, see below) in the
>> There is nothing about ARRAY_SIZE().
>> ARRAY_SIZE() will work quite good as well.
> Yes. Definitely it works. I was only mentioning about changing u32 to unsigned long for caps and passing BITS_PER_LONG  as size in for_each_set_bit.
>


Just to make it clear, I will use ARRAY_SIZE(mmc_host_capabilities) as argument in the next version of the patch.

Can anyone please respond to my previous request?

> Before sending new patch , I would like to inform that I have been sending this patch with the following checkpatch warning, just to keep it same as other usages of debugfs_create_file in the drivers/mmc/core/debugfs.c file.

> WARNING:SYMBOLIC_PERMS: Symbolic permissions 'S_IRUSR' are not preferred. Consider using octal permissions '0400'.

> Do I need to address this or keep it same as S_IRUSR ?



Thanks,
Harish Jenny K N
