Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7566E230264
	for <linux-mmc@vger.kernel.org>; Wed, 10 Sep 2025 06:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757485051; cv=none; b=sVdngb6hSmbE9OxEwwbRm1TZJoW00phYa3+NxVgGqXnuMB7CU33dC2EzR7ankyOK+qq9zAk/W6HK8FbSY/Ap4Vdv5ituGaaygHHL6vjT17sR6saBlYTN8Z9SiTuWnB+WnynnKqBld99greCzDZAQ6sazFYdu+luI1TG16oCk41E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757485051; c=relaxed/simple;
	bh=CIwo8p6QqtdSX40l4FEjE/kdQDyk02vI02UZXSw6rqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndIVJOkBpqilmN+jmRrOSGNMQalVvuAyuCFUkTm9Ze0ZO+FPqO7h3wGEKHZLlHWgMNzIqYQPSbi0+Eu0AO4LUZounKLwdDOW46I11zFU5F2iepQ+jbFaKPH59nxutKWsZ3tZRQktGyPdYIu+8tHMorv5tMw/pdoxJLFGtQncR68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eE8gx8JE; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eE8gx8JE"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74ee68bd763so879443a34.1
        for <linux-mmc@vger.kernel.org>; Tue, 09 Sep 2025 23:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757485048; x=1758089848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3EFzRI07IUvqZBHdTIdW/XHug72o9GRti5jGTLt0+A=;
        b=eE8gx8JEQe3rmCBnQ7uXIyceR58U5TJ9DwSO8TYkKVGq2eqrF3oqQkNuLUVhtT5C9H
         RAXTDyNvYrqi/Ado0Emb/deC7ztwCR+JBB7iWRvJiCz1DMqZnysUJDjS0kXy3Ydnkcxd
         sek8q68Jvk3RkEFiDiaDIbUlaG/ou47ridx79v7X6z6Z4pGT1GMFQUyDdGUXn4s8Hj9B
         cE9B6TcgKYiJ7HbgiKmgkf3HF81mpGM4tAmO5r7yUCchP0onoGLVPu80TSXjhRBjBea/
         +aLvusQVVVJvxZ6L/kjrQ06eNFM0MU3vIRa5WhdRP2eybn2R3MaJziSnWdBkF+bh8oYr
         Qb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757485048; x=1758089848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3EFzRI07IUvqZBHdTIdW/XHug72o9GRti5jGTLt0+A=;
        b=fNaZ41z4nyiJ45q5nI3ZrSkyTvTnjPJXZ5Fa2v6Dngfynmw4tbKhxl+Di/9t8+5BhF
         nKmX2fXdgJc6eDxa377AYrvcx4hBrfQck4qxvJJaMRC4JLPLz9kAmHcE02PyUmNqKQN6
         OUGrVd9hJqOKjvOcIIkxdG5watgaYskxroqC5Ztgr1EVzGESod95bwQcCB4Aei0HJBpS
         Za1DCepEJQSBweHaRZXp/axYiUTRko/sCtxKbdRxG23grKFRmEazCjlNyW2+qCvNlrzD
         Qm0kUx9OMnDKKptzmue5WKg0Fg3Cl/j8O1AHwrYbyVfy/mzUikRfwpyj8kHfAY0kYoF7
         sjTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWehxhTZmWLJPgAb5cCSaiwWcmiVChsQ7uVuAmclWYYyQok9yDQjIBZdaZz2j/J/ubInlO3TE+lE8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/QeLfDpiqUZL5XkSu4Oe1a226cVOtagipQCAw14MZ93LbQYWr
	s8foXj/6CdLSjlFdWc0IWSQgzIt0666k/sO6tQIWpvD2y9p75IFJe8uRIOU1eOYlADAK0Aiofwx
	g/pZXS+Mw4QJWYthtPnLLj1liT8dWev6f4Dvy00k1sw==
X-Gm-Gg: ASbGncuNnDfd5jxGfpsDpkJOXGaPX2pWX/CjIuYnu81ydgS0LqGUtfUx2Tuo2o8r7tG
	JN82dKLb/GwUS05pxHmpdy4AvFvK87yIdMvSsaANuuFsa5+Q9O3HypAO5ydFxfijEGqMev/WH4n
	UO2ap3/mAVyqBeGi9fkfhFzjcMR0VBFcaaMMgNlFyQTuY8LClEVnykoVSqz8YC5FwsYfJN8zvLH
	dk/0Lp+
X-Google-Smtp-Source: AGHT+IE7lRlQkJ3hgsk8H/9jGxAL9ADt7dYRJ2EC9lnTn8FIKrdgZyfWKjzBqJrQQnr7Wc+j5ZfC8zfT2IwALQeFluM=
X-Received: by 2002:a05:6830:2a11:b0:747:b09f:a868 with SMTP id
 46e09a7af769-74c6ee33d14mr7689428a34.2.1757485048431; Tue, 09 Sep 2025
 23:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909211316.1857198-1-beanhuo@iokpp.de> <20250909211316.1857198-2-beanhuo@iokpp.de>
 <PH7PR16MB6196EBBBDAAF16EB09095E8EE50EA@PH7PR16MB6196.namprd16.prod.outlook.com>
In-Reply-To: <PH7PR16MB6196EBBBDAAF16EB09095E8EE50EA@PH7PR16MB6196.namprd16.prod.outlook.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 10 Sep 2025 08:17:17 +0200
X-Gm-Features: Ac12FXxSXtn7t-_dBx6uGFouuJ_wdt_OeMmsMyIDM415LRFlQQDU-WNnzBH5WPY
Message-ID: <CAHUa44EP56FFJJu4X6PUi+6yYcRcON4RzQecJMecUfq6WunRWQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: core: Fix variable shadowing in mmc_route_rpmb_frames()
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: Bean Huo <beanhuo@iokpp.de>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Bean Huo <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 7:42=E2=80=AFAM Avri Altman <Avri.Altman@sandisk.co=
m> wrote:
>
> >
> > From: Bean Huo <beanhuo@micron.com>
> >
> > Rename the inner 'frm' variable to 'resp_frm' in the write path of
> > mmc_route_rpmb_frames() to avoid shadowing the outer 'frm' variable.
> >
> > The function declares 'frm' at function scope pointing to the request f=
rame,
> > but then redeclares another 'frm' variable inside the write block point=
ing to
> > the response frame. This shadowing makes the code confusing and error-
> > prone.
> >
> > Using 'resp_frm' for the response frame makes the distinction clear and
> > improves code readability.
>
> Fixes: 7852028a35f0 ("mmc: block: register RPMB partition with the RPMB s=
ubsystem")
> > Signed-off-by: Bean Huo <beanhuo@micron.com>
> Reviewed-by: Avri Altman <avri.altman@sandisk.com>

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks,
Jens

>
>
> > ---
> >  drivers/mmc/core/block.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> > 9cc47bf94804..dd6cffc0df72 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -2936,15 +2936,15 @@ static int mmc_route_rpmb_frames(struct device
> > *dev, u8 *req,
> >                 return -ENOMEM;
> >
> >         if (write) {
> > -               struct rpmb_frame *frm =3D (struct rpmb_frame *)resp;
> > +               struct rpmb_frame *resp_frm =3D (struct rpmb_frame *)re=
sp;
> >
> >                 /* Send write request frame(s) */
> >                 set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK,
> >                           1 | MMC_CMD23_ARG_REL_WR, req, req_len);
> >
> >                 /* Send result request frame */
> > -               memset(frm, 0, sizeof(*frm));
> > -               frm->req_resp =3D cpu_to_be16(RPMB_RESULT_READ);
> > +               memset(resp_frm, 0, sizeof(*resp_frm));
> > +               resp_frm->req_resp =3D cpu_to_be16(RPMB_RESULT_READ);
> >                 set_idata(idata[1], MMC_WRITE_MULTIPLE_BLOCK, 1, resp,
> >                           resp_len);
> >
> > --
> > 2.34.1
> >
>
