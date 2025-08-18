Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2277423506A
	for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529048; cv=none; b=rgAhqCYZl4k4A54zQribnQH42H9g9kRJ/OvXkpYe2r3psA+d+nuUHnFrGk36/2/D4w7vp8un0Ty+1TK4jvMUOR+Ww9uj7TlJj2O5xYiL/Xw2wpUxvOOjY9shUhI0L7C4r5MzQkS0PulyWX0H6mEjyOQM7/MHkC9fp0XlBR3jXMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529048; c=relaxed/simple;
	bh=zM1QLTJ8d9ktsdYpqAp8azR1zWsMGreYGCU1Y7gItTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fxmq5lrv3z45mgsSf6RV+ob7KZUM9iVAxcWUL8dogcT3lThHGckGWaxKIskI1uWubCk0pmTyD6skWoo64F127xUrFrg/yXg/xNc8Hm8mJPPP2z9sk8cfKIl8UVjeVS/VQrWMUEGCgiij0ygvN0YFt5UCfuwbmR6V/0sZKtZBvmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FlC6BW++; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FlC6BW++"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d603b62adso35615727b3.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 07:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755529041; x=1756133841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7O0UQ1pCQtHfpFhQ25ojbKTIwk2c1/Y6ODmytP6Xa8=;
        b=FlC6BW++sY58ehg2Cz2eWAKYQ0MmNlzajhMPj7gycznmhYHAatrB2SrMTdknO2Qfrb
         Zl6iWLr+AJa8BQKtocDfif3k827vllpIdTr5IRyKzQbjP13hWEn2iOvMZzWo9mU+ZDAn
         i6nnWlP9VN2XvRZbRZZrZZfQ/9xm2UjqK5Jbjn4UFPAxgnH3JmLDjf4FwdYyVktRCOZP
         1A9oPEWXa3A/sRpNGVDQOg44XF8+qmMMGEdQMyufvwi9zWNQtVLVM9jvk8lILYJJ68mL
         +fSv6Or75vHKJ/eLT1E+Io79eaajY/ApWaoDE64/33+8fyOW9EMfCKm2s1uXVHwf0efy
         7q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755529041; x=1756133841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7O0UQ1pCQtHfpFhQ25ojbKTIwk2c1/Y6ODmytP6Xa8=;
        b=AP82m3iuoY7B7wkx2+5cFtYfqKs+P8I2WXO9JWo96D3qci0ALVjuZ0OupHEn7wYyAY
         s85+oG0RFcZY4qggqFaFoFXHc7saqAfXLa/EzYPPQXfRaIlAvJq1E9IWkLV8xirXLVvP
         XsesbDtPMkDVakY9BvNrIywy0ASmZbt01nnmwlu0Q9wCHG2Rh4/9eOD+GR2lU4KqlmbS
         vjIUTh1vNd9XWlBDsTeMjs9eeTnmQratzt1XwUx+qGw6JiF+9vQtSyLsboao5GA3RQ1P
         nGXj8izqCSAIi/uxwZ9Ke8Khz0qRRWR41UuUptj4FU2z9gp42uNacPuwC+Gd+HF4DRKM
         po1g==
X-Forwarded-Encrypted: i=1; AJvYcCU9+A0QvNHum+KdK+bACjgCk1DYhK8KTfNhlED1Zkm3lSqP9eMhR7GSaAYV67WxAPRgeWNVcmYreB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp6xVjlH153qAO3wuk18PpQ+5KaU/5k+cimyQEKjQ22iRME1RP
	2hEYpdP/9mAfxYk8HYnGGCdLQj+VgHiokC30k5B/38udObKQajefGQ+OdX/B1s29ly69/PenUBx
	aXFM8HTd6gnZWFHKafPlkXohxF9nnK22cTE1VzyWJUA==
X-Gm-Gg: ASbGncvgyL+5o2W2JyXUyRk9havKZEVaWeREPgRsSIpa9KjrSxSTyguIDS48WfflKzT
	06vjkI1QjgqoWdf/PeLxb/AA1ZVEtdHARkAaqM4mnSLpuWlobkj4yKIqnDXVwTk6AF/iTVQC49P
	qJFinresKyz2QdH+MXf/lmZZKFGBo7RyDvQngRZ24y+N+Raq1rOa4xOLeh6AfSSbbsm1bWLDO2r
	rCrep0o
X-Google-Smtp-Source: AGHT+IFrpy3Zh36/3rhDK9Yo1wKEo3VGJNpy/ovwmXZmsLaz1X1Vs5J2QxFrcBYfNMY8dyhO3nn0S7+Gkz85+LoYBJg=
X-Received: by 2002:a05:690c:e0d:b0:71b:69fd:257b with SMTP id
 00721157ae682-71e7740a667mr102425067b3.0.1755529041394; Mon, 18 Aug 2025
 07:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818-mobileye-emmc-for-upstream-4-v4-0-34ecb3995e96@bootlin.com>
In-Reply-To: <20250818-mobileye-emmc-for-upstream-4-v4-0-34ecb3995e96@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 16:56:44 +0200
X-Gm-Features: Ac12FXzpIsw7z74y8Gp-wah-Wi-b7dV6r0hRPk1lXGPmvuoz888ocsyHK-dWIPs
Message-ID: <CAPDyKFovFcBX+DwrVfKt_NKbWcTxk8ZOgn5ndo=fVT78Zk=qzQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] mmc: introduce multi-block read gap tuning
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Aug 2025 at 16:03, Beno=C3=AEt Monin <benoit.monin@bootlin.com> =
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
> only the status of the read operation.
>
> Finally the last patch uses mmc_read_tuning to implement the multi-block
> read gap tuning in the cadence host driver, by doing a multi-block read
> and increasing the gap delay until the read succeeds.
>
> In the previous version of this series, mmc_read_tuning had a struct
> mmc_card parameter and was making use of the helpers. This parameter has
> been dropped so the last two patches are now independent of the rest of
> the patchset.
>
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
> Changes in v4:
> - Dropped the card parameter of mmc_read_tuning.
> - Updated the last patch following the review of Adrian.
> - Link to v3: https://lore.kernel.org/r/20250716-mobileye-emmc-for-upstre=
am-4-v3-0-dc979d8edef0@bootlin.com
>
> Changes in v3:
> - Move the changes related to CMD23 support by MMC card to separate
>   patches at the beginning of the series.
> - Change the mmc read function to be less appealing to reuse/abuse
>   outside of tuning context.
> - Link to v2: https://lore.kernel.org/linux-mmc/cover.1751898225.git.beno=
it.monin@bootlin.com/
>
> Changes in v2:
> - Split the code between the core and the driver by adding a generic
>   function to read blocks from the MMC.
> - Link to v1: https://lore.kernel.org/linux-mmc/2a43386ffef4012530ca2421a=
d81ad21c36c8a25.1750943549.git.benoit.monin@bootlin.com/
>
> ---
> Beno=C3=AEt Monin (6):
>       mmc: core: add mmc_card_can_cmd23
>       mmc: card: add mmc_card_blk_no_cmd23
>       mmc: mmc_test: use mmc_card cmd23 helpers
>       mmc: block: use mmc_card cmd23 helpers
>       mmc: core: add mmc_read_tuning
>       mmc: sdhci-cadence: implement multi-block read gap tuning
>
>  drivers/mmc/core/block.c         | 12 ++-----
>  drivers/mmc/core/card.h          |  9 +++--
>  drivers/mmc/core/core.c          |  9 +++++
>  drivers/mmc/core/core.h          |  1 +
>  drivers/mmc/core/mmc_ops.c       | 72 ++++++++++++++++++++++++++++++++++=
++++++
>  drivers/mmc/core/mmc_test.c      | 10 ++----
>  drivers/mmc/host/sdhci-cadence.c | 63 ++++++++++++++++++++++++++++++++++=
-
>  include/linux/mmc/host.h         |  1 +
>  8 files changed, 157 insertions(+), 20 deletions(-)
> ---
> base-commit: 8936497143de1da7958178d57db6011eceeb14a8
> change-id: 20250716-mobileye-emmc-for-upstream-4-40ef552c3b59
>
> Best regards,
> --
> Beno=C3=AEt Monin, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
