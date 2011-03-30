From: NamJae Jeon <linkinjeon@gmail.com>
Subject: Re: About mmc delayed workqueue.
Date: Wed, 30 Mar 2011 09:40:43 +0900
Message-ID: <AANLkTik8Cymp9GDg9hFwmZuoZ9XySqUL9A7t3k1nM5UM@mail.gmail.com>
References: <AANLkTikB-g44H80hLsrBUcJ4svOZAXisBvFvno4uqKm+@mail.gmail.com>
	<20110329233459.GI27290@trinity.fluff.org>
	<m3sju58pap.fsf@pullcord.laptop.org>
	<AANLkTi=5R9w0k_Hg=htyDc=aQDA+t1HOLvWtfAOvMo+z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51753 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295Ab1C3Ako convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2011 20:40:44 -0400
Received: by wwa36 with SMTP id 36so852694wwa.1
        for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2011 17:40:43 -0700 (PDT)
In-Reply-To: <AANLkTi=5R9w0k_Hg=htyDc=aQDA+t1HOLvWtfAOvMo+z@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Dear. Chris, Ben.

Thanks for your reply.

As you know, booting time is important factor in embededd device.

If rootdelay is set to 5, kernel will be waiting for 5 sec. root_wait
is also looping per 100ms.

I have a question. Why is  mmc using delayed workqueue ?

Thanks.


> 2011/3/30 Chris Ball <cjb@laptop.org>:
>> Hi,
>>
>> On Tue, Mar 29 2011, Ben Dooks wrote:
>>> On Wed, Mar 30, 2011 at 08:33:12AM +0900, NamJae Jeon wrote:
>>>> Hi. Chris.
>>>>
>>>> I found some problem in mmc driver. =A0As you know, in nand trend,=
 emmc
>>>> nand is used =A0booting device in embededd product.
>>>
>>> yeah, a really nasty trend if you ask me.
>>>
>>>> It means that kernel, rootfs image is stored in emmc nand device. =
and
>>>> when rescaning mmc, mmc driver is working by delay work queue.
>>>>
>>>> It can be cause "can not mount rootfs". =A0If =A0kernel mounting i=
s faster
>>>> than mmc rescan, this problem would occur..
>>>>
>>>> I changed to schedule_work instead of mmc_schedule_delayed_work. I=
 can
>>>> make patch & test.
>>>>
>>>> could you tell me your opinion ?
>>>
>>> Use root_wait on the commandline and it will wait for the root devi=
ce
>>> to become reayd.
>>
>> Ben's right that you should use "rootwait" (I don't think it works w=
ith
>> the underscore in the middle), rootdelay=3D5 if you want the boot to=
 fail
>> if the partition isn't mounted after a little extra time, or an init=
rd
>> if you want full control over rootfs mounting.
>>
>> These parameters are documented in Documentation/kernel-parameters.t=
xt.
>>
>> Thanks,
>>
>> - Chris.
>> --
>> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
>> One Laptop Per Child
>>
>
