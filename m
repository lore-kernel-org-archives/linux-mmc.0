From: Nick Sanders <nsanders@chromium.org>
Subject: Re: eMMC tuning fail issue
Date: Tue, 1 Dec 2015 18:44:01 -0800
Message-ID: <CANvYXzis+yK=vaDQ8WdiqJT=5ZxiUXE0jkCc3Q5MSMxUmdG80Q@mail.gmail.com>
References: <BY1PR03MB138867E7C24E60866C690C129A0F0@BY1PR03MB1388.namprd03.prod.outlook.com>
 <CAPDyKFqWzc_HYU2Hd4=W-sfyj3D6j30s6-iC=PaosMzoagCkag@mail.gmail.com> <BY1PR03MB1388B8651A016856752C99AA9A0E0@BY1PR03MB1388.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34499 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757244AbbLBCoV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2015 21:44:21 -0500
Received: by oies6 with SMTP id s6so16889122oie.1
        for <linux-mmc@vger.kernel.org>; Tue, 01 Dec 2015 18:44:21 -0800 (PST)
In-Reply-To: <BY1PR03MB1388B8651A016856752C99AA9A0E0@BY1PR03MB1388.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen Bough <Haibo.Chen@freescale.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

This code is active on all Chromebooks with eMMC without an issue, and
the eMMC spec doesn't require a delay here. So I don't think it can be
a common problem. What eMMC model are you using specifically?

Also, this change fixes a problem with audio glitching on systems with
runtime pm or active retuning due to very long read latency caused by
40ms of mdelay in the kernel read path. Runtime pm sets the eMMC to
sleep if it has not been used in a short time, so intermittent reads
always go though the retuning path.

Thanks,
  Nick

On Tue, Dec 1, 2015 at 5:32 PM, Chen Bough <Haibo.Chen@freescale.com> wrote:
>
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Tuesday, December 01, 2015 8:45 PM
>> To: Chen Haibo-B51421
>> Cc: nsanders@chromium.org; linux-mmc@vger.kernel.org
>> Subject: Re: eMMC tuning fail issue
>>
>> On 1 December 2015 at 09:41, Chen Bough <Haibo.Chen@freescale.com> wrote:
>> > Hi,
>> >
>> > After
>> > commit 197160d52e859575ff0ad1afd674ab2a825b9f83
>> > Author: Nick Sanders <nsanders@chromium.org>
>> > Date:   Tue May 6 18:52:38 2014 -0700
>> >
>> >     mmc: sdhci: remove mdelay in eMMC tuning
>> >
>> >
>> > I find Micron eMMC HS200 and HS400 can't pass tuning on i.MX7D platform,
>> here is the log:
>> >
>> > [    2.835581] sdhci: Tuning procedure failed, falling back to fixed
>> sampling clock
>> > [    2.843071] mmc1: tuning execution failed
>> > [    2.847104] mmc1: error -5 whilst initialising MMC card
>> >
>> > When I revert this commit, issue gone.
>>
>> Thanks for reporting the problem!
>>
>> There's been a lot of changes regarding tuning since then, both to sdhci
>> and the mmc core. So before I consider a revert for that patch, can you
>> share on what baseline you are on!?
>
> I based on the latest Linux-next, v4.4-rc2.
>
>
> Best regards
> Haibo Chen
>
>>
>> [...]
>>
>> Kind regards
>> Uffe
