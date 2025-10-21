Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12EF2ED84C
	for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041933; cv=none; b=S5GF3gkS0R9sMNy5oWgAu/lG9m8Vrtr/V064S5LS2XoZTW+s+WGy9jGVK8kVnHfCpjt0DZaLy9BbTbbNd2KDj9YsDfSdq5MOEWCk3ZtBjLfw/F7g0VrgVO8l4/lvF+rq6/zwi1IV18GA6uM9ssTcMuOC53pgNy73iVM3nwxq5Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041933; c=relaxed/simple;
	bh=aBEFnTlPAvnwfJmdD/mW2FKztGQqloyuy4uiKb33rKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7bo7IeYKrX4zuVJZRyuXRzF03VqzAcqS/NSsirpjp4Zcdui7Bxi9urFywuBIC3QfmvHGkD3ZrW9/d5Hed17aVfwxhIxuUoLBpDUqjKU/CHtZcPm1RDULTunwK2WWI6opdqYEEfXUre4o2b1JBb9oWFtqi1OlKNdPoLjFfn5Q80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yCWPVOyR; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yCWPVOyR"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78488cdc20aso37337257b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2025 03:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761041930; x=1761646730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VSV64miEq6SNN4ENGfpeepcBv+FY5eGzfqe2NSbdXzQ=;
        b=yCWPVOyRp518aqUhltpD7HhvVMUmeOxf6i+pTzDL3aKDkrpDLkYv0R/60OPifJ/4C8
         mAjuXZS371udBhpEhseJ9MvwFBH30nANlLF9A5rjLvX2//L8xeazekLl3POAVnlC2AiE
         W9PVokkgNeVOqDvibEi6o8VPD47jQDULiZDGqCZ6SlJHVuxR2f2rvrgj8lVkisuFgJQ7
         6ZfbHQfPJ/HUeAmzBw+Ghh4gwknJk9WYCKmWtVsmLeI8ZRDzb9CCF0ItjVAy/eW++lwi
         iu45XMyKrimUjUJemhIXYmpuXPug1Fxjc8si3FluHFdkHBfTCRcbPlkfbO2sBfdoh1Rb
         WZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041930; x=1761646730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSV64miEq6SNN4ENGfpeepcBv+FY5eGzfqe2NSbdXzQ=;
        b=szCekwckbD3k+iI/afNqkONRE3mu61JkFTgGl3cNJsjUJZssZ3mUKJ/bvXuIymL3D0
         8VLv64Oa+3BueA76Zt5itcATO253YBF73C+CXNLJXEWmLrG0qoH0ZYW/QimTGGZYQFCn
         DxgBp9eXh+QnGHMKTjzq8/7LqjEZ6HC+lcjSomtvIwN9AxP0Tjb9OHtqedLGSxueyisD
         J1gLjhaqgHBpV5ZabuqICgpMkakI1oIo6gz0Nf9Q0fJzgB6ERx47Zc8oqjkkRmUppOf3
         BaJ+qP/HL0vuG1kHZrwXyf0x0MHnh8Hn4aamsAc5t+KIFbVhY7eDt+mC7g8lPY/+6Nmj
         JtOg==
X-Forwarded-Encrypted: i=1; AJvYcCUKaLIyB5clUpJ4Z7Yy/Vq0AzfX6LaJdZIQRIt9K06WWxA6ywwGm67TzYRda9pRi1oSYsmxtuOYGcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3wpuTL3SNf5HgvTpA4G6LThsAtdGnBSbB/Litq8tp1CV09+FW
	iBju7DL2qrMgLxFjjp+YJ7AU9LayV545QiooYq7W7F1tRldkoyYoUh/DRljjwQGuKfhuTie33c+
	t2N2MMSyY0e4tusSVsope+GinS6oUbZPeJBL/SpA53Q==
X-Gm-Gg: ASbGncuF/zR5EsssVgxJvL3dZSqWKazJiJaHA+Xk1iyg9kPVCNZ7tGrdfEb7eFxztOs
	Mf+WPi8OXGhbDmjPdqNINfk0vv4xwPIGjBbxavXwNw6Q+0v+64AROw/zD/FpLUkvezPXqGarPZ6
	r0GLPDC6l7GZDr1GSsry/yI9cW9/a5PdSZMC4tFART2C9T0ScAV5h29ht6o+Zee0VmIf0fSZwMq
	8fhO4cRgsbQj9+Q2SO0zoTarhWd50TmzI1Z1GNHkY+/qGYyRIuBaWp4CMTyCpq15R4sy9eh
X-Google-Smtp-Source: AGHT+IExyr4jzRbRE6gfesAsE6t7ySg8zgFgKjCwno7Ev1nt8NpIsy3iEOb8TkBNaANECnJvhMlf5cVTYmr6Cpg1k0I=
X-Received: by 2002:a05:690e:4009:b0:63e:17d8:d985 with SMTP id
 956f58d0204a3-63e17d8db6emr13403081d50.53.1761041930635; Tue, 21 Oct 2025
 03:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1760924981-52339-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1760924981-52339-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 Oct 2025 12:18:14 +0200
X-Gm-Features: AS18NWDQm-vrOUTUrisMfFjVw8v8SyQWQNv8yyxp6evWm-p1T9mLMCAPZTO-hLk
Message-ID: <CAPDyKFoKZTcFsLvtWqqXsxDmDZpSg2jvAw=U8xn56vzKFSiXag@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Change DLL_STRBIN_TAPNUM_DEFAULT
 to 0x4
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-rockchip@lists.infradead.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Oct 2025 at 03:50, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> strbin signal delay under 0x8 configuration is not stable after massive
> test. The recommandation of it should be 0x4.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Do we need a fixes/stable-tag here too?

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index eebd453..5b61401 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -94,7 +94,7 @@
>  #define DLL_TXCLK_TAPNUM_DEFAULT       0x10
>  #define DLL_TXCLK_TAPNUM_90_DEGREES    0xA
>  #define DLL_TXCLK_TAPNUM_FROM_SW       BIT(24)
> -#define DLL_STRBIN_TAPNUM_DEFAULT      0x8
> +#define DLL_STRBIN_TAPNUM_DEFAULT      0x4
>  #define DLL_STRBIN_TAPNUM_FROM_SW      BIT(24)
>  #define DLL_STRBIN_DELAY_NUM_SEL       BIT(26)
>  #define DLL_STRBIN_DELAY_NUM_OFFSET    16
> --
> 2.7.4
>
>
