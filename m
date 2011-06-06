From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/3] dmaengine: add new dma API for max_segment_number
Date: Mon, 6 Jun 2011 11:48:56 -0700
Message-ID: <BANLkTin7mqqTsosPHbztaPfL7s_TUGT1qg@mail.gmail.com>
References: <20110606091410.GB10508@n2100.arm.linux.org.uk>
	<20110606183925D.fujita.tomonori@lab.ntt.co.jp>
	<20110606094751.GC10508@n2100.arm.linux.org.uk>
	<20110606191041U.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38887 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab1FFSs6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jun 2011 14:48:58 -0400
In-Reply-To: <20110606191041U.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux@arm.linux.org.uk, cjb@laptop.org, patches@linaro.org, vinod.koul@intel.com, gregkh@suse.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org

On Mon, Jun 6, 2011 at 3:12 AM, FUJITA Tomonori
<fujita.tomonori@lab.ntt.co.jp> wrote:
> On Mon, 6 Jun 2011 10:47:51 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>
>> On Mon, Jun 06, 2011 at 06:41:09PM +0900, FUJITA Tomonori wrote:
>> > On Mon, 6 Jun 2011 10:14:10 +0100
>> > Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> >
>> > > On Mon, Jun 06, 2011 at 05:06:03PM +0900, FUJITA Tomonori wrote:
>> > > > max_segs isn't unrelated with the dma mapping API. I explained=
 above,
>> > > > IOMMUs doesn't increase the number of segments (could decrease=
 the
>> > > > number of segments by merging).
>> > > >
>> > > > The limitation about the number of segment already lives elsew=
here
>> > > > (e.g. queue's limits.max_segments).
>> > >
>> > > I think you're missing the point entirely.
>> > >
>> > > Lets take the problem at hand: you have two devices. =A0One of t=
hem is
>> > > handled by the DMA engine code. =A0One of them is a block device=
=2E
>> > >
>> > > The block layer needs to know the various parameters of what is
>> > > allowable for DMA, including such things as the maximum size of =
a
>> > > segment, and the _number_ of segments that can be placed into an=
y
>> > > one request.
>> > >
>> > > As the DMA provider is _entirely_ separate and unknown to the bl=
ock
>> > > device driver, the block device driver has no way to sanely prov=
ide
>> > > these parameters to the block layer - they are not a property of=
 the
>> > > block device driver, but of the DMA provider.
>> >
>> > struct device_dma_parameters is used for a property of the block
>> > device drivers (and scsi HBA drivers, etc). Not DMA provider. Righ=
t?
>>
>> Wrong. =A0struct device_dma_parameters is a property of the _DMA_ _p=
rovider_.
>> It has to be. =A0Read what I said above and think about it.
>
> I think that it's up to your definition of DMA provider.
>
>> In many cases, it so happens that the DMA provider and the block dev=
ice
>> driver are the same entity, and so it may appear that device_dma_par=
ameters
>
> But could be the different entities, right? If so, the value should b=
e
> smaller one? Who is responsible for setting the correct value? The
> proposed API blindly set the value (just overwrite). The API would be
> better to set a new value only when the new value is smaller? Or
> having a separate structure and selecting the smallest value?
>
> struct device_dma_parameters assumes that the DMA provider and the
> block (and SCSI, etc) device driver are the same entity.
>
>> is a property of the block device driver. =A0As soon as you have to =
start
>> dealing with DMA providers being separate from the block device driv=
er
>> then your eyes will be opened and you'll see that it can't work the =
way
>> you seem to want it to.
>>
>> The DMA parameters have to come from the DMA provider or they're a t=
otal
>> nonsense.
>
> I don't think that I claim that the DMA parameters don't come from th=
e
> DMA provider. It depends on the definition of the DMA provider,
> though.

dmaengine expands the class of dma providers to include standalone dma
agents on a host bus (or elsewhere) in addition to the traditional bus
mastering host-bus-adapters that the existing api understands.  So in
the case of slave dma the dma capabilities of the block-device are
irrelevant because another agent will do the transfer on behalf of the
block-device driver.  So the value should be whatever the dma device
driver says it is.

--
Dan
