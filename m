From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: slow eMMC write speed
Date: Thu, 29 Sep 2011 09:24:40 +0200
Message-ID: <CACRpkdYdrfhFSfLh=Zgjox60KbYCqN+n_WdOaP2sv_mhai+iig@mail.gmail.com>
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
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64420 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab1I2HYm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2011 03:24:42 -0400
Received: by yxl31 with SMTP id 31so345440yxl.19
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2011 00:24:41 -0700 (PDT)
In-Reply-To: <4E839302.5020001@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: J Freyensee <james_p_freyensee@linux.intel.com>
Cc: Praveen G K <praveen.gk@gmail.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>

On Wed, Sep 28, 2011 at 11:34 PM, J Freyensee
<james_p_freyensee@linux.intel.com> wrote:

> Now in the 3.0 kernel I know mmc_wait_for_req() has changed and the g=
oal was
> to try and make that function a bit more non-blocking,

What has been done by Per F=F6rlin is to add pre_req/post_req hooks
for the datapath. This will improve data transfers in general if and
only if the driver can do some meaningful work in these hooks, so
your driver needs to be patched to use these.

Per patched a few select drivers to prepare the DMA buffers
at this time. In our case (mmci.c) dma_map_sg() can be done in
parallel with an ongoing transfer.

In our case (ux500, mmci, dma40) we don't have bounce buffers
so the only thing that will happen in parallel with ongoing transfers
is L2 and L1 cache flush. *still* we see a noticeable improvement in
throughput, most in L2, but even on the U300 which only does L1
cache I see some small improvements.

I *guess* if you're using bounce buffers, the gain will be even
more pronounced.

(Per, correct me if I'm wrong on any of this...)

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

There are two issues IIRC:

- The block layer does not provide enough buffers at a time for
  the out-of-order buffer pre/post preps to make effect, I think this
  was during writes only (Per, can you elaborate?)

- Anything related to card geometries and special sectors and
  sector sizes etc, i.e. the stuff that Arnd has analyzed in detail,
  also Tixy looked into that for some cards IIRC.

Each needs to be adressed and is currently "to be done".

> The other fundamental problem is the writes themselves. =A0Way, WAY m=
ore
> writes occur on a handheld system in an end-user's hands than reads.
> Fundamental computer principle states "you make the common case fast"=
=2E So
> focus should be on how to complete a write operation the fastest way
> possible.

=46irst case above I think, yep it needs looking into...

Yours,
Linus Walleij
