Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A7209668
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041923; cv=none; b=t91FXqkj5BmIwdlTYWDmv1knKSjoy32tla4tXjy7Rdu/Wq9+4cjJ/hc225le1xhw1+Zcxmudd7AXcYS3EzTxbmMq/+qgCvDsr83nq9pOk+WgGP8hfJ/3CxhEKO8QHUI4SK2MteVLx1K2aoTnGpx44RgLtFt8+HOwumA6T3UWOvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041923; c=relaxed/simple;
	bh=u0aF0vd4QcjvPIuR0+km623x+V7ksr6MnKsaPN/8+xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIuQw4BXO8noNhXEeeAYQIzJdWfE3pb9flFe6a+eSbl93LwavoBY3O2KiqnFLDV7GFjXX0nMW2G54Hq16EOxYQy5zahHJYZU/zNw5nCaSAqhXcyRkBbJnDgY5mhJEI5rAZcaimJiqRXrUS7biSPSmoo8aImDJcoHyjKqZZETvQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DPVF7zbe; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPVF7zbe"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7020d8b110aso43072577b3.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Apr 2025 09:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744041918; x=1744646718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sIltRROPIS1IFEA+sscZBf150A68RCMQ2MklOTTVcXo=;
        b=DPVF7zbeZiok+kLrcO1mMH5DVBDyne3+gv1n9v70X32P+npah5RaGGrQQ4Xmv7MrCS
         r0vXD5SL6nF78IAwk9X8voAEtQh/oYeXNItxXIpCQlnpn0L81ZrIP2MBeloBUfzWcbvz
         jFIVwhc5u8zefr4AyHn5atFJiSVu+E+8/0oru43HXp/tY9m7lxqFlohmncelf4Bb1jfe
         iTtHeUHbyMxqAbClhlyatFHyO3E7IFW+AJpZlVlxaf2pPtf9fOqeYyzfSMGhXKjNq9iv
         W24wDbL0kK4UKLYZHj5l7MOcPwNxb0vGdiCFqopfl8Q+gAXT6o6TtOFF/TmJ/DVBhD2w
         VUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744041918; x=1744646718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIltRROPIS1IFEA+sscZBf150A68RCMQ2MklOTTVcXo=;
        b=SEDpwf1JuqP1fe0Ihcfm4I3kO00/+lZepH2Jcq4mhtEflabchzmsFCcmSjCRVzo7JS
         mcbmcwe5bWQNfytZtP9J+dZhVjcg2ZSvdLuzqCKtQa/I5ytpIrGSjmupcSrQ1tP/KnVS
         IwkapYE48RibARmiNaiHSZCxiOWdOVbzwfVD/+6Ciiy8aHh78YILeSCMYrTikg/x+2XU
         Td/avPOMR+ie5dgEH6OWZI/dCKbtiu+aKrI5oOpwgFgqEExw9DW9cS0bqmWxMlaNKkgC
         qspJSmQm3F4cvdXz5bw7oF3KSjKuz5bNEzqXsdJeCW/eIrfiY90oaRENybsdXqXtdDgZ
         rnkg==
X-Forwarded-Encrypted: i=1; AJvYcCWoLsRKkcLewUa7mJM/PxN0mtzL3ArUjUpJDCTjQXb3IMyWGP/atrrBNqxw/jiPdg0pH5kUheH2O6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YywzXHhz2bNxz0HfppUCvz7A1Qhv1Wos92Lj1Ye9jpGb072Nil2
	9U1Z16cMHBxkALmzttEUTijs8RRNBwM8C7grSeZi/rsRJNADF5oVyuf9gzAO1m4nL8W++bImD79
	nM7f3gZDEUF6VvyATWcDe66YIxnkyCSBoBVgBSg==
X-Gm-Gg: ASbGncvZsWXU3BwkZz1OiP6yTkX/xQzjGmN2cLUL/yocG8nbyk7KkC3zwsr0porl4em
	8WvyD4WXYLxFvDC+iChs3sFs1+NRXztHfJ8RVMjA3QKZ7GdAxm/oYjPW2TNd9D/+tiREFbj25HO
	lv5aM6jSH9OtdgwjQY7cNm6DwmdHU=
X-Google-Smtp-Source: AGHT+IHfemisUrYTSu+R+ITsGXJEjJhr5usaC/eR6dHy88Fr/iGTY4qDERK1sHs9feVLfrvg0UHQslChxfDxU3tm638=
X-Received: by 2002:a05:690c:630a:b0:702:46a3:4721 with SMTP id
 00721157ae682-703e153033amr248995447b3.15.1744041918403; Mon, 07 Apr 2025
 09:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326143945.82142-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20250326143945.82142-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20250326143945.82142-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 7 Apr 2025 18:04:42 +0200
X-Gm-Features: ATxdqUFP_RvU6m6--vLVjW3iZgEwByAoHi4eONoRyG_VyZwI9qdEZYqg6kr0NJo
Message-ID: <CAPDyKFrCy-rWeYz3qoRsTQkw+PY3e7=zGUN==4U5_8FvdHezGQ@mail.gmail.com>
Subject: Re: [PATCH 07/15] dt-bindings: mmc: renesas,sdhi: Document RZ/V2N support
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

- trimmed cc-list

On Wed, 26 Mar 2025 at 15:40, Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add SDHI bindings for the Renesas RZ/V2N (a.k.a R9A09G056) SoC. Use
> `renesas,sdhi-r9a09g057` as a fallback since the SD/MMC block on
> RZ/V2N is identical to the one on RZ/V2H(P), allowing reuse of the
> existing driver without modifications.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 773baa6c2656..7563623876fc 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -69,7 +69,9 @@ properties:
>                - renesas,sdhi-r9a09g011 # RZ/V2M
>            - const: renesas,rzg2l-sdhi
>        - items:
> -          - const: renesas,sdhi-r9a09g047 # RZ/G3E
> +          - enum:
> +              - renesas,sdhi-r9a09g047 # RZ/G3E
> +              - renesas,sdhi-r9a09g056 # RZ/V2N
>            - const: renesas,sdhi-r9a09g057 # RZ/V2H(P)
>
>    reg:
> --
> 2.49.0
>
