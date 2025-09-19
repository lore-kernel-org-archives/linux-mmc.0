Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E1224DD17
	for <linux-mmc@vger.kernel.org>; Fri, 19 Sep 2025 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279152; cv=none; b=nKGsUAY+8xPPWCuGzJpvCEmMFGZ3Lshs1DVoJePNAb47XgXSCjPwbAzy3ZKA447ZYVUIL1+r3W3ORa3X4h7PZbDC048RAxUlYmCpSZEeweczR0FA+UD/JSmCuEq/T35AQvZ0zkQnAo/2EbtA5BTpvyAiostjQMChnJKhug7hdgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279152; c=relaxed/simple;
	bh=Uh7RA+SkqfZ23yJNTc2e3SnZ3wd3GErf0OaU341/ICM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJHn957DRyVArHu6U+NFjQA3vlSH2TZ1jOCAl+fCmfQo2Tu5aw2Fv6F7fRbxr7PLEEMicQ+1AG2UrpEwCCuBV+Fwsh8ibYYGieYxxBqOAGDe4afQqLpBgA+ZMwpTWpalMovRT+z9RWSQCIl37wrzqPj6QageDlzx5yTfUtWhBak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NalluPQd; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NalluPQd"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-ea5c8833b15so1601243276.1
        for <linux-mmc@vger.kernel.org>; Fri, 19 Sep 2025 03:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758279149; x=1758883949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzzD9mUUMKzw0ugA88AiWwEs70VRCzFRfuxqcw3uI/U=;
        b=NalluPQd+xpui/McZFiH5eDsZZOgNdvLbkiZaPoYffERpDGPIMK1jK+JnCNnJPMGXS
         83XTY+Po/9JzwFdYRKwuobHZfi4nB0giKzlHWaMUv0ZZRNCFcPx+onM7uux98Ky0Xsfs
         n6+Jl1ympyLMiEjazlJ6fxzHkA9mOBBxCqc5C2fhA2uTGtmn5+9RS3t7xJTqnKwAm0ah
         /u6vW7l78YVNZFJn02uCNM5jtPfb7ukWHmVNY2jmXnAeyIeAsM+DNAb3KyUFHo8g8do5
         VlqE1ZphnZQzIwKlgVgFoq9S67xY2AJe/H3fCvN4TzBUGY3oGke8z2cwNELGt1GpR7rr
         IadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758279149; x=1758883949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzzD9mUUMKzw0ugA88AiWwEs70VRCzFRfuxqcw3uI/U=;
        b=BJz6DrAd3o/0gxx6RKenvlfpIFm64/p0/SZ6N0VxkmGia5/Grtfdm4VzM5e/pN4Lzl
         4YHDdDmrisB5OcNJxb/WwmdprY+2MKHpuxcvrMxbb81WGO9dRbPsHQaZff33Cs24x/AX
         8YbgPyzqakSTVSC8LDQIqPjziuEXQQO8FzSdJe1P0hkerHj3HCRkN5VmekV1CJR9Jkri
         /mke7h3mtV6lfnC85B6RTSPOR1w9lUvvyKIlswi5MBUs6VktgJ3yBPKi3N33BxhCzWqh
         iIKFyoTZldOkebUDAZsyaOg70SWNQO3NICfbxvXWpjSG/owuCyVh+7tQ15LLTSDmGL1C
         EO7A==
X-Gm-Message-State: AOJu0Yxu47XLadSgCbJ50GE1vFGakwMQK4mlaOSVB42CcgKbbHUYSaV6
	5SGNgJTbC4+16krC2TyJnq+jE9mCh1HRbjlpCS/KMMQRzo4l9BXO2AqlCmoEYGzztqnJERBpYC7
	8zNolgVcbS82jaY5tWSKOBfOtDYMfaDFfuS7b827FKKXK+rwjCjgWw6g=
X-Gm-Gg: ASbGncvOFJ3f1QNq3qE+52HYTmLJzxV1DkrXQcN7wOzGpG6bGEmlo0SsPpugV8DVNf7
	7hKEASk0gF2o13sACeI2M70X0dUMs1PaiQEbcjtLFxdDKAlY/zVX7+brqDTBacCm90XvoIncdv9
	Yar9RjKN6mUfdNEjd0RS0S+fliVzJ00T+/aeKqkAQuvxOis1WijE5rOVXOPf4eSKIyFGBOz8n8A
	DwDcKIn
X-Google-Smtp-Source: AGHT+IHI9nO8lq5Pp2KudwoTpRKFpuZ3FdUKlTe15qwsxTFT/SmijXYfhYuulGFKS6hWzbTrYiBzrkFA3kl3zO1cVww=
X-Received: by 2002:a05:690e:1449:b0:633:b7cf:cb16 with SMTP id
 956f58d0204a3-6347f5937b3mr2337155d50.26.1758279148519; Fri, 19 Sep 2025
 03:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912084112.2795848-1-mikko.rapeli@linaro.org> <175822973684.1568500.2874531983654815490.b4-ty@sntech.de>
In-Reply-To: <175822973684.1568500.2874531983654815490.b4-ty@sntech.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 19 Sep 2025 12:51:51 +0200
X-Gm-Features: AS18NWAi0MBQy69KlaoQfcok2GqNKVNbSAgXUL0xqECXbJKR8EN79nmBjPlkClA
Message-ID: <CAPDyKFogz=nym2CGh0LJpVad5hmycdfeoYta4DPfY4b4ozDMVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: select ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-mmc@vger.kernel.org, Mikko Rapeli <mikko.rapeli@linaro.org>, 
	linux-kernel@vger.kernel.org, adrian.hunter@intel.com, 
	victor.shih@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw, 
	geert+renesas@glider.be, angelogioacchino.delregno@collabora.com, 
	dlan@gentoo.org, arnd@arndb.de, zhoubinbin@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Sept 2025 at 23:09, Heiko Stuebner <heiko@sntech.de> wrote:
>
>
> On Fri, 12 Sep 2025 11:41:11 +0300, Mikko Rapeli wrote:
> > On rk3399 based rockpi4b, mounting rootfs from mmc fails unless
> > ROCKCHIP_PM_DOMAINS is enabled. Accoriding to
> > Heiko St=C3=BCbner <heiko@sntech.de> all SoCs since 2012 have power
> > domains so the support should be enabled by default.
> >
> > Failing boot without CONFIG_ROCKCHIP_PM_DOMAINS=3Dy:
> >
> > [...]
>
> Applied, thanks!
>
> [1/2] arm64: select ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
>       commit: aff3de3b9a597763bec5d1c56c11b56fb2613085
> [2/2] ARM: rockchip: select ROCKCHIP_PM_DOMAINS
>       commit: 47c9bfdf7376e8b1842699b064ae3b052e2c3c1b

Looks like you picked the old version of the patches. Did you intend
to pick the v4? Then it's the one below you want.
https://lore.kernel.org/all/20250915083317.2885761-5-mikko.rapeli@linaro.or=
g/

Note, I have picked the other patches from the v4 via my pmdomain/mmc trees=
.

Kind regards
Uffe
