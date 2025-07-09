Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07368287278
	for <linux-mmc@vger.kernel.org>; Wed,  9 Jul 2025 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057386; cv=none; b=NTWvzz5Dzs05/VENbYt2MtfJcu5WVKoymw02cn+qd8tVBCDWaHRMyObw9kByYZB7jwVEVxr2xdhQAORxFnias6Eltv5Zi7SAwFjF4tiWrTzH1y4zAn4MC/pdxYIOFZeoaS4CvXuKza6dCu7zXbjPamOEbjX52IJAIMLbNgcVGkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057386; c=relaxed/simple;
	bh=mBiq3LdEFkT8yAGmpY7VY+ypmr1/6AhCyqWSdeCtF3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDwwncZMD3T6Y8ouZlfadp4jdPRXtzS7jwPLcx6OMRUJ+zpm6D6PVTB9g/mgquE9vl6rtjV9qAoZMc09LRDBItsd28h2C7PHorSLWRexy2KdS8HvltIqjp9nALK5jiAgUm0ZqdTw5u54ozf+Aq6jwK263T6Q6MOwz4iwMrUOI0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AaC5Kop2; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AaC5Kop2"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7086dcab64bso46435287b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 09 Jul 2025 03:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752057384; x=1752662184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0p9u4plpxbVFh6lI2RB4vHEjyRIuK37OQFSWTJvPBhE=;
        b=AaC5Kop2CZtOc2ehoFxMqfS5vP52B/3LpBFLLXj0wg+I0lQrquA5/gbwkNOjsRo5gS
         HT3CgZBldalHCuOsf2vJHX4kKMOjx+GKld181LtRHIIBC03V6e3cUWUB3m+hV6M9x7iI
         TaNpTFOtVxybkYv26+8diGhlH/LfNR9nV6QdsxWvv6HYTKebhWF1SzhAGKU3YYSh/eMH
         mifLBrVBugPwUN5euzGQEraEeX0tlNl0tjoJ3lk28sPpKnXzbb6N7ZJohA+1QDObOQ2a
         5AMHQO1qM+iHw1m8+t7/LAxGTAHnC5tMKsYQooRszjpSQ74Fa7TgjFzwKxZkIR4kI3q+
         A0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752057384; x=1752662184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0p9u4plpxbVFh6lI2RB4vHEjyRIuK37OQFSWTJvPBhE=;
        b=PjZPuCWEwNupQRL+Bx8S0CROgqaumZhNW9APaJAJ2ro3ZqModMg+3WJkyeq4gI5Mry
         6GY3eEHp9P2QqcL+M4dNB6BaRCRcRcTECBt6PikTqQ5vF+XbTFDngyIW7KKleo8obI80
         rS4yre51IQthS+lR+E03mjFZucPHrI4dvlRQZn7wlNze0ky64AxpVM3cNvQU5b/TT0Pg
         Ve4tVo+NCGRzI5fuPAr9IZkaJbtGuqjHb2ghuS8K6kdMqTT5t0zTtzNBWmdgH1IIBaDG
         EnJzz9ejl1jVMMqwr4S36S5af9S1MwAYSTBJAOdInA0HmYMINSj2vFs2plDhEnmNR7nv
         Y3ow==
X-Forwarded-Encrypted: i=1; AJvYcCVqjXP2/cSTk5L4M0w/rvm4z8P2lkWfJqfv9pa3eGzyWPQ3P44sKtCHqICCQ8+dYYDJGWLmSw+Wwbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8mTogZbAgFdnAEtqiqlV+2Dwyr43hr31BFkpCK+OpbSqucArl
	3MjhILlqmDCMjk1ZxkfaKJmzjA6sDi9+cNPT9aGGzZaj6aEJhXh1t5mOe447zA/Cypw1pe9t7P6
	iiSSrxE/LFZPccJ0ROxvgWXD8yodWOjNsqW40S68hog==
X-Gm-Gg: ASbGnctxMC16KNngvqG98JD04SWC/n7fd1erbE2yrnPNu/HQ8xozqId+Z/rukCUqmZb
	/9MNkazf7TmeapeT6TggjbOBR6q5S5gWKzBIdAhuw+NTkjxePg9lrEM6Cb3EYCzqOVxbtp0VfN6
	6l2XnFwoxRIVbC2HvbvSzM2LinswGxN+TYOIgvnf0x5xfb
X-Google-Smtp-Source: AGHT+IE83XXdAl+aWVQg+Tc9AgySBYO9LqjNqiDZMc/oFmg29Li6jivhx7YjZSQgp9l/oFfbXq07gAyjA/zaDQ6XS9Y=
X-Received: by 2002:a05:690c:708e:b0:70e:7a67:b4c5 with SMTP id
 00721157ae682-717b1a17b03mr28925717b3.36.1752057383758; Wed, 09 Jul 2025
 03:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750765495.git.zhoubinbin@loongson.cn> <CAPDyKFrYYdhrctvwJ=VdTRHYSLSO_MjGKfasP53muVbe1+=0ag@mail.gmail.com>
 <CAAhV-H5_iokrgA+efG5A9PEfCiQ-Wh2AhssnTXMzmJPE3RPtUQ@mail.gmail.com>
In-Reply-To: <CAAhV-H5_iokrgA+efG5A9PEfCiQ-Wh2AhssnTXMzmJPE3RPtUQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Jul 2025 12:35:47 +0200
X-Gm-Features: Ac12FXwAkwnffI0MhMh9MuqyGN1IKBhd3sj0L-DBUX9H5dvO2DwXdx3NbqUnn3U
Message-ID: <CAPDyKFqL6a=KJ50TPcUpnj7HKdYz9oN8+2B2XP7FMTEYpUbUaA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] LoongArch: Introduce the Loongson-2K MMC host
 controller driver
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-mmc@vger.kernel.org, wanghongliang@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Jul 2025 at 13:37, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> On Thu, Jul 3, 2025 at 8:20=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> >
> > On Tue, 24 Jun 2025 at 13:58, Binbin Zhou <zhoubinbin@loongson.cn> wrot=
e:
> > >
> > > Hi all:
> > >
> > > This patchset introduce the MMC host controller on Loongson-2K series
> > > CPUs.
> > >
> > > They are similar, except for the interface characteristics and the us=
e of
> > > DMA engine, specifically, the Loongson-2K0500/Loongson-2K1000 use an
> > > externally shared APBDMA engine, while the Loongson-2K2000 uses an
> > > internally exclusive DMA.
> > >
> > > Based on this, I'm splitting the driver into two patches.
> > >
> > > List of the patchset:
> > > Patch1: bindings for Loongson-2K0500/Loongson-2K1000;
> > > Patch2: driver for MMC controller using externally shared APBDMA engi=
ne;
> > > Patch3: bindings for Loongson-2K2000;
> > > Patch4: driver for MMC controller using internally exclusive DMA.
> > >
> > > Thanks.
> > >
> > > -------
> > > V4:
> > > patch(2/4):
> > >  - Code formatting;
> > >  - Fix lkp error
> > >     https://lore.kernel.org/all/202506202031.TNchn822-lkp@intel.com/
> > > patch(4/4):
> > >  - Rename function names:
> > >         ls2k1000_mmc_regmap_config -> ls2k0500_mmc_regmap_config
> > >         loongson2_mmc_reorder_cmd_data -> ls2k0500_mmc_reorder_cmd_da=
ta
> > >         loongson2_mmc_set_internal_dma -> ls2k2000_mmc_set_internal_d=
ma
> > >  - Use macro definitions for magic numbers.
> > >
> > > Link to V3:
> > > https://lore.kernel.org/all/cover.1750216134.git.zhoubinbin@loongson.=
cn/
> > >
> > > V3:
> > > patch(1/4):
> > >  - Rename dt-binding file as loongson,ls2k0500-mmc.yaml.
> > > patch(2/4):
> > >  - Fix lkp error;
> > >     https://lore.kernel.org/all/202505130918.uanOGxju-lkp@intel.com/
> > >  - Add regulators support for ios ops;
> > >  - Add ack_sdio_irq() callback;
> > >  - Add MMC_CAP2_SDIO_IRQ_NOTHREAD flag;
> > > patch(3/4):
> > >  - Add Ack-by tag.
> > > patch(4/4):
> > >  - Update commit for fix_data_timeout().
> > >
> > > Link to V2:
> > > https://lore.kernel.org/all/cover.1746581751.git.zhoubinbin@loongson.=
cn/
> > >
> > > V2:
> > > patch(1/4):
> > >  - Add reg define for each reg entry.
> > >
> > > patch(2/4):
> > >  - Put all code in the c-file;
> > >  - Use mmc_from_priv() instead of host->mmc;
> > >  - Use sdio_signal_irq() instead of mmc_signal_sdio_irq();
> > >  - Use devm_mmc_alloc_host() instead of mmc_alloc_host();
> > >  - Use mmc_regulator_get_supply();
> > >
> > > patch(4/4):
> > >  - Add fix_cmd_interrupt function which is needed by Loongson-2K2000.
> > >
> > > Link to V1:
> > > https://lore.kernel.org/linux-mmc/cover.1744273956.git.zhoubinbin@loo=
ngson.cn/
> > >
> > > Binbin Zhou (4):
> > >   dt-bindings: mmc: Add Loongson-2K SD/SDIO/eMMC controller binding
> > >   mmc: loongson2: Add Loongson-2K SD/SDIO controller driver
> > >   dt-bindings: mmc: loongson,ls2k0500-mmc: Add compatible for
> > >     Loongson-2K2000
> > >   mmc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC controller driver
> > >
> > >  .../bindings/mmc/loongson,ls2k0500-mmc.yaml   |  112 ++
> > >  MAINTAINERS                                   |    7 +
> > >  drivers/mmc/host/Kconfig                      |   13 +
> > >  drivers/mmc/host/Makefile                     |    1 +
> > >  drivers/mmc/host/loongson2-mmc.c              | 1029 +++++++++++++++=
++
> > >  5 files changed, 1162 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mmc/loongson,ls=
2k0500-mmc.yaml
> > >  create mode 100644 drivers/mmc/host/loongson2-mmc.c
> > >
> > >
> > > base-commit: f5c755ef810009b85350884c483705bd04365370
> > > --
> > > 2.47.1
> > >
> > >
> >
> > The series applied for next, thanks!
> >
> > Note, I am leaving you to address/discuss Huacai's comment on patch1
> > as a new patch on top.
> Hmmm, if possible, I prefer Binbin to send a clean v5 with that
> modification. Or you modify it by yourself when applying.

Sorry, the patch has already been applied and I didn't think a
variable rename was that big of a deal.

Please just post a patch on top and I will happily apply it.

Kind regards
Uffe
