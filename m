Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C40C33A702
	for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2026 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245460; cv=pass; b=Iut0MneaF5bXR/DWLMiQjG2cKz2ZQ8XGj23wVq5PSnBq4lYm148iZ2A7hYWfdst10lpAjqTIc8amhDnJfNfN07IUWH73kZHdk/TR0GfvLlV1DexxxIo/Vi/3rwMhDbeg6iWfcqXLi2u9pxtpMOCTlvKsnUK2mXVNtwPd+WY7SYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245460; c=relaxed/simple;
	bh=/u3zVaCUOi1leLGIXQJ3yEy5YFCbysx4+Z9LqXEjesI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8vb1yFJbRfLsSKKqGmPQWbt8xfi4wuSm9ea7/dEXcRWVFZENJdZ5XqCTKP1JyrgIc1sei3GW6LDkFdP97VcPupRJDIuUnEOxBetSspz5KN9XMCuSJB4EzMKBEkWJoUc7REAdtvmTSMAr1ozvt+SkDT864cFe3iGERLHDU/UMfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LOD1Pj+n; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LOD1Pj+n"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a283c44478so10191253e87.3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2026 02:30:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776245456; cv=none;
        d=google.com; s=arc-20240605;
        b=OvhyTq3NvNsHjLZY2r2RRWy7MIse1LsDMvFICd1k+4Iue4ARUsKKz0bLwp7PNkQqeZ
         YuL0V6/FxEnemWPUfExRgwTL+JDK+WCZ5v4cdf1f2jLCbfvCLy2llG4QZpf7DJ1gdkfk
         pFZT0UX4hWGvwHsFNXD2cuPwfvOopruHCuN8FOoaIDG4LdPL2hJb6cKwwCY53yyyxp/Z
         Fo7z9CCStYNhHkaCD6bODiF6S9oFH2BNxAwoFcOHNJ5Rdunux19dvoM/NUWE5cbLCZW4
         LZ7nQ5rp5C3FD3WVPFy8+dfiK4eyGYN1VF8XLlVJVvLfV0AJo/SPAkNM7aH5Oe7idtVQ
         GbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=asoGm5k2b/W+D3bbPPi1yaiAJFNCI1hMG2WOSwnM4dM=;
        fh=yOZZ5IWy1I6yHQAg7AxzcJmj03h8np4vJCHDPn0LbcY=;
        b=aEcNYA01mdYyUh+cwsFzJUalReMakfFHYK1/FztdK7V7ofhoLxqAHljjKS4DU4RAUU
         jg4BNMuu1p7m5UF1Lvz6tpivmcN6E0/yQEism77hfvC48bISpCjysxawRkCXFw6jzi0P
         LDOsXPZ1wVD8UtnpTClkj5kWDqemcGS9Z+TYj0HnF8UVyDWQEWlHbTZLpOM8sACEKwkz
         lJCNusS71FDIGZB7CSc3mKyGdRoU+MPk3OJPW7v62shUsne+a+a9P95SUE3w38jx0lfV
         Oh6NAUFXzJIs8OM9UoXGJ223V0RBHmf5FJnm4qdgAQ5X3V2rxq2W0i5MtdXF9cyRHMPu
         kt7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776245456; x=1776850256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=asoGm5k2b/W+D3bbPPi1yaiAJFNCI1hMG2WOSwnM4dM=;
        b=LOD1Pj+nKhgtpF9KzWymULpbCcYNTX+fbqaoaWCbO7WRWjYfBUdR1gWgppffNUC7M+
         0AKsTwvH3osVEYL7+zrwcdWHLVviGl/4217qIe9mWyPbRD1RO1jvpULWt6b0QF51oZeY
         bU5TIYMIP/5N7aKoKVvVx5VVLutMeLyoAzDUiCjaG6TghNK/KvvnjVpkkcUAgTLiZxak
         zQgzo9WQATYm1BOPo6YPhDJJcSIM7SAIGoyzTBJaL0PkgqR7KalL/jBUP3T/H8nx+cHy
         JQgKbQP0FIpnJpyqW94Y7g8fbw3mwjyXxTrKj9uMbpH6Y+a83kuF+t9jrCC5EXbFv2OG
         1EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776245456; x=1776850256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asoGm5k2b/W+D3bbPPi1yaiAJFNCI1hMG2WOSwnM4dM=;
        b=tIYaYEOlkwUW0gmkh/HG1uJP1QefSpIq0IhWDB5uEcIOmPhodGP91WqOdv7aZtQ5bP
         +5WSqykRXPAejPLVGKHk+rTt4KsoY8qivzuWK5no3XUGn5teL6Oi0yNpM0h3/DwJYkjX
         sKVbYTBKiXPin/pGa1Sh6Q+MnG595cs8q7wL1UXISlePv6iXZNQi+eWx7hqfMHh5rEVi
         5BbBjadPscXbJTLE/HViJACnTMW0AFnr62Lw8yl2AwRb6YB6hjcxPGAiMdj91es0wnvL
         lg6Jr6fj4FoR+5IoKYfVSW136jlwngrZOwzXhVAiGZWnQrtBJHna4vI6MBBpLX0hJBBG
         ePuA==
X-Forwarded-Encrypted: i=1; AFNElJ+4Avxiku+MRl6slh50z++3TI6ryZ1h3V2Um4Khkh5PlypajYyULxqKs/v/mQuF48ByMdtx/UG1/Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAeoMhblV/JDlSZBdM53dXEblAvKmFy7YymBzUE7PwlI/y+JmE
	0v32zdnFUrsrTVA+DjXEoIHQA8uGEQe2/t2NVbteAlNqWhewBn2ItbFbxTOEMwND0zGhhbUHtjM
	tIFB8lDdWugR5pUQCP31kYgnmu9GQwIabbRPW+nMvew==
X-Gm-Gg: AeBDietQOLxHPINhlnjiwgWp5ISe0MmQe9v9R1OaJz+EK44Mzij1sqWsUd8EZflHrvg
	DvablZ6dC/9MCNK9S82S9L9g5s+QdCO2HSVZ/RtUJ+C8vkyNx5m5AxTFYZYrbva1fCs20jPXFcW
	3ShrWC8kcL5e1wv11hZkAcMypQTqOSZGDXAqETg0K3iJWXalf7Uq/MIWyrQrMgTtmzORYsRCxJc
	K+hvv84yeKKJSyxIhKWeb5D67+0SlJcH7Fzjceu2bT8kp4P6tZBZpv8kFCurVHYtuHDkfpzNK+O
	Ku0YHVBx9Ua/bVbP03I=
X-Received: by 2002:a05:6512:3d0f:b0:5a2:7bc2:a385 with SMTP id
 2adb3069b0e04-5a3efb59485mr6720922e87.38.1776245455495; Wed, 15 Apr 2026
 02:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320203249.1965044-1-kamal.dasu@broadcom.com> <20260320203249.1965044-2-kamal.dasu@broadcom.com>
In-Reply-To: <20260320203249.1965044-2-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 15 Apr 2026 11:30:18 +0200
X-Gm-Features: AQROBzBOthnLox9m6ZSYs81w-N5rCn_yi2Nlq-wjOxJAb8f3I9FXVnuOvR94YUA
Message-ID: <CAPDyKFrZLWg0KAa9DW-R2RAYvP70_T-DtosCpYRf3kMtprb7DQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] mmc: core: Add panic-context host operations for
 pstore backends
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, William Zhang <william.zhang@broadcom.com>, 
	bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Mar 2026 at 21:33, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>
> Add three new optional callbacks to struct mmc_host_ops for panic-safe
> MMC I/O:
>
>   - panic_prepare: drain in-flight requests and prepare for polled I/O
>   - panic_poll_completion: poll for request completion without interrupts
>   - panic_complete: restore normal host state after panic I/O
>
> Add mmc_panic_claim_host() which uses WRITE_ONCE() to claim the host
> without taking the spin lock, since during panic other CPUs are stopped
> and may hold the lock.
>
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
>  drivers/mmc/core/core.c  | 23 +++++++++++++++++++++++
>  include/linux/mmc/host.h | 12 ++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 860378bea557..5326b246b4f2 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -860,6 +860,29 @@ void mmc_release_host(struct mmc_host *host)
>  }
>  EXPORT_SYMBOL(mmc_release_host);
>
> +/**
> + *     mmc_panic_claim_host - force-claim a host in panic context
> + *     @host: mmc host to claim
> + *
> + *     Force-claims the MMC host without locking. During kernel panic
> + *     other CPUs are stopped and may be holding mmc_host->lock (e.g.
> + *     inside __mmc_claim_host or mmc_release_host). Unlike sdhci_host->lock
> + *     which is freed by the hardware drain+reset, mmc_host->lock has no
> + *     hardware counterpart, so we must bypass it with WRITE_ONCE.
> + */
> +void mmc_panic_claim_host(struct mmc_host *host)
> +{
> +       if (!host)
> +               return;
> +
> +       WRITE_ONCE(host->claimed, 1);
> +       host->claimer = &host->default_ctx;
> +       host->claimer->task = current;
> +       WRITE_ONCE(host->claim_cnt, 1);
> +       WRITE_ONCE(host->ongoing_mrq, NULL);
> +}
> +EXPORT_SYMBOL(mmc_panic_claim_host);

The above doesn't account for whether someone else has already claimed
the host. I believe we should check that to better understand our
current state.

If the host is claimed, it's probably due to ongoing read/write I/O.
Then, how do we gracefully terminate those requests?

If the host isn't claimed, the mmc host (and mmc card) may have been
runtime PM suspended. We should take that into account, because
runtime resuming the host in atomic context is most likely not going
to work.

> +
>  /*
>   * This is a helper function, which fetches a runtime pm reference for the
>   * card device and also claims the host.
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ba84f02c2a10..cd44b62d29cb 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -272,6 +272,16 @@ struct mmc_host_ops {
>          * negative errno in case of a failure or zero for success.
>          */
>         int     (*uhs2_control)(struct mmc_host *host, enum sd_uhs2_operation op);
> +
> +       /*
> +        * Optional panic-context ops for pstore backends that write to MMC
> +        * during kernel panic with interrupts disabled.
> +        */
> +       int     (*panic_prepare)(struct mmc_host *host);
> +       bool    (*panic_poll_completion)(struct mmc_host *host,
> +                                        struct mmc_request *mrq);
> +       void    (*panic_complete)(struct mmc_host *host,
> +                                 struct mmc_request *mrq);
>  };
>
>  struct mmc_cqe_ops {
> @@ -758,4 +768,6 @@ int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
>  int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
>  int mmc_read_tuning(struct mmc_host *host, unsigned int blksz, unsigned int blocks);
>
> +void mmc_panic_claim_host(struct mmc_host *host);
> +
>  #endif /* LINUX_MMC_HOST_H */
> --
> 2.34.1
>

Kind regards
Uffe
