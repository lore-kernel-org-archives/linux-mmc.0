Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F471238D53;
	Tue,  8 Jul 2025 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974650; cv=none; b=dQTYX9l1+NBZwKNcmcbMfsuGvJMHkqyz1K3Mp2eNDGkWJ5zvI07yFsIFh/iu2eVw6WaepGebGc3bWY9/+2167QOgwyHmF4jrT7k+klNvBUtpMyWUUTd+rovWQitxBGRTi/bXz530S1taY75pRQAHUoGmWDpHsTmVRRVdHkhPb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974650; c=relaxed/simple;
	bh=Jd1T3sx5/KDM7mM/Zz9GYUL0ia9E2nQPf9lXHvRXZmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvlEOsq9kjotYniE6DKqrWXaPWbY1vYX9BWcbdTbAupMpmBzo9JPqJPOVdA/JrRPvMrzjYb1s6w5P2qzUwWYCPfjPiASTUd7u89pY9M3lRVR7U7JcewGjd5qknmSGT1I6i7y4LWHbrECSxVndA838VsNsUM7Wb4+RxfYZIbqWEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8nq7PEA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8nq7PEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DBFC4AF09;
	Tue,  8 Jul 2025 11:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751974650;
	bh=Jd1T3sx5/KDM7mM/Zz9GYUL0ia9E2nQPf9lXHvRXZmg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F8nq7PEAruPGzsKz4P4NPY8fjlO12G267D+JfaTOJBlY9Sdy7wsx7gC8260kkay+s
	 tWzPO2AFi7VgsHZQFuMTUIUB2mOlg4eLLcL1dGT+3O8jKRSOtepBQ50xTYvyVIV+dA
	 tq2+iW1AyJQ3DPbGaAHWr8v6s4r+shU6M9vCbysNwPP98wgn91/lSxRqp/gyEmXrYd
	 hEx55u5kpcsnUIVyciA+so3Imi2MRuaol3VWpP1b7hniyGrvJxxOOL/TT3ssfmPABK
	 2jumotIZ4n9V/NqtlR6USayOsUh8wfkG14ZjSTr1zqhT5Nd65oQnqvoNvFuVM+CiOp
	 BJwIOmG1igKmA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so5974963a12.0;
        Tue, 08 Jul 2025 04:37:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYwanICshJTPiTZGgCuUJN4/YrhBBWdFv1KKjEsF7kBk5Yw+VRgUy2CXBTt8mUqffPDiGw3wWR68vR@vger.kernel.org, AJvYcCVVeguin5XMRMfO69gJVZ0ICaraoCGSyfLul3+pVICuajWLSdf8KODdkCSJI9M85mToXtz2dMPa0HO+@vger.kernel.org
X-Gm-Message-State: AOJu0YwCzoZnX+QgyWbOHc4LutfJWrG8+ThRlGKbifmPfcOBTjyzwWHh
	zzoz+NB2AIHgD/uvoV6FPp2hdtQnQCjEr2xKL18YgJoq+w4ke8kNDKeD5ghVD9+WnO8lQYXchHk
	d/pNO1jI6RdJuOfczWMG0MARuL/m3il0=
X-Google-Smtp-Source: AGHT+IEMgxD68DfBMaanXG5eeXbGOXoBXXlNeYuvtnHciJwKTyhTsZrPo9HwnqIJqhWKZ9LIePES093KoEtz6FDlvYM=
X-Received: by 2002:a05:6402:3591:b0:609:b5e0:598a with SMTP id
 4fb4d7f45d1cf-60fd3491e75mr13553204a12.24.1751974648555; Tue, 08 Jul 2025
 04:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750765495.git.zhoubinbin@loongson.cn> <CAPDyKFrYYdhrctvwJ=VdTRHYSLSO_MjGKfasP53muVbe1+=0ag@mail.gmail.com>
In-Reply-To: <CAPDyKFrYYdhrctvwJ=VdTRHYSLSO_MjGKfasP53muVbe1+=0ag@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 8 Jul 2025 19:36:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5_iokrgA+efG5A9PEfCiQ-Wh2AhssnTXMzmJPE3RPtUQ@mail.gmail.com>
X-Gm-Features: Ac12FXy7BnhlcEeIQ7dGegd_kOusW7rEMktXmQkFWtnZ5nNqQpKNzizLE72fA9E
Message-ID: <CAAhV-H5_iokrgA+efG5A9PEfCiQ-Wh2AhssnTXMzmJPE3RPtUQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] LoongArch: Introduce the Loongson-2K MMC host
 controller driver
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-mmc@vger.kernel.org, wanghongliang@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 8:20=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Tue, 24 Jun 2025 at 13:58, Binbin Zhou <zhoubinbin@loongson.cn> wrote:
> >
> > Hi all:
> >
> > This patchset introduce the MMC host controller on Loongson-2K series
> > CPUs.
> >
> > They are similar, except for the interface characteristics and the use =
of
> > DMA engine, specifically, the Loongson-2K0500/Loongson-2K1000 use an
> > externally shared APBDMA engine, while the Loongson-2K2000 uses an
> > internally exclusive DMA.
> >
> > Based on this, I'm splitting the driver into two patches.
> >
> > List of the patchset:
> > Patch1: bindings for Loongson-2K0500/Loongson-2K1000;
> > Patch2: driver for MMC controller using externally shared APBDMA engine=
;
> > Patch3: bindings for Loongson-2K2000;
> > Patch4: driver for MMC controller using internally exclusive DMA.
> >
> > Thanks.
> >
> > -------
> > V4:
> > patch(2/4):
> >  - Code formatting;
> >  - Fix lkp error
> >     https://lore.kernel.org/all/202506202031.TNchn822-lkp@intel.com/
> > patch(4/4):
> >  - Rename function names:
> >         ls2k1000_mmc_regmap_config -> ls2k0500_mmc_regmap_config
> >         loongson2_mmc_reorder_cmd_data -> ls2k0500_mmc_reorder_cmd_data
> >         loongson2_mmc_set_internal_dma -> ls2k2000_mmc_set_internal_dma
> >  - Use macro definitions for magic numbers.
> >
> > Link to V3:
> > https://lore.kernel.org/all/cover.1750216134.git.zhoubinbin@loongson.cn=
/
> >
> > V3:
> > patch(1/4):
> >  - Rename dt-binding file as loongson,ls2k0500-mmc.yaml.
> > patch(2/4):
> >  - Fix lkp error;
> >     https://lore.kernel.org/all/202505130918.uanOGxju-lkp@intel.com/
> >  - Add regulators support for ios ops;
> >  - Add ack_sdio_irq() callback;
> >  - Add MMC_CAP2_SDIO_IRQ_NOTHREAD flag;
> > patch(3/4):
> >  - Add Ack-by tag.
> > patch(4/4):
> >  - Update commit for fix_data_timeout().
> >
> > Link to V2:
> > https://lore.kernel.org/all/cover.1746581751.git.zhoubinbin@loongson.cn=
/
> >
> > V2:
> > patch(1/4):
> >  - Add reg define for each reg entry.
> >
> > patch(2/4):
> >  - Put all code in the c-file;
> >  - Use mmc_from_priv() instead of host->mmc;
> >  - Use sdio_signal_irq() instead of mmc_signal_sdio_irq();
> >  - Use devm_mmc_alloc_host() instead of mmc_alloc_host();
> >  - Use mmc_regulator_get_supply();
> >
> > patch(4/4):
> >  - Add fix_cmd_interrupt function which is needed by Loongson-2K2000.
> >
> > Link to V1:
> > https://lore.kernel.org/linux-mmc/cover.1744273956.git.zhoubinbin@loong=
son.cn/
> >
> > Binbin Zhou (4):
> >   dt-bindings: mmc: Add Loongson-2K SD/SDIO/eMMC controller binding
> >   mmc: loongson2: Add Loongson-2K SD/SDIO controller driver
> >   dt-bindings: mmc: loongson,ls2k0500-mmc: Add compatible for
> >     Loongson-2K2000
> >   mmc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC controller driver
> >
> >  .../bindings/mmc/loongson,ls2k0500-mmc.yaml   |  112 ++
> >  MAINTAINERS                                   |    7 +
> >  drivers/mmc/host/Kconfig                      |   13 +
> >  drivers/mmc/host/Makefile                     |    1 +
> >  drivers/mmc/host/loongson2-mmc.c              | 1029 +++++++++++++++++
> >  5 files changed, 1162 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/loongson,ls2k=
0500-mmc.yaml
> >  create mode 100644 drivers/mmc/host/loongson2-mmc.c
> >
> >
> > base-commit: f5c755ef810009b85350884c483705bd04365370
> > --
> > 2.47.1
> >
> >
>
> The series applied for next, thanks!
>
> Note, I am leaving you to address/discuss Huacai's comment on patch1
> as a new patch on top.
Hmmm, if possible, I prefer Binbin to send a clean v5 with that
modification. Or you modify it by yourself when applying.

Huacai

>
> Kind regards
> Uffe
