From: Praveen G K <praveen.gk@gmail.com>
Subject: Re: slow eMMC write speed
Date: Wed, 28 Sep 2011 13:34:17 -0700
Message-ID: <CAHzg1A8Cgz8DNje_We9MKJ90E4=9BDw9XzvEQU5h2et8HPHBjw@mail.gmail.com>
References: <CAHzg1A9usWP8o3xjEq3yFn56bEqk_Qp0a8-2FJzoRZG1MqPRPA@mail.gmail.com>
	<CACRpkdYamRVpBbhAcgn7rXBGcgHUp7+9PCrmOUkXV1BvZ+4pDw@mail.gmail.com>
	<CAHzg1A9H31hWdEKR5+_p8HuA_oq6o8EkESpJ22kQ4e4oFDH8GQ@mail.gmail.com>
	<4E837C89.9020109@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33654 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732Ab1I1UeT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2011 16:34:19 -0400
Received: by bkbzt4 with SMTP id zt4so8439717bkb.19
        for <linux-mmc@vger.kernel.org>; Wed, 28 Sep 2011 13:34:17 -0700 (PDT)
In-Reply-To: <4E837C89.9020109@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: J Freyensee <james_p_freyensee@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Wed, Sep 28, 2011 at 12:59 PM, J Freyensee
<james_p_freyensee@linux.intel.com> wrote:
> On 09/28/2011 12:06 PM, Praveen G K wrote:
>>
>> On Tue, Sep 27, 2011 at 10:42 PM, Linus Walleij
>> <linus.walleij@linaro.org> =A0wrote:
>>>
>>> On Fri, Sep 23, 2011 at 7:05 AM, Praveen G K<praveen.gk@gmail.com>
>>> =A0wrote:
>>>
>>>> I am working on the block driver module of the eMMC driver (SDIO 3=
=2E0
>>>> controller). =A0I am seeing very low write speed for eMMC transfer=
s. =A0On
>>>> further debugging, I observed that every 63rd and 64th transfer ta=
kes
>>>> a long time.
>>>
>>> Are you not just seeing the card-internal garbage collection?
>>> http://lwn.net/Articles/428584/
>>
>> Does this mean, theoretically, I should be able to achieve larger
>> speeds if I am not using linux?
>
> In theory in a fairy-tale world, maybe, in reality, not really. =A0In=
 R/W
> performance measurements we have done, eMMC performance in products u=
sers
> would buy falls well, well short of any theoretical numbers. =A0We be=
lieve in
> theory, the eMMC interface should be able to support up to 100MB/s, b=
ut in
> reality on real customer platforms write bandwidths (for example) bar=
ely
> approach 20MB/s, regardless if it's a Microsoft Windows environment o=
r
> Android (Linux OS environment we care about). =A0So maybe it is softw=
are
> implementation issues of multiple OSs preventing higher eMMC performa=
nce
> numbers (hence the reason why I sometimes ask basic coding questions =
of the
> MMC subsystem- the code isn't the easiest to follow); however, one lo=
oks no
> further than what Apple has done with the iPad2 to see that eMMC prob=
ably
> just is not a good solution to use in the first place. =A0We have mea=
sured
> Apple's iPad2 write performance on *WHAT A USER WOULD SEE* being doub=
le what
> we see with products using eMMC solutions. The big difference? =A0App=
le
> doesn't use eMMC at all for the iPad2.

Thanks for all the clarification.  The problem is I am seeing write
speeds of about 5MBps on a Sandisk eMMC product and I can clearly see
the time lost when measured between sending a command and receiving a
data irq.  I am not sure what kind of an issue this is.  5MBps feels
really slow but can the internal housekeeping of the card take so much
time? I mean, for the usual transfers it takes about 3ms to transfer
64kB of data, but for the 63rd and 64th transfers, it takes 250 ms.
The thing is this is not on a file system.  I am measuring the speed
using basic "dd" command to write directly to the block device.

> So, is this a software issue? or if
>>
>> there is a way to increase the size of bounce buffers to 4MB?
>>
>
>
>
>>> Yours,
>>> Linus Walleij
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
