From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v5 2/2] mmc: core: Support packed command for eMMC4.5 device
Date: Sun, 4 Mar 2012 17:25:06 +0900
Message-ID: <CAKYAXd8HMrdB9mzgsz5XmMxkDE+gMce+CTEDFU4J67nusNtLOg@mail.gmail.com>
References: <4934441a17d25c3249556f7bf281b1be.squirrel@www.codeaurora.org>
	<CAKYAXd_6OqQJ78mPJp11gRvGwwg88S_n_Auu=_HdP_ZXzCKrDg@mail.gmail.com>
	<6669559e86c1d13b27e941ff2acf89d2.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64081 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab2CDIZI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Mar 2012 03:25:08 -0500
In-Reply-To: <6669559e86c1d13b27e941ff2acf89d2.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-kernel@vger.kernel.org

Hi. Merez.

Thanks a lot about your performance measurement.

I think that your measurement is enough and correct and the firmware
of mmc vender should be optimized or change properly rather than
modifying the current patch.

And currently we can use only write packed cmd by my suggestion.

I would like to add my reviewd-by tag in updated patches also.

Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>

Thanks.

2012/3/2  <merez@codeaurora.org>:
> Hi,
>
> Our tests showed that the write packing improved the performance of t=
he
> write sequential operations:
>
> Long write operation:
> ----------------------
> no-packing: 15.8 MB/s
> packed commands patch (both READ and WRITE packing are enabled): 23.3=
 MB/s
>
> Several parallel write operations (sum of all the write throughputs):
> ---------------------------
> no-packing: 17.1 MB/s
> packed commands patch(both READ and WRITE packing are enabled): 25 MB=
/s
>
> Parallel long read and long write operations (write throughput):
> -----------------------------------------------------------------
> no-packing: 12.2 MB/s
> packed commands patch (both READ and WRITE packing are enabled): 16.3=
 MB/s
>
> Parallel short read and long write operations (write throughput):
> -----------------------------------------------------------------
> no-packing: 15.4 MB/s
> packed commands patch (both READ and WRITE packing are enabled): 16.4=
 MB/s
>
> Several Parallel short read and short write operations (sum of all th=
e
> write throughputs):
> ---------------------------------------------------------------------=
-----
> no-packing: 12.5 MB/s
> packed commands patch (both READ and WRITE packing are enabled): 15.5=
 MB/s
>
>
> Random read and random write:
> ------------------------------
> I checked the random read and random write IOPs by using the IOZONE
> application. There was a slight degradation in the read results due t=
o the
> packing and no improvements in the write results.
>
> The results are:
>
> IOZONE file size of 100M:
> no-packing: random read: 4675, random write: 729
> packed commands patch (both READ and WRITE packing are enabled): rand=
om
> read: 4557 random write: 723
>
> IOZONE file size of 256M:
> no-packing: random read: 4632, random write: 744
> packed commands patch (both READ and WRITE packing are enabled): rand=
om
> read: 4498, random write: 742
>
> Thanks,
> Maya Erez
> Consultant for Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>
>> Hi. merez.
>>
>> Would you share random read speed with us ?
>>
>> And Write speed also..
>>
>> Thanks.
>>
>> 2012/3/1 =C2=A0<merez@codeaurora.org>:
>>>> This patch supports packed command of eMMC4.5 device.
>>>> Several reads(or writes) can be grouped in packed command
>>>> and all data of the individual commands can be sent in a
>>>> single transfer on the bus.
>>>>
>>>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>>>> ---
>>>> =C2=A0drivers/mmc/card/block.c =C2=A0 | =C2=A0496
>>>> +++++++++++++++++++++++++++++++++++++++++--
>>>> =C2=A0drivers/mmc/card/queue.c =C2=A0 | =C2=A0 48 ++++-
>>>> =C2=A0drivers/mmc/card/queue.h =C2=A0 | =C2=A0 13 ++
>>>> =C2=A0drivers/mmc/core/mmc_ops.c | =C2=A0 =C2=A01 +
>>>> =C2=A0include/linux/mmc/core.h =C2=A0 | =C2=A0 =C2=A04 +
>>>> =C2=A05 files changed, 535 insertions(+), 27 deletions(-)
>>>>
>>> Hi,
>>>
>>> We ran performance tests on the packed commands patch. We found out=
 that
>>> enabling the read packing didn't improve the performance in any of =
the
>>> scenarios we ran (see the detailed results below).
>>> Therefore, we suggest to move the read packing code to a different =
patch
>>> and approve only the write packing code for now. The read packing a=
dds
>>> complexity to the code and we don't see a point in adding it while =
the
>>> intention is to disable it.
>>>
>>> Test results:
>>>
>>> Long read operation:
>>> ----------------------
>>> no-packing: 39.5 MB/s
>>> packed commands patch (both READ and WRITE packing are enabled): 39=
=2E5
>>> MB/s
>>> packed commands patch + enabling only READ packing: 39.5 MB/s
>>>
>>> Several parallel read operations (sum of all the read throughputs):
>>> ---------------------------
>>> no-packing: 42.6 MB/s
>>> packed commands patch(both READ and WRITE packing are enabled): 38 =
MB/s
>>> packed commands patch + enabling only READ packing: 38.2 MB/s
>>>
>>> Parallel long read and long write operations (read throughput):
>>> -----------------------------------------------------------------
>>> no-packing: 23.8 MB/s
>>> packed commands patch (both READ and WRITE packing are enabled): 12=
=2E6
>>> MB/s
>>> packed commands patch + enabling only READ packing: 12.5 MB/s
>>>
>>> Parallel short read and long write operations (read throughput):
>>> -----------------------------------------------------------------
>>> no-packing: 22.9 MB/s
>>> packed commands patch (both READ and WRITE packing are enabled): 8.=
4
>>> MB/s
>>> packed commands patch + enabling only READ packing: 8.6 MB/s
>>>
>>> Several Parallel short read and short write operations (sum of all =
the
>>> read throughputs):
>>> -------------------------------------------------------------------=
-------
>>> no-packing: 41.6 MB/s
>>> packed commands patch (both READ and WRITE packing are enabled): 35=
 MB/s
>>> packed commands patch + enabling only READ packing: 36 MB/s
>>>
>>> Thanks,
>>> Maya Erez
>>> Consultant for Qualcomm Innovation Center, Inc.
>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>>>
>>>
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>
>
