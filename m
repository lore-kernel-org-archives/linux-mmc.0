Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0523A13BAE6
	for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372783; cv=none; b=IGix1Gtz9Bjw31Yq1qkn6AA0povZO98KQlVD/7LQTyxHElzpuUCwP5bNbxMqVQGBQ3ISuywQgs0A33drux4e3GlTg/z58eYwhkphQpphYsmRV76kIhvO/TWvr9qbSJIqQkD0CgyUkSif+kkoNmdUEUsb2EacRK0AZgjhW3GNS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372783; c=relaxed/simple;
	bh=2V9uuyJPhlig9+/4XmnPnpe+7jmkoupBMH2zUb1Lchs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvjA/LQQfFnXrXzN77gKjwMgOthoOHkcQeKsiWlpwapsLtBj1uEAoTb83+NQFiUffIJSOCZ5gSMiYJQXk+D4z+X6KvsPioZSQ6FyILdQKMbxDTqTyhLsyCMuLICeskjoChdpZpvXVyYdebSOURsdS1nu8AI3JZiBLuAbGF7Aoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Idpai2EV; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Idpai2EV"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso4221192276.0
        for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372781; x=1711977581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BjNMxVepD+YX7ysye0RhbHMEfHTEI6sx86YCOKWHoWM=;
        b=Idpai2EVeYFY8RSPVKaoQq3xVGcTX6MkHCh8hfta2GmZ4ym2KUFyPCzoQ9RK4g2FvR
         Y9vHU7UGQXAsIfLxLbsxT880zvP+I8z+zwIyuSBoothYbTaAgmXnGpPZk+s4ora3h8RP
         4Dq8k2ocTGFQ9BW+5ABYNNepoO+bp1YfDn7BOkJMHVLE1V+/LMNvd8CwXiY48SUNORii
         wEAsooB1zybfinDMQ58qYEffULw2ezEOLOk1vxCT+lu7mVh3n3thV8Z5PnPVFLgP2Fei
         6gcxPbvGeibkn4K7gmxKMbZJz+Fs/TYDChgEH/pTR1G8dbnG4JtF4ZnMzArGrthEdk5V
         A05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372781; x=1711977581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjNMxVepD+YX7ysye0RhbHMEfHTEI6sx86YCOKWHoWM=;
        b=sIclFzoQ+XMAGyBGY6SFvChaaKHt9bhC83fVQ+8X/vNgxqzpMwVubPwmGHOj03a2OZ
         qh+T2pvHQ4EyGXzALhKmP3KRWfC/zzseHN2JKM/XCOWPrSHpctJGv3h7erN27RJjS+fi
         lx3b2kSGAulM/eoSVLMUjNLMq3az1NkQDVuoqAY67a0gQbn0yz1RbC36R6OezzRLH5nn
         ivWq1XfGh2LPfw5Uhl2gQ+jq8ri3LlJ8NRE08jISAbqXOyzENuN4kG9PLDQxmxFy/uC1
         Fg2ckRdSW4xQEeHX68+Kl8U2bkXafy9trcOEccR/Srh3EQDyJsQCPXNnhiU1ZuVl87+6
         /PMw==
X-Forwarded-Encrypted: i=1; AJvYcCUDO3bdzNf+VXWIh3BM/gZJd8jJt4qUrDEJX15LCQ5DY0RWCh0X6jUdB5rNYO1jPPxoZLWm8TaAES7IRTuVzgpZ34J695Ib1/qJ
X-Gm-Message-State: AOJu0YwmLPR1cnKS3MPbJM1O9LOiGn8bDw3BbLJtmt7jyXgCs1XzNvWO
	l7kzvL3LwzCV+XcpIvFSkKRu68UI+sfABZcRbJEPfyGxXKzfiLzRJJonBM0uTPx+JPDbnkD2FzH
	lwLsPoubOgYpqVM//T4qGFiRGXUp+1an9hTr0fA==
X-Google-Smtp-Source: AGHT+IGnDoTkiAyGAjMYuEX2XuLCOVNO1nePZFio+38KODS6eBtIiu0pZ9fQyrKx4iI0l11mvrR+O5cV3EWfnrt4CNk=
X-Received: by 2002:a25:868f:0:b0:dc7:49a8:e148 with SMTP id
 z15-20020a25868f000000b00dc749a8e148mr4637616ybk.27.1711372780959; Mon, 25
 Mar 2024 06:19:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320223837.959900-1-jm@ti.com>
In-Reply-To: <20240320223837.959900-1-jm@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:19:05 +0100
Message-ID: <CAPDyKFqRer67XAHjovD7k-dcrtT2Oxpr-Gh4XUSaH+iS4MCcOg@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Add tuning algorithm for delay chain
To: Judith Mendez <jm@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Andrew Davis <afd@ti.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Mar 2024 at 23:38, Judith Mendez <jm@ti.com> wrote:
>
> This patch series introduces a new tuning algorithm for
> mmc. The new algorithm should be used when delay chain is
> enabled. The ITAPDLY is selected from the largest passing
> window and the buffer is not viewed as a circular buffer.
> The new tuning algorithm is implemented as per the paper
> published here [0] and has been tested on the following
> platforms: AM62x SK, AM62A SK, AM62p SK, AM64x SK, and AM64x
> EVM.
>
> The series also includes a few fixes in the sdhci_am654
> driver on OTAPDLYEN/ITAPDLYEN and ITAPDELSEL.
>
> Changelog:
> v4->v5:
> - Add dll_enable = false
> v3->v4:
> - Add acked-by
> - Remove extra newline
> v2->v3:
> - Remove fixes tags when not needed
> - Fix return for tuning algorithm
> - Fix ITAPDLY_LAST_INDEX
> - Use reverse fir tree order for variable declarations
> - Save all ITAPDLYENA changes in itap_del_ena[]
> - Remove unnecessary parenthesis
> - Remove unnecessary variables
> - Save itapdlyena for HS400 timing
> v1->v2:
> - Remove unnecessary indentations and if/else in
>  sdhci_am654_calculate_itap
> - Optimize sdhci_am654_calculate_itap()
> - Call sdhci_am654_write_itapdly() in sdhci_am654_set_clock()
>  instead of sdhci_am654_setup_dll()
> - Change otap_del_sel[], itap_del_sel[], and itap_del_ena[]
>  to type u32
> - Revert unnecessary reformating in sdhci_am654_set_clock()
>  and sdhci_j721e_4bit_set_clock()
>
> Judith Mendez (7):
>   mmc: sdhci_am654: Add tuning algorithm for delay chain
>   mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
>   mmc: sdhci_am654: Add OTAP/ITAP delay enable
>   mmc: sdhci_am654: Fix itapdly/otapdly array type
>   mmc: sdhci_am654: Update comments in sdhci_am654_set_clock
>   mmc: sdhci_am654: Add ITAPDLYSEL in sdhci_j721e_4bit_set_clock
>   mmc: sdhci_am654: Fix ITAPDLY for HS400 timing
>
>  drivers/mmc/host/sdhci_am654.c | 176 ++++++++++++++++++++++++++-------
>  1 file changed, 138 insertions(+), 38 deletions(-)
>

It's a bit unclear to me whether this series is actually fixing a
regression or whether it should be considered as improvements for the
tuning logic. For now, I decided that it looks like the latter (please
tell me if you don't agree). That said, the series is applied for
*next*, but I also took the liberty of re-ordering the patches, so
those without a fixes tag comes last.

Thanks and kind regards
Uffe
