Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077BE23F385
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780065; cv=none; b=Q9P7p3S/cTMr6u4Xry9vo78O7bXjQp2BRRRyAOR0f7Aps/ZCVzEtA+K5SiuYbkXPiVOXS8u4jza/QZ8O0lEU7Q+fUC9neBag7yPozXCePhDkflmmE3obodLSlXk1LLp36xGHth6UtbWk1ftEPFqShDfoaYlmUD7Oq50Lu4KIq0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780065; c=relaxed/simple;
	bh=CsgzFVnTYO9pVnz1WkCA3cY3MwyvM8leR3dck+STYhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=it0XeFV3tHITsBg/OexPrMaVmD/PymUZ8QmW3dEEQpHQR+FaojV1NNpt8BTHVjlo5vrqFpZFLfO1XykA/rw3YBIaFMAVv3Ntdx6fnx8RZYLuOHbLQf0c01uUvRekXJ6naHG9fjSLkxmaMlhu0jis5wbM3VKH+rhbjcAQ/T8GM50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vk0lwBC3; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vk0lwBC3"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c554d7dc2aso482640685a.3
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741780063; x=1742384863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KYhx9DaAOiP6jF5M8Xgcxe4GOKv+W9gmD/EErDso9Us=;
        b=vk0lwBC3DD9XI7mx25wZLcgdkhmeHsRj9R1hT0lp09BT3SrAG+6LmK77RlrW8G/e1z
         Ueb5k5FUOcB3aJJGoDrHWAE6S4mpYW5sUsCRQlmtEIFYkp0bMuMaxy5xeH6xRFEZf2Dt
         rRSBzWCs3VQUu1uT9QbkWSuITqXcRcq+QuL2c9j5UosqJYDqj60EhOjKU34xGZso8wi2
         HZdJoLNUO7YDRnPDVHZYEL1rCPSptz6UoWvy92kqCP00C/O5AwoW4O55yP1DhlN4r0DE
         9UyCf6wA6603T0AeMXEudQEetEk8UrqNuSrNbDCoZCxcyLf87+rEHaD8JuIMik4x571A
         xpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741780063; x=1742384863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYhx9DaAOiP6jF5M8Xgcxe4GOKv+W9gmD/EErDso9Us=;
        b=YLpvXzm4TZo1wDNt3mv6TL3dNNg/gfvIa2MdVqcdck08eWJao8b9fnaPIJf2haANN0
         gd30FDV2VN9knO286/ru09v9aCOQfnAhJRMIThUQwWvXR2VfZINW3+wENnRB+10PSQ8q
         7tSrsqTM/kSL+eyWB9174F/MzhZuX/HqIkfmwNqBFQF4Hm6WKTBFxioFPX/ra8QNLuOz
         etm2w33w1zubiQ1azaQqbs5RyBy1kw94n28VF0WBToFG0SoTUrcTllLQuJEYhikWFahr
         G9Lsqrls38v2z56pDgSBpKgzl3N+HyY3VhjTycvW2t41Ro6o0HtaYflbPRKQiTer7rKV
         PNLA==
X-Gm-Message-State: AOJu0Yz21Jp9d4lATBuIW/ioeqfqozOxhS59rZKj3mcSUOVp8IZCNJB4
	c/K3Ot3vSWkP8NzNpfwxUZk7/M0bfT+2AMLxYP1o5pATEqkXYvQE8BFzNzpYBvFt0PYqwRy8FWT
	MuB1vDkdn20mKaQRTqssMmVkTcoMxiOzZbZqVs3W1hVWc5wfF
X-Gm-Gg: ASbGnct6Gk1MHjda69mHpELrftp7YRd6jaV+UDQU8QCmmZ3lotal988tV8GsHHDp0Aq
	MuVgCR9VJkwIP08YsAkxDP9x236lXgUkXdW723Dp0uJ+4j8RRBb1+3NNy5TLbJGU1bm0Za963hT
	k8sImI3L8nowcpmRwfQUFXacy+Bfc=
X-Google-Smtp-Source: AGHT+IF0lO7rB3mWD7blFn7GfkRM4hwdjNq4xOSBHo+r44rM5JWV0KqKVr3xlzCG2Oxa1YaeAce+NSCiX5b1ks8ukWw=
X-Received: by 2002:a05:690c:45c1:b0:6fb:1f78:d9ee with SMTP id
 00721157ae682-6febf2fa005mr289717017b3.15.1741779701874; Wed, 12 Mar 2025
 04:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214075146.85101-1-avri.altman@wdc.com>
In-Reply-To: <20250214075146.85101-1-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:41:05 +0100
X-Gm-Features: AQ5f1JpIECkHyMYK3R4gmpSDtP6SlCq8ATdxtlDlD8AmURxYuivfAO_rpMRRtso
Message-ID: <CAPDyKFqNTp+iv+Okxn4n0qrnOXeuuegxJ4fkAmOoKv__JwqbDQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc-utils: Docs: Fix Sphinx build error
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 08:54, Avri Altman <avri.altman@wdc.com> wrote:
>
> This patch fixes a Sphinx build error encountered during the
> `make html-docs` process. Apparently the _static directory was absent
> and the master document not being set in the Sphinx configuration.
>
> Fixes: 1d1b1159ce7a ("mmc-utils: Add documentation section")
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Applied to mmc-utils, thanks!

Kind regards
Uffe


>
> ---
> Changes in v2:
>  - Add a fixes tag
> ---
>  docs/_static/.gitkeep | 0
>  docs/conf.py          | 2 ++
>  2 files changed, 2 insertions(+)
>  create mode 100644 docs/_static/.gitkeep
>
> diff --git a/docs/_static/.gitkeep b/docs/_static/.gitkeep
> new file mode 100644
> index 0000000..e69de29
> diff --git a/docs/conf.py b/docs/conf.py
> index 9c08a23..9bc69ce 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -39,6 +39,8 @@ templates_path = ['_templates']
>  # This pattern also affects html_static_path and html_extra_path.
>  exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']
>
> +# The master toctree document.
> +master_doc = 'index'
>
>  # -- Options for HTML output -------------------------------------------------
>
> --
> 2.25.1
>
