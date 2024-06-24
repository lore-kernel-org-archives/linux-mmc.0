Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C4A19FA68
	for <linux-mmc@vger.kernel.org>; Mon, 24 Jun 2024 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251281; cv=none; b=LKJPmMbx1fwE8YxiHVJEysfD842QowRHNsdrJlOK7+uQTC7UziUIaJBXtvnupF2lbS8zFFSnw4urpS0GeBMGVg0Ic4Fdklj9rCOp0s+FH2Zxf3+72fqwsAwZy9aTFV6y5A6fXFgmCl2p7HHuV8vA/S4oKy1wT3Zr4e28mPadlCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251281; c=relaxed/simple;
	bh=P1jGE0yj+W9MBcCc+1zGVoDh+/I8AA93BhngLeHVOT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kq34c6s7cbKfaryTGXagWVL/bXCpwbWv1rsD0cq0e5IxXECfo0CMGZuvTRYY2SfX4jgnYI5RTK88VkWFWQP83hHWY9RO014UMJzqRu0UEeM8FYxeoK3AM0bc52BR+XUcuvGeiYoAan0ndMSYU6ogHuo6zCG4CBXMPjHaXbNC1vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=Rh/zq9wI; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Rh/zq9wI"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-df481bf6680so4268299276.3
        for <linux-mmc@vger.kernel.org>; Mon, 24 Jun 2024 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1719251278; x=1719856078; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GD6JszPohU81NGGS/aKdIrLNqexC1KvwW9h5dgcZ2tY=;
        b=Rh/zq9wItMzkrJJuiqb+MSt3M5QW+41ZoEoUXas+4gioNtQwzsK3SIYcxhJL3rNSJF
         TQR2cdKS+zUzwj3x7bxg8YYZQgy0IZRUYpfrLV7OICmCQygCwBS6xzaRXMOXXXi3vaqM
         Mno0Cc1eje/5fGObXUHPsL47Y8mRnsEr+BM28Ev/ZLtr1IUfNcUp2ZXu545AK52TgVE7
         LRYHyTvjwB2wTgh2u814jzx+8/zMGUdJ+05llRDB1UQWuga70Yyi8DzLOKX3A9bnMB34
         yPExxQWM9vRZgxLwjalGzLzmjOPXtQ5liu3j22/c4IZmw/lVmPyGH4Dy4jtaDyzY6fIU
         yEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719251278; x=1719856078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GD6JszPohU81NGGS/aKdIrLNqexC1KvwW9h5dgcZ2tY=;
        b=uUCP6cRO7yrzx8nCNupVsG/bcQmVOQdSCaV3xhNCrW+ureeNH1Abg3NuKcP2gIxX1c
         wTcGb7q/rDjkBGVg6w7gZ2cHdAph9b/4hQCzu7i0rsNsG1zixEu5yXjKXFJB+xD7BXCv
         T/MxZE7HkyLtQAbmF7df6cEEkMHminKh7qYRTuSLOIi/4vLXShRgkspj9IdM0beQ9qcN
         skVEPDYmeaQWAYNQXKoOepEUlMzJvMonUagx0hVwQVHb1g1cIXlic9PLEVqG56HpVpQM
         FKsbjAE7BwHaUWOfRqgINm9dz7bUR4YqXsHvw/3ORvN4fw32tNPxM6HrRAvn488eSddB
         o4Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWXyIkFmQd+Y9/icWt0mJgZDuzkuO9Gb/UbrBtFZragCsXHdpArI3tSFZ2kBxJUyZ7i8caS3Bj5cWTYiw343SnA0ERzQYNX4UzF
X-Gm-Message-State: AOJu0YyuX6TtBBPla9pvvW9VbZZOgTzAztP7Al7Tj3XYS9PSgI6XEdRy
	CC3FSJCBrhPBnooU7QuTMGcWTDWFi5Wnd7+/nSpLBYrjCo8aisfClXXc1l83LRIBcOctNQZreWc
	qVrkVZPpNs8YHkjWs0G0YdFI2nra+ILZOpaO+TA==
X-Google-Smtp-Source: AGHT+IEam62Ke7h6aMEIOfZkOn8q0O/x65GpW/b4zmed/2bsjgtR1QeT3Q2l3hKiUKoRuWDKy+pcqMjQukMAFKYFW9Y=
X-Received: by 2002:a25:291:0:b0:df4:f2d2:fcd6 with SMTP id
 3f1490d57ef6-e0303fe9b62mr4805338276.44.1719251277992; Mon, 24 Jun 2024
 10:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
 <20240524182702.1317935-7-dave.stevenson@raspberrypi.com> <ZmCl7LXbdCwJm/wJ@lizhi-Precision-Tower-5810>
In-Reply-To: <ZmCl7LXbdCwJm/wJ@lizhi-Precision-Tower-5810>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 24 Jun 2024 18:47:41 +0100
Message-ID: <CAPY8ntCUzU=T_RgJPGvunYXM2Zmd39Kei-qFaoM37-Vc62TyUQ@mail.gmail.com>
Subject: Re: [PATCH 06/18] dmaengine: bcm2835: make address increment platform independent
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Vinod Koul <vkoul@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Vladimir Murzin <vladimir.murzin@arm.com>, Phil Elwell <phil@raspberrypi.com>, 
	Stefan Wahren <wahrenst@gmx.net>, Serge Semin <Sergey.Semin@baikalelectronics.ru>, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, iommu@lists.linux.dev, 
	linux-sound@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"

Hi Frank

Thanks for the review, and sorry for the delay in coming back to this.

On Wed, 5 Jun 2024 at 18:53, Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, May 24, 2024 at 07:26:50PM +0100, Dave Stevenson wrote:
> > From: Stefan Wahren <stefan.wahren@i2se.com>
> >
> > Actually the criteria to increment source & destination address doesn't
> > based on platform specific bits. It's just the DMA transfer direction which
> > is translated into the info bits. So introduce two new helper functions
> > and get the rid of these platform specifics.
> >
>
> Fix increment source & destination address depend on the platform drvdata.

This is not platform drvdata.

The code was converting from the generic DMA transfer direction enum
into the hardware specific bitmask, and then looking at that for
whether it was using an address increment or not.
It's more readable, and easier to add in the newer variant of the
hardware, if we check the generic transfer direction.

I've reworded it for V2 as

"The criteria for whether an address increment is required is based
solely on the DMA transfer direction. The driver was converting from
direction into the hardware's "info" bitmask and using that, which
is therefore dependent on the hardware variant.

Change to using the DMA transfer direction via helper functions
to remove this hardware specific dependency."

Hopefully makes the situation clearer.

> It should be depend on dma_transfer_direction.
>
> look like it is bug fixes. Can you add fixes tag.

No, as described above, it's not a bug fix.

  Dave

> > Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > ---
> >  drivers/dma/bcm2835-dma.c | 28 ++++++++++++++++++++++------
> >  1 file changed, 22 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> > index ef452ebb3c15..d6c5a2762a46 100644
> > --- a/drivers/dma/bcm2835-dma.c
> > +++ b/drivers/dma/bcm2835-dma.c
> > @@ -252,6 +252,24 @@ static u32 bcm2835_dma_prepare_cb_extra(struct bcm2835_chan *c,
> >       return result;
> >  }
> >
> > +static inline bool need_src_incr(enum dma_transfer_direction direction)
> > +{
> > +     return direction != DMA_DEV_TO_MEM;
> > +}
> > +
> > +static inline bool need_dst_incr(enum dma_transfer_direction direction)
> > +{
> > +     switch (direction) {
> > +     case DMA_MEM_TO_MEM:
> > +     case DMA_DEV_TO_MEM:
> > +             return true;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
> >  {
> >       size_t i;
> > @@ -336,10 +354,8 @@ static inline size_t bcm2835_dma_count_frames_for_sg(
> >   * @cyclic:         it is a cyclic transfer
> >   * @info:           the default info bits to apply per controlblock
> >   * @frames:         number of controlblocks to allocate
> > - * @src:            the src address to assign (if the S_INC bit is set
> > - *                  in @info, then it gets incremented)
> > - * @dst:            the dst address to assign (if the D_INC bit is set
> > - *                  in @info, then it gets incremented)
> > + * @src:            the src address to assign
> > + * @dst:            the dst address to assign
> >   * @buf_len:        the full buffer length (may also be 0)
> >   * @period_len:     the period length when to apply @finalextrainfo
> >   *                  in addition to the last transfer
> > @@ -408,9 +424,9 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
> >                       d->cb_list[frame - 1].cb->next = cb_entry->paddr;
> >
> >               /* update src and dst and length */
> > -             if (src && (info & BCM2835_DMA_S_INC))
> > +             if (src && need_src_incr(direction))
> >                       src += control_block->length;
> > -             if (dst && (info & BCM2835_DMA_D_INC))
> > +             if (dst && need_dst_incr(direction))
> >                       dst += control_block->length;
> >
> >               /* Length of total transfer */
> > --
> > 2.34.1
> >
