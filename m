Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBB72D94B9
	for <linux-mmc@vger.kernel.org>; Fri, 18 Jul 2025 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843897; cv=none; b=DjxTgZasodnxaKJLP8GeeVU8p4aDa95OpDCRoVO17HwP4x8V2L8yQcy+wNuDiJM0flwmtPbPhNKhZHg+WAfTjufIQkok6CDykHHjuH7JtzHrDMUT7sjk0Kyk3sf2VXf/sij+MZNiNh17b3m8J/U4IgLH5HfsUG1+ygC9Ww1qTAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843897; c=relaxed/simple;
	bh=sozEw8FyWyDjapcwikfsnTLYtBoVTtIi2agNNPNo3lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCvaZvgasieg2MzfLB/CkuzyC3mMyphf4oWrszApNO0Qp7UVZhbUQs7MWhhUsYEzMNBzcuJp/ZYHlC6stpxNQOUyfQYhuwK3w7paQvx6EF6k42c12tpxS83UX/PJe5zAsLor1i2hcNXhb/QLXF5nOjssZjayddoFV9FCaXVpeQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TsxhWYWz; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TsxhWYWz"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7183dae670dso20097467b3.2
        for <linux-mmc@vger.kernel.org>; Fri, 18 Jul 2025 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752843894; x=1753448694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cjbUkrtlM4UaM9lc1BaVPt7R7JS/MDa+VxvwtUnNho=;
        b=TsxhWYWztpDmEV+Jhylaoj/hUSk5G3+WDp/q3NryGUBHlcu331aStE02VAmR8IgKHF
         mXNcadTwzsqDc8AZPO9RBPVqy6nKj8FGkV6PM2GlX7VmM7stpvPoq59NPJr0NmFNjewe
         y9/Y/f7z8FHUSOf/9aMAL+5eezFf64l5X1csZoAUVUHSskKiIHWB7i1ybybYDpcVoe7W
         z5T51oI47lgdemsICdy4sLmhIQTQEbCwPcF5TSoxXC1yJrnVzXxacaV9qhkaRIxb2scw
         b9EfSktvgG67FcGucIW9D6Tfo5AEMAERGHDbyM+cJcXIaTHIvzLJx0yO4zsIMXaYHnb2
         aq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752843894; x=1753448694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cjbUkrtlM4UaM9lc1BaVPt7R7JS/MDa+VxvwtUnNho=;
        b=eHvYhZb5jrIJUk6ecmA5KL5G/dKVcuBP/OKaIxakJlTKM2i6R8yzB88ZascQaU1LAv
         kcyWuscxgBBdf3vnn+aLcvLK6KMn2FEF5J8F6AFKKPIEYrpfDC55nwFAcT7hD3KxNlnS
         FFIxwo7lGiC4VSNiLQreAu68WO6AiVWDhEpp0oBJLs3oqnpIoi6UkwPYEzavmyY4Quz/
         Iif4lmPGWN2iAFMigDxlV2WcHRrsy9fSPn7KlR74h8ECPQIXrwlbOhtGEDry0rUp/43b
         K9w3N8Gfr6OxAhQ/MBXSQc7dhuny+lU5faXLDvc9OdE4JUgYyyK+AQVhN0ESiJ7FnLo6
         QBxA==
X-Forwarded-Encrypted: i=1; AJvYcCV62VpJK93bfO7J78yqaEkFAjJP1i5NHmzyzhKx52anqwfUhpmCZDupaokI1xpge78hVjPZI9FTqfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmRpkhjlgRBCX/elMBCb3DL/fgQiBjsBW15adm2N2Td2PzhXEs
	fe+5SgcH5BLRAeWTVobOSDu5M8vAY+jop3ZLwthCLohIlC+Uu67Mq34S4t+MBcKOhUsWeeOflkr
	Fdlj/q+RAX992n2zo1K0366t4NjujAmmRsC41rZfH5g==
X-Gm-Gg: ASbGncuPU6uJPGHNySdUi0BwA4JyRm27Z30fWQvYH+GXVxY0Cpg+FMo3I2zPVqJ+783
	D1VoS4sZTxLXeysCzwGpkm+UejOoF2YV3x3kr11CTF3JIFQF3lDeNYbTontSVKu+TrX9/tEu0YC
	01WVjZASomkAHUofJioMZUoHqMk9ackQX40GkFs3OUAA9rPKdHO5n9uHhiOJSMtBfOR/Z1chlUQ
	GSeuyTP
X-Google-Smtp-Source: AGHT+IHAREX9jlEB7DDQFJly6tT608RByxRGCuonOYwIH/zjWk609eGj2ygFHsSBmEbKSc/+O98hZVdjh7b1hxqPJfQ=
X-Received: by 2002:a05:690c:6611:b0:719:5675:5ef1 with SMTP id
 00721157ae682-719567560camr21315517b3.23.1752843893829; Fri, 18 Jul 2025
 06:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716-mobileye-emmc-for-upstream-4-v3-0-dc979d8edef0@bootlin.com>
In-Reply-To: <20250716-mobileye-emmc-for-upstream-4-v3-0-dc979d8edef0@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 18 Jul 2025 15:04:18 +0200
X-Gm-Features: Ac12FXxVwAQXB6b2VTbpgI0Tf9IffZ9HFaLLM_9W8621oBuAcd55DDCIeBmgDuY
Message-ID: <CAPDyKFqa6ut25uaDN6pP50wGi2+DZ8MJ6_OZ6ujtgjfHz4hxzg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] mmc: introduce multi-block read gap tuning
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Jul 2025 at 17:47, Beno=C3=AEt Monin <benoit.monin@bootlin.com> =
wrote:
>
> This patchset implements the multi-block read gap tuning for the SDHCI
> cadence driver.
>
> The first two patches introduce helpers to check for CMD23 support by
> MMC card: mmc_card_can_cmd23 for support proper and mmc_card_blk_no_cmd23
> for the NO_CMD23 quirk.
>
> The next two patches use the new helpers in mmc/core/mmc_test.c and
> mmc/core/block.c.
>
> The next patch add mmc_read_tuning to read blocks from MMC as part of
> the tuning. This function does not return the data read to the caller,
> only the status of the read operation. It also takes an optional card
> argument, not used when called from execute_tuning() but present in
> execute_hs400_tuning() and prepare_sd_hs_tuning().
>
> Finally the last patch uses mmc_read_tuning to implement the multi-block
> read gap tuning in the cadence host driver, by doing a multi-block read
> and increasing the gap delay until the read succeeds.
>
> v2 -> v3:
> Move the changes related to CMD23 support by MMC card to separate patches
> at the beginning of the series.
> Change the mmc read function to be less appealing to reuse/abuse
> outside of tuning context.

A quick review made me feel a lot better about this, thanks!

Although I will need a few more days for review and possibly it's
getting too late for v6.17 for me, but let's see, I will do my best.

Kind regards
Uffe

>
> Link to v2:
> https://lore.kernel.org/linux-mmc/cover.1751898225.git.benoit.monin@bootl=
in.com/
>
> v1 -> v2:
> Split the code between the core and the driver by adding a generic
> function to read blocks from the MMC.
>
> Link to v1:
> https://lore.kernel.org/linux-mmc/2a43386ffef4012530ca2421ad81ad21c36c8a2=
5.1750943549.git.benoit.monin@bootlin.com/
>
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>
> ---
> Beno=C3=AEt Monin (6):
>       mmc: core: add mmc_card_can_cmd23
>       mmc: card: add mmc_card_blk_no_cmd23
>       mmc: mmc_test: use mmc_card cmd23 helpers
>       mmc: block: use mmc_card cmd23 helpers
>       mmc: core: add mmc_read_tuning
>       mmc: sdhci-cadence: implement multi-block read gap tuning
>
>  drivers/mmc/core/block.c         | 12 ++----
>  drivers/mmc/core/card.h          |  9 ++++-
>  drivers/mmc/core/core.c          |  9 +++++
>  drivers/mmc/core/core.h          |  1 +
>  drivers/mmc/core/mmc_ops.c       | 79 ++++++++++++++++++++++++++++++++++=
++++++
>  drivers/mmc/core/mmc_test.c      | 10 +----
>  drivers/mmc/host/sdhci-cadence.c | 69 ++++++++++++++++++++++++++++++++++=
-
>  include/linux/mmc/host.h         |  2 +
>  8 files changed, 171 insertions(+), 20 deletions(-)
> ---
> base-commit: 4ad9e44c76b301e786eb4cdab890eac8c7eebd42
> change-id: 20250716-mobileye-emmc-for-upstream-4-40ef552c3b59
>
> Best regards,
> --
> Beno=C3=AEt Monin <benoit.monin@bootlin.com>
>
