Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0B625D53B
	for <linux-mmc@vger.kernel.org>; Mon,  9 Jun 2025 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479140; cv=none; b=HK6IElduVIeGGmZEpiyDmgzXuG8NU0aNPfLNsfGj55rGjwaJ34xXLQeL6fMTNt5wwInUksfIJnJQmIIoISYKp4dVrTDvKl/79eKJH25sxCpYYATQzPj13jnJ3PIB0Udz3i+d2A9c9B+b3dI41fjIJTD+ocfYERqljW+K7isUuNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479140; c=relaxed/simple;
	bh=kyCZGylePIRPc6/p6l1PQEVjFz3QH7t1Uv+tm5q9j3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkZIHLqljazEoWxbZxgoODMkLa+5kacbHLBIEdc/yEZtQTn0lC3/mTZxoWraefKgDB2Gi5wRNKxjyv/cJZNu3cbH5t75dsJ/WOzuiNmG3g+IH5GdTbve3MuD/SHbIMtVoG5pw2ecmCpp9YM7fsFNzMRrkJKSvnFFOeV40o77w18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=doyGoE8O; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="doyGoE8O"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e812fc35985so3839543276.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jun 2025 07:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749479138; x=1750083938; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=08IPBfBcl0I5u93yG1iOBKn0aIO2SlE43zAjUb4+G4A=;
        b=doyGoE8ORQ3JlonlZN5qvcxXaQbFwtRKpqrjatygXlexRIQkHaXjCxieATh2AVUeUG
         lX8nfz/e9y13pnNPNyie/GFg2e8L/vLD7pMjuYbJSidCQdw+YULlKP6F6oTpACjsXoYK
         rG5it7WepOfigGMd7wZLHOhgSKVRwUEIBcjbhumWXVPeREmI0R2jbv4UXpIPtuHIlj1P
         xyIv8OXh88rPTvIjRIu52EKx4gs8DQwp8jBx8N3f/Yzvg34/zgOo99yVV1jY16+C6GpL
         AiLH6/p/DIZp5KmYsNpaF6zT7sV9tkux9CK/93uAtaT3nR4J78rXiUZZ9eVJcOY4kcqB
         Lomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749479138; x=1750083938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08IPBfBcl0I5u93yG1iOBKn0aIO2SlE43zAjUb4+G4A=;
        b=w1mqYoH3e8/GGlEPw6QBQYI0XNjoAFW4fM5f6yrZAGE9otI0ZxItDKPRSxYr5o3r61
         H98OqYMHxUnkkhkJkFe88EOqWoSyumpmLSWLTL/LUIEYqaS+5bIU6xvFoJ6jX7CM05Ex
         Il5znUrRiOMU+N5OkfD45tkxRcFH1FT7e6F8QliYv+NIVZElEuiZ4NA50c6bnW2EwFpb
         sMPGujOHBafcRaZ4FJuFPt9PUIQSvD2zQd2g5IQv5zhrDDRGl98xtQj2TFFz12524KRA
         fc/+I39vVFQWA3DtgAG9faxCFukXJMUl1IiAC63VCxno1YHpBtrrX0mtnFjLz/XuCryD
         tyBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWATQRy7WJ03+P9wC/5zbEOmUVzFUOvpMh1gmwgC6tmVe+1K8SB7T8lAkwrEXbJNF/MDndEQ7TXKQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTpLkhypFoGz6uJIbizCc7JjD9t9pOFVx3g0ZegBY6dmohkwXp
	82MLDunLrUVAtXFU5nXuaDCkuAfne+u5Xk+ynCK/y1rcjQOErEKzY+5pEU05Jk/VtxfLd2f4VpT
	OJ6tIJoG/o/Zrac1tPFqhIdm4XhUnIHbnjJBreVYhVA==
X-Gm-Gg: ASbGncs2DinT0eV1RxCBUlV/PN6eMNzSWfAJ8DE9EkrY7gwDGQWERswqt7Lz9NVpDZU
	V78Lvn+B7gwGqzgysNbQFkhMsi7u5EEAo6n+d2Dz8isDRGUddE2s4VcPNWHreMLw538h8TnZg1W
	TXlsStQIZTUEvihlRNPEVMlvcubLrDeq9yQl6+o22r9YfU
X-Google-Smtp-Source: AGHT+IFJR4aUEYQFFbDZaS8lUqINbO+uSj5liG0a2YzJSs3reQoye8CT00DeZ0MCmOmCgc5uVI1W+JPgVoRQgVJQkXI=
X-Received: by 2002:a05:6902:2d82:b0:e81:9581:4b8d with SMTP id
 3f1490d57ef6-e81a22e28damr12881553276.27.1749479137932; Mon, 09 Jun 2025
 07:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523-21-k1-sdhci-v1-0-9f293116a7e7@gentoo.org>
In-Reply-To: <20250523-21-k1-sdhci-v1-0-9f293116a7e7@gentoo.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Jun 2025 16:25:02 +0200
X-Gm-Features: AX0GCFurOqp9D4c4_5rdTPaeyNA34lDzrdQDOcopYfWdJ2pwCdIenMEDwksvwR0
Message-ID: <CAPDyKFqUkjG8=f35CmGmTjN60_HzGnF7XihK7t8X1KA=kNSGig@mail.gmail.com>
Subject: Re: [PATCH 0/2] sdhci: spacemit: improvement of register defintion
 and HW busy detection
To: Yixun Lan <dlan@gentoo.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 May 2025 at 16:47, Yixun Lan <dlan@gentoo.org> wrote:
>
> These series address two comments from Ulf during the review cycle
> of version 2 [1].
>
> - improve register/BITs definition to make them less generic
> - drop MMC_CAP_WAIT_WHILE_BUSY flag to disable HW busy detection,
>   this is tested on Bananapi-F3 board.
>
> Link: https://lore.kernel.org/all/CAPDyKFoDWS6DWdKOaxTDEYeKv3hjVDoR7XGi19nESVssc-RG8g@mail.gmail.com/ [1]
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
> Yixun Lan (2):
>       mmc: sdhci-of-k1: make register definition vendor specific
>       mmc: sdhci-of-k1: disable HW busy detection
>
>  drivers/mmc/host/sdhci-of-k1.c | 140 +++++++++++++++++++++--------------------
>  1 file changed, 72 insertions(+), 68 deletions(-)
> ---
> base-commit: f7f05c5ea4af0f28cccfa49fe1af65e85dba5ef6
> change-id: 20250522-21-k1-sdhci-c987fd67c82f
>
> Best regards,
> --
> Yixun Lan

Applied for next, thanks!

Kind regards
Uffe
