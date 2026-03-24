Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710A23E0C41
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357088; cv=pass; b=BZtcoZ7vTbXMawFL/4Aw3q10tU2/vOwXS/ndayfUITz6vWv2LvdW/Jo5SEMtTOUGoHC6u6Fo2+mIDfC/RQrpilVhVZfx1sBPQw/XnUylN5CIOUo83GIbYxCT15GPE7vYM7A/GQiG428CjWiAl8fh0WET2Xz9p738k2u14t+psiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357088; c=relaxed/simple;
	bh=qSjkKhFylhqFiBn2Bkj5KC6mFvDrD6D6o7Jn5/5wioE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=timDPpUXl33Ns/19RzVkgz1lc/ayoHEs2wK9nxf+TWTqpxA2xmpX/ZnnPdkLzkQTFHq4iMu2RSrKVQKInsxUv3glVAaYjFQ+BTMRM9nGKMifTZqo2MlWb7SHo84IkD4AwFPQ0iuXC43PwzhMFvgbE6tu+cepKbbcv/uhowzK3z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DEx363f4; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEx363f4"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a27dddecb0so7321033e87.2
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 05:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774357083; cv=none;
        d=google.com; s=arc-20240605;
        b=WOU7dtjkm0dZzr1uTTfbOJh3nYmqne6h0sZq2ultzjjoaEDW9dCAMCbFBDe24Rm0Kg
         z1XK4Msq54x47h3rG6QW4XI3JFxbOfQsl8YNhk1M/HuxA8EcM2waPQPwTyefkbjRIM0F
         zapK0lhglTnVyRmOQ/6kHlBq+umPMflRsFFX/VNrVEkWXSSpJnIAo6Nswtj4IPc/6SwB
         0yqbp6CATnZior5uFgrDE1TbWenVhX7OJiQTrVEC40hSHUp/NlSrkZsd630RgrUrVd0f
         WHOCuNeUopCrnNQxGvIjP6/Mnm8caAISMF3+/usUy7xSW3fMkAjZ8D3v3FR7jyHqNfia
         jGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qSjkKhFylhqFiBn2Bkj5KC6mFvDrD6D6o7Jn5/5wioE=;
        fh=lxbDCqcMrUE7tEIoyYXJwrU4V7EAA70OuyK5wiKgmSA=;
        b=ZGrrzF3ZOZx6IJXk4D5o/FyWefPGjE4B047fucxxl/6797UTt9l1h32ivDLJ2gdGGZ
         PpUp5gkJoAR7BPfU1RWlxFXkC0jmC2re3PjO/C1dkWm9oNSRsEKvCdTbenJslsyd4eXe
         rnA4/uZ4Zx8ce23LVZwqXA+4Tu920s+vbctDiBi6/sM6g1+tww+BARcApIHKU8bvO0RA
         +3ImWvch+zf05/mDyx8ICHgQnCmwZ/+majmc40MPVkSd12Dyp6vH3ZPo3OoAWzLOMIFe
         ACY4HrxbGHP2w9y9xS01AqT8LAcQXhZa2MZ4GHoXxbvEifMeacJ25nmlfGRCTNrIbtbG
         nV7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774357083; x=1774961883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qSjkKhFylhqFiBn2Bkj5KC6mFvDrD6D6o7Jn5/5wioE=;
        b=DEx363f4A93kwZuU9E9v4smgfHeW6eBob9U97dDIQImhDpkGue9/kb9L/HZLgvYdul
         u5AZt6+hkj3ekHvYTqlD4DG8LIehzoyCDiYY5QWaoZuYwOA8QBJQDZhHg5US8wnrFahe
         0rZvxttDyK8ig2X1CY/WKkgiEIhTQ9hlW9/b5jpZLIH0Q/lzulJGyjvlohEp29HQTDfu
         2NIYUozbzD0MZOy+6kaWNS+x5iydDmnAcIoAV8mwUZDccUqZ5Y1YZzh5bOQqyXCztEsb
         DYQGJFgRvFxeqSKWMXWLfcXDHBj49YQNrEiqA+pDXf9HC+aAeLO7QLW9pSTEOFy4Dycw
         g+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774357083; x=1774961883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSjkKhFylhqFiBn2Bkj5KC6mFvDrD6D6o7Jn5/5wioE=;
        b=D31kSmRKhrDxrXaJV2HloxbsxXk6OfrfOiEIacPSM+y1qCRL20GSq4xbCI8gM8RXSa
         Y2Jozl1qCMluWisNk+uEfu5QDwiAnHIWDGOiuF6SO4NoWJqeKtFnW4lyMlYMb7A32t+k
         qU0M3bZcUnxJt2M9KHZiMMJ0k55ym28MqZoCYG6AYVSG36FgSEHVf1nYxsXtJdxa8Gxx
         mkTaJCgoXyMgPmFxTF+hD1+oTyiCTBVba6WxhsFFujAbxJY1tVVcQDhMgYJk84Hi7yn3
         IB+KL9WEEMaUuG0vml/HqOxvPYKqlh7yKCj7R00uonGzly6UH/ZsbTnOv6aoJM2iiRqR
         p3jg==
X-Forwarded-Encrypted: i=1; AJvYcCWGHcKslLJPlwfQe0dqenwrD5WzEvn1rZrvqK48cf/sE3RAfmu0vknuvZl90tt9E61gfxh88m4D/pU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGyLFIT8Tj2v4kxOQnsb5qg/HKbIWJF+zZ+Rj5W/IVMCjTOxt6
	2eEv+FKxtxwHJ4CM4IDDJXgFVofsBwux6K+d7Sd9n4PRqkanknkoOZQrvp0GFxT6OgGOWXo6NLC
	HHjJ1+fHKit3AcrCTQpDguGcUtOUPn9P0s9vLFxLQp4qLlhtZrQSM+64=
X-Gm-Gg: ATEYQzzdsVJaGvsOXWzSS7WhddYcrzhYfmh9vOhxIP/EngcDKAtbNVh8LPflIUiiqlt
	N1tPhmK7PJZ0C6z/lEtK92rpbitbVvYwm9gVP7JwJw4lkFz+F6hBrPwP5U7MqC/R1wMQiL87o6m
	h+jID41MfoqUX5UD3duzASXWc+h7Ysrx4J2pljE4m20Wa0ijXeudS/TKX6VHcIarLJq6poJkdHj
	P68gVvLTPxsPKAJkggYVgfI96X18snV9baDQnWGhY9Y37JU/ZrJtywXuFYj0r4jw95AKyYn3pij
	l1lA004PkE/OZvIMn1g=
X-Received: by 2002:a05:6512:3094:b0:5a1:1914:2bac with SMTP id
 2adb3069b0e04-5a285b4e0fbmr5386037e87.25.1774357083008; Tue, 24 Mar 2026
 05:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305194052.5120-1-sean@starlabs.systems> <20260312121559.19197-1-sean@starlabs.systems>
 <20260312121559.19197-2-sean@starlabs.systems> <CAPDyKFpueaHyaOGn5Fn_JdnD4kPeBsDcGx8ykgnuyJ=CFPyxyQ@mail.gmail.com>
 <CABtds-26cuCMZbRhAaioOOCcX=w6J_mpCxgxahjwz7QJEZqe5Q@mail.gmail.com>
 <CAPDyKFrjhNj38dvvf5AGjCxSKkX02C-B6h4+dX0iOxyOc+Hruw@mail.gmail.com> <CABtds-2DjtJ=8GzNdi0ZOLPdBfGWdfeXX790o_gvNVE=d9+=Pw@mail.gmail.com>
In-Reply-To: <CABtds-2DjtJ=8GzNdi0ZOLPdBfGWdfeXX790o_gvNVE=d9+=Pw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Mar 2026 13:57:26 +0100
X-Gm-Features: AQROBzBKBBtwCao3ZKag3DZmXxkPesnjLoNkTlIIwPg4lcoltD3Wvj4VkAO9NAQ
Message-ID: <CAPDyKFqi_Ayc3kffNHvhTmNSxjMhSAa7wr4rQuP6060ifH3y=g@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/6] mmc: rtsx_usb_sdmmc: avoid false
 card-detect on tray readers
To: Sean Rhodes <sean@starlabs.systems>
Cc: Ricky Wu <ricky_wu@realtek.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2026 at 13:30, Sean Rhodes <sean@starlabs.systems> wrote:
>
> On Tue, 24 Mar 2026 at 12:23, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 24 Mar 2026 at 12:59, Sean Rhodes <sean@starlabs.systems> wrote:
> > >
> > > Hi Uffe
> > >
> > > Thanks for the feedback - to answer your questions:
> > >
> > > > Would you mind elaborating on this so I can better understand the problem?
> > >
> > > SD_CD is used for presence, but that's asserted by trays or blanking cards.
> > >
> > > > What prevents the MMC core from handling this correctly?
> > > >
> > > > Don't some of the commands time out, eventually causing mmc_rescan() to bail out?
> > >
> > > It does bail out, but SD_CD is still asserted, so it tries again. The
> > > main thing this breaks is S3 entry - it's either slow (like 100
> > > seconds), or never gets there.
> >
> > First, please don't top post, but reply in-line below so we can follow
> > the discussion.
> >
> > It's the mmc driver's ->runtime_resume() callback that calls
> > mmc_detect_change(host->mmc, 0).
> >
> > It's sounds to me like the mmc host is being runtime resumed/suspended
> > over and over again, hence we end up calling mmc_detect_change() many
> > times when it's not really needed. Right?
> >
>
> Correct

So why does the rtsx usb card driver do that?

Could it keep the mmc host runtime resumed for a while and then we
could add a debounce period to the call to mmc_detect_change()?

Kind regards
Uffe
