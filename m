Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC711D2707
	for <linux-mmc@vger.kernel.org>; Wed,  2 Oct 2024 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877608; cv=none; b=LLLHMUBatfvF14tgFjzLn+Fnn7qFPUVLO2msiAt0uBxvqOsRWcGOneWpH4HuYROht7mkLFmWGnBRw+1pWINCFPk/EWvwNttwwc6QI2dL7UN6e7otlgE0mU2P4JIS7ZHMrdn4Xglssj6kGgVuCTC3+y+HR9Pjl4tNlwVF1OBIX2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877608; c=relaxed/simple;
	bh=IAfOxs+MmT/GnEakCW2nbON7Y/GmcDUpYfP7wK60w48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEAuRL9uc3qsW7DT8zbNsRKWmN5CCLFbONsat1/wctNi+gGumljqIhsrzhdsi6+hRIp9ordJsnDko8V0aQD985C7SDGcHjhsk52Oe1lf6Qo9y9FQv/ml7miEafJl5MKu3c6fYw52P/JileKHKNE4cEHio3SbjeBNtoArqCltaWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r7FoxIkh; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r7FoxIkh"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fac6b3c220so45370041fa.2
        for <linux-mmc@vger.kernel.org>; Wed, 02 Oct 2024 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727877604; x=1728482404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAfOxs+MmT/GnEakCW2nbON7Y/GmcDUpYfP7wK60w48=;
        b=r7FoxIkh1N0aMKg1mxNgfRkvsb66Uscruxz421Sz7m1pE6B1qh9AvmM+0SQ2AGcK7g
         AZk+54AISYTB3jzhhd3voXSHg0zBdmwnM00jHKNfdAr0UNFwxoPtjr2DbYB4GRPEd6Mk
         zEsIWlYXvL+GxMehIBMvyKHf2fv7epGyNIOmPXiL8aeSiKeLo1TyfxBwWSameYfx9FaI
         A+qElqpoH/oYsZzZCJvZyp1GZbNs49zU1CCfEAC8X7zx3OfWbaoPhAoT1cugNzW6T+w1
         5EAMSeK9crA7x1e8BEYhW++8uJAumKTWpQIck/IHxROYJ3Kh4kb04M4pXVHnOLImcCbt
         dcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877604; x=1728482404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAfOxs+MmT/GnEakCW2nbON7Y/GmcDUpYfP7wK60w48=;
        b=b/qKmVPdWZ8uBKvsOiAluX6CaqPQ5MBihgCOjbbd7u+q0IxlwUesnxs3Ke5CJNV3ym
         kcXyDV1XeL6cN6DzHWNJtylh0QspG7akVUnrdt2ANjHmz8xUHcsASeR0mRORGNYnfdvN
         GTwBOXnmr/XjnihoZDBEcNzftgMo0rxXLe54+MMMlgQeAvIyDqYQ1OfZPEL6wK12BCYM
         HmUMC/yC5U49joBEHOskcP1Qp8SMVW5ZUsmvvhQTp5QHB/7gmrxWjtl34ubyf0CdRJSP
         BnJPPWp52qzDJJrRRvyUobnUs0tB0uqN0lIHDvlhxhbWOawR1m98eDZyT92t4O2bsQxA
         FeBA==
X-Forwarded-Encrypted: i=1; AJvYcCV8GXxOAOPJboXxcBSrEmYZF2l9gcfxo0+9YgimoIwohZaQvbIhIF6wvOzoef9tvcCnFKaaEvZFXOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy58VlPNRIONd9BjNuUx181INOMMtpm6sWWwBfFtntgMIj+2dS3
	wv9ct/Hxz1lKDi5raupUS77Mknc9RxtDXJiX5yio/RzG/uFyQxuFKUkcTsyUSXb2Qm1UoawjOF+
	CQtfOKj07hhLyLrgRWTnGd5kxyE37tpFNZEk/rQ==
X-Google-Smtp-Source: AGHT+IGKpyD86o51/mH1jmT3XyTXXQ04eUmkZrdRnPAbt4xNVnFa0ctf59clyoNk8jd6v51p1J6gAo/K0SkEmpgV3uY=
X-Received: by 2002:a05:6512:224a:b0:531:8f2f:8ae7 with SMTP id
 2adb3069b0e04-539a0677474mr2946120e87.25.1727877604149; Wed, 02 Oct 2024
 07:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001221931.9309-1-ansuelsmth@gmail.com> <20241001221931.9309-5-ansuelsmth@gmail.com>
In-Reply-To: <20241001221931.9309-5-ansuelsmth@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Oct 2024 15:59:53 +0200
Message-ID: <CACRpkdarPcHnZOrhq1r+-DyWbGWL00tPjLohEac+tZZu_f=Uow@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] mmc: block: attach partitions fwnode if found in mmc-card
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	INAGAKI Hiroshi <musashino.open@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>, Li Lingfeng <lilingfeng3@huawei.com>, 
	Christian Heusel <christian@heusel.eu>, Avri Altman <avri.altman@wdc.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Mikko Rapeli <mikko.rapeli@linaro.org>, 
	Riyan Dhiman <riyandhiman14@gmail.com>, Jorge Ramirez-Ortiz <jorge@foundries.io>, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, 
	Jens Wiklander <jens.wiklander@linaro.org>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Li Zhijian <lizhijian@fujitsu.com>, 
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, upstream@airoha.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 12:20=E2=80=AFAM Christian Marangi <ansuelsmth@gmail=
.com> wrote:

> Attach partitions fwnode if found in mmc-card and register disk with it.
>
> This permits block partition to reference the node and register a
> partition table defined in DT for the special case for embedded device
> that doesn't have a partition table flashed but have an hardcoded
> partition table passed from the system.
>
> JEDEC BOOT partition boot0/boot1 are supported but in DT we refer with
> the JEDEC name of boot1 and boot2 to better adhere to documentation.
>
> Also JEDEC GP partition gp0/1/2/3 are supported but in DT we refer with
> the JEDEC name of gp1/2/3/4 to better adhere to documentration.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

This looks very useful and avoids a lot of out-of-tree hacks.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
