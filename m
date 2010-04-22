From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 2/8] SH: add DMA slave IDs for two SDHI controllers, add
	slaves to sh7722
Date: Thu, 22 Apr 2010 16:05:35 +0900
Message-ID: <n2saec7e5c31004220005w331e3a0el4ef829558a74b132@mail.gmail.com>
References: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
	 <Pine.LNX.4.64.1004211732340.5292@axis700.grange>
	 <j2xaec7e5c31004211702v9ba71743jedd24562f8dea0a5@mail.gmail.com>
	 <Pine.LNX.4.64.1004220824200.4655@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1004220824200.4655@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Thu, Apr 22, 2010 at 3:28 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Wed, 21 Apr 2010, Magnus Damm wrote:
>> On Wed, Apr 21, 2010 at 11:36 AM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > SuperH SDHI controllers can use DMA, add slave IDs to the header a=
nd slave
>> > definitions to sh7722.
>> >
>> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> > ---
>> > =A0arch/sh/include/asm/dmaengine.h =A0 =A0 =A0 =A0| =A0 =A04 ++++
>> > =A0arch/sh/kernel/cpu/sh4a/setup-sh7722.c | =A0 10 ++++++++++
>> > =A02 files changed, 14 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/arch/sh/include/asm/dmaengine.h b/arch/sh/include/asm=
/dmaengine.h
>> > index 2a02b61..876e601 100644
>> > --- a/arch/sh/include/asm/dmaengine.h
>> > +++ b/arch/sh/include/asm/dmaengine.h
>> > @@ -29,6 +29,10 @@ enum {
>> > =A0 =A0 =A0 =A0SHDMA_SLAVE_SIUA_RX,
>> > =A0 =A0 =A0 =A0SHDMA_SLAVE_SIUB_TX,
>> > =A0 =A0 =A0 =A0SHDMA_SLAVE_SIUB_RX,
>> > + =A0 =A0 =A0 SHDMA_SLAVE_SDHI0_RX,
>> > + =A0 =A0 =A0 SHDMA_SLAVE_SDHI0_TX,
>> > + =A0 =A0 =A0 SHDMA_SLAVE_SDHI1_RX,
>> > + =A0 =A0 =A0 SHDMA_SLAVE_SDHI1_TX,
>> > =A0};
>> >
>> > =A0#endif
>>
>> Thanks for your work on this. Two SDHIs may be enough for most
>> processor types, but I think the G3 processor actually has three. Wi=
th
>> that in mind, I think it makes more sense to keep the slave ids
>> together with the processor specific bits in for instance
>> arch/sh/include/cpu-sh4/cpu/sh7722.h.
>>
>> If you have time, can you please make a patch that moves the slave i=
ds
>> into the processor specific header files? This on top of the other
>> code in the sh/dmaengine topic branch.
>
> Ok, yes, first, I forgot to mention - this patch series is based on y=
our
> earlier SH dmaengine patches. Secondly - sure, we can move these defi=
nes
> in cpu-specific headers, otoh - why? This is just an enum, it doesn't=
 take
> space in binaries, and having them all together helps uniformity and
> avoids duplication, I think. So, I would just add those SDHI2 macros =
to
> this list. The important thing is, the actual slave definition array =
are
> per-CPU. Which is now the case after your patch series.

Like you say, the actual slave definition array is per processor type.
But the available hardware blocks varies with processor type, and we
already have other processor specific information in the cpu-specific
headers. It does not add any code size, true.

The reasons why I prefer them to be split out are:

1) When someone adds support for a new processor it's easy to
implement the same type of information in the new cpu-specific header
as other processors. Adding and removing things from a global list of
processor blocks in a driver/framework specific header file hidden
somewhere is not going to happen. Also, people usually only focus on
one processor at a time. A long global list is just going to make
people confused. "Why is there a SDHI2 there when I only have SDHI on
my processor?"

2) Having them in a global list adds an unneccesary point of patch
serialization.

3) We keep other things like GPIOs and HWBLK in cpu-specific headers
already, why be special?

4) Having it in a global list may encourage people to include this
header from drivers. Isn't it better to force the drivers to use this
value as a cookie instead? This prevents people from adding hardware
block specific workarounds to the driver that may or may not work on
all processors...

/ magnus
