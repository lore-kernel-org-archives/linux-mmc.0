Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9D6207A11
	for <linux-mmc@vger.kernel.org>; Wed, 16 Oct 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089938; cv=none; b=ByvzFlsjV6UDUxsmJZQichu8vDyyparTGqBL0i6oT6kDbv37GVk1BegK2pFBFaUSRnVOp+AuAihI79fAvFXWMDm4n0NVqYhEQI+ZsuK+hu+WvkZwiq2u1ZaaAfqVo/CPeHipO6ZvroxyzIgLttGRDd1wVQEewuTLtFMqbxS+hDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089938; c=relaxed/simple;
	bh=2dlhfGjjK7bz4fLFDWVKZIt+LaevKw7NaSjuGu3W6rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GErWMCbsKCh+63bLyatYYvnV0Axt1h4QtzVkbNzUWX+q9c6teRv5q+tmX93mkgY5tapPg38mu9lkjvvCH28w/EH2peUVmA8I6SCSCt5bmLviGkeOh7o8Vf5e6TQi0VVzf4oRKrY8E00b4zymbXICkRth9uwKk1tKKFrH2IqUxP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YYU6c6lj; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YYU6c6lj"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e3d97b8274so8458397b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Oct 2024 07:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729089936; x=1729694736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f2192OkMIEFKuoR3f9bF9zS4kE07HltUT6+CE9CV1wA=;
        b=YYU6c6ljgwWuc/r96ARCUQagApfMgqP+nqNKV1bZhe6NRR2UYseLw7fkjRu7+JU4A/
         bNEuok8Q2V6vY9uxayopaLnZhhmntuATFcO7AjFqhd3OFWQyhgu33WMI4yxPyYiz6Oa3
         NEq6qmtZsZAPAoLsSQSbO8jEk+0uYY28k9aUl8jaC+pnHUpClDUrwyOLZiG0j3Z+mq4G
         HArR47+imm2tH4j6roXOsIN3HG0TqnCapSLKgw7XxY6Fxw2E6lG4rDDvN2cAAFNOSSFZ
         Nw5ew22LSKEFCPQpzMzMXrGxeQ/iqqmiUN7lhNxt+C3yIyGKNFo2VEXUWZBDCIFd4KYh
         v/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729089936; x=1729694736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2192OkMIEFKuoR3f9bF9zS4kE07HltUT6+CE9CV1wA=;
        b=f/8nVlXniIRqRrXgVuQcCGblZGQT0oFnPbNJnJ6aFOC6y9MAeaOpfL6ZmIh+dKFomQ
         nVQfXtfvXru8t+YYKZZCSUHnI7ur1G9nVry1ax2/9J7IKpyk8qF6CaU7ZjpZl7PXJqjN
         PLe7z3GHQ1VfQongKSFXzbxTDnY5HMcIsfV4lqEMg6U7PSOdhYKXpODZl1ROt7D2ML15
         OOGqYV3Kq/TQBnW5+hDjAXist/E8lMdcAzgS1QEQDy5rgbu6Avc7rbHgnAdVoWx+Wb2d
         J6b86H04PYUu/VKEOn1rOv2kiyR+kz0egPH6yrvDq3H0DWE9+G4Tqaro1GXhTDmqwSh9
         zmCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwHwfhAFFzbyE4j1hJ780ySLcGvShGwJaNiiQOlft5WKnaUsrQqjP6yesv1yGUvJEB2Nz6gKXRueU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeWhOjoqo/5rpK3R+DLmtAK0LlGB4R4i6PSRwI6+EZ9K2vQCKe
	4l2IY63X4JkES+LGmVe7oL05bFwI448WTnDZjUt4su7JlbHLcV8RiJQGVhkuV7dV6bUJ9x5ttCt
	68YtglIBbh7DZtiJtwJsQlbtv/np81XQIq9Q0rTuVDNzZDZHHUgk=
X-Google-Smtp-Source: AGHT+IEnPDp7JTC1QUNhwN+3rrkzI5nEH+Odsf+WSUJkJxnXoWOjSYgc8YBypERL0Moyl5lmsMgQNGXrCNXN8Z5XWKU=
X-Received: by 2002:a05:690c:2c02:b0:6e4:9758:ac22 with SMTP id
 00721157ae682-6e49758ba59mr14127187b3.19.1729089936092; Wed, 16 Oct 2024
 07:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014114458.360538-1-avri.altman@wdc.com> <18e66783-0fc7-4c55-8087-dc4212e851b4@intel.com>
In-Reply-To: <18e66783-0fc7-4c55-8087-dc4212e851b4@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 16 Oct 2024 16:44:59 +0200
Message-ID: <CAPDyKFoXsgXNevDoCGTKSTwz-PfavfEHG5feyzEbeynRq3bDGw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Use GFP_NOIO in ACMD22
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Avri Altman <avri.altman@wdc.com>, linux-mmc@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 11:44, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 14/10/24 14:44, Avri Altman wrote:
> > While reviewing the SDUC series, Adrian made a comment concerning the
> > memory allocation code in mmc_sd_num_wr_blocks() - see [1].
> > Prevent memory allocations from triggering I/O operations while ACMD22
> > is in progress.
> >
> > [1] https://www.spinics.net/lists/linux-mmc/msg82199.html
> >
> > Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Avri Altman <avri.altman@wdc.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/mmc/core/block.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index 04f3165cf9ae..042b0147d47e 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -995,6 +995,8 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
> >       u32 result;
> >       __be32 *blocks;
> >       u8 resp_sz = mmc_card_ult_capacity(card) ? 8 : 4;
> > +     unsigned int noio_flag;
> > +
> >       struct mmc_request mrq = {};
> >       struct mmc_command cmd = {};
> >       struct mmc_data data = {};
> > @@ -1018,9 +1020,13 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
> >       mrq.cmd = &cmd;
> >       mrq.data = &data;
> >
> > +     noio_flag = memalloc_noio_save();
> > +
> >       blocks = kmalloc(resp_sz, GFP_KERNEL);
>
> Could have memalloc_noio_restore() here:
>
>         memalloc_noio_restore(noio_flag);
>
> but I feel maybe adding something like:
>
>         u64 __aligned(8)        tiny_io_buf;
>
> to either struct mmc_card or struct mmc_host is better?
> Ulf, any thoughts?
>

I have no strong opinion.

A third option could be to allocate the buffer dynamically in the
struct mmc_card when probing the mmc block device driver, based on
mmc_card_sd() returning true.

if (mmc_card_sd())
   card->io_buf = devm_kmalloc(&card->dev, 4, GFP_KERNEL);

Kind regards
Uffe
