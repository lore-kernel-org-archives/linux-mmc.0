From: Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] mmc: sd: Meet alignment requirements for raw_ssr DMA
Date: Thu, 17 Nov 2016 13:19:02 +0000
Message-ID: <3676563.EjIzX52DqA@np-p-burton>
References: <20161111142236.8270-1-paul.burton@imgtec.com> <CAPDyKFqNNP-M37_ieq2na0agsQvh8oyv=nWdSsW2nQDw+zB9WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3544831.2MXeGp1UeY";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:58106 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941690AbcKQSKE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2016 13:10:04 -0500
In-Reply-To: <CAPDyKFqNNP-M37_ieq2na0agsQvh8oyv=nWdSsW2nQDw+zB9WA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

--nextPart3544831.2MXeGp1UeY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Ulf,

On Thursday, 17 November 2016 13:51:02 GMT Ulf Hansson wrote:
> On 11 November 2016 at 15:22, Paul Burton <paul.burton@imgtec.com> wrote:
> > The mmc_read_ssr() function results in DMA to the raw_ssr member of
> > struct mmc_card, which is not guaranteed to be cache line aligned & thus
> > 
> > might not meet the requirements set out in Documentation/DMA-API.txt:
> >   Warnings:  Memory coherency operates at a granularity called the cache
> >   line width.  In order for memory mapped by this API to operate
> >   correctly, the mapped region must begin exactly on a cache line
> >   boundary and end exactly on one (to prevent two separately mapped
> >   regions from sharing a single cache line).  Since the cache line size
> >   may not be known at compile time, the API will not enforce this
> >   requirement.  Therefore, it is recommended that driver writers who
> >   don't take special care to determine the cache line size at run time
> >   only map virtual regions that begin and end on page boundaries (which
> >   are guaranteed also to be cache line boundaries).
> 
> This about virtual regions, not about physical contiguous allocated
> memories, such as those you get via kmalloc(n, GFP_KERNEL). Right?

This is about memory being cache-line aligned. Since the mapping from virtual
to physical operates on pages, which will always be some multiple of a cache
line size, it doesn't matter whether we're talking about virtual or physical
addresses (& it's a good job because semantics get awkward between
architectures - from my MIPS perspective I'd say kmalloc returns a virtual
address).

This has nothing to do with the memory mapped for DMA being physically
contiguous (which as you say, it typically needs to be), it has to do with how
it is kept coherent with caches that the device performing DMA has no
knowledge of or access to.

> 
> > On some systems where DMA is non-coherent this can lead to us losing
> > data that shares cache lines with the raw_ssr array.
> > 
> > Fix this by kmalloc'ing a temporary buffer to perform DMA into. kmalloc
> > will ensure the buffer is suitably aligned, allowing the DMA to be
> > performed without any loss of data.
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: linux-mmc@vger.kernel.org
> > ---
> > 
> >  drivers/mmc/core/sd.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index 73c762a..f6f40a1 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -223,6 +223,7 @@ static int mmc_decode_scr(struct mmc_card *card)
> > 
> >  static int mmc_read_ssr(struct mmc_card *card)
> >  {
> >  
> >         unsigned int au, es, et, eo;
> > 
> > +       u32 *raw_ssr;
> > 
> >         int i;
> >         
> >         if (!(card->csd.cmdclass & CCC_APP_SPEC)) {
> > 
> > @@ -231,14 +232,21 @@ static int mmc_read_ssr(struct mmc_card *card)
> > 
> >                 return 0;
> >         
> >         }
> > 
> > -       if (mmc_app_sd_status(card, card->raw_ssr)) {
> 
> So the struct mmc_card, which contains "u32 raw_ssr[16]", is already
> allocated via using a kzalloc().
> As kzalloc() returns a physically contiguous allocated memory, using
> DMA for reading the data into the memory pointed to by card->raw_ssr
> should be safe.
> 
> Unless I am missing something, of course.

Sadly you are. This is incorrect because the raw_ssr field of struct mmc_card
may not begin or end at a cache-line boundary. On systems where mapping a
buffer for DMA requires cache invalidation we may therefore lose data if it
shares a cache line with some other data. In this case let's say we have
something like this:

0x1000: u32 raw_scr[2];
0x1008: u32 raw_ssr[16];

Now let's say we have 16 byte cache lines and we try to map raw_ssr for DMA.
If the architecture requires that we invalidate the memory being mapped in
caches (in order to avoid any writebacks clobbering the DMA'd data) then we
have a problem because our choice is either to:

- Writeback the line that overlaps with raw_scr, then invalidate it along with
  the rest of the cache lines covering raw_ssr. This won't do because there's
  nothing stopping us from pulling the line back into the cache whilst the DMA
  occurs on some systems - say we access raw_scr whilst the DMA to raw_ssr
  happens or the CPU just speculatively prefetches something. The DMA API
  cannot detect the former & would have no way to deal with it if it could,
  and on systems where the latter is possible we have no choice but to
  invalidate the cache lines again after the DMA is complete. What would we do
  with the first line then? We can't write it back to preserve raw_scr because
  it includes some potentially stale copy of the start of raw_ssr, which we
  would then clobber the DMA'd data with.

- Or, we just invalidate the line which overlaps with raw_scr. We can't do
  this because we might throw away some part of raw_scr.

So we have no choice but to align the buffers used for DMA at a cache line
boundary. This is what the paragraph in Documentation/DMA-API.txt is about &
the MMC code currently fails to meet the requirements it sets out. Allocating
the buffer to be DMA'd to with kmalloc will meet that alignment requirement.
One possible alternative would be to ensure that the raw_ssr field of struct
mmc_card is always aligned at an ARCH_DMA_MINALIGN boundary within the struct,
with nothing after it until another ARCH_DMA_MINALIGN boundary. That seems
like it'd be a bit messy though, and probably easy for someone to break.

Of course when a system has DMA that is coherent with caches there's generally
no need to worry about any of this, but users of the DMA API generally can't
rely on that, again as Documentation/DMA-API.txt says. Any buffers mapped for
DMA should be ensured to be cache-line aligned at minimum giving the
architecture code backing the DMA API a chance to do the right thing for the
given system.

Thanks,
    Paul

> 
> > +       raw_ssr = kmalloc(sizeof(card->raw_ssr), GFP_KERNEL);
> > +       if (!raw_ssr)
> > +               return -ENOMEM;
> > +
> > +       if (mmc_app_sd_status(card, raw_ssr)) {
> > 
> >                 pr_warn("%s: problem reading SD Status register\n",
> >                 
> >                         mmc_hostname(card->host));
> > 
> > +               kfree(raw_ssr);
> > 
> >                 return 0;
> >         
> >         }
> >         
> >         for (i = 0; i < 16; i++)
> > 
> > -               card->raw_ssr[i] = be32_to_cpu(card->raw_ssr[i]);
> > +               card->raw_ssr[i] = be32_to_cpu(raw_ssr[i]);
> > +
> > +       kfree(raw_ssr);
> > 
> >         /*
> >         
> >          * UNSTUFF_BITS only works with four u32s so we have to offset the
> > 
> > --
> > 2.10.2
> 
> Kind regards
> Uffe


--nextPart3544831.2MXeGp1UeY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYLa5GAAoJEIIg2fppPBxlcxgP/jgE+21j0WtffsiCek2N4Nuy
DB+Sh/5n+EU4HLT4ufnh+TTD0OdZeeyTvrnIfHb/oNEi4dWgJApcMbpfU7hJSfF+
hasuoUpvR7b4+shA5X9BSf2OPf6UWoWcDdCMs3x93rwsAnn0568V5/AWtJhZREUH
Fmhq1x69Dj8iu7vWx900Ftxas38yFwkBqUsKNZCvPXc/RmC0WKZ77sxfrg6nCVX6
SMn4hH5gFSjLEgo3F2BBRTeulY8DQUBjtz1APDoOBHdHBKjgIeHUo7+MkqJSQCto
B0vhSJ20ZNjFORPT0FUfsFelLuaaGM1t0Xv1Rve3t3C8QH2j8nUBgYXvc9DjL+zj
yBdyFzgW59zNY5veUCLkafSQu4DHVLIih9ekV9yh3qc9vLa1kaJ/qwj1hmzekgK3
niSLNArggqWsQDWM+4yFOpvGFqtVNe4i+ALSBttWXRsrMg1s2vcT+7cEMaf8ZPKz
rTSxv2XYNNyLo9hAWbZZGmrFojq8xDtfF733hfHqWl3Q76jGl/kD23M/SwtWXXBW
vTni59IX5oDYmq46n7oZ1pNPaxd4iFPfuxsqazb/7pk6YcVgIib9Isk6r9MRwX7G
Z57NfCtfVu+/K71ZCexqS8dJJd7BF0Tgv8TS+BKD3jyhPu5cNVqSt037tefPPDx8
ei7cZAVfnwFOtfk1gYP+
=rFmt
-----END PGP SIGNATURE-----

--nextPart3544831.2MXeGp1UeY--
