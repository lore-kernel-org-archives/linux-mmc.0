From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: Support non-power-of-two block sizes for
	ux500v2 variant
Date: Mon, 26 Nov 2012 10:27:12 +0000
Message-ID: <20121126102712.GC19440@n2100.arm.linux.org.uk>
References: <1350050522-8852-1-git-send-email-ulf.hansson@stericsson.com> <20121121153811.GN3290@n2100.arm.linux.org.uk> <CAFEEs1kzJUgsvnzgWwU4i7o1jkE=8iTq5+NJ_t1jdiHEm7b-RQ@mail.gmail.com> <20121121165048.GO3290@n2100.arm.linux.org.uk> <CAFEEs1nb+UD+8_jsKvGKhyFqGDogN5wsmV30PnELqahTMDyRVA@mail.gmail.com> <20121122173708.GJ5764@n2100.arm.linux.org.uk> <50B34270.7070403@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50632 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab2KZK21 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Nov 2012 05:28:27 -0500
Content-Disposition: inline
In-Reply-To: <50B34270.7070403@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per =?iso-8859-1?Q?F=F6rlin?= <per.forlin@stericsson.com>
Cc: Per Forlin <per.lkml@gmail.com>, Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Mon, Nov 26, 2012 at 11:20:32AM +0100, Per F=F6rlin wrote:
> On 11/22/2012 06:37 PM, Russell King - ARM Linux wrote:
> > On Thu, Nov 22, 2012 at 06:28:30PM +0100, Per Forlin wrote:
> >> On Wed, Nov 21, 2012 at 5:50 PM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >>> On Wed, Nov 21, 2012 at 05:13:55PM +0100, Per Forlin wrote:
> >>>> On Wed, Nov 21, 2012 at 4:38 PM, Russell King - ARM Linux
> >>>> <linux@arm.linux.org.uk> wrote:
> >>>>> On Fri, Oct 12, 2012 at 04:02:02PM +0200, Ulf Hansson wrote:
> >>>>>>  /*
> >>>>>> + * Validate mmc prerequisites
> >>>>>> + */
> >>>>>> +static int mmci_validate_data(struct mmci_host *host,
> >>>>>> +                           struct mmc_data *data)
> >>>>>> +{
> >>>>>> +     if (!data)
> >>>>>> +             return 0;
> >>>>>> +
> >>>>>> +     if (!host->variant->non_power_of_2_blksize &&
> >>>>>> +         !is_power_of_2(data->blksz)) {
> >>>>>> +             dev_err(mmc_dev(host->mmc),
> >>>>>> +                     "unsupported block size (%d bytes)\n", d=
ata->blksz);
> >>>>>> +             return -EINVAL;
> >>>>>> +     }
> >>>>>> +
> >>>>>> +     if (data->sg->offset & 3) {
> >>>>>> +             dev_err(mmc_dev(host->mmc),
> >>>>>> +                     "unsupported alginment (0x%x)\n", data->=
sg->offset);
> >>>>>> +             return -EINVAL;
> >>>>>> +     }
> >>>>>
> >>>>> Why?  What's the reasoning behind this suddenly introduced rest=
riction?
> >>>>> readsl()/writesl() copes just fine with non-aligned pointers.  =
It may be
> >>>>> that your DMA engine can not, but that's no business interferin=
g with
> >>>>> non-DMA transfers, and no reason to fail such transfers.
> >>>>>
> >>>>> If your DMA engine can't do that then its your DMA engine code =
which
> >>>>> should refuse to prepare the transfer.
> >>>>>
> >>>>> Yes, that means problems with the way things are ordered - or i=
t needs a
> >>>>> proper API where DMA engine can export these kinds of propertie=
s.
> >>>> The alignment constraint is related to PIO, sg_miter and that FI=
=46O
> >>>> access must be done with 4 bytes.
> >>>
> >>> Total claptrap.  No it isn't.
> >>>
> >>> - sg_miter just deals with bytes, and number of bytes transferred=
; there
> >>>   is no word assumptions in that code.  Indeed many ATA disks tra=
nsfer
> >>>   by half-word accesses so such a restriction would be insane.
> >>>
> >>> - the FIFO access itself needs to be 32-bit words, so readsl or w=
ritesl
> >>>   (or their io* equivalents must be used).
> >>>
> >>> - but - and this is the killer item to your argument as I said ab=
ove -
> >>>   readsl and writesl _can_ take misaligned pointers and cope with=
 them
> >>>   fine.
> >>>
> >>> The actual alignment of the buffer address is totally irrelevant =
here.
> >>>
> >>> What isn't irrelevant is the _number_ of bytes to be transferred,=
 but
> >>> that's something totally different and completely unrelated from
> >>> data->sg->offset.
> >> Let's try again :)
> >>
> >> Keep in mind that the mmc -block layer is aligned so from that asp=
ect
> >> everything is fine.
> >> SDIO may have any length or alignment but sg-len is always 1.
> >>
> >> There is just one sg-element and one continues buffer.
> >>
> >> sg-miter splits the continues buffer in chunks that may not be ali=
gned
> >> with 4 byte size. It depends on the start address alignment of the
> >> buffer.
> >>
> >> Is it more clear now?
> >=20
> > Is this more clear: you may be passed a single buffer which is misa=
ligned.
> > We cope with that just fine.  There is *no* reason to reject that t=
ransfer
> > because readsl/writesl cope just fine with it.
> >=20
> The MMCI driver doesn't support alignment smaller than 4 bytes (it ma=
y
> result in data corruption).

Explain yourself.  That's what's lacking here.  I'm explaining why I
think you're wrong, but you're just asserting all the time that I'm
wrong without giving any real details.

> There are two options
> 1. Either one should fix the driver to support it. Currently the driv=
er
> only supports miss-alignment of the last sg-miter buffer.
> 2. Or be kind to inform the user that the alignment is not supported.

Look, it's very very simple.

If you have a multi-sg transfer, and the pointer starts off being
misaligned, the first transfer to the end of the page _MAY_ be a
non-word aligned number of bytes.  _THAT_ is what you should be checkin=
g.
_THAT_ is what the limitation is in the driver.  _NOT_ that the pointer
is misaligned.

