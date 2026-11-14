Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794680196;
	b=kl6g00OhLwvlgy+A/TChkNoqByflf5ELNDbnRzo+4jf5svX3gTQ6KyqA0KdVBs95qlm9
	 7FtZwpk6dvueSEQsI21619Po5pFa37jt0Y4BfWRgigRI9yQewPc1oPCQDe+VuXM/ANDDR
	 wAy0HU2agVgm7OpklX4NZggXA0fYF0x+kjhFAD4AxCr7ZEb/bDJ0DiGWGF/r22nHWHkON
	 D7+83KnhtLxQikAnu3IpSIZfczq8HZbLbmT7ioRJAmz92hYlCALnU8NwoRoQ3QxrJlg3s
	 qHf66BXP09GdQ8KWOEdAxPEqAadIe7nTcmind9hv/OxkrKi/MtmwbIL+UL04F2o5BHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794680196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nkt2JQuYxF5BabtIplfQAWBZ1OpVC8q+QXSET0I4YtA=;
	b=p9nl/cqO75lawaQTn6QwRV7NLITxVwa+43kItVH4dgo33uyyDiUMHKYpCrSyf29hETnI
	 RjqcvfQioSlU/3R4RjU5UmMRn05sVXaH7MsI1Gl5n0PmC0PxVvsMSSjL3fXyjkQy5umCS
	 7fFZDL8xwXwhlMGYNc+q5x2Fnwv6miQteNM7Hwxmw85lH+wt6MWNYnXy6gfka3oP59Jif
	 1oSjwnzbQj13Z/JaZQes/DuYI+nVVsFxDetKT3RK+ITz5TasD7jWlrVyLJjUmrJ/D5+ug
	 3LiKJti7YKHKhmEsc6FKXSWqsg0yZHCs1huL/4angaeigAwk8SubKzinbKj1ctxKdqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PquvY3b1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8C7606A327
	for <linux-mmc@vger.kernel.org>; Sat, 14 Nov 2026 18:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF8C7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PquvY3b1
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91e7af9a67fso13077296d6.2
        for <linux-mmc@vger.kernel.org>; Sat, 14 Nov 2026 10:16:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794680195; cv=none;
        d=google.com; s=arc-20260327;
        b=IbjJCH6yjlowxvlFU+9fjxWnbnMR52khvRcwV4oDRDKbX1w4GsTaLzd9y+jpLeyBm+
         0tzbDHclP0Pj/bYtj/GzypByfeO3P2/4Dye6mxomI6pfjA7hLNY2BkbSeMaF94YMN8rk
         yqli40Q7T39Yas+dbJPmkPJC44BY0Tt/uMAHAGF96kJu7Bgmwa3IW3Uii88yOrlgh/oR
         PrJ32l991l2hFej+DmJnzDHSbgVDw47jHQbHBeSjySUkDA/K2mpQFEe1dWYJxzYhm5mj
         w8lqrYTX/jbpi6oHtmUBunbi8z7dM9mCaHQqZaAdkXisZBbwRsJFjAnXYe0S+snbW4Q4
         IvSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nkt2JQuYxF5BabtIplfQAWBZ1OpVC8q+QXSET0I4YtA=;
        fh=3Wa9KMzSI4OOpWXRztXRxDuE//TNkflzFwoCLbhvHds=;
        b=qdpb8fTJ0q0Z58QHQP1J7KiND2m3Js+w2r6mXDHiGc9xoO/wDGf+dWziDfiCUBpscm
         HnNC9QZURMpa/co8JLnpmNiDNz0NxFqcPdQPIaEMBAsoEPoV6PqPmp2pHT/gnfhuD39y
         XIFYSVzq2lz48zhsju1u3Ce+pgrYo3FM6hP7ZB+j9DFSH+Fe9owLuu6/JIPHtpTDcjS9
         /g4RCpJw2bmovgvvqSQ7Zbn3lNZROrlbkx5DW0n31GG+g6dFK7bKup8WwzRyubfi4gSs
         txaCWOCZUwnOBgMcV+ReWvVcQntVTNC33cn5vVTvy6xyFD3lONvBBZ1vYxbu8WpXCvRE
         ddvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794680195; x=1795284995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nkt2JQuYxF5BabtIplfQAWBZ1OpVC8q+QXSET0I4YtA=;
        b=PquvY3b1jhACnW0EO/jm5iRal409mv35f1wOmmHL/cYtbxuNrsc1+Q2V6rerQtrxqu
         3RAANHwy3J8sudMiqn0c+APvtGfmKELfA8Iu2u5TGDyrjx00SDC4lcXAEbuc3fyqdolL
         +9h/nyqcV3ogeSsXmjmHVLbxNm+qfFz6dUmEknQrJkZWkbUDYrmxe6hcu4shuBsdj5h7
         sjN4c65Fx1/NdXym8ymTjPoirVXbWBkAsSRlb0/lCHAK4HMhvyqNG7qhFMeYowMwDq6w
         4m3rTOyvCCOikquNme0GsXYbL4O4XLgmM5SVoKNCnbmr4M514A58rYcgk22Pi8ztYvdc
         7vjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794680195; x=1795284995;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nkt2JQuYxF5BabtIplfQAWBZ1OpVC8q+QXSET0I4YtA=;
        b=lF36au1MSlXH3dcXxpVDUi0xjSahsb7KqtbEYfnOI1hJB0omOf4WyxSUdOCj1A98+G
         n1Q/VGg0dIQB3O0Lm0Njmg5ted+06EtT5znoWqhnki4p8RqH4ciA20LH8XxFxyK5WLbb
         YnCAMQGZMFJQMRK9LD5IRYfTQNvUR9t8n8513zL/JaKWdfLW45vltj5fqmumLg1jbOvb
         Q5UB0qojpfC/W+5NHMZvseBZOuD3I32eX+N9L4PqME4SIDSWQBydW6huIwZv9vGtOR0C
         4zoSGYLT1eGcGkJxYyBJLm5E24r6YsQZOcoZwtvtvgWSlcWfeGiAFvjWgNEeUZEgUsiY
         4f2g==
X-Forwarded-Encrypted: i=1; AL+hErHTHGDqhRsNUd+MeaUIYfAhO+61Ic0ZY7ROzT9NpKbFbGsSjZvHsp/qeQAcF5pkQYg2mqvZtd1glik=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GRcDy3JzLXz6Rb8oHGP5gH2LQ9q2AMXMWIG3SQiuA3OetNigw
	CpG25rC2vA4f2FgPj+jVyO42rgD1yJxbPpOwL8dfluOZOzrsLUOPDsyj6WAhuMjxu9iIxfkFxDs
	/AhAVYLFmX7dL8CfmyBt4BnXH6iasizw=
X-Gm-Gg: AYBFou2NTvUuGij9PkOCmNQTUPmrxP5BCFZ3ltUZvf6XCfv+5vHAl+m/0lONzFADtpI
	5yK+CiM7AzHpMSwq3xwL5auB+tpVWKZF67N/U60bNBbVdY4gdmgaWEsufzEHqkwxDFqksiflOi6
	iqBf61wi6WBd1b/tZosUNdOS1d95TLWTEbNrRh4hZPtl+Bg+eHioMZwS55OdaMEwihO99AG+2bL
	h0HYwrIQ41jWdYkZCFa0S9qw2X/tHMU69zR/7mAgJjnqFmsUtr+8AeTXeedf6P5u4WCyjNhN4Hz
	QWzY9wc3oweWqZSANxPjpwbmKekiEoi86rNNzl3kbe0Y+9slvwuPArDw0pZvM9YR8OKiOHtIK6I
	iZPfdjwudooGVaWlJR6Y41BC8xgKOFiNv+KtC
X-Received: by 2002:a05:6214:1d01:b0:91e:cb87:e4a5 with SMTP id
 6a1803df08f44-91f2423ebc4mr97360156d6.38.1794680194690; Sat, 14 Nov 2026
 10:16:34 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114051011.275554-1-artem122novak@gmail.com> <132b7ffc-c1b7-4adb-ac66-6f40cc512048@gmx.net>
In-Reply-To: <132b7ffc-c1b7-4adb-ac66-6f40cc512048@gmx.net>
From: Artem Novak <artem122novak@gmail.com>
Date: Sat, 14 Nov 2026 12:16:23 -0600
X-Gm-Features: AclHuK9rIL5Lwdo0B9w7amHU_R88anVbZPxmDS9sLUS9DFnzhL9cg8dXPAbBPHU
Message-ID: <CAPufuhZLT2QM+i97zETYCVs2jRBT0enf+zo+CiiSoiVseOUnmg@mail.gmail.com>
Subject: Re: [PATCH] mmc: bcm2835: restore scatterlist after DMA setup failure
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Hemanth Selam <hemanth.selam@gmail.com>, John Garry <john.garry@linux.dev>, 
	Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greetings.

Yes. If DMA setup fails, the request falls back to PIO with a
shortened scatterlist entry.
This can cause the PIO transfer to omit part of the data,
potentially resulting in corrupted or incomplete I/O.

I had a kernel panic while running my Raspberry Pi server,
which made me find this problem.

For trimmed_sg:
I kept trimmed_sg to explicitly track the scatterlist entry whose
length was modified.
original_len alone tells us the previous length, but not which entry to res=
tore.

Best regards,
Artem

On Sat, Nov 14, 2026 at 3:50=E2=80=AFAM Stefan Wahren <wahrenst@gmx.net> wr=
ote:
>
> Hi Aartem,
>
> Am 14.11.26 um 06:10 schrieb Artem Novak:
> > The DMA preparation path shortens the final scatterlist entry
> > to reserve space for FIFO drain words.
> >
> > If DMA mapping or descriptor preparation fails, the request
> > falls back to PIO, but the shortened scatterlist entry is left
> > unchanged. Restore its original length and clear drain_words
> > before returning to the fallback path.
> >
> > Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost contr=
oller.")
> > Signed-off-by: Artem Novak <artem122novak@gmail.com>
> are there real potential negative consequences? I'm asking because there
> is a fixes tag.
> > ---
> >   drivers/mmc/host/bcm2835.c | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> > index efd1903c3ccd..49a975e984df 100644
> > --- a/drivers/mmc/host/bcm2835.c
> > +++ b/drivers/mmc/host/bcm2835.c
> > @@ -449,6 +449,8 @@ static
> >   void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *=
data)
> >   {
> >       int sg_len, dir_data, dir_slave;
> > +     struct scatterlist *trimmed_sg =3D NULL;
> > +     unsigned int original_len =3D 0;
> >       struct dma_async_tx_descriptor *desc =3D NULL;
> >       struct dma_chan *dma_chan;
> >
> > @@ -480,6 +482,8 @@ void bcm2835_prepare_dma(struct bcm2835_host *host,=
 struct mmc_data *data)
> >               for_each_sg(data->sg, sg, data->sg_len, i) {
> >                       if (sg_is_last(sg)) {
> >                               WARN_ON(sg->length < len);
> > +                             trimmed_sg =3D sg;
> > +                             original_len =3D sg->length;
> >                               sg->length -=3D len;
> >                               host->drain_page =3D sg_page(sg);
> >                               host->drain_offset =3D sg->offset + sg->l=
ength;
> > @@ -495,14 +499,21 @@ void bcm2835_prepare_dma(struct bcm2835_host *hos=
t, struct mmc_data *data)
> >                                    &host->dma_cfg_tx);
> >
> >       sg_len =3D dma_map_sg(host->dma_dev, data->sg, data->sg_len, dir_=
data);
> > -     if (!sg_len)
> > +     if (!sg_len) {
> > +             if (trimmed_sg)
> > +                     trimmed_sg->length =3D original_len;
>
> Maybe I missed something, but why do we need trimmed_sg? Can't we just
> check original_len instead?
>
> Best regards
>
> > +             host->drain_words =3D 0;
> >               return;
> > +     }
> >
> >       desc =3D dmaengine_prep_slave_sg(dma_chan, data->sg, sg_len, dir_=
slave,
> >                                      DMA_PREP_INTERRUPT | DMA_CTRL_ACK)=
;
> >
> >       if (!desc) {
> >               dma_unmap_sg(host->dma_dev, data->sg, data->sg_len, dir_d=
ata);
> > +             if (trimmed_sg)
> > +                     trimmed_sg->length =3D original_len;
> > +             host->drain_words =3D 0;
> >               return;
> >       }
> >
