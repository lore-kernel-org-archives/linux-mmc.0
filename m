Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66522DE71E
	for <linux-mmc@vger.kernel.org>; Wed, 17 Sep 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119579; cv=none; b=tMMQ0j3hdvScF6bZvF0TM+bkFSLOKJuYIxdiHe9AUjk2JW5/H8tzZJWGUSQzb0Dyi1RfeRdY40peZz9hz9koc3qSveEed2esK57W6loTNFjEATr2QI7yum+EJgxIA20XOHv3XYze4XfY1t57k66V2prSK+yafYrpCSQjNTlifIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119579; c=relaxed/simple;
	bh=tcnHxortbdFdgmr9duRFABSbgVONmqvd0HPd6fDcn/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6wa6ORwvdN0OnSa/2ggGwI8FnLYIzizzYbAheDizxIr8tHgsVX3XY3+jJmwwiE+Mg6attQc8C3KRNOKe9YDDKBcxCeC4VJfxtueumD+zmkLKeKX5q2P+iLmJF8aqgQMP1nmj9s5r8rHfBZfLShOLxxTnR2mYFKRZDnkiY1Xi3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZAzfgnhf; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZAzfgnhf"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ea3f9e9f782so4534518276.1
        for <linux-mmc@vger.kernel.org>; Wed, 17 Sep 2025 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758119577; x=1758724377; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dCz4bFinyR1BieLUIHZQZV0TDdidYv9V2bEcGI7xH7o=;
        b=ZAzfgnhfmlHY3kWDrEgfGpTFDQM5zNLAp4u0yML2KyRy2y6Q+93SKmnEWvz7UEgTWz
         /OcjGzC6pAvm+ddVkNAW9+6YhnW6NQH8JzBVL3qbtFYSLVGQ29mDhQRWIfWJfZrGWLcC
         uQw3fC1w7r70oKqh342UuABIEmEcTD0a4KxehjL+1JoqsUG8pjfQW2C2P3855vWZtMIi
         7LlCwmu5WrBBHAcGh5dIfediBCTeaMJxw6U5DLPItpyZbBq2GNAWTU9ZAPMeIcPoamt2
         QnjFP8rRQf07Oy6+oNw6KkSvrDPLP81G+cRiPcr4p4tnkJi7qYiyJ4W84cCEgHOrDdZs
         423A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758119577; x=1758724377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCz4bFinyR1BieLUIHZQZV0TDdidYv9V2bEcGI7xH7o=;
        b=qfzk8o0vLGuMed/0OQ/pjidYJ4KHqDCZK5mp5r0MBF30OEGqOW5edjZSxP1v10Ub+G
         kd2HbbtUD4jcBPQR/KGBLOVoQVLydZR64vhU70Vmlddlpz6QT0o84y9tliMyyDxShuyB
         ICJyqqJxKXtis0OqTPwpNSEEK03G5GUUyRKXyyYEBoDzzq+PfTuc6OXyvlopk3Af/rxq
         JW5+jewrux1AnDBSHiV6VXnLUBbsu8g+vBEt8hI9So4E/liIEZxoOnMNhdt2+lao5dZ4
         xsx0K3Pu4mSt05kdRY0p8sVOx9uiBLzo+bRAlVT6uoWq1HIUiA+f91T8I+bQ8b/aSo5f
         oQLg==
X-Forwarded-Encrypted: i=1; AJvYcCVoPEw1+J14GhQWtIL5pKkkwFSgN05EqyrISm0yp/z4N51cS8FXJ3QgO/a0RTiuH0lfOGBst3M9d9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXI3wSsiBH0UTHp7+6+kax3HRoLOFjdfATuvRBMcPug8tf0RwF
	LUjDpLhJyP+dqyKS+7cQ4L+/dh1E6+rgKzKi33kyz3U8f/tSUNsX3OC7QUTjq8p/HXidfuK6XYm
	ndGoJwyVtczvrSG5gc9QyrpiRG9DKKk3lTL5Q1EMetw==
X-Gm-Gg: ASbGncuEXEGcZlYuVeIOgR8zZjQtOuFRH0mh2eYNcjCNdllRrq9i5BLHTo6jEMmXkHz
	QcivtlICXtTbKsTetYsVB1kYS+22agDur1wUNOx1gelxA4yAyUlkYTST717yYROKWlckQRQQox5
	99HgkGo/bB9unAJ5fjmn1TMDb8dKPy7pw0DNTL70qXVx5kTqlmA5G66VlSOexPwcwGyx5A8P2GP
	aAH3lb4
X-Google-Smtp-Source: AGHT+IGYd75X0Qf3WTxoJJzFk2/YdrBkHI2rWEVx/WssCazdqocK2S+85yiq6AsUYraILKbckm2rz5VkDvdIi7Gceg0=
X-Received: by 2002:a05:6902:124c:b0:ea5:c97c:3182 with SMTP id
 3f1490d57ef6-ea5c97c50bcmr1102726276.36.1758119576502; Wed, 17 Sep 2025
 07:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
In-Reply-To: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Sep 2025 16:32:20 +0200
X-Gm-Features: AS18NWBqAAb3pOa1iLGjs8mbJODRThiYyAWA34gbcKMC5sx254a7Jh6zE5vInCA
Message-ID: <CAPDyKFpR+uueS16P7OZi6-1NVrEyPbizuSnMHWMyROfqzPjarg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] enable ROCKCHIP_PM_DOMAINS
To: Mikko Rapeli <mikko.rapeli@linaro.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

+ Heiko

On Mon, 15 Sept 2025 at 10:33, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
>
> Hi,
>
> MMC_DW_ROCKCHIP needs ROCKCHIP_PM_DOMAINS before MMC is detected
> on Rockchip rk3399 rockpi4b and similar devices. Make this dependency
> more visible, or the default with ARCH_ROCKCHIP if possible.
>
> v4: fixed Kconfig whitespace, added select REGMAP_MMIO to MMC_LOONGSON2
>     instead of disabling COMPILE_TEST
>
> v3: use "default ARCH_ROCKCHIP" in ROCKCHIP_PM_DOMAINS as suggested
>     by Arnd Bergmann <arnd@arndb.de>, enable more MMC drivers for
>     COMPILE_TEST and remove MMC_LOONGSON2 which doesn't link,
>     remove PM dependency as suggested by
>     Geert Uytterhoeven <geert@linux-m68k.org>
>     https://lore.kernel.org/linux-mmc/aMQv1V49xa_MThGq@nuoska/T/#md2b3252f9dce14f3f79a493c426f2761cba1dc25
>
> v2: changed from "depend on" in MMC driver to "select" as default
>     on ARCH_ROCKCHIP as suggested by Ulf and Heiko
>     https://marc.info/?i=20250912084112.2795848-1-mikko.rapeli%20()%20linaro%20!%20org
>
> v1: https://lore.kernel.org/linux-mmc/20250911144313.2774171-1-mikko.rapeli@linaro.org/
>
> Mikko Rapeli (4):
>   pmdomain: rockchip: enable ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
>   mmc: add COMPILE_TEST to multiple drivers
>   mmc: select REGMAP_MMIO with MMC_LOONGSON2
>   ARM: rockchip: remove REGULATOR conditional to PM
>
>  arch/arm/mach-rockchip/Kconfig    |  2 +-
>  drivers/mmc/host/Kconfig          | 10 ++++++----
>  drivers/pmdomain/rockchip/Kconfig |  1 +
>  3 files changed, 8 insertions(+), 5 deletions(-)
>

Patch 1 applied for next to my pmdomain tree. Patch 2 and 3 applied
for next on my mmc tree. Thanks!

Heiko, can you pick up patch 4 via your Rockchip tree? Or if you
prefer me to pick it, I can funnel it via my pmdomain tree. Let me
know please.

Kind regards
Uffe
