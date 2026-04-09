Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4A9364E8B
	for <linux-mmc@vger.kernel.org>; Thu,  9 Apr 2026 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749985; cv=pass; b=JmC7l8lyzoodNw9ln8aZw2i5WGzHVqwP8w1Uw+2nrTGbEFcNlhJOLop/gjM+i0dVqYNW3sMbQeEj52RY4hSdaa0WQVKRcYct8K3D1tjS5AeMPhoRDbplRFDIbdUFqA9Knlfs9UFA9L1zLQkFnLslBoqS566K0O2nl/8N0EDufL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749985; c=relaxed/simple;
	bh=rJmUXxuWdbLLRGgIfJ4Iiqbjj900q/zmn5gxTyohyAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGvEFIN0DcemQ+h1k68kOUqFtJcDVo1vzo4DbZxLIXGBxpMCskQlDPJjwlmP8XoVqYLoeygI0/gOmbMjzOz31HTL/HvSRxIiMHtnQYyrKzF6C/vQNVnhDjc1ll8LacocqBemBaLy2GhCnzraEZGOYVtzKPtWURsxCE9xM5hHXuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T/k0MBpK; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T/k0MBpK"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a2967e5de4so1595615e87.3
        for <linux-mmc@vger.kernel.org>; Thu, 09 Apr 2026 08:53:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775749982; cv=none;
        d=google.com; s=arc-20240605;
        b=jWhuYBiMiPJ6rTfRfdwKKWxoe60Nz2YX5WABfrK2gjJ1L0kEQj0VQLzvB0Gqggxpqx
         t/Mh3KSbmI+EbMt5j+B1cyuj8At5gxhpfQZy2ZWkF0S1oTHyzygOV9OOwmz5LSilNhdn
         69Us36Y8ySY+pjyn7nbNK05TVaQ1jDE0wuW5Dk60l97vpqSRsDhQd/qflkD4MiLmEemT
         ZGKd/PFVNiutd2V4Q6mvANFAd8WqUlTpB0VwlJTsY/BgRLp9QvJFwtB/309F+9eF28OP
         31WXVaZH9aVLlwNBdW8U+ZGfMeCSlPLoQ/NfqujCVNSfb2CQqhNWLyAQQYQR/TwrpE5S
         ZXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6zl9LFIDj0EpC373TRCmqh+DxZCHlyzNZnwfKGpLy7o=;
        fh=sN7MECVPg/kA57KF51sRxttSDsVxZRYOxEJkmJMZGVQ=;
        b=OPJxTJ7B28JycTSI7Bv50UTUS2J8bv+6YBeTOKMHnhsw/pGIi3yJZVbORLqQhNnGhn
         SfpyEu0kJp5SQqPeI8ukp/dmaM+MAe5CiqWbzLVu7L1wSxT/rsTunS+IT9EpltTxdPk9
         MawK9U0cvIhN9L6sUb5U+FDNwRraymemK6OKBOeBBFCuSVQCA+EjDIDkXma+paOgiQdD
         Ge5QzJWTjApe+aMr6sVtNCVZexiQxOrHvE8W5fTqszFVk64CCbcEkseO9N1zp8E72k+P
         nJ5qWQnYpY282USdqE7ESeRe8O9gZl2YB05RKWQ/feyANM3+he15MYIerBqmcUwfE4/O
         YLBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775749982; x=1776354782; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6zl9LFIDj0EpC373TRCmqh+DxZCHlyzNZnwfKGpLy7o=;
        b=T/k0MBpKPIipgJABNYRc6Utxf0Nfap4KEE3RVUjfilhNOVCR92mKeO8+HICvEBdXAv
         TAmgORlqQgQJHlvUZL/e2r6HKEgHvtkvmPKrUr7L49FmCsRQFe3T2SQ2Mui0kFO+NB/J
         W0ASz3m49TsUpWnSbFT6ye29vimpwHVEm94jUx4xcE8jzGc4HuogexHryGY0NZqtj+QY
         M45D45it+f9acbEapuoSFER7ir6Bm2mXfzQYM5V54eG+0jqgiENLIBD2qJxtCH1YswYT
         ug7hJmGPfmy/gFQ27JMAFdRvk3lYwqcHpP33jaAdS93CBhvy87H6Jaf6DxTcSDrHKwu4
         Ft+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775749982; x=1776354782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zl9LFIDj0EpC373TRCmqh+DxZCHlyzNZnwfKGpLy7o=;
        b=QVOuu39ntVJCp23KG4Ivcw7qCMUm8mc4pSE6nCGnSa12reQjeI4T3RG3hRGmiTEQrg
         2aPrr4cMuyHdA5sKSmnNJ5JnTxTMJ92CBNhdm+EJmqpOATVo/zbKVAnO+c35JtZftft2
         IPXoKNbQHgPTua0VQVZrqlzy0pBApdGRHuBepF86xcx7MRiJJ8v1wMBw8bsXB2tlcvID
         yvyRiH29Gd/VLMEwO06+WejCxss/LitDUIxazucYTYH+0dQDOwj4zmbq2FL0i660q2ZO
         lUjclJgpY+5vuLghw/Sx8nbYA59VZkcWhtEUUrDECnu3Bc1ncNrt4XYIlEd2gIoVu2X5
         kebg==
X-Gm-Message-State: AOJu0YwxnfFngzGmDDklypj31VcBNi7ft1IBYHtMSm18gXAuwABg28dd
	uEn1sxpJUq338gtam+GV8tRmxPwHP2SOBp9+PkWwqGsEdG5N8MyOYwdWGXLxsIvNZxfrsKTwYlq
	6eUvLD0TqACihNAo9/1RKzUI/rOmKrHjvP8zPRbiizw==
X-Gm-Gg: AeBDiesZx3Tc/AlwKaBYuKR7b4FLj1Z8FBvzMd8idybnBIwFpU8iXj2EyeRUJokMjCi
	X8NbhYEiQOw1XbuM3zj/gZbBRn/GNDFFzd0M5gC1BPDOFmF5EW3yug9knwiT8G/JuR9Nk3ZQc6T
	QpjdVmtB3jN84Qw2hS5xzm8RZUtIh963RnXvr6v26QxMO9xEJD3hONuELkHq4/w6yrV6MZFGzDi
	IMPEvMEDbrKcGENxtN3A18D17Z3cLvC9jIx9dsTwYfVlIFZn9ztwx7gQzlufkw6LzDorvw2YKoL
	S/Nk3XSv
X-Received: by 2002:ac2:4f03:0:b0:5a2:7ba1:493e with SMTP id
 2adb3069b0e04-5a33755d853mr9252332e87.13.1775749981996; Thu, 09 Apr 2026
 08:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407014033.1305033-1-18255117159@163.com>
In-Reply-To: <20260407014033.1305033-1-18255117159@163.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 9 Apr 2026 17:52:23 +0200
X-Gm-Features: AQROBzBcAhFGjCvPqBwyv8nRcLKyUUQskZOkkLxCbYHn8YwBXPU4iSL0YAv20hU
Message-ID: <CAPDyKFokLDENm+2UeL+PLs1J5FHG1VmU1T_Ef3af9QKGZZB95A@mail.gmail.com>
Subject: Re: [PATCH] mmc: Simplify with scoped for each OF child loop
To: Hans Zhang <18255117159@163.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Apr 2026 at 03:40, Hans Zhang <18255117159@163.com> wrote:
>
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
>
> Signed-off-by: Hans Zhang <18255117159@163.com>

Applied for next and by amending the commit message according to
Shawn's suggestion, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/quirks.h | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index c417ed34c057..93bf79d79cec 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -213,14 +213,9 @@ static const struct mmc_fixup __maybe_unused sdio_card_init_methods[] = {
>  static inline bool mmc_fixup_of_compatible_match(struct mmc_card *card,
>                                                  const char *compatible)
>  {
> -       struct device_node *np;
> -
> -       for_each_child_of_node(mmc_dev(card->host)->of_node, np) {
> -               if (of_device_is_compatible(np, compatible)) {
> -                       of_node_put(np);
> +       for_each_child_of_node_scoped(mmc_dev(card->host)->of_node, np)
> +               if (of_device_is_compatible(np, compatible))
>                         return true;
> -               }
> -       }
>
>         return false;
>  }
>
> base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2
> prerequisite-patch-id: fcb16f319f35ddb88e1668bbe7a8811d88235672
> --
> 2.34.1
>
