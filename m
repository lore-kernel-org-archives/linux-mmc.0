Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31CE1BC26
	for <linux-mmc@vger.kernel.org>; Fri, 15 Mar 2024 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710500148; cv=none; b=unEcdXupgvKC+SeOGlW+vqf8jqUToXk0zrplQTH25p/QleTpx/F1oQDIzXX0bIMrJ2/bxm+DTK9F+7Pr3h4ixSqaDpjaaD8Lcno/qLR8JrwEDfoQr5/v7BdI53xnmSsvfRlSN+rHMebiqRKXgI4AAN2oPnbAowGpt8dQEi4okbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710500148; c=relaxed/simple;
	bh=gKHklsfF2gox13da7B8q8n6TDTbEdarDO5cbu28yMxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDW2Y/T9O2R15GyDszi7VAHF95E82zzf4cxSkv1Hb8l6Zj4WZrd8Y9FBN2HGrl6tMY5SKbyWA0DXRTuGX3oY2TYCPEilxubUS7Ttc8wzWTOFuZ08ex5wZ3LHG2hB+T9i4t9KWAp7ve8+9OteBH3MTowOz/0WVSDAt0G7/LcNBTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=chSEqUNx; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="chSEqUNx"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so1786416276.1
        for <linux-mmc@vger.kernel.org>; Fri, 15 Mar 2024 03:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710500146; x=1711104946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aYCVB7vuASjmLwIHPiyxNRZapV4SHyBblFxELE1dC1U=;
        b=chSEqUNxoaFiGa5ivgsGoFfAX9NRw9sBPQlCwTGbp86pz8IhQGbYQzvWlTW2I/z516
         McMxoFVxHbE4TW5b3+k/9di3rOte1D3Hp+ocXMWRmTjYfgkfKG+WbqaE0Q/QbRQt4OIc
         ECsPWWSHYBccfVfruIMTJsSjaeBZxNldtNbobKE6g0PDNzLWwAfjvS5EjuZArb+NpRdH
         duMYCx1q0yRHMfqO3Sm3AYjesOW5sd4GI6q+ivaxiuio+lH0qwAZZVRYIbgu7oKXo1PJ
         0cvwj+aTY1f4x7AqpMuFJi6dgnzPstUygqXug/v5iKnbnGhXP8t7jYcryf5Wiob4DeMG
         wiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710500146; x=1711104946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYCVB7vuASjmLwIHPiyxNRZapV4SHyBblFxELE1dC1U=;
        b=oe0Trm6gOInrqPSe8SOxNlvxGnTzzGy+Q4bAzaIXi5iSqqGPyy00gYxMC4KUn25iEO
         NexfwbONdIJNxQeNQXuO+3PzVc+nSpY0FGDGinXSP4WjQXRsW6A2x7/saU6+x6P9Y8+H
         46M64gIv0aak+kMeW4QsGb+dClkBWnXhA9iKAgk1wbFSkn6ByQ9lLDfdBl0pQPdDZ8Ya
         AZznC/0X/hBbwukz7avm8MOiY2h7k60urYIwVdQWsHy+mU7qCeF+iI2BjG5lY3o5449u
         9FeQd85585KALWMJXtn7cTON5oJkPccMncmWDykNCpnvD91Ib9GBhO/FGSXBjMHWNCN8
         Fdmg==
X-Forwarded-Encrypted: i=1; AJvYcCVx9E2A3bXqQ2agDCD57PmLPjSExDzKBFJhbGIkMYFOdr8LEEN/MTJ1MpVkkqlY8R3zXCNKyh49BRH+Hx10vOk8CzMpBTyJV6iP
X-Gm-Message-State: AOJu0YxBFJZSYNmEQuwlPaJmhmOKmoAy0ZPeBxDbi45xVF/G1tdeWJ3M
	M93w3ik/LASeEV2bxBO3idVcrMlOIANUA90MgGwXedoE9ZWWBA8J2WekOiXgDvC+xskC2fS6Dla
	ID/ExXfjq5F7MTvWIkX8XkZl3SLdcWHVjcxUnSg==
X-Google-Smtp-Source: AGHT+IEzehH2Yynt/EG5y4VxYs6FaPKWMrio4WVEdwJ7MoEI0eL7E+yiQcbwFj15WntgERZ8J5uQ0goEuQvfH5QlLNA=
X-Received: by 2002:a25:2e47:0:b0:dcc:4cdc:e98e with SMTP id
 b7-20020a252e47000000b00dcc4cdce98emr4286555ybn.5.1710500145700; Fri, 15 Mar
 2024 03:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314141440.3305802-1-serghox@gmail.com>
In-Reply-To: <20240314141440.3305802-1-serghox@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 15 Mar 2024 11:55:09 +0100
Message-ID: <CAPDyKFrP1XgJo_zDDunpzb6g8QWo4k3Ye1dJCWBGVvhdprCCkg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] mmc: sdhci-of-dwcmshc: Add CQE support
To: Sergey Khimich <serghox@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Jyan Chou <jyanchou@realtek.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 15:14, Sergey Khimich <serghox@gmail.com> wrote:
>
> Hello!
>
> This is implementation of SDHCI CQE support for sdhci-of-dwcmshc driver.
> For enabling CQE support just set 'supports-cqe' in your DevTree file
> for appropriate mmc node.
>
> Also, while implementing CQE support for the driver, I faced with a problem
> which I will describe below.
> According to the IP block documentation CQE works only with "AMDA-2 only"
> mode which is activated only with v4 mode enabled. I see in dwcmshc_probe()
> function that v4 mode gets enabled only for 'sdhci_dwcmshc_bf3_pdata'
> platform data.
>
> So my question is: is it correct to enable v4 mode for all platform data
> if 'SDHCI_CAN_64BIT_V4' bit is set in hw?
>
> Because I`m afraid that enabling v4 mode for some platforms could break
> them down. On the other hand, if host controller says that it can do v4
> (caps & SDHCI_CAN_64BIT_V4), lets do v4 or disable it manualy by some
> quirk. Anyway - RFC.
>

We have just updated the bouncing addresses in MAINTAINERS for Asutosh
Das and Ritesh Harjani, that also helps maintain cqhci. Would you mind
re-submitting to allow them to have a look at this too?
Asutosh Das <quic_asutoshd@quicinc.com>
Ritesh Harjani <ritesh.list@gmail.com>

Kind regards
Uffe

>
> v2:
>  - Added dwcmshc specific cqe_disable hook to prevent losing
>    in-flight cmd when an ioctl is issued and cqe_disable is called;
>
>  - Added processing 128Mb boundary for the host memory data buffer size
>    and the data buffer. For implementing this processing an extra
>    callback is added to the struct 'sdhci_ops'.
>
>  - Fixed typo.
>
> v3:
>  - Fix warning reported by kernel test robot:
>         | Reported-by: kernel test robot <lkp@intel.com>
>         | Closes: https://lore.kernel.org/oe-kbuild-all/202309270807.VoVn81m6-lkp@intel.com/
>         | Closes: https://lore.kernel.org/oe-kbuild-all/202309300806.dcR19kcE-lkp@intel.com/
>
> v4:
>  - Data reset moved to custom driver tuning hook.
>  - Removed unnecessary dwcmshc_sdhci_cqe_disable() func
>  - Removed unnecessary dwcmshc_cqhci_set_tran_desc. Export and use
>    cqhci_set_tran_desc() instead.
>  - Provide a hook for cqhci_set_tran_desc() instead of cqhci_prep_tran_desc().
>  - Fix typo: int_clok_disable --> int_clock_disable
>
> v5:
>  - Fix warning reported by kernel test robot:
>         | Reported-by: kernel test robot <lkp@intel.com>
>         | Closes: https://lore.kernel.org/oe-kbuild-all/202312301130.itEZhhI5-lkp@intel.com/
>
> v6:
>  - Rebase to master branch
>  - Fix typo;
>  - Fix double blank line;
>  - Add cqhci_suspend() and cqhci_resume() functions
>    to support mmc suspend-to-ram (s2r);
>  - Move reading DWCMSHC_P_VENDOR_AREA2 register under "supports-cqe"
>    condition as not all IPs have that register;
>  - Remove sdhci V4 mode from the list of prerequisites to init cqhci.
>
>
> Sergey Khimich (2):
>   mmc: cqhci: Add cqhci set_tran_desc() callback
>   mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support
>
>  drivers/mmc/host/Kconfig            |   1 +
>  drivers/mmc/host/cqhci-core.c       |  11 +-
>  drivers/mmc/host/cqhci.h            |   4 +
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 188 +++++++++++++++++++++++++++-
>  4 files changed, 199 insertions(+), 5 deletions(-)
>
> --
> 2.30.2
>
