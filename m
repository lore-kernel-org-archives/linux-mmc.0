Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BB21FE451
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jan 2025 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737113922; cv=none; b=oL+0+4j5/ON5Lz6CfKwsfhTiFsN07ChttIpPvRvc03fYHuPsXcnhRQ9UI3vatdO5QucEiLjvc5J4DzZRklmfKMBMZCBcD+sJf47r+srpee2tC+nSvLUXQ4AdNH5SB+r4G6nr/VMR61vpAJIxS5BPgvpDrm4F7Y8vTIi8D611jBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737113922; c=relaxed/simple;
	bh=2M8am5A2DVoyOZ22b28RiVbvcm1Ewz67x0ff6XvgUWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktcZkTWhWJG0zUNB6VdQ0wDSt2CivqzIl/4Fs4EjkoWpSY/h46/zA0KPyDLAr3YTYK+ut8r8c1KuoY2nt0VEp2rWXCuLEydHPcyIT0Gqtx7M8p5geLCBkeTqF478EtVDDEXa7gGLlg93yz2Xc2FoQk0T7wy+Vy9Suig0unIs0n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YzqkVVPP; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YzqkVVPP"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so3100922276.3
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jan 2025 03:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737113919; x=1737718719; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BjH52Gt7pbVlFexmy0PD7qyBVgnl2uWcLkq/v2LIyu8=;
        b=YzqkVVPP3uIBEvgs05NRWnbP1VIZTNB2pIEiHjP/kfRSqd4vfu+XMSWBOeeVWkKyLR
         I1ixN5uaZ5MfK9Xqyg54MycTR/oFKhbbsu8auiL901HpUI/QeVFuCWTPqNzVASn0r05V
         px6NRLUeK0sv9NJZ6MAoA3P9kvJa2aFi/DEBbm2kndxAKL6kUn041aDqlO9ma7ppO+bO
         vtpsau7zdN2wMJxndH6m4rq+abPL02aIJZ+QLXkghytEUT4CXgHK/lwZnPhuBmNLABCx
         dAxFyhU63OIK2BaLx+0eU1ATL71v3k0tN5Mp+etM0GrjC3yyxQiqT5wkM39Lcg09dEVA
         5B+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737113919; x=1737718719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjH52Gt7pbVlFexmy0PD7qyBVgnl2uWcLkq/v2LIyu8=;
        b=iiwC4IB3UYQP5EVI9MSbKDSVp37hkREMerFPbZuzaHoUa/eKDGIei/HBMi9QBBFw02
         H1TszVoHVMHRoBZ60Xy8Tm1Kf/w0eAW3PaXGe0eCu3YX4rlP4oOk6zo1zAIIU9Ai8/rA
         unCSbq5+Pk9SFc/aFeOuGkTTiKr+fX2gfuwjPoFc6FZaorgpvx47aAk28csJtaEQJHc2
         II18dok4p5t4VNWrquG/rYW7FFxnsKZ+yRa699955/EanNQOtrNhvCxKeQos0litDez/
         dXJjL2BV0B6iH14nJ6b6e/bkApefGgKT/LMkOdAzbglCrlc3NaBL5/b0UNM7+P1GEDx2
         Hbcg==
X-Gm-Message-State: AOJu0YzDGohItE7gUhNMTxOJ7vKP6CY/p9LX01olNDX5e2UQKMjOrVzo
	L87ce1/8ekpDTZPtzyIb9SgE1uwWYV0AzQSgCvBdyDnDreUX3cdsTwTrTbEuwF9UTTabvSWPhE4
	0N6vGXpVUxLK+Y3CJYmqFfeqgvWSOlU0LRs6d1aVS7pXh6+wT
X-Gm-Gg: ASbGnctqmtqn1ogulM8f+kbIWWf1cimpxzCNBSL2k8UHcYIhHB7yet7are6vlqUe7gD
	51rsDEWReA6UqACjfxZMt38S131aJVXXhwC8wgis=
X-Google-Smtp-Source: AGHT+IHH0l6yUrrv1l9kWgMp63AW9MENaeUpJ8LHnl+ZYs5UORg6hAG/HJOGVHF0YI6EmwKcPptRM2b0n9LVP8emiL8=
X-Received: by 2002:a25:c70b:0:b0:e4d:d319:b99 with SMTP id
 3f1490d57ef6-e57b1894eb6mr987696276.36.1737113919702; Fri, 17 Jan 2025
 03:38:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110085424.104849-1-avri.altman@wdc.com>
In-Reply-To: <20250110085424.104849-1-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Jan 2025 12:38:04 +0100
X-Gm-Features: AbW1kvaaR1POmB6MF90TyN67-4ZbwVNzLLBu0_eiuM2mkOyd6wC5IW7COEtC1Yc
Message-ID: <CAPDyKFp0fgXUuCnhAY14t0TO0tOeuWfjQAu3in9Lw515NWJbqA@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: docs: Fix a typo
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Daniel Custodio <Daniel.Custodio@wdc.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Jan 2025 at 09:57, Avri Altman <avri.altman@wdc.com> wrote:
>
> Fix a typo in mmc-utils official repository address.
>
> Reported-by: Daniel Custodio <Daniel.Custodio@wdc.com>
> Closes: https://github.com/avri-altman-wdc/mmc-utils/issues/1
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Applied for master, thanks!

Kind regards
Uffe


> ---
>  docs/README.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/README.rst b/docs/README.rst
> index dd07ffc..9606501 100644
> --- a/docs/README.rst
> +++ b/docs/README.rst
> @@ -11,7 +11,7 @@ Source
>
>  mmc-utils resides in a git repo, the canonical place is:
>
> -https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc-utils.git
> +https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git
>
>
>  Mailing list
> --
> 2.25.1
>
