From: Praveen G K <praveen.gk@gmail.com>
Subject: Re: slow eMMC write speed
Date: Wed, 28 Sep 2011 19:24:03 -0700
Message-ID: <CAHzg1A9Pgug__=SRuhsQOaTQQLudZKQCN=tL9N0saDd5-ou5TQ@mail.gmail.com>
References: <CAHzg1A9usWP8o3xjEq3yFn56bEqk_Qp0a8-2FJzoRZG1MqPRPA@mail.gmail.com>
	<CACRpkdYamRVpBbhAcgn7rXBGcgHUp7+9PCrmOUkXV1BvZ+4pDw@mail.gmail.com>
	<CAHzg1A9H31hWdEKR5+_p8HuA_oq6o8EkESpJ22kQ4e4oFDH8GQ@mail.gmail.com>
	<4E837C89.9020109@linux.intel.com>
	<CAHzg1A8Cgz8DNje_We9MKJ90E4=9BDw9XzvEQU5h2et8HPHBjw@mail.gmail.com>
	<4E838B43.5090605@linux.intel.com>
	<CAHzg1A-wa0Gm2jXrU6q3L7-NBzQQJmZszraDsfs-Dgb8F6gT6w@mail.gmail.com>
	<4E839302.5020001@linux.intel.com>
	<CAHzg1A9Cr46QqWbTZgtYmEXBYBxU5K2j829iGuXpkFPymkiapA@mail.gmail.com>
	<4E83A6EF.4070301@linux.intel.com>
	<CAHzg1A9QrZFLVxQHUgED3UbJCzLM7wmvWmx+0zPcimnGBbZnxQ@mail.gmail.com>
	<25C8F176-4375-4328-9E95-7F8E90C34E18@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:48234 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab1I2CYE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2011 22:24:04 -0400
Received: by yib18 with SMTP id 18so127057yib.19
        for <linux-mmc@vger.kernel.org>; Wed, 28 Sep 2011 19:24:03 -0700 (PDT)
In-Reply-To: <25C8F176-4375-4328-9E95-7F8E90C34E18@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: J Freyensee <james_p_freyensee@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Sep 28, 2011 at 5:57 PM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
>
> On Sep 28, 2011, at 4:16 PM, Praveen G K wrote:
>
>> On Wed, Sep 28, 2011 at 3:59 PM, J Freyensee
>> <james_p_freyensee@linux.intel.com> wrote:
>>> On 09/28/2011 03:24 PM, Praveen G K wrote:
>>>>
>>>> On Wed, Sep 28, 2011 at 2:34 PM, J Freyensee
>>>> <james_p_freyensee@linux.intel.com> =A0wrote:
>>>>>
>>>>> On 09/28/2011 02:03 PM, Praveen G K wrote:
>>>>>>
>>>>>> On Wed, Sep 28, 2011 at 2:01 PM, J Freyensee
>>>>>> <james_p_freyensee@linux.intel.com> =A0 =A0wrote:
>>>>>>>
>>>>>>> On 09/28/2011 01:34 PM, Praveen G K wrote:
>>>>>>>>
>>>>>>>> On Wed, Sep 28, 2011 at 12:59 PM, J Freyensee
>>>>>>>> <james_p_freyensee@linux.intel.com> =A0 =A0 =A0wrote:
>>>>>>>>>
>>>>>>>>> On 09/28/2011 12:06 PM, Praveen G K wrote:
>>>>>>>>>>
>>>>>>>>>> On Tue, Sep 27, 2011 at 10:42 PM, Linus Walleij
>>>>>>>>>> <linus.walleij@linaro.org> =A0 =A0 =A0 =A0wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Fri, Sep 23, 2011 at 7:05 AM, Praveen G K<praveen.gk@gma=
il.com>
>>>>>>>>>>> wrote:
>>>>>>>>>>>
>>>>>>>>>>>> I am working on the block driver module of the eMMC driver=
 (SDIO
>>>>>>>>>>>> 3.0
>>>>>>>>>>>> controller). =A0I am seeing very low write speed for eMMC =
transfers.
>>>>>>>>>>>> On
>>>>>>>>>>>> further debugging, I observed that every 63rd and 64th tra=
nsfer
>>>>>>>>>>>> takes
>>>>>>>>>>>> a long time.
>>>>>>>>>>>
>>>>>>>>>>> Are you not just seeing the card-internal garbage collectio=
n?
>>>>>>>>>>> http://lwn.net/Articles/428584/
>>>>>>>>>>
>>>>>>>>>> Does this mean, theoretically, I should be able to achieve l=
arger
>>>>>>>>>> speeds if I am not using linux?
>>>>>>>>>
>>>>>>>>> In theory in a fairy-tale world, maybe, in reality, not reall=
y. =A0In
>>>>>>>>> R/W
>>>>>>>>> performance measurements we have done, eMMC performance in pr=
oducts
>>>>>>>>> users
>>>>>>>>> would buy falls well, well short of any theoretical numbers. =
=A0We
>>>>>>>>> believe
>>>>>>>>> in
>>>>>>>>> theory, the eMMC interface should be able to support up to 10=
0MB/s,
>>>>>>>>> but
>>>>>>>>> in
>>>>>>>>> reality on real customer platforms write bandwidths (for exam=
ple)
>>>>>>>>> barely
>>>>>>>>> approach 20MB/s, regardless if it's a Microsoft Windows envir=
onment
>>>>>>>>> or
>>>>>>>>> Android (Linux OS environment we care about). =A0So maybe it =
is
>>>>>>>>> software
>>>>>>>>> implementation issues of multiple OSs preventing higher eMMC
>>>>>>>>> performance
>>>>>>>>> numbers (hence the reason why I sometimes ask basic coding qu=
estions
>>>>>>>>> of
>>>>>>>>> the
>>>>>>>>> MMC subsystem- the code isn't the easiest to follow); however=
, one
>>>>>>>>> looks
>>>>>>>>> no
>>>>>>>>> further than what Apple has done with the iPad2 to see that e=
MMC
>>>>>>>>> probably
>>>>>>>>> just is not a good solution to use in the first place. =A0We =
have
>>>>>>>>> measured
>>>>>>>>> Apple's iPad2 write performance on *WHAT A USER WOULD SEE* be=
ing
>>>>>>>>> double
>>>>>>>>> what
>>>>>>>>> we see with products using eMMC solutions. The big difference=
? =A0Apple
>>>>>>>>> doesn't use eMMC at all for the iPad2.
>>>>>>>>
>>>>>>>> Thanks for all the clarification. =A0The problem is I am seein=
g write
>>>>>>>> speeds of about 5MBps on a Sandisk eMMC product and I can clea=
rly see
>>>>>>>> the time lost when measured between sending a command and rece=
iving a
>>>>>>>> data irq. =A0I am not sure what kind of an issue this is. =A05=
MBps feels
>>>>>>>> really slow but can the internal housekeeping of the card take=
 so much
>>>>>>>> time?
>>>>>>>
>>>>>>> Have you tried to trace through all structs used for an MMC
>>>>>>> operation??!
>>>>>>> Good gravy, there are request, mmc_queue, mmc_card, mmc_host,
>>>>>>> mmc_blk_request, mmc_request, multiple mmc_command and multiple
>>>>>>> scatterlists
>>>>>>> that these other structs use...I've been playing around on tryi=
ng to
>>>>>>> cache
>>>>>>> some things to try and improve performance and it blows me away=
 how
>>>>>>> many
>>>>>>> variables and pointers I have to keep track of for one operatio=
n going
>>>>>>> to
>>>>>>> an
>>>>>>> LBA on an MMC. =A0I keep wondering if more of the 'struct reque=
st' could
>>>>>>> have
>>>>>>> been used, and 1/3 of these structures could be eliminated. =A0=
And
>>>>>>> another
>>>>>>> thing I wonder too is how much of this infrastructure is really=
 needed,
>>>>>>> that
>>>>>>> when I do ask "what is this for?" question on the list and no o=
ne
>>>>>>> responds,
>>>>>>> if anyone else understands if it's needed either.
>>>>>>
>>>>>> I know I am not using the scatterlists, since the scatterlists a=
re
>>>>>> aggregated into a 64k bounce buffer. =A0Regarding the different =
structs,
>>>>>> I am just taking them on face value assuming everything works "w=
ell".
>>>>>> But, my concern is why does it take such a long time (250 ms) to
>>>>>> return a transfer complete interrupt on occasional cases. =A0Dur=
ing this
>>>>>> time, the kernel is just waiting for the txfer_complete interrup=
t.
>>>>>> That's it.
>>>>>
>>>>> I think one fundamental problem with execution of the MMC command=
s is
>>>>> even
>>>>> though the MMC has it's own structures and own DMA/Host-controlle=
r, the
>>>>> OS's
>>>>> block subsystem and MMC subsystem do not really run independent o=
f either
>>>>> other and each are still tied to each others' fate, holding up
>>>>> performance
>>>>> of the kernel in general.
>>>>>
>>>>> In particular, I have found that in the 2.6.36+ kernels that the =
sooner
>>>>> you
>>>>> can retire the 'struct request *req' (ie using __blk_end_request(=
)) with
>>>>> respect to when the mmc_wait_for_req() call is made, the higher
>>>>> performance
>>>>> you are going to get out of the OS in terms of reads/writes using=
 an MMC.
>>>>> mmc_wait_for_req() is a blocking call, so that OS 'struct request=
 req'
>>>>> will
>>>>> just sit around and do nothing until mmc_wait_for_req() is done. =
=A0I have
>>>>> been able to do some caching of some commands, calling
>>>>> __blk_end_request()
>>>>> before mmc_wait_for_req(), and getting much higher performance in=
 a few
>>>>> experiments (but the work certainly is not ready for prime-time).
>>>>>
>>>>> Now in the 3.0 kernel I know mmc_wait_for_req() has changed and t=
he goal
>>>>> was
>>>>> to try and make that function a bit more non-blocking, but I have=
 not
>>>>> played
>>>>> with it too much because my current focus is on existing products=
 and no
>>>>> handheld product uses a 3.0 kernel yet (that I am aware of at lea=
st).
>>>>> However, I still see the fundamental problem is that the MMC stac=
k,
>>>>> which
>>>>> was probably written with the intended purpose to be independent =
of the
>>>>> OS
>>>>> block subsystem (struct request and other stuff), really isn't
>>>>> independent
>>>>> of the OS block subsystem and will cause holdups between one anot=
her,
>>>>> thereby dragging down read/write performance of the MMC.
>>>>>
>>>>> The other fundamental problem is the writes themselves. =A0Way, W=
AY more
>>>>> writes occur on a handheld system in an end-user's hands than rea=
ds.
>>>>> Fundamental computer principle states "you make the common case f=
ast". So
>>>>> focus should be on how to complete a write operation the fastest =
way
>>>>> possible.
>>>>
>>>> Thanks for the detailed explanation.
>>>> Please let me know if there is a fundamental issue with the way I =
am
>>>> inserting the high res timers. =A0In the block.c file, I am timing=
 the
>>>> transfers as follows
>>>>
>>>> 1. Start timer
>>>> mmc_queue_bounce_pre()
>>>> mmc_wait_for_req()
>>>> mmc_queue_bounce_post()
>>>> End timer
>>>>
>>>> So, I don't really have to worry about the blk_end_request right.
>>>> Like you said, wait_for_req is a blocking wait. =A0I don't see wha=
t is
>>>> wrong with that being a blocking wait, because until you get the d=
ata
>>>> xfer complete irq, there is no point in going ahead. =A0The
>>>> blk_end_request comes later in the picture only when all the data =
is
>>>> transferred to the card.
>>>
>>> Yes, that is correct.
>>>
>>> But if you can do some cache trickery or queue tricks, you can dela=
y when
>>> you have to actually write to the MMC, so then __blk_end_request() =
and
>>> retiring the 'struct request *req' becomes the time-sync. =A0That i=
s a reason
>>> why mmc_wait_for_req() got some work done on it in the 3.0 kernel. =
=A0The OS
>>> does not have to wait for the host controller to complete the opera=
tion (ie,
>>> block on mmc_wait_for_data()) if there is no immediate dependency o=
n that
>>> data- that is kind-of dumb. =A0This is why this can be a problem an=
d a time
>>> sync. =A0It's no different than out-of-order execution in CPUs.
>>
>> Thanks I'll look into the 3.0 code to see what the changes are and
>> whether it can improve the speed. =A0Thanks for your suggestions.
>>
>>>> My line of thought is that the card is taking a lot of time for it=
s
>>>> internal housekeeping.
>>>
>>> Each 'write' to a solid-state/nand/flash requires an erase operatio=
n first,
>>> so yes, there is more housekeeping going on than a simple 'write'.
>>>
>>> But, I want to be absolutely sure of my
>>>>
>>>> analysis before I can pass that judgement.
>>>>
>>>> I have also used another Toshiba card that gives me about 12 MBps
>>>> write speed for the same code, but I am worried is whether I am
>>>> masking some issue by blaming it on the card. =A0What if the Toshi=
ba
>>>> card can give a throughput more than 12MBps ideally?
>>>
>>> No clue...you'd have to talk to Toshiba.
>>>
>>>>
>>>> Or could there be an issue that the irq handler(sdhci_irq) is call=
ed
>>>> with some kind of a delay and is there a possibility that we are n=
ot
>>>> capturing the transfer complete interrupt immediately?
>>>>
>>>>>>
>>>>>>> I mean, for the usual transfers it takes about 3ms to transfer
>>>>>>>>
>>>>>>>> 64kB of data, but for the 63rd and 64th transfers, it takes 25=
0 ms.
>>>>>>>> The thing is this is not on a file system. =A0I am measuring t=
he speed
>>>>>>>> using basic "dd" command to write directly to the block device=
=2E
>>>>>>>>
>>>>>>>>> So, is this a software issue? or if
>>>>>>>>>>
>>>>>>>>>> there is a way to increase the size of bounce buffers to 4MB=
?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>> Yours,
>>>>>>>>>>> Linus Walleij
>>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe li=
nux-mmc"
>>>>>>>>>> in
>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-i=
nfo.html
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> J (James/Jay) Freyensee
>>>>>>>>> Storage Technology Group
>>>>>>>>> Intel Corporation
>>>>>>>>>
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe linu=
x-mmc"
>>>>>>>> in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-inf=
o.html
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> J (James/Jay) Freyensee
>>>>>>> Storage Technology Group
>>>>>>> Intel Corporation
>>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-=
mmc" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.=
html
>>>>>
>>>>>
>>>>> --
>>>>> J (James/Jay) Freyensee
>>>>> Storage Technology Group
>>>>> Intel Corporation
>>>>>
>>>
>
> some questions:
>
> does using a bounce buffer make things faster ?
>
> I think you are using sdma. =A0 I am wondering if there is a way to i=
ncrease the the xfer size.
> Is there some magic number inside the mmc code that can be increased =
?

The bounce buffer increases the speed, but that is limited to 64kB.  I
don't know why it is limited to that number though.
> Philip
>
>
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
