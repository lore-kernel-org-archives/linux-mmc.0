From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: Re: [PATCH 1/8] mmc-core: Use kmalloc_array() in mmc_test_area_init()
Date: Tue, 10 Jan 2017 15:37:54 +0800
Message-ID: <CAG2=9p_E6byp0PKY5FUbXgwrN6pwYAxBh40SpDXJSu_yWSBxWQ@mail.gmail.com>
References: <8e2accf5-90b3-6bd0-2abd-699927bc459b@users.sourceforge.net>
 <a9b14d1d-de5c-5a22-fcd0-021d7b01cb36@users.sourceforge.net> <CACRpkdbO2_fRDuuEV-aJCL7X=m7Zads=M-N_75OqBdz66YYqHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbO2_fRDuuEV-aJCL7X=m7Zads=M-N_75OqBdz66YYqHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Harjani Ritesh <riteshh@codeaurora.org>, Jens Axboe <axboe@fb.com>, Mike Christie <mchristi@redhat.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 10 January 2017 at 02:31, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, Jan 8, 2017 at 10:42 PM, SF Markus Elfring
> <elfring@users.sourceforge.net> wrote:
>
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Sun, 8 Jan 2017 18:44:26 +0100
>>
>> * A multiplication for the size determination of a memory allocation
>>   indicated that an array data structure should be processed.
>>   Thus use the corresponding function "kmalloc_array".
>>
>>   This issue was detected by using the Coccinelle software.
>>
>> * Replace the specification of a data structure by a pointer dereference
>>   to make the corresponding size determination a bit safer according to
>>   the Linux coding style convention.
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>
> Chunyan has been running this test code so she might have additional
> insights to provide. I am not aware about anyone else really running the
> tests, are there people who do it?

I talked about mmc_test on #armlinux channel with a person whose
nickname was s84 other day. It seemed that s84 was also trying to use
mmc_test module.

Regards,
Chunyan

>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij
