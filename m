From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 0/7] DMAENGINE: fixes and PrimeCells
Date: Sun, 9 May 2010 12:48:16 +0900
Message-ID: <l2j1b68c6791005082048j5deaf863g2887c968ff841f2f@mail.gmail.com>
References: <1272848060-28049-1-git-send-email-linus.walleij@stericsson.com>
	 <i2t63386a3d1005070213u2ad32613w694be1ecbeb46856@mail.gmail.com>
	 <20100507093256.GB19936@n2100.arm.linux.org.uk>
	 <x2j63386a3d1005070443yfadbaf3ct8686a8f7aae6412f@mail.gmail.com>
	 <j2r1b68c6791005070531u57b4b1basc56d45d0e06b1d04@mail.gmail.com>
	 <k2k63386a3d1005070910kcdb516dcga60c24043b1b44de@mail.gmail.com>
	 <m2u1b68c6791005071937s5b2bbb60p6de395a6c06a963e@mail.gmail.com>
	 <w2re9c3a7c21005081524z2a52a078nad8d316553dfde80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36022 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab0EIDsR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 8 May 2010 23:48:17 -0400
In-Reply-To: <w2re9c3a7c21005081524z2a52a078nad8d316553dfde80@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, May 9, 2010 at 7:24 AM, Dan Williams <dan.j.williams@intel.com>=
 wrote:
> On Fri, May 7, 2010 at 7:37 PM, jassi brar <jassisinghbrar@gmail.com>=
 wrote:
>> =C2=A0IMHO, a DMA api should be as quick as possible - callbacks don=
e in IRQ context.
>> =C2=A0But since there maybe clients that need to do sleepable stuff =
in
>
> None of the current clients sleep in the callback, it's done in
> soft-irq context. =C2=A0The only expectation is that hard-irqs are en=
abled
> during the callback just like timer callbacks. =C2=A0I also would lik=
e to
> see numbers to quantify the claims of slowness.
The clients evolve around the API so they don't do what the API doesn't
allow. Any API should try to put as least contraints as possible - you =
never
know what kinda clients are gonna arise.
Lets say a protocol requires 'quick' ACK(within few usecs) on control b=
us after
xfer'ing a large packet on data bus. All the client needs is to be
able to toggle
some bit of the device controller after the DMA done, which can very we=
ll be
done in IRQ context but maybe too late if the callback is done from a t=
asklet
scheduled from DMAC ISR.
The point being, a DMA API should be able to do callbacks from the IRQ =
context
too. That is, assuming the clients know what they do.

Also, I think it is possible to have an API that allows request submiss=
ion from
callbacks, which will be a very useful feature.
Of course, assuming the clients know what they can/can't do (just like =
current
DMA API or any other API).


>> callbacks, the API
>> =C2=A0may do two callbacks - 'quick' in irq context and 'lazy' from
>> tasklets scheduled from
>> =C2=A0the IRQ. Most clients will provide either, while some may prov=
ide
>> both callback functions.
>>
>> b) There seems to be no clear way of reporting failed transfers. The
>> device_tx_status
>> =C2=A0 =C2=A0can get FAIL/SUCSESS but the call is open ended and can=
 be performed
>> =C2=A0 =C2=A0without any time bound after tx_submit. It is not very =
optimal for
>> DMAC drivers
>> =C2=A0 =C2=A0to save descriptors of all failed transactions until th=
e channel
>> is released.
>> =C2=A0 =C2=A0IMHO, provision of status checking by two mechanisms: c=
ookie and dma-done
>> =C2=A0 callbacks is complication more than a feature. Perhaps the dm=
a
>> engine could provide
>> =C2=A0 a default callback, should the client doesn't do so, and trac=
k
>> done/pending xfers
>> =C2=A0for such requests?
>
> I agree the error handling was designed around mem-to-mem assumptions
> where failures are due to double-bit ECC errors and other rare events=
=2E
well, neither have I ever seen DMA failure, but a good API shouldn't co=
unt
upon h/w perfection.


>> c) Conceptually, the channels are tightly coupled with the DMACs,
>> there seems to be
>> =C2=A0 no way to be able to schedule a channel among more than one D=
MACs
>> in the runtime,
>> =C2=A0 that is if more then one DMAC support the same channel/periph=
eral.
>> =C2=A0 For example, Samsung's S5Pxxxx have many channels available o=
n more
>> than 1 DMAC
>> =C2=A0 but for this dma api we have to statically assign channels to
>> DMACs, which may result in
>> =C2=A0 a channel acquire request rejected just because the DMAC we c=
hose
>> for it is already
>> =C2=A0 fully busy while another DMAC, which also supports the channe=
l, is idling.
>> =C2=A0 Unless we treat the same peripheral as, say, I2STX_viaDMAC1 a=
nd
>> I2STX_viaDMAC2
>> =C2=A0 and allocate double resources for these "mutually exclusive" =
channels.
>
> I am not understanding this example. =C2=A0If both DMACs are register=
ed the
> dma_filter function to dma_request_channel() can select between them,
> right?
Let me be precise. I2S_Tx fifo(I2S peripheral/channel) can be be reache=
d
by two DMACs but, of course, the channel can only be active with
exactly one DMAC.
So, it is desirable to be able to reach the peripheral via second DMAC =
should
the first one is too busy to handle the request. Clearly this is a
runtime decision.
=46WIHS, I can associate the channel with either of the DMACs and if th=
at DMAC
can't handle the I2S_Tx request (say due to its all h/w threads
allocated to other
request), I can't play audio even if the DMAC might be simply idling.


>>
>> d) Something like circular-linked-request is highly desirable for on=
e
>> of the important DMA
>> =C2=A0 clients i.e, audio.
>
> Is this a standing dma chain that periodically a client will say "go"
> to re-run those operations? =C2=A0Please enlighten me, I've never pla=
yed
> with audio drivers.
Yes, quite similar. Only alsa drivers will say "go" just once at playba=
ck start
and the submitted xfer requests(called periods) are repeatedly transfer=
ed in
circular manner.
Just a quick snd_pcm_period_elapsed is called in dma-done callback for
each request(which are usually the same length).
That way, the client neither have to re-submit requests nor need to do =
sleepable
stuff(allocating memory for new reqs and managing local state machine)
The minimum period size depends on audio latency, which depends on the
ability to do dma-done callbacks asap.
This is another example, where the clients wud benefit from callback fr=
om IRQ
context which is also perfectly safe.

>> e) There seems to be no ScatterGather support for Mem to Mem transfe=
rs.
>
> There has never been a use case, what did you have in mind. =C2=A0If
> multiple prep_memcpy commands is too inefficient we could always add
> another operation.
Just that I believe any API should be as exhaustive and generic as poss=
ible.
I see it possible for multimedia devices/drivers to evolve to start nee=
ding
such capabilities.
Also, the way DMA API treats memcpy/memset and assume SG reqs to be
equivalent to MEM<=3D>DEV request is not very impressive.
IMHO, any submitted request should be a list of xfers. And an xfer is a
'memset' with 'src_len' bytes from 'src_addr' to be copied 'n' times
at 'dst_addr'.
Memcpy is just a special case of memset, where n :=3D 1
This covers most possible use cases while being more compact and future=
-proof.
