Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BA01442F6
	for <linux-mmc@vger.kernel.org>; Thu, 17 Oct 2024 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156439; cv=none; b=AXvOgVMfScIVKj0TKkK+qK30zS7dl5QhmsCD9GZ2cDhd9WGEeoCd85mc5M768DGOTSWCwiXu7WebFhHhUpwebTjd3US9+gQ4xNXEi51NJRPbdiXuBQOqZYto7jY0Dqh72L3w1lRlE3inQKqh3zfd293i66qhos2mY0mY/IdWT8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156439; c=relaxed/simple;
	bh=E/EX2nXPIh11iJuOLzPIXcFFLY7/ooLBLNxV1EXXXBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpnJMLVSNdyfSbAhvGT7Gx0E9knYRJWiB2gyi8wsNFHbq2Q+QrwDnwZwDGE9DzWhiwDd5OYW0cBv37KNjGkgsmMsJ+h0/ODxLHMlwPuZ2cErVQ8l851WUwQdbdICWaHHVJc5CQJJFS0oOchuhIAzT4EPEZEC2sQfzA+gvBNQcjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q/oIpQMK; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/oIpQMK"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e29047bec8fso1498042276.0
        for <linux-mmc@vger.kernel.org>; Thu, 17 Oct 2024 02:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729156434; x=1729761234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LQTXgfd5CIC42gxjBiNXn1kbj+3FKhiZetQm59o+9L4=;
        b=q/oIpQMKqDMKgP+eGipRSWgwOSwu/HFMMmB813u9oVT4QbnzNkCIHjzu7ZhVbWvQHX
         xjKQcaPtzTFNI1Rcyr2rF2eAC7RgBE3vVI/1FFZS+SYNyVP40mk36ui0gLlgug9OVI/X
         OERjo3oZ8FcAAYHnXWLv4FgsuCwHTwyS0AgaSz1H5JmRaQrLqvaJzyNYW0l2dYQk1H5n
         mefMtsd05EaKTCtMndwa2XG8xPg09PCISajVLkI1lYNwSPM2xi9rkTpcPHOeW7lt6giL
         0TqYKmkF4Mfbqxoei6TJvcJMnvcz6oso4Sq5UjnkRJnAXNiNxkpQC6iwSvvr2nZK4w+R
         wFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729156434; x=1729761234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQTXgfd5CIC42gxjBiNXn1kbj+3FKhiZetQm59o+9L4=;
        b=lEOjqGFwutUW/MnayrA+S81fObq2XxWIVYCRQeyrFfcYqf9//KCU927q5KH5O6FyzY
         Hk/ndcafN06fQk9SOzuBiiUk7+PCzis9vLBUDE7MP/htmEmr1FDDEp1fFDCC4gqaZ8Td
         Q6bzUJibJvmIzxmalCeGKmTjCXIWSUW0/QzDNHfdr+/TSfoIbXBUEqOp+vu4ItA8OchB
         nHKqz5vYGk6TjABb/Xrw+p9YTsp5NPNy80S5WVxoc3wx55hd64lVEa0aaDEGzBgnnhbl
         Ua0S/76xmx9tdxSHSdeQtmBg1IKT1jxfMjIvhlNYFXXrUaEMopjmooPreLNJrSm1Kb3/
         5s/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVi/oKZMaB7rso4tCsw9Rs8eD4DVskt0iAEcqNsNMNL/RWnnpqvHzjFzDMyKRz2+6R5uS3Vtur3T5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAz8TiLTxED9UFQTqIUBeKXYC9eCeLFr3+v4WdNVjEJF5OCoOW
	P8ShVY6f9yIt9GooGicJy0k3+pFADuDoEPIu33wu+KzlBaUME+tafnMnGVnFHPcSHePSTdltcx8
	54UuMD1MFrv6rOYthDW25oPkLssn1Y8+IxpQt9g==
X-Google-Smtp-Source: AGHT+IEbp8eABRktb1aC4fWMaK7REcsntuOUjtNgrXb0K6kIzZKbpfLWxRHUTtkYPxgKePE5lMpKwVSKCeDzOlLz5aE=
X-Received: by 2002:a05:6902:e90:b0:e29:27db:a1ac with SMTP id
 3f1490d57ef6-e2b9cfb1dd3mr2151179276.17.1729156434494; Thu, 17 Oct 2024
 02:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014114458.360538-1-avri.altman@wdc.com> <18e66783-0fc7-4c55-8087-dc4212e851b4@intel.com>
 <CAPDyKFoXsgXNevDoCGTKSTwz-PfavfEHG5feyzEbeynRq3bDGw@mail.gmail.com> <DM6PR04MB65750E8C697235F8E0B42CA8FC462@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65750E8C697235F8E0B42CA8FC462@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 17 Oct 2024 11:13:17 +0200
Message-ID: <CAPDyKFqb_gJ74sddXRreZ49D8mM0yseSwg=L-M4Q8MvrtacXGQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Use GFP_NOIO in ACMD22
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Oct 2024 at 17:21, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > On Tue, 15 Oct 2024 at 11:44, Adrian Hunter <adrian.hunter@intel.com>
> > wrote:
> > >
> > > On 14/10/24 14:44, Avri Altman wrote:
> > > > While reviewing the SDUC series, Adrian made a comment concerning
> > > > the memory allocation code in mmc_sd_num_wr_blocks() - see [1].
> > > > Prevent memory allocations from triggering I/O operations while
> > > > ACMD22 is in progress.
> > > >
> > > > [1] https://www.spinics.net/lists/linux-mmc/msg82199.html
> > > >
> > > > Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> > > > Signed-off-by: Avri Altman <avri.altman@wdc.com>
> > > > Cc: stable@vger.kernel.org
> > > > ---
> > > >  drivers/mmc/core/block.c | 10 +++++++++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > > > index 04f3165cf9ae..042b0147d47e 100644
> > > > --- a/drivers/mmc/core/block.c
> > > > +++ b/drivers/mmc/core/block.c
> > > > @@ -995,6 +995,8 @@ static int mmc_sd_num_wr_blocks(struct
> > mmc_card *card, u32 *written_blocks)
> > > >       u32 result;
> > > >       __be32 *blocks;
> > > >       u8 resp_sz = mmc_card_ult_capacity(card) ? 8 : 4;
> > > > +     unsigned int noio_flag;
> > > > +
> > > >       struct mmc_request mrq = {};
> > > >       struct mmc_command cmd = {};
> > > >       struct mmc_data data = {};
> > > > @@ -1018,9 +1020,13 @@ static int mmc_sd_num_wr_blocks(struct
> > mmc_card *card, u32 *written_blocks)
> > > >       mrq.cmd = &cmd;
> > > >       mrq.data = &data;
> > > >
> > > > +     noio_flag = memalloc_noio_save();
> > > > +
> > > >       blocks = kmalloc(resp_sz, GFP_KERNEL);
> > >
> > > Could have memalloc_noio_restore() here:
> > >
> > >         memalloc_noio_restore(noio_flag);
> > >
> > > but I feel maybe adding something like:
> > >
> > >         u64 __aligned(8)        tiny_io_buf;
> > >
> > > to either struct mmc_card or struct mmc_host is better?
> > > Ulf, any thoughts?
> > >
> >
> > I have no strong opinion.
> Then I would vote to stay with Adrian's original NOIO suggestion, because:
> 1) My testing shows that mmc_sd_num_wr_blocks() is hardly being hit, and
> 2) that allocation is within the write timeout anyway
>
> So unless you want it otherwise, will remove the redundant macro call and re-spin.

Sounds good to me!

[...]

Kind regards
Uffe
