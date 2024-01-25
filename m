Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E4B171A2
	for <linux-mmc@vger.kernel.org>; Thu, 25 Jan 2024 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224737; cv=none; b=adgO42Zp5oC+Jh3I8pjtDkh57r6+tfb0No/75XnWo5g4w7BHA6/CdVeOqK3kpasBwXfhEqyU/10+S4hZWwi/nqIymPJ1278wYKYJND7a1QwUxHncmBlvth1rXTemzanef3J3fIaAxwGm2MY3kMvgJ3riGnci3nWfrzvwnfMhWzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224737; c=relaxed/simple;
	bh=7uvqzJiFOH7CqK9D/XE9qIcs6f8P8aqvGseDf75yXXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmwMjZXCuXUUTNzWrfYEOcidBhVA20m1wGv4X6ePRLx//agyXhdAQ1EqUpK3nYViHfLgr3ekzEOcc/IXGweim/cY5AsBBhPcvHCCTE2dzDd9j0aAXWx6uI3zbPvjANzMeMLKFJbFPkwKdew1f1AmqNiLryJ5MV0n/7/lrt05SRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZsSCs86a; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZsSCs86a"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5ff7ec8772dso2725127b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 25 Jan 2024 15:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706224734; x=1706829534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uvqzJiFOH7CqK9D/XE9qIcs6f8P8aqvGseDf75yXXM=;
        b=ZsSCs86a/S2lz8chareQY9wVV7h/sZwKG7z3FaRYk2qI7Plqd1cVedCVgy07OdHtrU
         X823lr3pENXGI3wijqr7ejCytYOwlL1+WZkhRm4sIDQKWJYlOP9rCm4Jc5eWvzfTW/ox
         Rxvh5eh1BJv+5PqtvNdEZ5Xk0zQxmLUnTQZ9efZGubshZFTVIGAFJkOMKCW5vbVxzH4y
         ZmkL2gazF3rb9ejhMOw5D1B4TW1zRu28+bsv+fwyq8uyrhHEDrWJmF+J1ETDArQYkkKW
         BtpnPhBRf7GnX2ju0BQPIm+r8F3HZ1KNuddnuiwRSbB9/U08aNnLjQZW3RbRT6mFVSgp
         ty4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706224734; x=1706829534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uvqzJiFOH7CqK9D/XE9qIcs6f8P8aqvGseDf75yXXM=;
        b=PTcQ/ePbMNFnUEQQ9TgkxUJpNpLbz91cuIFLMeeQyFYNQowY4g3GtioJnU46PvGnhH
         vElEsfHKY1NgS2M83yrewHnci4XX4EKmdAAB/LhZdQiGx5gGMWpYM9Wuos9XQr9Ykuhe
         95osHDvN3A22LLjAiG5wXRI+JxYdt8bRT7WP1mksPXZDLE9mmPpbuLjOFY7sy2yoI9DS
         LhKp0cOKNyECaNd6lk+9sm7T/IjcJtWm1XDp5ZGV6rajxRh1FEN8+WK9+3bVPuSigOQ4
         GYdgYo+y2nQ+bwLUiWMaWGQ+6HVCymVLgpzPdFrFclK4YbBWly7hxOWqCpRlgyLwzR90
         G0pQ==
X-Gm-Message-State: AOJu0YxmX35Fq2ymTY/5Dmd7Xr3wi04RjALMNkz5tgasqSY+fq/yA3A3
	Gj83yiSq9e/m277WufeHz9GwaLfXMppGfbd6t3THx9qf9JCeTyGfCMYzS9RiTjWpoxSeoPeIHgg
	Jtuw9JkO9U16aTr/I6hBqNuqDm7VXUhB477DgFw==
X-Google-Smtp-Source: AGHT+IGYkPRYDSlscKRk4G+SfhQLgKGn3yOaS30O2gXXD5Tt9NYFdgvgNJQJQsN4IwIhaD5odaQS198rhu6R/5DbH+Y=
X-Received: by 2002:a81:aa4c:0:b0:5ff:35f1:714b with SMTP id
 z12-20020a81aa4c000000b005ff35f1714bmr601737ywk.12.1706224734637; Thu, 25 Jan
 2024 15:18:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-mmc-proper-kmap-v1-0-ba953c1ac3f9@linaro.org>
 <20240125-mmc-proper-kmap-v1-1-ba953c1ac3f9@linaro.org> <7ca13324-ac47-4648-9b3c-c616de515625@app.fastmail.com>
In-Reply-To: <7ca13324-ac47-4648-9b3c-c616de515625@app.fastmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 26 Jan 2024 00:18:43 +0100
Message-ID: <CACRpkdZWrRCoG_HL4WxpcauP_ipvfekg3j67fUHewUuMxGzBeA@mail.gmail.com>
Subject: Re: [PATCH 1/7] mmc: davinci_mmc: Map the virtual page for PIO
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Adrian Hunter <adrian.hunter@intel.com>, 
	Angelo Dureghello <angelo.dureghello@timesys.com>, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, linux-block@vger.kernel.org, 
	Linux-OMAP <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 5:37=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:

> I think to do this properly, the driver would have to
> use struct sg_mapping_iter like the cb710 driver does,
> but the conversion is not as simple as your patch here.

Ack, how typical, so that is what I write in the cover letter
that I wanted to avoid but it seems there is no avoiding it then.

It's a bit trickier but I guess I can pull it off, it better get some
testing.

Thanks Arnd!

Yours,
Linus Walleij
