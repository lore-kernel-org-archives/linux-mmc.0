Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2960C223336
	for <linux-mmc@vger.kernel.org>; Mon, 15 Dec 2025 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765813422; cv=none; b=hp1gZQaGPk50P7c3sL4ZrIcRgT5TCkRcNmEqrKZsEGj4RiEt4wDWSRbayPgEnY9xdHoH79+DpbRhGEcgR32uT11Oe4hKuFuhspYnZm6piOk9cllBT3aPdkcBHqvAQXcAaJdhP+9hv430tLz+IAVC2wT87sCI+En5sVycwIefF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765813422; c=relaxed/simple;
	bh=Z2a3M2ESMF9WTEfcsdmwWJPI9ukauQttx4Dfbf44t+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awUL/Ou5RQ32eyYZM+dFVM85ThF0+CAkV08QKdCLcxkimC25k9qQP587/H8RMupyBngSXKEzL3yEo72qoO47wA+ho1nyI2TqU3pFdBoTQh7S8leuqqg1nR0+sF50npthppbhiFkkHrsv4FbymiV8q4yTAaZ0GiGgnWuiCe2Nv/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NXc4uQy4; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXc4uQy4"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-598eaafa587so4249015e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 15 Dec 2025 07:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765813416; x=1766418216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ag1xTdS2WJOy6gmYcvslytrIx/tnDCnR7K3JJNqwY/g=;
        b=NXc4uQy4/E+ZGjRfZNeVKTLpjaE7lvusQn4Og1Aq0T0kMpGiyifE8oUKokqGB53ft8
         5cDhneVkhQDBH/QOD6kRaldRnbQmobtmSklk35XrTNS/sb5Rsp9q/b4CNt/CY4aUqKqq
         3YA0HlUR9d0SmZGd46omIGI2a2rd9wpocVe8bpi5PNoQefp4ioX2WgjMhNqAMAJrJI+T
         OlB9dJZxfHu1zPyZ6M9aQYgSNPUmPmPD8u6+JRkJWndxMmNDt8Wf6RmYSt2WSEOqPU5E
         +lubBJ+4xJRO1+c/qL2yqVyn7uZaHig+Veac3zQ9XfeSvVc568wo1NDo+mGSJEzXCp55
         lAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765813416; x=1766418216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ag1xTdS2WJOy6gmYcvslytrIx/tnDCnR7K3JJNqwY/g=;
        b=SFxVsVz83491O5/rbCNSovn55AMl8SrPlDrlWlGWNU0a7gMg9sxnTCW0QEuTHOwPdV
         yJ6l/llXIUDPDm42R8qSNqutluXLUrxMSYcIO9QcxSwXSjS33hfQyB+2srBbkNSQ4LSp
         DqHxYFswwHm8zMX1yAc1B5SgQ7jNWA+EQECMqElzgkc5yYn+OjvHy65qZHCJqgiLGMZM
         Ke+/Wq5DJogL78QbzQixFr5IgTqjqHP3LuG8V5EsS1rtTaL+zAh3VAprLI1CHuphAIfP
         kSIcVKFZWiAhsu93y293qLvq0Yw04Q2SJh0JZ+KUCWNDrdvvBhln/nfQTzZqrInMN2jM
         I4ug==
X-Gm-Message-State: AOJu0YxhsRrK+gunWSa+3NsSzGowMxdTKwZxx5Dqtul0nTWWTnKu/3g1
	Yz/aP2ZmWI9SbrM+7K13cRusm7Ig58l2jlqRlRt55Vk4qUVSv3xZV/TLixbth/1DwpSF3b8riEy
	osGGW/K3ZS1j/RfVmCywshsuBC6tdtNCJph+0ADcVTn6GG2p0NWN4
X-Gm-Gg: AY/fxX65hVmos6Wg5MdEFZUHcW4Hp8Tc2PS9T2bwqrkBedHwNCAtUVyTL0c5mQBm81l
	4YRPd+jySE1hB20XhkP8TTbnNyLKuPV3OhmDEd344pjNzMs4aBvZjBjJGN9rEC9QmunzOsOq3FI
	Hz35Mk++Jm7MO0JsRnxjCCIjM69XsnuCKLB9URQUdnDVV9Ew7cN+5k2xfeZiJnETskqEgb0uaeM
	736mX5zjN9I66SYAN1arj+OUpTW+5kMorSS2hD57r/kU7xxew7+BuPwtrrpC2ZKgzBTWDUf
X-Google-Smtp-Source: AGHT+IGlko49bLIENZg6n4zO73WrzVUzwZ/ZU90v8N3nyr9+/wMisbhjaL/Kqq+4fWLgzHJwKAujEw7R9BlKLplpNig=
X-Received: by 2002:a05:6512:230e:b0:577:3ccf:cdee with SMTP id
 2adb3069b0e04-598faa8f00emr3892543e87.41.1765813416206; Mon, 15 Dec 2025
 07:43:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 15 Dec 2025 16:42:59 +0100
X-Gm-Features: AQt7F2pOv_kN5nsxWphWt4nBKY1sFeWRHUzNlBtC3vQ98ZHVhSqtCgQpxOClmDY
Message-ID: <CAPDyKFoc87upieLFZ81f4o5xRPHnuP_-xFHVqe8Y=CgjNnUiLw@mail.gmail.com>
Subject: Re: [PATCH v2 0/13] dwmmc cleanup
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Nov 2025 at 01:15, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
>
> Hi Ulf & Jaehoon
>
> As you can see, dw_mmc is likely one of the most complex and difficult-to=
-read
> host driver at present. It maintains various states and bottom-half sched=
uling,
> containing a significant amount of redundant code=E2=80=94including a mul=
ti-slot mechanism
> that has been unsupported for over a decade.
>
> Jaehoon attempted to remove cur_slot more than ten years ago, but the dri=
ver still
> retains the slot structure and the associated queue mechanism designed to=
 support
> multiple slots. This has made the already complex code even harder to rea=
d and maintain.
>
> The first four patches aim to eliminate some of the redundant code, while=
 the remaining
> patches are intended to ultimately remove the dw_mci_slot variable. To fa=
cilitate review
> and minimize the risk of regression, each patch is designed to accomplish=
 a single,
> clear objective.
>
> This series have been tested on the RK3588S EVB1 platform.
>
>
> Changes in v2:
> - Fix sparse warning
> - Use helpers from regulator.c and remove check for mmc_regulator_set_ocr=
.
> - add commit message
> - make commit message clear that we remove two things
> - remove a unused code
> - Fix dma_set_mask_and_coherent mistake by code rebase
> - fix compile warning
>
> Shawn Lin (13):
>   mmc: dw_mmc: Remove unused struct dma_pdata
>   mmc: dw_mmc: add dw_mci_prepare_desc() for both of 32bit and 64bit DMA
>   mmc: dw_mmc: Remove vqmmc_enabled from struct dw_mci and user helpers
>     from core
>   mmc: dw_mmc: Remove unused header files and keep alphabetical order
>   mmc: dw_mmc: Move struct mmc_host from struct dw_mci_slot to struct
>     dw_mci
>   mmc: dw_mmc: Let glue drivers to use struct dw_mci as possible
>   mmc: dw_mmc: Move flags from struct dw_mci_slot to struct dw_mci
>   mmc: dw_mmc: Remove id and ctype from dw_mci_slot
>   mmc: dw_mmc: Remove sdio_id from struct dw_mci_slot
>   mmc: dw_mmc: Move clock rate stuff from struct dw_mci_slot to struct
>     dw_mci
>   mmc: dw_mmc: Remove mrq from struct dw_mci_slot
>   mmc: dw_mmc: Remove queue from dw_mci
>   mmc: dw_mmc: Remove struct dw_mci_slot
>
>  drivers/mmc/host/dw_mmc-exynos.c      |   9 +-
>  drivers/mmc/host/dw_mmc-hi3798cv200.c |   6 +-
>  drivers/mmc/host/dw_mmc-hi3798mv200.c |  17 +-
>  drivers/mmc/host/dw_mmc-k3.c          |  21 +-
>  drivers/mmc/host/dw_mmc-pltfm.c       |   2 +-
>  drivers/mmc/host/dw_mmc-rockchip.c    |   9 +-
>  drivers/mmc/host/dw_mmc-starfive.c    |   5 +-
>  drivers/mmc/host/dw_mmc.c             | 621 ++++++++++++++--------------=
------
>  drivers/mmc/host/dw_mmc.h             |  83 ++---
>  9 files changed, 302 insertions(+), 471 deletions(-)
>
> --
> 2.7.4
>

To start moving forward, I decided to apply patch1 and patch2 for next, tha=
nks!

Kind regards
Uffe
