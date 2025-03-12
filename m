Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E596F1D63FF
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779695; cv=none; b=f0dG+XZO3u2KzGidt4GGqi1NXFKDXXrZMTEyxubKiABd58d6b9JWnMtESyfn6DKFv0Ts2oVQmbW8+OO/OdW+xH+vCFSmtecNBE1eq43ByqvF4zxZjebVkszyeUGt4miOLMokISBBdrOjNCHCjanQF6/dRxQTexHVZ76TKoGJ+6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779695; c=relaxed/simple;
	bh=Hfr8OMjeRYQrrUoqZYyJ4x09/UOphYrS/PiBPFEdw3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1I3KbuCfdOY2is1Uzp8mamH4G6n7mdNuI64I+Pqq+WQrKYnaGj9QGRPxY7z/RdjjOz9fohg/c4AyJPAv1FvTN0bDW7BiQYvDSaf0ssDauFjVLAeXftF9CjSAtyUUjkuKCRzeU3drgMbG4E24iWmObRdoBtOP2WuUMK3DYJ01l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J3Af76AB; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J3Af76AB"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6fead015247so49289877b3.2
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741779693; x=1742384493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9j/U4EQoiHgptz6boB/MjI8ID8/t5hKi1/d0T2PV2gc=;
        b=J3Af76ABRVnPZ3wiswxq5nwCp0pIU0EhXhfBLyPY9Mrvf9LCH4qYTWwjdvF31GBQbe
         dRHp2F2EbKmLm1OjGUF+0tYdAWoyxO4vp/X/GCTCtJZIRtLJm8K9MBp50BMjkEjVZKsP
         HQiZ3T/Lkif1+PfGm652dAaKqrBzWRKv1ozgeeGXd2/H4IZurDuPZSB7yNUUl6cZ+C6p
         e0s09RovtPuvu2kE5bqwaUjrGOhenZM5nDba3KvK5YeKIkiOLu9EswLK/houJbDtXAtZ
         9RNdxhg5KRXpIsTeq0sUS6AgEkvbJfLcVrFVIA+U9Y3I8v5RU56UUD4MAj298mKb10to
         7Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741779693; x=1742384493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9j/U4EQoiHgptz6boB/MjI8ID8/t5hKi1/d0T2PV2gc=;
        b=RSvARGzzjAoFTCVzreQzHwwv+AX8k3GKM6W1pPAdTd6nWq/eapLjEHpMtlyd6AJh9I
         /ttfZ9WbTns/LLwVO4YAmMiiW92FOcvt9zvKHtsVU/USmJwYay6+7J+ryUAjBk2oTpwY
         9wuGvNwBk/+/dItALWg3OQh0j3gArC3AmEXnpYm8P28gPxTEDT9AOC8wG7Oz/QOvaLBC
         w3HMcDQnINQ4PnQDxxX5TE3hvx3hgpyOKxhL77+2pKYzqC+BC9Jddq2+YBENgjI3bNNb
         s76Dom4xVVELkMLSvZHTCP7L+daYw5r+to/nDlB9JNQjIK/xP7gNzirld1+94sYQ6ZKn
         e/bA==
X-Forwarded-Encrypted: i=1; AJvYcCV+pN8l6W6GMd1Ra80FLE1TWasa9xws4JrgDWgW0zjmyYBrBgP8Xr2cCAZzLH6UNoRQS7zWHpV9tZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeNVEwCkzbaSkT9QcVQ5Akw+usI4loE9wwdsujeVcZzCtskDhg
	CNNGqVfa9CPF/MpRGWEN5wPPQGBfKkXkS8DwHdXEdaOi/2WiUAmtNIGyHHeWS/XFsUgAKV8xPSx
	nlu8syg4Xa/faVf/26fkNsRxCQboSSM8ygvXsbLWFz8jPPKnm
X-Gm-Gg: ASbGnctMPDRNvR4Zb4HZrtXK9LI6v+YGQ0ulFmRCSQKhSOCEQMHg0jnaaOQbBSeZGTd
	34MWyI3yfXIhVoGfSJlcyEMSs/ffK74nJQJDdLHoWpxFpEvqkmX8hgnhVJ1eX6/rFiT0x18Qcls
	UpYJhNbt+tZg+Wo1uHIKTuSzc2wwg=
X-Google-Smtp-Source: AGHT+IHH7uvA9yNgehQh/WvJpzE1DNm3tApCMv5rqkkOcqny/w/ZhYHeJeGOrtmKDOjQNX4IleJQ5b7Zm4VytQlV/xE=
X-Received: by 2002:a05:690c:4b83:b0:6fd:2b7d:9a4e with SMTP id
 00721157ae682-6febf30734bmr319577817b3.18.1741779692875; Wed, 12 Mar 2025
 04:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203172905.463629-1-gwendal@chromium.org> <BL0PR04MB656432C4EEB1A9EC3C6BDC0DFCF52@BL0PR04MB6564.namprd04.prod.outlook.com>
In-Reply-To: <BL0PR04MB656432C4EEB1A9EC3C6BDC0DFCF52@BL0PR04MB6564.namprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:40:57 +0100
X-Gm-Features: AQ5f1JomwgZ8i077_9iFpZbF1ecTQpS7Pplx8R4KSPTSkDekFPV367E5OrYQJ10
Message-ID: <CAPDyKFpFzBJvx1QxKytAs95_exCwj+HeDD7Pq7uMzqH1s69EwA@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: fix conditional around sparse
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Gwendal Grignou <gwendal@chromium.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Feb 2025 at 18:40, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > sparse would always be invoked, since `ifdef C` is always true afet `C ?= xx`.
> > Instead, use ifeq to check if C is 0 or 1.
> >
> > Check that `make C=0` does not invoke sprase.
> >
> > Fixes f884bfe684f ("mmc-utils: Make functions static for local scope
> > enforcement")
> Nit sha1 should be 12 characters.
>
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>

Applied to mmc-utils, thanks!

Kind regards
Uffe


>
> > ---
> > Changes from v1:
> > - added signature
> > - add test line to enphasize it is not a revert.
> >
> >  Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 06ae0f7..c0284bb 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -27,14 +27,14 @@ progs = mmc
> >
> >  # make C=1 to enable sparse - default
> >  C ?= 1
> > -ifdef C
> > +ifeq "$(C)" "1"
> >         check = sparse $(CHECKFLAGS) $(AM_CFLAGS)  endif
> >
> >  all: $(progs)
> >
> >  .c.o:
> > -ifdef C
> > +ifeq "$(C)" "1"
> >         $(check) $<
> >  endif
> >         $(CC) $(CPPFLAGS) $(CFLAGS) $(DEPFLAGS) -c $< -o $@
> > --
> > 2.48.1.362.g079036d154-goog
>
