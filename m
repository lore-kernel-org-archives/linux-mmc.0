Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37B1288C20
	for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2025 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035491; cv=none; b=YN8BFhk7CA2NK9YdDgfg41YZwXbyWRIvtSClhyic1ln+gCd/SF3K5nq2DQC6u8pNizqINlxj1Q1KgGqyHlElMHlt6HfFaCxXycwFpeWoyb/9BNYTevUGS232V4d797cT/BYlmFG5Im4EU4WJbz9UI3yuBPCSfN6dLSh8rhQQiso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035491; c=relaxed/simple;
	bh=0+caDIujhpz0FRhcDE2+VAxE9La8nPwvKl4NgW9uldY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MM90hFbn/WvD6FORPUAs2y/q717wINNU/5IdiLeqMZFGAzTXjKnZBzEUL2x3BYTI9e3vTTnkDWZvQ94uxMZHNMaRZvm0AprrFhF1gSSI+xGztgelXHAvmTgeRczHq+BaHnEa7qnYQKPGBT96kptiXdBkHxZM5SsxIOt76jyzgYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=THAgaj/6; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="THAgaj/6"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3d80891c6cso1227657466b.1
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2025 01:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761035487; x=1761640287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=08GVp+OInLnYCUoelIzBBSQmuc+ORFR2n22PxCU3mnk=;
        b=THAgaj/6Iobqr6JGlLMTmydst7CfyaKHS/tBYyy7uUE8VAqlatGaSCU3BfgVd9/ZWN
         ks3LOwhAqvDGQIOAc65aFxuCPbntyep7P5XiJ1lmbVJ6rEun/44qELHpfcHov0FjNLkq
         A+j3pm0kW/B2SuvIDx2CX9TLcxx0F/ZNW0Po/2A99Rm9SPtMqk2L7nsXe1PjmPfZTWtz
         iU5oxqWMGhBuJvKJZAPeaAIHQfFH0vYrx39krRrgljcqSogRoyDUEdZRAMjqmsSxlTME
         rUYFdEHLDgQMPcjGarofp8/CNOG8pj27UmNSbiWtK3JXKRImpfvY27x4fxb/SGuc2E1V
         F3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035487; x=1761640287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08GVp+OInLnYCUoelIzBBSQmuc+ORFR2n22PxCU3mnk=;
        b=USRq5tqjx2Mv4tDbXG4+hgS5IsRte8E02njGN3ysic4dciI4CrgEGjpBcBCGyUXOb2
         fsaNSXnaDY+adJkH5BhG8i3HWYcES1tS6l0jI9NDl3KfSp+kNvEIlGZWVyuf6ClFkkNn
         F0+4el0CMU8i6ZFRDlUjFnPqhTHcv1YLFqtEs7XJv5jxlExwb6cZvnyxfJSgDQ3Do1WW
         DzqtJha/WpbXDkKKF/aNSZNi57RKaETOgnSRRjt8sXiYbXSJdMnyPx4lVsHar+RV3S29
         PXFu/s4uPMGshKYi29ER84pa91d64NlKAun/meEZNcvkdXe9eZtJr3RkwyjCqoTyRAda
         edjw==
X-Forwarded-Encrypted: i=1; AJvYcCWPy+T5TFmZ/PlmkwMlo0qF68nAqXP/tsWNedVTkNU5HmrbGf+Mgp5xFoVg+owxIztcDm4zH5X4NAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvldUfV7S90UUIsneWHoUfhybk3czW6okE2dUUxNPxvi++iT2x
	1VKQ6uClH5G/HFaAaMIfuRn4KaCL3JUA2oYuT1JptUFRrpTfQhf1PUKZ9OxU4xD/cMQ=
X-Gm-Gg: ASbGnctkufhSwCOn3BuxuIGdAmMQfVSveI/HVhW26oB2UJh0nMwtoxD9i/tkb1M/q9v
	PuDvC6bAjk1Vnwl2j8JoJsu1DBX+G5EvAthVHP/6K6zq88wX1ABAla4J2XvSMMQ3SVDSZaO+TFO
	MsBi1MqrIlLEYdM860OG1cBXDjp6Z6zCJLGxCHzNhYMmoq420hzMd7qDSJ18CDnRS8zA65BLwWM
	1V6JFVn6PPhyPzqaXIhknnHykoEKAOyWAaavHe0vlgI39YCA6aSjR185EENKLUHkUXfu0gwiK4B
	vzsVI84LW6a7FJKMRT+OCvgq4vprVt3duLLF/NrMrBI5gLApInD/xP3AC4+3lPYlIGd9jV170pk
	BBydVb6upOWLi80C3BCvSvwuRH55HFbpcaMzLYAh7cYzFUYLTOHNGWmymS9/OW8RAaF2zVy7Bgj
	+Hax0wngfbFXALHuRbRgsr7l4q8cCj9blbeGRjGu61zy1Orh/LUQMb
X-Google-Smtp-Source: AGHT+IE9nMGLvWb06pmplezToqR2L95J3tFlgDU1qAVV3hP6xK1kSz7780MH5ZLzX2rb+2xlSC+S1Q==
X-Received: by 2002:a17:907:1b05:b0:b46:57fd:8443 with SMTP id a640c23a62f3a-b645f0f9a4emr1588815766b.24.1761035487224;
        Tue, 21 Oct 2025 01:31:27 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b65e83960e6sm1008220066b.33.2025.10.21.01.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 01:31:26 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:31:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: chenhuacai@kernel.org, dan.carpenter@linaro.org, 
	david.hunter.linux@gmail.com, khalid@kernel.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, lkp@intel.com, 
	skhan@linuxfoundation.org, ulf.hansson@linaro.org, zhoubinbin@loongson.cn
Subject: Re: [PATCH v2] mmc: pxamci: Simplify pxamci_probe() error handling
 using devm APIs
Message-ID: <pvid2ycmgbkbmegnnzwl4hyev6e2smusxk5olkuqxfwxzykz2e@jlvolirolrxl>
References: <o55ujlbvxwezsf3ogqx33pcbg5b2lviy6bv5ufnz6t7yi4v23t@i6uiafh6no6c>
 <20251020183209.11040-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2qhn5ffy7ssp2gct"
Content-Disposition: inline
In-Reply-To: <20251020183209.11040-1-rakuram.e96@gmail.com>


--2qhn5ffy7ssp2gct
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] mmc: pxamci: Simplify pxamci_probe() error handling
 using devm APIs
MIME-Version: 1.0

Hello Rakuram,

On Tue, Oct 21, 2025 at 12:02:07AM +0530, Rakuram Eswaran wrote:
> On Thu, 16 Oct 2025 at 14:20, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@bayl=
ibre.com> wrote:
> > On Wed, Oct 15, 2025 at 12:16:57AM +0530, Rakuram Eswaran wrote:
> Sorry for the delayed reply as I was in vacation.=20

I didn't hold my breath :-O

> Ah, got it =E2=80=94 I=E2=80=99ll drop the clk_get_rate() comment since i=
t was only a reminder
> from your WIP suggestion.
>=20
> Just to confirm, are you referring to adding a call to clk_prepare_enable=
()
> before clk_get_rate()? I can move the clk_get_rate() call after
> clk_prepare_enable(), or drop the comment entirely.
>=20
> If my understanding is correct, I=E2=80=99ll keep v3 focused on the curre=
nt set of
> fixes and handle the clk_get_rate() precondition (by moving it after
> clk_prepare_enable()) in a follow-up patch. That should keep the scope of=
 each
> change clean and review-friendly.
>=20
> > > -out:
> > > -     if (host->dma_chan_rx)
> > > -             dma_release_channel(host->dma_chan_rx);
> > > -     if (host->dma_chan_tx)
> > > -             dma_release_channel(host->dma_chan_tx);
> >
> > I was lazy in my prototype patch and didn't drop the calls to
> > dma_release_channel() in pxamci_remove(). For a proper patch this is
> > required though.
> >
> > To continue the quest: Now that I looked at pxamci_remove(): `mmc` is
> > always non-NULL, so the respective check can be dropped.
> >
>=20
> Understood. Since pxamci_remove() is only called after successful allocat=
ion
> and initialization in probe(), mmc will always be a valid pointer. I=E2=
=80=99ll drop
> the if (mmc) check in v3 as it can never be NULL in normal operation, and
> remove the dma_release_channel() calls as well.

Yes, I suggest to make restructuring .remote a separate patch. (But
removing dma_release_channel belongs into the patch that introduces devm
to allocate the dma channels.)
=20
> I=E2=80=99ve prepared a preview of the v3 patch incorporating your previo=
us comments.
> Before sending it out formally, I wanted to share it with you to confirm =
that
> the updates look good =E2=80=94 especially the cleanup changes in pxamci_=
remove() and
> the dropped clk_get_rate() comment.
>=20
> static void pxamci_remove(struct platform_device *pdev)
> {
> 	struct mmc_host *mmc =3D platform_get_drvdata(pdev);
> 	struct pxamci_host *host =3D mmc_priv(mmc);
>=20
> 	mmc_remove_host(mmc);
>=20
> 	if (host->pdata && host->pdata->exit)
> 		host->pdata->exit(&pdev->dev, mmc);
>=20
> 	pxamci_stop_clock(host);
> 	writel(TXFIFO_WR_REQ|RXFIFO_RD_REQ|CLK_IS_OFF|STOP_CMD|
> 			END_CMD_RES|PRG_DONE|DATA_TRAN_DONE,
> 			host->base + MMC_I_MASK);
>=20
> 	dmaengine_terminate_all(host->dma_chan_rx);
> 	dmaengine_terminate_all(host->dma_chan_tx);
> }

Looks right.

Best regards
Uwe

--2qhn5ffy7ssp2gct
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmj3RNoACgkQj4D7WH0S
/k6+YQgAr92q5s709v2e2BChQIN4X2vYjeO2/gvjNuan22NTaX7HppNrsjvFEnLQ
PKamVLa4sZMUMa1Zpc1rP3B1qg1+lsYClULLMBczGMzBoHYjlCqivZWEd6NL1LaZ
rSw2n5PrsUTDrCH94opmwLm/JL/I9x+Ofq8mnyOZRDY3CClcn6Dre7ZdPvRxEwt2
5v3i9C+UL9LA+ikeeOermflH/FgPguY8zixyH7nFDRfmOO0MmJhmk5fx0OQ2BvgV
DRE5GuHRFOf69W37oRMSmOPNyW9yktsb/YTItSNvuc7ihllD2I4OMcnsSnaSlw3O
umMuZIVp59WFY1WJFnsx7yX4aqQxYg==
=iPja
-----END PGP SIGNATURE-----

--2qhn5ffy7ssp2gct--
