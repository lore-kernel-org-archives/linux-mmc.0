Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A2E30B50D
	for <linux-mmc@vger.kernel.org>; Tue, 27 Jan 2026 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511717; cv=pass; b=DSVhHlabjKMRH2yZqdArClysNLWFs5OUKUS7eF43+ik/Sc2GsWI3uxgx3xWRIuBk8rr1WMdMyBnhkimUFw/AG37+V+tv2Iiq6P62go6GIsP4zOypF2e3pbtNA8TQ+dIGlqUf5GPs7fluHc7OhXSDXOc5EjzkCYD061NwXwqC/18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511717; c=relaxed/simple;
	bh=0nBGv5wc1gmbESug/E5wRnEti7NNLqkL2DwDYGRbhz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfMoI28WYvsOgaF3NZp9cHxgQIsZRp7qMHQOfL01j3P7OHq7/f1WrmcYMV1F6J/MQz0Gjfk4VHTum/GmbE/rKseeKnjQ57kXOJy7+n/RoKDNCkVWWWA+HJFBaGX3ilhtaSos0k2RESVa0a1v1TU17Z41QHXzs0JKUWMYKM/MxbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EfdUH40p; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EfdUH40p"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59dd54b1073so5599582e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 27 Jan 2026 03:01:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769511711; cv=none;
        d=google.com; s=arc-20240605;
        b=Yuci5k6xZN36Z6M/xZBQBnhCD1AU5134qDgnYtvSyK4soRT4ZTAaCWNt8+yTs4F0su
         pyqnnkxOzoRi6P5L41CDBGTax1vzbuFnQchNGJCS+y1cJK9FAg26h7ZgaLfYKiBsLjBQ
         x7rqrrH2Fgl83fI/S4Eac6b+BqjeyMKzUeMmLtyFg/kAvbFGgHEi87WQosisptovhYYm
         Klscq/EA5lVmG444YhqQ6ewk5rzM84OMnChZ5z6lV+EBW7aXSJ8UlPEJAFh9jpu0EsWv
         4PJCskDqp7w6zqWo3DxBxMYpNZkngFQsvGfgoOnFveka7SRn+aeb2bXjWWbK9AiNB3Ld
         VLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1gGemghmIbFPm4hIemba33PEl/d6mpxTKhUfTDkpp3Y=;
        fh=AGfYq7xVoIXWJpqsJ2mgUcKmh0mUQ6SpsydhbvytcNw=;
        b=XtWdPHZ8bN3UCdTrMHD+gmSSQlyvYHX6+WNYd4yQSNHf0QDHqtBdbSD8DIzsiMSy/A
         W8MgObLZLDCl7Dgic84+E4MvmwNzhKjJrTdVgLREaq6X69w/5EsMgHu/FYcRz6GCETtL
         9xJn0OReeiaFsg/7EWCz8nl6xLKRJ2vn9rBdsvjwytUrJiQ7kpyoklvff3rVxSXSw45n
         aq2gbH9xB5lOYTkKPalNZxbi5Sm7wd/1co3+BQvBB1AiufD0kHzi1p8T4u6UDFDj6fK5
         GUiu+iTgsPMJ/KGshl3HpRCRPnfDrd7TgxRnk/ntuzyKnaP0EXCWox+F4uPDcZ3pT7v5
         niDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769511711; x=1770116511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gGemghmIbFPm4hIemba33PEl/d6mpxTKhUfTDkpp3Y=;
        b=EfdUH40p3tWD33Jq6JtukyKUgKs4/49/mFeXkHQjPJvYTzQJiau1+bgJpgUQYiCYK2
         FH+RPAmg9a+yfwO7+uO6PCDpNUxfgu2NBGeF8yrrUCO1qOTwo83YIzzc8k7hrERDlvd6
         992I6sX0O1ooVOG8dhg+4nT1NwfjBmTp/FjK8n9LrrSkjovhK2vM1n6Ovi0EaMaOzJOz
         njuTQSiSI3OaWpW2rqslry8qNRBSWO7HeWZN1U3tu08ZucOGAqR9PxDZ3gjzMOsHIs5N
         7DQet0IfwWGfmujiCLXQ3wyGNaU8U27jA1IBOFTVGl1AbBog7Wah2eJcz71mmXZn6Lmx
         Zc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769511711; x=1770116511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1gGemghmIbFPm4hIemba33PEl/d6mpxTKhUfTDkpp3Y=;
        b=eCkkOYuva7OABcOYvE1zHV4m9QARCNSF/kBWP7fjHkfYxVFBd9fQ/8laY4vjilXIHp
         jUO+8yRJexHevGOz575IfGBx2uJWbmHxKyVMEwFnE5EzYtESqCQ8m5gS3eQRVYtO9pvP
         CiKISBnmIvaUMsS+JMM7eUQvLesCpdOTYETHUkOoKm1rxg+ueoGrTPWad/Y3e8AM4dxT
         UpLahR62u7wDeV4Sh4geYkMsRmd7G+aZmRlY4l3vyWdzV1DKCKzhyCkE6a3PRUP5tKLk
         qpjKigKOnGqX9AToNFRRb3Q2F/pvmsvmTiu1gwReq3Bkh+Uf37/c8cFCuJrN6J0gSPqG
         EX2A==
X-Gm-Message-State: AOJu0YxN7BXzi4SH34lYV3q5VVNAJuwuFIE0bnR0OZu6uHxCqEaXIqNS
	mijUjWPcxTDWKVzjDN+97JpDn8hBHNfxBOsV+fEFMfVZKveD+NgqECXXyFwhHDWNRQvShwLrWjF
	kNSSY6QCu5i82ln8bsoLIPiWLb74r/RuQ/XR7S8L8/fDHS2/nMhXhF7E=
X-Gm-Gg: AZuq6aLeS9kL0O19GJ3pAAxex4RYF9SdOejFBIFbMLBcCr/Di1PbIzmQkDE2FwiqCKB
	YeqtlhGcP1U4fz1uKQlAo6K3QrvoJ3WISmeuvVprm6T/H394EZmf0z+JKT30Cpeu4WuoQXV3Mse
	H9Ny6OgcFg4orqMJsS1EPiLlCbUdle8lCjZ+tJg1m3/RCRuiYZYdb5pzlorpYieJG6mgLxyKF+p
	OZ5WZYUfSA/81HgP4Fi9Mu9ylFWelOgxoP8KDERT3gSRb7cPy4enfboBxBfMgSCDhMNQpmIwL8p
	FBgiVGU=
X-Received: by 2002:a05:6512:61a4:b0:598:faf0:66e7 with SMTP id
 2adb3069b0e04-59e040246f4mr508182e87.26.1769511710575; Tue, 27 Jan 2026
 03:01:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
 <1767665829-183001-16-git-send-email-shawn.lin@rock-chips.com>
 <CGME20260126132209eucas1p17cd332f56bbe6aa2f168d50b44626ebe@eucas1p1.samsung.com>
 <55a29373-fe1f-4628-9e0e-e1ade3a64edd@samsung.com> <9bed7572-d4f2-4d48-af14-61aecdc1b1f0@rock-chips.com>
In-Reply-To: <9bed7572-d4f2-4d48-af14-61aecdc1b1f0@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 27 Jan 2026 12:01:14 +0100
X-Gm-Features: AZwV_QimkMMxMknwHBEUzeC9aG5ek6jrQj3-6zKLCQrJKPytzfLoDFl2E7fDr3w
Message-ID: <CAPDyKFrT+_W0-NBMQ6cP21x6sU8RVkOdrr8x0WaJ8O=5D7nqoA@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] mmc: dw_mmc: Remove check before calling mmc_regulator_set_vqmmc()
To: Shawn Lin <shawn.lin@rock-chips.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Jan 2026 at 15:34, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Hi Marek,
>
> =E5=9C=A8 2026/01/26 =E6=98=9F=E6=9C=9F=E4=B8=80 21:22, Marek Szyprowski =
=E5=86=99=E9=81=93:
> > On 06.01.2026 03:17, Shawn Lin wrote:
> >> The vqmmc regulator is acquired as optional via devm_regulator_get_opt=
ional().
> >> The helper function mmc_regulator_set_vqmmc() currently returns -EINVA=
L when
> >> vqmmc is not present. This patch justifies why this error code is acce=
ptable
> >> within the dwc driver's usage context.
> >>
> >> The function is invoked in two scenarios:
> >> 1. In mmc_set_initial_signal_voltage(): The return value is ignored, s=
o
> >>      returning -EINVAL is harmless.
> >> 2. In mmc_host_set_uhs_voltage(): This higher-level UHS voltage settin=
g
> >>      procedure should not be attempted if the vqmmc regulator is not a=
vailable
> >>      in the first place. Thus, signaling an error is the correct behav=
ior.
> >>
> >> In both call paths, returning -EINVAL for a missing optional regulator
> >> does not introduce regressions.
> >>
> >> So this patch removes the check and still returns error to the core, i=
nstead
> >> of zero, if vqmmc isn't present.
> >
> > Unfortunately this change, merged recently to linux-next as commit
> > 9157b7f91ed6 ("mmc: dw_mmc: Remove check before calling
> > mmc_regulator_set_vqmmc()"), introduces a regression: it breaks probing
> > of the built-in eMMC storage device on Samsung Exynos3250 based Rinato
> > board (arch/arm/boot/dts/samsung/exynos3250-rinato.dts). In the kernel
> > log there are only a few lines about EINVAL error:
> >
>
> I overlooked the case where vqmmc is optional with HS. Thanks for
> reporting it. Before we drop the check, I think more things should be
> done to improve mmc_regulator_get_supply() to distinguish -ENODEV with
> other errors.Given it's nearly merge window, let's consider to drop
> patch 15 and  patch 18(which you reported boot unstable) and rework
> after then in the next cycle.

Marek, thanks for reporting!

Shawn, I have dropped patch15 and patch18 from the series from my next
branch, thanks!

Kind regards
Uffe


>
> Thanks.
>
> > dwmmc_exynos 12510000.mmc: IDMAC supports 32-bit address mode.
> > dwmmc_exynos 12510000.mmc: Using internal DMA controller.
> > dwmmc_exynos 12510000.mmc: Version ID is 260a
> > dwmmc_exynos 12510000.mmc: DW MMC controller at irq 65,64 bit host data
> > width,128 deep fifo
> > mmc_host mmc0: card is non-removable.
> > mmc0: error -22 whilst initialising MMC card
> > mmc_host mmc0: Bus speed =3D 50000000Hz (req 100000Hz, actual 100000HZ =
div
> > =3D 250)
> > mmc0: error -22 whilst initialising MMC card
> > mmc0: Failed to initialize a non-removable card
> >
> > It looks that the vqmmc regulator is optional and eMMC chip can switch
> > to HS without changing the (optional) regulator voltage. Without this
> > patch the mmc0 is probed properly on this board:
> >
> > mmc_host mmc0: card is non-removable.
> > mmc_host mmc0: Bus speed =3D 50000000Hz (req 400000Hz, actual 396825HZ =
div
> > =3D 63)
> > mmc_host mmc0: Bus speed =3D 50000000Hz (req 52000000Hz, actual 5000000=
0HZ
> > div =3D 0)
> > mmc_host mmc0: Bus speed =3D 100000000Hz (req 100000000Hz, actual
> > 100000000HZ div =3D 0)
> > mmc0: new HS200 MMC card at address 0001
> > mmcblk0: mmc0:0001 F5X5MA 3.64 GiB
> > mmcblk0boot0: mmc0:0001 F5X5MA 4.00 MiB
> > mmcblk0boot1: mmc0:0001 F5X5MA 4.00 MiB
> > mmcblk0rpmb: mmc0:0001 F5X5MA 512 KiB, chardev (244:0)
> >
> > Best regards
>
