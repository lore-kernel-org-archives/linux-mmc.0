Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7B74F211
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893528; cv=none; b=mfZ5bBWMfxFZA5E6mdwSS7HcFbYz2Jw7K1n4EUkZDz9gg6UFa95XyGigECBVc65Zq3/TWsMpDTvK9inGMIfFEuQ1AjVGKflaxnqDnR8KjUAXcCSaS9YwdgX1UDnRI0NvcCBlacclPQZjpcTj5dfwqN3T1mD70JeliMHO1c7PM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893528; c=relaxed/simple;
	bh=SQMNm/Wgloa85H/6Ml/z+UyGgCgN9Pm78Q6nwvCTYt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emBPQyqdBwUkyxmkmFD9TlNjJgi2qSE8OFrXdaB53T+HxgqNBuJqJ3gf0EDftTuFRV9QfKI+HGpdlDYTVoqt6+A/AZsYUpQnEZUzeMdwJqOWNhmj66h9FvEYi6ZCHaUZFWn01O7XJEalyzRLxv67ihVejw5PZ4hZVmur0eZZc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OL5Nao81; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OL5Nao81"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-63b3a9ff064so9013267b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718893525; x=1719498325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SQMNm/Wgloa85H/6Ml/z+UyGgCgN9Pm78Q6nwvCTYt0=;
        b=OL5Nao81oJKls2x2xNXV9G/VLUWSItD0Hd5yBzxZJLJGqX9SgVyy8wVwhM+yLR3Pt6
         VOmNxrF+DkaYmKE/3PIJU7OlYgDBiw5J32MA5T3egKvH3nwuOu17c3OpzwWVC+/Sr/Wc
         +uoGBWMVqX4jjUQoWheH+2bByYekd5OpcBXVzVVCajXw8b1o7GFQxrPzuEQYQhUZTgpk
         Ia3I60JHSstYsf12I4wXrEnQJwSSVFXLhBlkltpMs9G2RDxnNbwIk7cspOMP5/LnCP4O
         y+o9oVIEFY5qGPvpEZQw9/MRcgpz+EMbDnxh6ZGVZtMDSs0mf9ZTmOvQGBml8eRBw/aU
         6CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718893525; x=1719498325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQMNm/Wgloa85H/6Ml/z+UyGgCgN9Pm78Q6nwvCTYt0=;
        b=C7gSznihVeIU94OHLwGHxy+vki+FCftYMor43TwLie6a0/rZ2FI2aj+86KHJ4KC2pJ
         hD0YGDiTO4eP/OOJR2HY+TwPIKgOLkvEqihjMslyYcAh35acGdolw8fNNYmk6W1dKCs2
         mf1e2Nly66Y4fDSVlJsIzrnopP2imsQuVrsZzUY+tNJWEni4ZdlWafqzLOL0sd4ITjew
         BuuvS0eelVkVP/LpgGrOkJQkFErqi3NvIwSK0JultpQ4BrZajftLDap8RVayJxUzTWy/
         W1ljOoo6Gp0QnN7/kaHAzcMkvxbjHosYVzZX6VdPEKsVx47xQo8JXOSYDRglBUFAoqq9
         PVgg==
X-Gm-Message-State: AOJu0Yx0iR9WDzGlq1/64Aku52ODQPf9H17/SuY5BdGJCOBX9mO7USC5
	iTcr5OWVPqQ2HrEiQHWXRgH29WkU1oQz9EqgX0PVLLF2jpY6WlpZWIZI3CSM4dt9mIuowDJDQcS
	XAa7FreFzYFlQXZIhI/6aQYhfHGLTdooC9i9RgA==
X-Google-Smtp-Source: AGHT+IHR7fpKdExIeayYO8J71ywzwR+4VpYOIFbdfii6VoqwkxcVhItB0QotOZnRgehcLXlgkNKGKaigbbl58w+Xms0=
X-Received: by 2002:a25:8188:0:b0:dfb:1ea:23ee with SMTP id
 3f1490d57ef6-e02be17b1bamr6168497276.37.1718893524724; Thu, 20 Jun 2024
 07:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612-brigade-shell-1f626e7e592f@spud> <20240612-dense-resample-563f07c30185@spud>
 <CAPDyKFozcUPuMooDHVSBZomHTGKzseVf9F=YBY_uQejh9o3x7g@mail.gmail.com> <20240620-sabbath-ambulance-b8764fb386e9@spud>
In-Reply-To: <20240620-sabbath-ambulance-b8764fb386e9@spud>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Jun 2024 16:24:49 +0200
Message-ID: <CAPDyKFre12rqqwar8sfoWyc6duS3psp4OT=W5ToG9r_EdqH89w@mail.gmail.com>
Subject: Re: [RFC v1 1/3] mmc: mmc_spi: allow for spi controllers incapable of
 getting as low as 400k
To: Conor Dooley <conor@kernel.org>
Cc: linux-mmc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	cyril.jean@microchip.com, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 16:12, Conor Dooley <conor@kernel.org> wrote:
>
> On Thu, Jun 20, 2024 at 02:50:15PM +0200, Ulf Hansson wrote:
> > On Wed, 12 Jun 2024 at 17:48, Conor Dooley <conor@kernel.org> wrote:
> > >
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > >
> > > Some controllers may not be able to reach a bus clock as low as 400 KHz
> > > due to a lack of sufficient divisors. In these cases, the SD card slot
> > > becomes non-functional as Linux continuously attempts to set the bus
> > > clock to 400 KHz. If the controller is incapable of getting that low,
> > > set its minimum frequency instead. While this may eliminate some SD
> > > cards, it allows those capable of operating at the controller's minimum
> > > frequency to be used.
> > >
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > Looks reasonable to me. I assume you intend to send a non-RFC for
> > this, that I can pick up?
>
> I do intend doing that. How soon depends on whether or not you are
> willing to take it on its own, or require it to come in a series with
> the spi driver changes.

I can pick it separately, if that makes sense to you.

Kind regards
Uffe
