From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 3/6] mmc: tmio: convert the SDHI MMC driver from MFD to a
 standard platform driver
Date: Tue, 15 Mar 2011 18:09:10 +0900
Message-ID: <AANLkTimgNYbz973XLoQhKEQ9W+8mhAOnG3_OHxnGvGwf@mail.gmail.com>
References: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
	<Pine.LNX.4.64.1103110846000.23675@axis700.grange>
	<AANLkTi=ywRE0omJ1t0yxqzMS4k+PpjfFH7aLtWMW7C=3@mail.gmail.com>
	<Pine.LNX.4.64.1103140857350.6125@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51899 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab1COJJL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2011 05:09:11 -0400
In-Reply-To: <Pine.LNX.4.64.1103140857350.6125@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

On Mon, Mar 14, 2011 at 5:01 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Sun, 13 Mar 2011, Magnus Damm wrote:
>> On Fri, Mar 11, 2011 at 4:52 PM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > On sh-mobile platforms the SDHI driver was using the tmio_mmc SD/S=
DIO
>> > MFD cell driver. Now that the tmio_mmc driver has been split into =
a
>> > core and a separate MFD glue, we can support SDHI natively without=
 the
>> > need to emulate an MFD controller. This also allows to support sys=
tems
>> > with an on-SoC SDHI controller and a separate MFD with a TMIO core=
=2E
>> >
>> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> > ---
>>
>> Nice, I believe this is the right direction..
>>
>> > --- a/drivers/mmc/host/tmio_mmc.h
>> > +++ b/drivers/mmc/host/tmio_mmc.h
>> > @@ -92,7 +92,7 @@ struct tmio_mmc_host {
>> > =A0 =A0 =A0 =A0struct tasklet_struct =A0 dma_complete;
>> > =A0 =A0 =A0 =A0struct tasklet_struct =A0 dma_issue;
>> > =A0 =A0 =A0 =A0struct scatterlist =A0 =A0 =A0bounce_sg;
>> > -#ifdef CONFIG_TMIO_MMC_DMA
>> > +#if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
>> > =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bounc=
e_buf[PAGE_CACHE_SIZE] __attribute__((aligned(TMIO_MAX_ALIGN)));
>> > =A0#else
>> > =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bounc=
e_buf[1]; =A0/* A dummy in no-DMA case */
>>
>> ... but it would be nice if all this #ifdeffery could be avoided som=
ehow.
>>
>> Is it possible to use devres to allocate the bounce buffer dynamical=
ly
>> in the dma portion of the code?
>
> Well, this #ifdef has been there before, it's not new. But sure, we c=
ould
> get rid of it. Basically, what you're suggesting, is to allocate that
> bounce buffer dynamically - whether or not using devres. Just calling
> __get_free_page() in tmio_mmc_request_dma() and __free_pages() in
> tmio_mmc_release_dma() should work without any memory-leaking too. Wo=
uld
> this be ok?

Yes, tmio_mmc_request_dma() and tmio_mmc_free_dma() happen very
infrequently so that seems like a very good location for dynamic
allocation / free of the bounce buffer. Thanks!

/ magnus
