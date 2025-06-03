Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4862C3259
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748980944; cv=none; b=nFTRkSNq9DWEn3guS5FE2ZiPF7KyRAq3GSiBDWuMimTx5kLeR9ZvgwGg+vA+INIWFcR9dYALDU1/r3t5mpg6hdSau6Ab+ylX9XLYMnom4htOfL9X0vABIJ6ikiIUGY9ZrRhSJZ2Yv5oVO0yiHwm1ZrhQIx6qbHvNM39P3AFwCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748980944; c=relaxed/simple;
	bh=K7mYbEanim3f7HvwnSr13q0zdQduXybtOiIEIfnjJ/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANyiYj5LpVj0KWLlnMXXeJmgd+9RUY61vJ3dJGucuzTOp85VwQuX40db9814CUPYiql1hFzw7W7DL/5CBLxipzOuyS6Au+eQDo3bVmzgsvJXz3R2H2oqYcp71ldkzTE9kNnEINaWvD/W4EpK8U5+bu+AX3snluHUKAJq/CTJv/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ZkSK7PWa; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZkSK7PWa"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23508d30142so63869655ad.0
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jun 2025 13:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1748980942; x=1749585742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7mYbEanim3f7HvwnSr13q0zdQduXybtOiIEIfnjJ/4=;
        b=ZkSK7PWaeN76uPfXpCwIpVyv5/P+9WhqpDTFM0IYCiPwdH3nKn4xjuN5u0sNR2Izi6
         M43n2r+ri14+rI7idUnsSw2MVCDi0e7G6DZcg7TlKnXXmhNjoZXXcEe7JL3kTN67zma2
         3ZMT567hyB4PbaZg6zrlK+8UuILDI7bfOr6xMEivqo2H5m+jYvbbt8d6JnBR+lYcTzmT
         jNKSEOMYufs3R0nVLZa2b4PSMHHIq6W9OPVcK6Z9U43rkiUQlrd48NEuMf/KRkBWP9X3
         X0HWlGlfGfhT1Z3LNwgyCRrk/q//JG3NgZI18JjB9zGksfii9Ul027yoKroYoun++wIb
         O4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748980942; x=1749585742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7mYbEanim3f7HvwnSr13q0zdQduXybtOiIEIfnjJ/4=;
        b=ebQvbRsgbQfUQMKNc9VRgvdkaC3N1Crll0+KwVZGLuEhf0svTNya/l2KIftUp7SPkr
         9preNamaIyV+PVm4Qe3i0Z5ZU8U0Hzlc/BGiA4MMrRtxKqeYSI5mg4u3A56Rb0v8A6AQ
         AUK6fQj9Gjssi5A0BUapNF+R2WtBBA+8jcj39/eh1IW3A2xCTb055GK1leiwfaIyeImW
         N5p/Bh1C5CbfylEebQzjLrE1TVrG3CC8wgUg2ZRznmesA5jxqZAwSljiEcnuHp17E638
         6XUOq15MQ+NpDsjeWAjn6hCXywonhc4YSHts1CmcGEQN1w52QT+hnDiT6+rh50mzlAlu
         nb1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYCvHwLzDCFQs79DDsNEtAtRxj7PFlw4PD0n6pev8FDHUUyyDFEj+Ck0MEaoJA1f1L57W/gFwfdCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIFsReGX3lSSP/zi10NoR7n3Fns97c0GyrlsttLTVKZbJnV/cV
	jFRjDYMGot3ebXXzHjG14UI2v0HQMeHsu25AP1Z+hAKeTW0n0GYbJDpqUfpmCh4UMtfMeA5CYDF
	YCMzwaVCmN0GSkib2QeTwjFGKPvvnhDg=
X-Gm-Gg: ASbGnct5kyr0oSyLdmc8fFX6+AA44dM1cf8K2oOVwGiHZ7FRXSuYT1IzJIDYoq44e0c
	lVUIGKs5/NB8iBYcqxY7wp/AkI3zc0pcVsjJDVHjuZ8sd3gjuYe33XwegTbdEwY6ga8iJdRM0Ru
	szALDgtKZM7CmCx2MuP5wD0PNA9+ViC7BYY4qAWV3DyOJdYS0e+MrcuSVzZWoN6z7WbQ==
X-Google-Smtp-Source: AGHT+IGbCwQsYLgw99ZZfNEPT9b46Uas7cFFHBva8qR3JV9DepyWxOalQXIyM+mxa3HesqLdAmFamwLHhSjFWut5iuQ=
X-Received: by 2002:a17:902:ce03:b0:234:a139:11f0 with SMTP id
 d9443c01a7336-235e1129193mr836975ad.7.1748980941649; Tue, 03 Jun 2025
 13:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1748933789.git.zhoubinbin@loongson.cn> <592c6674a83a80558e55b143c483e29dcbfef1fd.1748933789.git.zhoubinbin@loongson.cn>
In-Reply-To: <592c6674a83a80558e55b143c483e29dcbfef1fd.1748933789.git.zhoubinbin@loongson.cn>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 3 Jun 2025 22:02:10 +0200
X-Gm-Features: AX0GCFuw48Uhx0mbdlqHrrvpfoZrKnoWd5gzYi6VJl6U1CBZuhlEsqxmUNyYRLI
Message-ID: <CAFBinCD2-u_6M3Lq7vkusxjp0XDoaTGu1Dyq4D1dFN1dPAHgKg@mail.gmail.com>
Subject: Re: [PATCH v3 11/36] mmc: meson-mx-sdhc: Use devm_mmc_alloc_host() helper
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Huacai Chen <chenhuacai@kernel.org>, 
	linux-mmc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 2:26=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn>=
 wrote:
>
> Use new function devm_mmc_alloc_host() to simplify the code.
>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: linux-amlogic@lists.infradead.org
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
