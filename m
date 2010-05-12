From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/7] DMAENGINE: add generic PrimeCell interface to COH 901
	318 v6
Date: Wed, 12 May 2010 11:35:21 -0700
Message-ID: <AANLkTilwcXmNjiuosbmaBudH965dNg3C7VIwlxNWkbzd@mail.gmail.com>
References: <1272848076-28315-1-git-send-email-linus.walleij@stericsson.com>
	 <AANLkTinAVhnpjgVTtbZYYKb1t_DInVwTKkkJRzcO97RX@mail.gmail.com>
	 <AANLkTim7Tp8lCwMbQwW5QiQ49j7idFFUWdU3x8azIlok@mail.gmail.com>
	 <CEE6BB42CAD6E947908279175AF8470A025A6DE803@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60475 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692Ab0ELSfW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 May 2010 14:35:22 -0400
In-Reply-To: <CEE6BB42CAD6E947908279175AF8470A025A6DE803@EXDCVYMBSTM006.EQ1STM.local>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus WALLEIJ <linus.walleij@stericsson.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, May 12, 2010 at 12:39 AM, Linus WALLEIJ
<linus.walleij@stericsson.com> wrote:
> [Dan]
>
>> >> +void dma_set_ambaconfig(struct dma_chan *chan,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct amba_dma_cha=
nnel_config *config)
>> >
>> > What happens when two primecell dma devices are present on one soc=
?
>> > Can that happen? =A0In that case we'll have conflicting providers =
of
>> > dma_set_ambaconfig().
>> >
>>
>> ...the ->device_control() method is already approaching an ioctl()
>> let's just add the argument parameter to complete the capability,
>> i.e.:
>>
>> int (*device_control)(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
>> unsigned long arg);
>
> So the unsigned long arg is to match an ioctl? Okidoki...
>
> If it was only for in-kernel use a void* would be preferred
> I believe since assuming unsigned long to be =3D=3D bus width
> is ... well, disturbing, since we'll be casting this into
> a struct pointer.

It's safe to assume that Linux does not run on any architecture where
sizeof(unsigned long) < sizeof(void *).

> So this should also be used for the AMBA configuration stuff
> then, so I have to make first a patch to convert all the
> device_control functions and then a patch on top of that to
> implement the AMBA call as a device_control() thingie?
>
> (Should work out...)
>
> Just a bit of work, so will take some more hours :-)

Apologies for not discovering this earlier in the review process, but
it gets rid of the last bit of 'specialness' of the Primecell api and
I can see it allowing other weird commands to be implemented
generically down the road.  Just let me know if you want to run any
compile tests for you.

> I will just have to make a proof-of-concept for the AMBA config
> interface for Russell first, then I'll be on the ioctl-like API.

Ok, I really appreciate your patience, I'll see what I can do to push
this post-rc1 if things turn out that way.

Regards,
Dan
