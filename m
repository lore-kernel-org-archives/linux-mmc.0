From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-xenon: add set_power callback
Date: Wed, 30 Aug 2017 15:13:03 +0200
Message-ID: <CAPDyKFqiaXj5LtA066BtRVrbTNB97XZM-qE2DEAz5Vc5WPDKMw@mail.gmail.com>
References: <1503338529-21102-1-git-send-email-zjwu@marvell.com>
 <e37d8951-7e1b-8431-5593-5e693295987f@intel.com> <87val76624.fsf@free-electrons.com>
 <59A464BA.6030401@marvell.com> <87bmmy65je.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36888 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbdH3NNF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Aug 2017 09:13:05 -0400
Received: by mail-io0-f182.google.com with SMTP id d78so3357680ioe.4
        for <linux-mmc@vger.kernel.org>; Wed, 30 Aug 2017 06:13:04 -0700 (PDT)
In-Reply-To: <87bmmy65je.fsf@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, Zhoujie Wu <zjwu@marvell.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Wilson Ding <dingwei@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, hongd@marvell.com, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On 29 August 2017 at 12:18, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Zhoujie,
>
>  On lun., ao=C3=BBt 28 2017, Zhoujie Wu <zjwu@marvell.com> wrote:
>
>> Hi Gregory,
>>
>> On 08/28/2017 08:54 AM, Gregory CLEMENT wrote:
>>> Hi,
>>>     On lun., ao=C3=BBt 28 2017, Adrian Hunter <adrian.hunter@intel.com>
>>> wrote:
>>>
>>>> On 21/08/17 21:02, Zhoujie Wu wrote:
>>>>> Xenon sdh controller requests proper SD bus voltage select
>>>>> bits programmed even with vmmc power supply. Any reserved
>>>>> value(100b-000b) programmed in this field will lead to controller
>>>>> ignore SD bus power bit and keep its value at zero.
>>>>> Add set_power callback to handle this.
>>>>>
>>>>> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
>>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>> I tested this patch on the Armada 3720 DB board. And thanks to this pat=
ch
>>> and by adding a vmmc regulator in the device tree I did not have anymor=
e
>>> the issue UHS card not detected on warm reset.
>>>
>>> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>>
>>> Actually for me this should be a fix. Indeed if I try to use a vmmc
>>> regulator without this patch then the SD card does not work at all I
>>> only have the following messages:
>>>
>>> "mmc1: Timeout waiting for hardware cmd interrupt."
>> This patch with sd vmmc power supply(must be claimed as AON, or card
>> detection can't work)enabled can solve the issue for warm reset. This
>> patch is must for xenon controller once vmmc power supply enabled,
>> since the HW will ignore any reserved value for sd bus voltage select
>> field and ignore the pwr_en in this case.
>
> That's why I would like that this patch was tagged as a fix.
>
> Adrian, Ulf, do you think it could be applied on the v4.13-rc or at
> least applied with the following tags ?
>
> Fixes: 3a3748dba881(" mmc: sdhci-xenon: Add Marvell Xenon SDHC core
> functionality")
> Cc: <stable@vger.kernel.org>
>
> Thanks,
>
> Gregory

Thanks, applied for fixes and by adding the above tags!

[...]

Kind regards
Uffe
