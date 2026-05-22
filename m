Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D7728F948
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779433148; cv=pass; b=KSvP8myxSTAnCUls0ssdPKar6e26d6tj//9KAl+YDj28Dn9Z7RpY4HRNyIPTS1aYhjaTo4GeD7aP1WmGjrIA9WowUYSvjv8dBQgY+8DbKKzR3tKn02gdSRel27q8vEXXjBS+51mt1mvd+ciTMZ8qe5nS1kQOUuSuIOXRagICUsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779433148; c=relaxed/simple;
	bh=PykdqMX7c1PpBgsORPKL69NgyLrJFep++3AS2tIT3UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWJlRFj5ycBkb2w4CjpcMTCJArhP1MforzoOwr4zOx9VmxcVpGqu8l7f3qyqfvxfgjdEkfFdK9Fj+TTFbnDNwS8rmmwVXPy092w1gKOb7kqL4sLI+6+d/mMZbDaEw9w9RTpe2m3BVQEP8I9frN93H9ePoPbhfeTmWH2acsdhzNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p7QmQNKc; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7QmQNKc"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bd2e8931915so1523765766b.1
        for <linux-mmc@vger.kernel.org>; Thu, 21 May 2026 23:59:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779433145; cv=none;
        d=google.com; s=arc-20240605;
        b=Ow1qvaq5egHJ1XYlGpv+3wcZAGhB/XpoRaq1kf15LR/bR/H4ivhCyDYtQbFtYl9vdJ
         s6npd93Hv7EWkP4u7TuK4CnafuzWDl4gqh090YPXXvfxDJOEpHSJptbOeUem/3k0EuXC
         inD8iirgleIfP7zcho9iU9Wek0x3+r43fTVGDFPXHFPX4qEsGMlCMsUQhhEL6tDN2cmL
         a02m12asKECdrV2WOP0KsqTR3RoamFq4OA1QdmL0ZxaQlcGKBun+rIs06qPlvqMxNBTy
         OgkgBR7VxvkqpgWELWryw46fufXVkpq+Yfc5Yk2AqdiEdSbBivAps6d7ls/d6ECnIQZa
         3rxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wr4ReVPYz5vfw1Mgrh3+nU6L4+BC2uZrj6SgqvM/nt8=;
        fh=ZUlvDF/MpI51vfeK+nkw/McjO+/e9PyMohg2F7YZJDY=;
        b=JOv2JuiDUU3PfEURl0GOrky6dyll8683ttOm7tD/UuYM4zpzUnDxmoLVI66bK+SkDw
         fSdrB8sUb6yHxX4F30h4pNjQCqOxrEHWQlK3RDpiocr+bpyg273yC5j4tByNjmEjC1bl
         9FArV+t99IXkwdZTWiATLJjDzHmuPDSbJ4rLgVlJM4K0M909V8AhHYOawzEetdXQwM9V
         ygmUQVkI3ycGt2Vsg6nsUQrKi5XWwN/pNIM4RaNYNi4bBLJo9jJlYETNYxnQl0LypDLS
         YvtOL4lCW2gV5N+YO3utlJMXnqbZb465GFJyZBCKWHBah/2DGUa5RONp2rWgE+dBKzGo
         Ie6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779433145; x=1780037945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wr4ReVPYz5vfw1Mgrh3+nU6L4+BC2uZrj6SgqvM/nt8=;
        b=p7QmQNKcNjNnERkX830ESrpRisLb0rB1P+ChUXqv7Q0NmaSKdDQGPg+k4cIr00cMnP
         +3il41NcUvKjD0QSQIY4wlQfm7j11jGUH6ad6XhHk3L/M43EUOFtcDbmEm2pluJHZOq+
         vKffIokyRjFBAK2FST/ee4/yPmhXUauQr6HKd/4CK0tORZqbOLvgAIYi6oWoMluJIqvL
         DzKBkcDCTlz3YvCWBMZPP3W05bmmxZwdxiAHs6KRtIzyKRm72RqXLjqXsWuyLYOtBUA+
         AxX2TtZ78ArMjHmOYqFqtU4insq45LJbKR/pJiaPWnxqkN+EzLGYs1eWKqHAY86vJIiE
         jgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779433145; x=1780037945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wr4ReVPYz5vfw1Mgrh3+nU6L4+BC2uZrj6SgqvM/nt8=;
        b=ffMNxsCNIgkLM+ccN0FEgJoj+LJj76uySrrd/WmC/ExJfcH3Uj7kpH9dFqTxsaeTuj
         m+Y40PKp5zKM09G/sLLlayFTbjtPIbFXFbC97iV4OjXPHePm4xBqmVJYqmhXgoSJAkqK
         VQuUBlbcJlLynlIV4oDGadnS18Y16BA2yGt2o0A2n9eweV4asMrg7o83aTJuiWPOas2T
         kG6lfCS1yh7S1WfKzLYq4bu1UXd+NKl6DSxW/vLDI/IpfjpUB5lp6wPUZEHggCypP76R
         0XIbgUmaXfGvaDfo5JCDNFKs+ZcJYVj9c94scfKbSno+CbeYE2K5GX3giLURTz7WVyHc
         dKcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yFlr/KtKbzj2m6vy32dQrDUrihS08Cjj20gCP/Sy32/sZsP58FDzG4pG4qPM+Yu8mdUUzgfP0UXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4BJCLqipXdjWY9aXviq493V41Suq8bSlSuFqLPV4/faHKLF/j
	s212nKqGjInlidu+pfj0pIj3ZhGPbxMBadF33Q61+JXBg9f60s2t8EgeTBuQ3eMIRTDnVUN+u2c
	ayhMW19PRC3TwReYB3uWzifkoF0lNmzc=
X-Gm-Gg: Acq92OFv5xxUZ3PJM1X2O5xSKR1F7V9qiLkAL0oHHuU1M78bYow6VF/O3O49xKwaBrZ
	itITj9QkLNQYBbVbnBtXY2btBMa+ovpORiWO0wCH0CzUugoFwVi4tAmLgv2TzKX0CN16ogH/Jda
	L8hGSD4GtpQpJnGWEqvrT1NqVtJeicGAkofhxGu9Xa/755mnsX6R+wbg6LfEpa0W/pp2iTEQ1x+
	fWw5h5BdytiKIh+kzqEIJ0uzZFAVLcf/Fdpz7XoyW5rWQrEMZxB8LBKVdPhThKA8J4SVQFijXIC
	EGQYuG9JICxkgAmwpAI=
X-Received: by 2002:a17:907:7ba9:b0:bc1:8598:f329 with SMTP id
 a640c23a62f3a-bdc0132ff46mr328232666b.21.1779433144820; Thu, 21 May 2026
 23:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521083506.356422-1-a.shimko.dev@gmail.com>
 <20260521083506.356422-2-a.shimko.dev@gmail.com> <201336a1-3b8d-45dc-b2b0-3fcac611eac1@intel.com>
In-Reply-To: <201336a1-3b8d-45dc-b2b0-3fcac611eac1@intel.com>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Fri, 22 May 2026 09:58:53 +0300
X-Gm-Features: AVHnY4IUtWI8QgSssFABwYVj0U_ZErzq30i-vbo8TocetCsBOk6coD_cQsK4qFc
Message-ID: <CAOPX744+iK+Okhd5rS1uXaFgCcA7CndYeJ38gB2Mv1T=TQG7CQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: sdhci-of-dwcmshc: improve delay and sleep
 handling with fsleep()
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: andriy.shevchenko@intel.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Fri, May 22, 2026 at 9:01=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 21/05/2026 11:35, Artem Shimko wrote:
> > Replace usleep_range() and udelay(1) (for consistency) with fsleep()
> > in several places to follow kernel documentation recommendation [1]
> > of using fsleep() for delays in non-atomic contexts.
>
> The usleep_range()'s have presumably been chosen and validated.
> They cannot be arbitrarily changed.  And then there is no point
> changing udelay() to fsleep().  Please let's just leave this.

Sure.

Should I send v3 without the commit?

Thank you!
--
Best regards,
Artem
