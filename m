From: Praveen G K <praveen.gk@gmail.com>
Subject: Re: slow eMMC write speed
Date: Wed, 28 Sep 2011 15:24:01 -0700
Message-ID: <CAHzg1A9Cr46QqWbTZgtYmEXBYBxU5K2j829iGuXpkFPymkiapA@mail.gmail.com>
References: <CAHzg1A9usWP8o3xjEq3yFn56bEqk_Qp0a8-2FJzoRZG1MqPRPA@mail.gmail.com>
	<CACRpkdYamRVpBbhAcgn7rXBGcgHUp7+9PCrmOUkXV1BvZ+4pDw@mail.gmail.com>
	<CAHzg1A9H31hWdEKR5+_p8HuA_oq6o8EkESpJ22kQ4e4oFDH8GQ@mail.gmail.com>
	<4E837C89.9020109@linux.intel.com>
	<CAHzg1A8Cgz8DNje_We9MKJ90E4=9BDw9XzvEQU5h2et8HPHBjw@mail.gmail.com>
	<4E838B43.5090605@linux.intel.com>
	<CAHzg1A-wa0Gm2jXrU6q3L7-NBzQQJmZszraDsfs-Dgb8F6gT6w@mail.gmail.com>
	<4E839302.5020001@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38927 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454Ab1I1WYD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2011 18:24:03 -0400
Received: by fxe4 with SMTP id 4so1059534fxe.19
        for <linux-mmc@vger.kernel.org>; Wed, 28 Sep 2011 15:24:02 -0700 (PDT)
In-Reply-To: <4E839302.5020001@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: J Freyensee <james_p_freyensee@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Wed, Sep 28, 2011 at 2:34 PM, J Freyensee
<james_p_freyensee@linux.intel.com> wrote:
> On 09/28/2011 02:03 PM, Praveen G K wrote:
>>
>> On Wed, Sep 28, 2011 at 2:01 PM, J Freyensee
>> <james_p_freyensee@linux.intel.com> =A0wrote:
>>>
>>> On 09/28/2011 01:34 PM, Praveen G K wrote:
>>>>
>>>> On Wed, Sep 28, 2011 at 12:59 PM, J Freyensee
>>>> <james_p_freyensee@linux.intel.com> =A0 =A0wrote:
>>>>>
>>>>> On 09/28/2011 12:06 PM, Praveen G K wrote:
>>>>>>
>>>>>> On Tue, Sep 27, 2011 at 10:42 PM, Linus Walleij
>>>>>> <linus.walleij@linaro.org> =A0 =A0 =A0wrote:
>>>>>>>
>>>>>>> On Fri, Sep 23, 2011 at 7:05 AM, Praveen G K<praveen.gk@gmail.c=
om>
>>>>>>> =A0wrote:
>>>>>>>
>>>>>>>> I am working on the block driver module of the eMMC driver (SD=
IO 3.0
>>>>>>>> controller). =A0I am seeing very low write speed for eMMC tran=
sfers.
>>>>>>>> =A0On
>>>>>>>> further debugging, I observed that every 63rd and 64th transfe=
r
>>>>>>>> takes
>>>>>>>> a long time.
>>>>>>>
>>>>>>> Are you not just seeing the card-internal garbage collection?
>>>>>>> http://lwn.net/Articles/428584/
>>>>>>
>>>>>> Does this mean, theoretically, I should be able to achieve large=
r
>>>>>> speeds if I am not using linux?
>>>>>
>>>>> In theory in a fairy-tale world, maybe, in reality, not really. =A0=
In R/W
>>>>> performance measurements we have done, eMMC performance in produc=
ts
>>>>> users
>>>>> would buy falls well, well short of any theoretical numbers. =A0W=
e
>>>>> believe
>>>>> in
>>>>> theory, the eMMC interface should be able to support up to 100MB/=
s, but
>>>>> in
>>>>> reality on real customer platforms write bandwidths (for example)
>>>>> barely
>>>>> approach 20MB/s, regardless if it's a Microsoft Windows environme=
nt or
>>>>> Android (Linux OS environment we care about). =A0So maybe it is s=
oftware
>>>>> implementation issues of multiple OSs preventing higher eMMC
>>>>> performance
>>>>> numbers (hence the reason why I sometimes ask basic coding questi=
ons of
>>>>> the
>>>>> MMC subsystem- the code isn't the easiest to follow); however, on=
e
>>>>> looks
>>>>> no
>>>>> further than what Apple has done with the iPad2 to see that eMMC
>>>>> probably
>>>>> just is not a good solution to use in the first place. =A0We have
>>>>> measured
>>>>> Apple's iPad2 write performance on *WHAT A USER WOULD SEE* being =
double
>>>>> what
>>>>> we see with products using eMMC solutions. The big difference? =A0=
Apple
>>>>> doesn't use eMMC at all for the iPad2.
>>>>
>>>> Thanks for all the clarification. =A0The problem is I am seeing wr=
ite
>>>> speeds of about 5MBps on a Sandisk eMMC product and I can clearly =
see
>>>> the time lost when measured between sending a command and receivin=
g a
>>>> data irq. =A0I am not sure what kind of an issue this is. =A05MBps=
 feels
>>>> really slow but can the internal housekeeping of the card take so =
much
>>>> time?
>>>
>>> Have you tried to trace through all structs used for an MMC operati=
on??!
>>> =A0Good gravy, there are request, mmc_queue, mmc_card, mmc_host,
>>> mmc_blk_request, mmc_request, multiple mmc_command and multiple
>>> scatterlists
>>> that these other structs use...I've been playing around on trying t=
o
>>> cache
>>> some things to try and improve performance and it blows me away how=
 many
>>> variables and pointers I have to keep track of for one operation go=
ing to
>>> an
>>> LBA on an MMC. =A0I keep wondering if more of the 'struct request' =
could
>>> have
>>> been used, and 1/3 of these structures could be eliminated. =A0And =
another
>>> thing I wonder too is how much of this infrastructure is really nee=
ded,
>>> that
>>> when I do ask "what is this for?" question on the list and no one
>>> responds,
>>> if anyone else understands if it's needed either.
>>
>> I know I am not using the scatterlists, since the scatterlists are
>> aggregated into a 64k bounce buffer. =A0Regarding the different stru=
cts,
>> I am just taking them on face value assuming everything works "well"=
=2E
>> But, my concern is why does it take such a long time (250 ms) to
>> return a transfer complete interrupt on occasional cases. =A0During =
this
>> time, the kernel is just waiting for the txfer_complete interrupt.
>> That's it.
>
> I think one fundamental problem with execution of the MMC commands is=
 even
> though the MMC has it's own structures and own DMA/Host-controller, t=
he OS's
> block subsystem and MMC subsystem do not really run independent of ei=
ther
> other and each are still tied to each others' fate, holding up perfor=
mance
> of the kernel in general.
>
> In particular, I have found that in the 2.6.36+ kernels that the soon=
er you
> can retire the 'struct request *req' (ie using __blk_end_request()) w=
ith
> respect to when the mmc_wait_for_req() call is made, the higher perfo=
rmance
> you are going to get out of the OS in terms of reads/writes using an =
MMC.
> =A0mmc_wait_for_req() is a blocking call, so that OS 'struct request =
req' will
> just sit around and do nothing until mmc_wait_for_req() is done. =A0I=
 have
> been able to do some caching of some commands, calling __blk_end_requ=
est()
> before mmc_wait_for_req(), and getting much higher performance in a f=
ew
> experiments (but the work certainly is not ready for prime-time).
>
> Now in the 3.0 kernel I know mmc_wait_for_req() has changed and the g=
oal was
> to try and make that function a bit more non-blocking, but I have not=
 played
> with it too much because my current focus is on existing products and=
 no
> handheld product uses a 3.0 kernel yet (that I am aware of at least).
> =A0However, I still see the fundamental problem is that the MMC stack=
, which
> was probably written with the intended purpose to be independent of t=
he OS
> block subsystem (struct request and other stuff), really isn't indepe=
ndent
> of the OS block subsystem and will cause holdups between one another,
> thereby dragging down read/write performance of the MMC.
>
> The other fundamental problem is the writes themselves. =A0Way, WAY m=
ore
> writes occur on a handheld system in an end-user's hands than reads.
> Fundamental computer principle states "you make the common case fast"=
=2E So
> focus should be on how to complete a write operation the fastest way
> possible.

Thanks for the detailed explanation.
Please let me know if there is a fundamental issue with the way I am
inserting the high res timers.  In the block.c file, I am timing the
transfers as follows

1. Start timer
mmc_queue_bounce_pre()
mmc_wait_for_req()
mmc_queue_bounce_post()
End timer

So, I don't really have to worry about the blk_end_request right.
Like you said, wait_for_req is a blocking wait.  I don't see what is
wrong with that being a blocking wait, because until you get the data
xfer complete irq, there is no point in going ahead.  The
blk_end_request comes later in the picture only when all the data is
transferred to the card.
My line of thought is that the card is taking a lot of time for its
internal housekeeping.  But, I want to be absolutely sure of my
analysis before I can pass that judgement.

I have also used another Toshiba card that gives me about 12 MBps
write speed for the same code, but I am worried is whether I am
masking some issue by blaming it on the card.  What if the Toshiba
card can give a throughput more than 12MBps ideally?

Or could there be an issue that the irq handler(sdhci_irq) is called
with some kind of a delay and is there a possibility that we are not
capturing the transfer complete interrupt immediately?

>>
>>> I mean, for the usual transfers it takes about 3ms to transfer
>>>>
>>>> 64kB of data, but for the 63rd and 64th transfers, it takes 250 ms=
=2E
>>>> The thing is this is not on a file system. =A0I am measuring the s=
peed
>>>> using basic "dd" command to write directly to the block device.
>>>>
>>>>> So, is this a software issue? or if
>>>>>>
>>>>>> there is a way to increase the size of bounce buffers to 4MB?
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>>>> Yours,
>>>>>>> Linus Walleij
>>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-=
mmc"
>>>>>> in
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
