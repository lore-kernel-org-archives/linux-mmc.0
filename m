From: Praveen G K <praveen.gk@gmail.com>
Subject: Re: slow eMMC write speed
Date: Wed, 28 Sep 2011 14:03:29 -0700
Message-ID: <CAHzg1A-wa0Gm2jXrU6q3L7-NBzQQJmZszraDsfs-Dgb8F6gT6w@mail.gmail.com>
References: <CAHzg1A9usWP8o3xjEq3yFn56bEqk_Qp0a8-2FJzoRZG1MqPRPA@mail.gmail.com>
	<CACRpkdYamRVpBbhAcgn7rXBGcgHUp7+9PCrmOUkXV1BvZ+4pDw@mail.gmail.com>
	<CAHzg1A9H31hWdEKR5+_p8HuA_oq6o8EkESpJ22kQ4e4oFDH8GQ@mail.gmail.com>
	<4E837C89.9020109@linux.intel.com>
	<CAHzg1A8Cgz8DNje_We9MKJ90E4=9BDw9XzvEQU5h2et8HPHBjw@mail.gmail.com>
	<4E838B43.5090605@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55440 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632Ab1I1VEB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2011 17:04:01 -0400
Received: by bkbzt4 with SMTP id zt4so8790bkb.19
        for <linux-mmc@vger.kernel.org>; Wed, 28 Sep 2011 14:03:59 -0700 (PDT)
In-Reply-To: <4E838B43.5090605@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: J Freyensee <james_p_freyensee@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Wed, Sep 28, 2011 at 2:01 PM, J Freyensee
<james_p_freyensee@linux.intel.com> wrote:
> On 09/28/2011 01:34 PM, Praveen G K wrote:
>>
>> On Wed, Sep 28, 2011 at 12:59 PM, J Freyensee
>> <james_p_freyensee@linux.intel.com> =A0wrote:
>>>
>>> On 09/28/2011 12:06 PM, Praveen G K wrote:
>>>>
>>>> On Tue, Sep 27, 2011 at 10:42 PM, Linus Walleij
>>>> <linus.walleij@linaro.org> =A0 =A0wrote:
>>>>>
>>>>> On Fri, Sep 23, 2011 at 7:05 AM, Praveen G K<praveen.gk@gmail.com=
>
>>>>> =A0wrote:
>>>>>
>>>>>> I am working on the block driver module of the eMMC driver (SDIO=
 3.0
>>>>>> controller). =A0I am seeing very low write speed for eMMC transf=
ers. =A0On
>>>>>> further debugging, I observed that every 63rd and 64th transfer =
takes
>>>>>> a long time.
>>>>>
>>>>> Are you not just seeing the card-internal garbage collection?
>>>>> http://lwn.net/Articles/428584/
>>>>
>>>> Does this mean, theoretically, I should be able to achieve larger
>>>> speeds if I am not using linux?
>>>
>>> In theory in a fairy-tale world, maybe, in reality, not really. =A0=
In R/W
>>> performance measurements we have done, eMMC performance in products=
 users
>>> would buy falls well, well short of any theoretical numbers. =A0We =
believe
>>> in
>>> theory, the eMMC interface should be able to support up to 100MB/s,=
 but
>>> in
>>> reality on real customer platforms write bandwidths (for example) b=
arely
>>> approach 20MB/s, regardless if it's a Microsoft Windows environment=
 or
>>> Android (Linux OS environment we care about). =A0So maybe it is sof=
tware
>>> implementation issues of multiple OSs preventing higher eMMC perfor=
mance
>>> numbers (hence the reason why I sometimes ask basic coding question=
s of
>>> the
>>> MMC subsystem- the code isn't the easiest to follow); however, one =
looks
>>> no
>>> further than what Apple has done with the iPad2 to see that eMMC pr=
obably
>>> just is not a good solution to use in the first place. =A0We have m=
easured
>>> Apple's iPad2 write performance on *WHAT A USER WOULD SEE* being do=
uble
>>> what
>>> we see with products using eMMC solutions. The big difference? =A0A=
pple
>>> doesn't use eMMC at all for the iPad2.
>>
>> Thanks for all the clarification. =A0The problem is I am seeing writ=
e
>> speeds of about 5MBps on a Sandisk eMMC product and I can clearly se=
e
>> the time lost when measured between sending a command and receiving =
a
>> data irq. =A0I am not sure what kind of an issue this is. =A05MBps f=
eels
>> really slow but can the internal housekeeping of the card take so mu=
ch
>> time?
>
> Have you tried to trace through all structs used for an MMC operation=
??!
> =A0Good gravy, there are request, mmc_queue, mmc_card, mmc_host,
> mmc_blk_request, mmc_request, multiple mmc_command and multiple scatt=
erlists
> that these other structs use...I've been playing around on trying to =
cache
> some things to try and improve performance and it blows me away how m=
any
> variables and pointers I have to keep track of for one operation goin=
g to an
> LBA on an MMC. =A0I keep wondering if more of the 'struct request' co=
uld have
> been used, and 1/3 of these structures could be eliminated. =A0And an=
other
> thing I wonder too is how much of this infrastructure is really neede=
d, that
> when I do ask "what is this for?" question on the list and no one res=
ponds,
> if anyone else understands if it's needed either.

I know I am not using the scatterlists, since the scatterlists are
aggregated into a 64k bounce buffer.  Regarding the different structs,
I am just taking them on face value assuming everything works "well".
But, my concern is why does it take such a long time (250 ms) to
return a transfer complete interrupt on occasional cases.  During this
time, the kernel is just waiting for the txfer_complete interrupt.
That's it.

> I mean, for the usual transfers it takes about 3ms to transfer
>>
>> 64kB of data, but for the 63rd and 64th transfers, it takes 250 ms.
>> The thing is this is not on a file system. =A0I am measuring the spe=
ed
>> using basic "dd" command to write directly to the block device.
>>
>>> So, is this a software issue? or if
>>>>
>>>> there is a way to increase the size of bounce buffers to 4MB?
>>>>
>>>
>>>
>>>
>>>>> Yours,
>>>>> Linus Walleij
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>>>
>>>
>>> --
>>> J (James/Jay) Freyensee
>>> Storage Technology Group
>>> Intel Corporation
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
> --
> J (James/Jay) Freyensee
> Storage Technology Group
> Intel Corporation
>
