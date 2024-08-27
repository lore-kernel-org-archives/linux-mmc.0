Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0503D2907
	for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2024 01:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724722140; cv=none; b=hOPNno9oRT60R0ZQSdN0arT8fltb3tbOggpLNDyehU5BYwxdAcnkTbe1gfXpSg/3BJrlH5IMSVVmhXjgINmNC8hFgSte32/L4IHPWrnqRF6AeVxnpBlbM5UMXETWvsg/jI6LuRSK0a7iTaAltpkZIlIGAeAyiKaWk5NFI8dT5Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724722140; c=relaxed/simple;
	bh=LWSsos9brGGFBVHUqBKo8WsLZqg2S2/k2MicY1l1GFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGBxjk5uocEaHCOSqIRgFpSymKfhmRw4Qz5mh3CtdD03GAkbPwzffcM8gQ5rkqW7n0sSUb2yBfoMveWu+a3byHnRfCBiCopXVvB6y2ERcx4cZ1I+/Hi8k4swoQaERC0EIKf2UajeuhxWMv1HCWS3Qn1hPpFZxo1SlmpYvgOuiRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rlo/tnLl; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rlo/tnLl"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6c91f9fb0acso22747997b3.2
        for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 18:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724722138; x=1725326938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=um0Ld/DK1dALC+xuyiImRq2CVo2mp6q3KWIX/uQM1TA=;
        b=rlo/tnLlXogSPYUun73ZU5s9pXgFCBqIEFIiMRksC30EfDSbUuKt5C2tDLo5lsXQgw
         lZ3Sr1X1NoCVpNpJp/4OU5bxq4Hw1J/RSI7qLTCrYRe3xE5TrXrzYE139pYBSbxaPcph
         357V+4w2dmRMgrd/KOpeTGzm+oyL4j5RgEhTLTmkSjiT5cClHedbsRbzMWt392OYpTva
         iF7zJ5eUbsDaPn7fOVEzltx1X2Oc+rjmnirPUhwyrtJFZh6ExdNgDVlAQayvQROKWfFQ
         r0d40e3fkpu5YluZAYIb1PBnVw+DMV0lngmTk15dXypCRApcVCTK7T7Su+AGs8RszLr6
         kwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724722138; x=1725326938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=um0Ld/DK1dALC+xuyiImRq2CVo2mp6q3KWIX/uQM1TA=;
        b=PWHaY6Gogw1EXzsJ4RmNZeMqe2Ag51QuWG25nJvCYZS8Lc8+X/ipmC/lPQ1ZaqwcKI
         vbiOvEPsmW8lqPSNSxuEiMWJ42EH4TEk2RP4XET9kOTUxBLItAXdrhhxLi69GQrsSpZ2
         gyKICEhqzHUVSduAq+5nXwUkrEiFd10qjoUXNkE9VEN6hYesAd/6OG77avicEvFIUKse
         1fGUahVyATRQFviw9Utv3gAxC7y08BD6hYbuPMcbXlxgnk3wIfUmK423rcAsiUa4sSxT
         JWpUZwM9uzCiros1le53o6mRgGxwHK/xYoAoS8Sh45JN52I8o1SDGfWQfqaxgEneTXlb
         gzgw==
X-Forwarded-Encrypted: i=1; AJvYcCUaoRLwika4CFDwdlwAJJ/PCwF83bkfAXCAKzvjKbX/UC0Sm+q2OmSystxtHwf4mNlmCglnEm9gMoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHgX7A+ykrbio0tEfNpZMgfpEs/qrXf3AXQs/O6qTe46GLsBZJ
	B+1ZtGSCWGRSNYwnFrhosU745qaeqEFKo9z999LQW7UpXeWL2j7fxnhOtZs870Fe00HdbR9UuKk
	VFdQ3k19yWzuQh7og5OxXYHprMWrOvlYmcmkMiQ==
X-Google-Smtp-Source: AGHT+IGivGnoM4u2PoEm3bwmD9C+DJbRzW3XIbEOxQ4Kz5QGN0k1ua5tksm0F2Od/7aSiugFThK2DFcpLfbYMP01jJU=
X-Received: by 2002:a05:690c:fce:b0:65f:77c3:63a0 with SMTP id
 00721157ae682-6c624320c13mr150269467b3.7.1724722137887; Mon, 26 Aug 2024
 18:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306232052.21317-1-semen.protsenko@linaro.org> <8896bcc5-09b1-4886-9081-c8ce0afc1c40@app.fastmail.com>
In-Reply-To: <8896bcc5-09b1-4886-9081-c8ce0afc1c40@app.fastmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 26 Aug 2024 20:28:47 -0500
Message-ID: <CAPLW+4=NcjOFRd14ecYd8sMsiJXH9c+ZXse7BVMCWe5ZbMmKMQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Christoph Hellwig <hch@lst.de>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@gmail.com>, 
	Matt Fleming <matt@console-pimps.org>, Christian Brauner <brauner@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 1:52=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:

[snip]

>
> > This change is not only fixing the boot with 16K/64K pages, but also
> > leads to a better MMC performance. The linear write performance was
> > tested on E850-96 board (eMMC only), before commit [1] (where it's
> > possible to boot with 16K/64K pages without this fix, to be able to do
> > a comparison). It was tested with this command:
> >
> >     # dd if=3D/dev/zero of=3Dsomefile bs=3D1M count=3D500 oflag=3Dsync
> >
> > Test results are as follows:
> >
> >   - 4K pages,  .max_seg_size =3D 4 KiB:                   94.2 MB/s
> >   - 4K pages,  .max_seg_size =3D .max_req_size =3D 512 KiB: 96.9 MB/s
> >   - 16K pages, .max_seg_size =3D 4 KiB:                   126 MB/s
> >   - 16K pages, .max_seg_size =3D .max_req_size =3D 2 MiB:   128 MB/s
> >   - 64K pages, .max_seg_size =3D 4 KiB:                   138 MB/s
> >   - 64K pages, .max_seg_size =3D .max_req_size =3D 8 MiB:   138 MB/s
>
> Thanks for sharing these results. From what I can see here, the
> performance changes significantly with the page size, but barely
> with the max_seg_size, so this does not have the effect I was
> hoping for. On a more positive note this likely means that we
> don't have to urgently backport your fix.
>
> This could mean that either there is not much coalescing across
> pages after all, or that the bottleneck is somewhere else.
>
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index 8e2d676b9239..cccd5633ff40 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -2951,8 +2951,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
> >       if (host->use_dma =3D=3D TRANS_MODE_IDMAC) {
> >               mmc->max_segs =3D host->ring_size;
> >               mmc->max_blk_size =3D 65535;
> > -             mmc->max_seg_size =3D 0x1000;
> > -             mmc->max_req_size =3D mmc->max_seg_size * host->ring_size=
;
> > +             mmc->max_req_size =3D DW_MCI_DESC_DATA_LENGTH * host->rin=
g_size;
> > +             mmc->max_seg_size =3D mmc->max_req_size;
>
> The change looks good to me.
>
> I see that the host->ring_size depends on PAGE_SIZE as well:
>
> #define DESC_RING_BUF_SZ        PAGE_SIZE
> host->ring_size =3D DESC_RING_BUF_SZ / sizeof(struct idmac_desc_64addr);
> host->sg_cpu =3D dmam_alloc_coherent(host->dev,
>                DESC_RING_BUF_SZ, &host->sg_dma, GFP_KERNEL);
>
> I don't see any reason for the ring buffer size to be tied to
> PAGE_SIZE at all, it was probably picked as a reasonable
> default in the initial driver but isn't necessarily ideal.
>
> From what I can see, the number of 4KB elements in the
> ring can be as small as 128 (4KB pages, 64-bit addresses)
> or as big as 4096 (64KB pages, 32-bit addresses), which is
> quite a difference. If you are still motivated to drill
> down into this, could you try changing DESC_RING_BUF_SZ
> to a fixed size of either 4KB or 64KB and test again
> with the opposite page size, to see if that changes the
> throughput?
>

Sorry for the huge delay. Just ran the tests:

- 4K pages, DESC_RING_BUF_SZ =3D 4K: 97 MB/s
- 4K pages, DESC_RING_BUF_SZ =3D 16K: 98 MB/s
- 4K pages, DESC_RING_BUF_SZ =3D 64K: 97 MB/s
- 16K pages, DESC_RING_BUF_SZ =3D 4K: 123 MB/s
- 16K pages, DESC_RING_BUF_SZ =3D 16K: 125 MB/s
- 16K pages, DESC_RING_BUF_SZ =3D 64K: 124 MB/s
- 64K pages, DESC_RING_BUF_SZ =3D 4K: 137 MB/s
- 64K pages, DESC_RING_BUF_SZ =3D 16K: 135 MB/s
- 64K pages, DESC_RING_BUF_SZE =3D 64K: 138 MB/s

As you can see, changing the DESC_RING_BUF_SZ value doesn't change MMC
throughput much; the fluctuations are just a measurement/statistical
error. Not that it matters much, but my measurement method was running
the same dd command I mentioned earlier:

    # dd if=3D/dev/zero of=3Dsomefile bs=3D1M count=3D500 oflag=3Dsync

For each combination, I ran it 10 times, with different wait time
between runs (as it affects the throughput), then taking top 10%
percentile value -- it just felt right. The dispersion wasn't too big
either. I used the same method in my previous mail as well, so it's
safe to compare these values with those.

Not sure if my test procedure and results cover everything you wanted
to see, so please let me know if you want me to run more tests (e.g.
by changing dd params, or running multiple dd commands with shorter
wait in between, etc).

> If a larger ring buffer gives us significantly better
> throughput, we may want to always use a higher number
> independent of page size. On the other hand, if the
> 64KB number (the 138MB/s) does not change with a smaller
> ring, we may as well reduce that in order to limit the
> maximum latency that is caused by a single I/O operation.
>

From what you said, it looks like it may make a sense to reduce
DESC_RING_BUF_SZ down to 4 KiB? If so, I'd suggest we do that in a
separate patch, as this one actually fixes kernel panic when 16k/64k
pages are enabled. Please let me know what you think.

Thanks!
