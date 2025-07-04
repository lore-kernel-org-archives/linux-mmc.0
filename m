Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFDB2EFD84
	for <linux-mmc@vger.kernel.org>; Fri,  4 Jul 2025 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751625873; cv=none; b=CUnh0dNvDSsVPkYhbsc3ZzTG1WUgz9bGR7RF+wQrKcaZPFyJuzFpwnSPJY24Vs+wfrB9ERKpsxAp+Am2I+nL3+VUUNg5PyWIeLYJ8DVrNJnagr5eL1E7pd42oWUfyN7rcxyOR+rHNFSAPt9x3awFAkwwMuK/cg0FC5Kv+cHtYG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751625873; c=relaxed/simple;
	bh=5guiqVsVLnv/ZIr7+V15ooWEV8YcnXKuVyZTVBle8dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNRiVsmvf3yRuP1bP4WPjE8Bp50WZWQmdZxWa3GDWM4kSYC5b6TAbxzJu+0l9BE0duu4pqZgOIwHFjwyC+H5OgODv+Kvq9Xy4ndm/Jl/JqB77a/zBiDbZgt/FLWCV9Z5wFbMDxJDT6uqRhAPDMjWFCBoCUEl8WeaEFQn4DGJOYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mwZ5on26; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mwZ5on26"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-710e344bbf9so6407577b3.2
        for <linux-mmc@vger.kernel.org>; Fri, 04 Jul 2025 03:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751625870; x=1752230670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5guiqVsVLnv/ZIr7+V15ooWEV8YcnXKuVyZTVBle8dU=;
        b=mwZ5on265YXR+SSXVTFAa0sNDQgeMENacIYBGXsL7pHxYtEqldFlh5PV+w6jloKjx2
         bVYgeo6HHsLJ66vI/AbCrGCiGwtn/FSf1K1BKAPCEsQMlX2uS3o/arGJNRlMAYQ0pT+K
         a4EOztisXlGhU35XCYlrZQWN9/uvSkrEv/9R8o5iUUwY08OWqg6GJ6zSZV8Ghwddv6pz
         GaU712QvJJpdR5fetSqX6W7nAeLleeSzIRf55N9ctSvdkp/2b0gEAAejdBA6uZtgs8uq
         8RTNSFvcmF/atUYG9br6T9OfF1oZYcPvzHwLSxcuyXc5CqEoBxXlBWL1Tuyp8e6slfqU
         X2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751625870; x=1752230670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5guiqVsVLnv/ZIr7+V15ooWEV8YcnXKuVyZTVBle8dU=;
        b=GlYdkZU/GrXpFeZvQwqI4VTy39V07Z8O8kMSSaWXX1YSaFpdyuULZDby8bGHWQD9c6
         FKsLklQ3mZjWenm0G4eqLPnpafMCItI3YajKlt9e7heMAPKn7pVohaEKq0XDh6YaNKWz
         ZOIWNhpF0DW7FJlXO9t9lyavZphUk95pi85xJPJA5nOdCRUNYiLoPL6wtrnhX5Fl8s7q
         QvWzzju7o0/MxOtqZqoGWvhgI1ji3TALeKnzqcyYoBox5PiqfvpvAdnmJ+4Tfh4ga3qd
         dkC3N/1fKGlV8xI2LV1GeEfdacfMvRwt2/kE9/+s3PZH4pGBO1HiIOV8NwUmer74MA9s
         37FA==
X-Forwarded-Encrypted: i=1; AJvYcCXYRRz88ZfYLzK+xaSRuq3FlRZDqFN3/+YRaptfSZqlGuV8DsLik9rW4D70k6n08VxCmk0RIPc/N3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0I9DaiXTjjeAmj+xAKQ3MZ2SxoNYBpk/TCZZUxUwhVgQhScix
	D4Zyxxv6JcmfaRmcR+zjW+u2Ir3+w5QXixtkmeNcHNv2sYYuGXg3C6VDH1qHT1PafVHbPcfduar
	KPE24NJmLqHKHPcWhpUhTbPlEVG7zZ0PqjEbs5aAjuw==
X-Gm-Gg: ASbGnctC9nj1yqz0y8cevTAfpvPHe945TzpXwYpCZ/RqzJ3L+i9O8S9hPJNzmE0kiWv
	hXABLpTXprnaQ1Nag8v43iywqJ3BbFauIVf82d/QU2P8A04bgzyYkUJQCFjBEsLAUW6pS+tYZ4l
	784eda59OXFZBk8qBdcwhi7CEdmfxgf8lmWOpPY2vj1aMf
X-Google-Smtp-Source: AGHT+IHxcc2Fxf3Ymhe5B77LuEeRBxhSWFvYLVsMhgLwf+RJJkmFP3Px1U7JlwlJL6aiE8sjF/I7Cpuheq/ounuXY9Y=
X-Received: by 2002:a05:690c:640d:b0:70c:a57c:94a3 with SMTP id
 00721157ae682-7166b6cd964mr16574447b3.19.1751625870644; Fri, 04 Jul 2025
 03:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627025032.1192873-1-rex.chen_1@nxp.com> <20250627025032.1192873-3-rex.chen_1@nxp.com>
 <CAPDyKFrm+KE_XuzuVkLeykmwmRkbNaY8aerLgs45uSWex2SLfQ@mail.gmail.com> <DB9PR04MB9626F66BB0CC3539219D3B82FC42A@DB9PR04MB9626.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB9626F66BB0CC3539219D3B82FC42A@DB9PR04MB9626.eurprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 4 Jul 2025 12:43:54 +0200
X-Gm-Features: Ac12FXzL9sGtjblIKfjQcfceCbnswuu_1FKcFADSJhfltP9gZQVUvblVdtrMARM
Message-ID: <CAPDyKFoWvcsi+6ohd_Dr3CZd935+Sx2cSRRT9m88DrLyzip1jA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: mmc_spi: multiple block read remove read crc ack
To: Rex Chen <rex.chen_1@nxp.com>
Cc: "conor.dooley@microchip.com" <conor.dooley@microchip.com>, 
	"bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "avri.altman@wdc.com" <avri.altman@wdc.com>, 
	"shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, 
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, 
	"wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Jul 2025 at 12:26, Rex Chen <rex.chen_1@nxp.com> wrote:
>
>
> On Fri, 27 Jun 2025 at 04:50, Rex Chen <rex.chen_1@nxp.com> wrote:
> >
> > Multiple block read doesn't need to read crc ack, so remove it.
>
> Why? Please elaborate.
> -----From Rex Chen:
> The origin implementation without my change, function mmc_spi_setup_data_=
message builds data transfer sequence, transfer one block data sequence con=
tains token, payload, crc, and 29 bytes scratch->status to wait crc ack fro=
m sdio device side for block write, also 1 byte for block read, I don't kno=
w why need this 1 byte transfer, and block read transfer failed if I add th=
is 1 byte sequence.
> I didn't find related description in specification about this 1 byte tran=
sfer, maybe I miss it, if so, could you pls let me know the details?

I don't know the details from the top of my head, sorry.

I would have to go and read the spec to find out, but I don't have the
time to do that currently. In other words, I will be relying on you
and others in the community to help out with this. So, please
re-submit your patches and include a proper commit message with the
information, then we can take it from there.

[...]

Kind regards
Uffe
