Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D1B4644E
	for <linux-mmc@vger.kernel.org>; Tue, 23 Apr 2024 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713857354; cv=none; b=Wxru1EQyTq8pUiVaJFWoo0CJjz0/K4Gm3Zw9OvII7eYspmv5HUDbEZ1PbgG6/7IkgaLNGpNnB1aMr8BahrItrP31MVVj43qlFD6bwcmQjD32asgpj9O+onXsXI62sk+LWl5oatSZGC/D/iYomuTc8MrNJ2xg9AzJp2pR/lIXzow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713857354; c=relaxed/simple;
	bh=8J9g8lnEZxWWfzBBFOCzCi6lqmw+2v5kQ0AaUn49+uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mmv0TjizUZ8kqJHBBVelok4go3aJQ82KPVo/tKo1mLzlvY26N14n3LKYKVbC5WkN7oHaPI8Z6OEWyd0gcEMfG3Q76dJVr2m8lrdnM7km4BzRQVZ4IRk7SpmxqrjAHi3wEuBWx4vmdzZH1JZE5C/E/taX4fkkjwViNynIeFOTlfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FUz2DoXo; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FUz2DoXo"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5aa17c29ba0so3105732eaf.3
        for <linux-mmc@vger.kernel.org>; Tue, 23 Apr 2024 00:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713857352; x=1714462152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8J9g8lnEZxWWfzBBFOCzCi6lqmw+2v5kQ0AaUn49+uo=;
        b=FUz2DoXoag7u3+egnkPVb61u5dTRmTG59Eh5ULYoABTNEvgm8spBYQgjOYi6ofgkjg
         z7Y15aMtiMY0CQMdv0KfjerjjDKVdNFm1BK6k3nIS8iAF8zEl79JnL2sFj0oYkaxo5o3
         mdFRpOHo7tHhT1oEApnrx9ShsLhFwrkFxIlxT4R/iW7yYBRrLIX/AIgqwC0ntDDd++AF
         Im08HgmH3rcaCoR9Sb8GtE+R7JpBjO1NwHWz4gtdjSWEAA14kbHFN4U0UjZYlloAQe9G
         SXg1+qWt9ym40M10289wxzkMzeqV1bzGgOUtFubyC5Q4nIUorv6iw9fEKsvh0gNXz9VX
         yXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713857352; x=1714462152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8J9g8lnEZxWWfzBBFOCzCi6lqmw+2v5kQ0AaUn49+uo=;
        b=RCKfDUsZCuoZqTWVyNJ5HHkBrdS3UV3lbkg6RWDx2wLLylDkBYRTHo3xo4iAm798Hb
         Rf/5wwqICFKzuiTFuybj+u8nKREwUkabpdoOrTUDHP+0B/R9PxzTPHsWkR3Tq1sx8MNw
         jnuvgl3SF25XApzkz4XQU8Lqb49kqRySYPDyujOubbsg3Q1Way7iQAKwLcValHgKgteO
         T79TL4Gu4pX+fwhSoeKidui2XkPOJQZj7N8SFFYoUaTa2H01ZiN7oTtpwdxtpytLzMcj
         yY+aiZHtFZf1a3QGgOdyKg96n3092pbTUPukGwtJ0mO/wgDd7wftcfO1D3m9oA+p/2QB
         EO2g==
X-Forwarded-Encrypted: i=1; AJvYcCXLXd6VFHzc+zj5XKqc8odh6EJZCSXoUwul7kOLrD3c+BYH21na5DyChfRl458jEa0+5yOi4pvc7SfPKMZhHlWKc+CyZDCq8xDp
X-Gm-Message-State: AOJu0YzhP/Kri1lBPak56wkKah/S+0Cncd/hUn0xn/ZE78KiOPwF8vms
	MwqOejZtPMzoOrnMVF1xXpmKOM2WMYF06pvjZHFi3j0MJUvIr/xmRUXZdjRO/15r9/XSV4EOlBr
	vXCFdIkiWjwKb/rWEZ5EfnwRMub+i1qe+0Gi27g==
X-Google-Smtp-Source: AGHT+IFR3tYO6BNlXgy56Tiz5e6rKgyLWYt2S9u0tnGHKee8gkVG/fWs/GiBy8pvObkdn3U5DOykXwfqRWSTNmFY9Ck=
X-Received: by 2002:a4a:5406:0:b0:5aa:5252:6efc with SMTP id
 t6-20020a4a5406000000b005aa52526efcmr14273463ooa.9.1713857351936; Tue, 23 Apr
 2024 00:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422091936.3714381-1-jens.wiklander@linaro.org> <DM6PR04MB6575CE5A70F2C733DF40E54CFC112@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575CE5A70F2C733DF40E54CFC112@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 23 Apr 2024 09:29:00 +0200
Message-ID: <CAHUa44EzMpRbhJ=-h4hJifgtrMsvDZj=Zt4C3JkDxjKE4gz=7A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Replay Protected Memory Block (RPMB) subsystem
To: Avri Altman <Avri.Altman@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 8:42=E2=80=AFAM Avri Altman <Avri.Altman@wdc.com> w=
rote:
>
> > The OP-TEE driver finds the correct RPMB device to interact with by
> > iterating over available devices until one is found with a programmed
> > authentication matching the one OP-TEE is using. This enables coexistin=
g
> > users of other RPMBs since the owner can be determined by who knows the
> > authentication key.
> Devices in plural?
> I am unaware of any board with multi eMMC devices soldered.
> Can you refer me to such a platform?

I'm testing with a Hikey960 (HiSilicon Kirin 620)
https://www.96boards.org/product/hikey
It has one soldered eMMC and one removable eMMC.

Cheers,
Jens
