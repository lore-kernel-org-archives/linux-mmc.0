Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC4A1D5AB1
	for <linux-mmc@vger.kernel.org>; Thu, 26 Sep 2024 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727331370; cv=none; b=sxnzfFMNB8ODXv69Y3tkDvAYtYmZA6wnAZmxGnaYQyCH0cAX5LxNRs4yPyOGkpavxBQEg7x7hzVvmoXSNsAEwLEBgqZ/C5pIYYuk6iac9ficL/zi5agM2nYfXwLok6sf51YEmtIN2yzgQlgaBz1yo8DgH2R4jOhS2svmS8gFZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727331370; c=relaxed/simple;
	bh=ykLbmLKr0QoC7hIm3VMPmhy29bEPVTyVZXowJRn3s9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HovocacgQ7X/QNfZylR9OYxO+L8D3TMmSKYYX97Ongg90eBsEPxABTnON2al4h3eeh1+zG8HC8PE8ZINRhGNyi5RIPNFt3PN8Ry1HLYtox4+ggLhkq5VX54Db7lPULenirfOKA36PHJGr7dG+0htlMugEZX0WUTcHD1W3yRIKFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DOsx3qAB; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DOsx3qAB"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75428b9f8so7613681fa.3
        for <linux-mmc@vger.kernel.org>; Wed, 25 Sep 2024 23:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727331366; x=1727936166; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykLbmLKr0QoC7hIm3VMPmhy29bEPVTyVZXowJRn3s9Y=;
        b=DOsx3qABmMZ3g6mYO7FQzKkz7LEF6Vhgqv1H53z526XL5tymvfotwZkQOGLjrzYRK4
         bINSrJzyvf1LkzONQT3EZGK+IIMLKImUy6MQU9LFW75GxG3a36M3AXp0aMARyFq/A36/
         W8u2hED7aubqoeHxWqHwjo6mY9UNK5SpmXdVqwbrJL2aozjG6nO3ELSnRrTNtg3pdyEm
         Dy28aroHzhhHEZM6k4QU8F9sTYGSa84I0e5CkrxVKZpcSpv5mvplnHghGw4HvUSJ19Eh
         0D9r7etH88ojpkkBQhyYU583DmSCQAjF0+6dp6rPlqSkmuNWHNT0jQ6QLn6jSYwA9O5P
         GR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727331366; x=1727936166;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykLbmLKr0QoC7hIm3VMPmhy29bEPVTyVZXowJRn3s9Y=;
        b=oBoskNWz0+ZqfRZOL31vR8CDxUEqpI2AJelP+wvXQebm7IDB4nw5vajZOwx5x72XWO
         YlYQ/07+9c66e5hg/utZyauV1pyzEv6MDHWu05eAhskUvkOpa2riE7nvumMMxD4K0IXp
         ae5qlwpRIcqMZo0aln0WXp2vAxlQRNGli/sMNZh5BT2UNeDf+QOU6IbCEZkvABt1RFD4
         BwBMoRsJzO0JRIHlzag12AFGmoH7AZoeugO2Sb++Yq3MeL9hV0Px9XqQUALEme/DmoOE
         esQ7ftEd+31xb8lo1rd8mXKZmR3F9BXTPWdPCFyJBc77G443BjuZro+5rjIpzK54D3c2
         PjJA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ7B1o4SXE+AGn+HZ2RHfeCOelhtwQYoRFRjWDFvcv6NFSku7jUxpEJXJtfujcvlxSJ9YcnmQ72LM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7tXMd2eLEZ7YMNx3hSfZ2GKt7rupGL9M6+wON/kpCFKqTWMYw
	zKFaxp/eUnrOG0o587io0SnjmENzHcTrimSRD0fmSmZlMiDFi3CGWTTSoK4tzsSs1a+gFeTCo9t
	uSQ2bJoBHVO1v/1BodA7q3R2V/qRZBSrO0qiGJCGnppJMT6goY1w=
X-Google-Smtp-Source: AGHT+IHbrtLrapShRABtlKmDwtmluNLT7K7CH6P2+rWdEGHx0b0RzOZCW26rtsum1GA0Htk4idVWjkz4WalwP/9NiEc=
X-Received: by 2002:a2e:a985:0:b0:2f3:cb70:d447 with SMTP id
 38308e7fff4ca-2f91ca44935mr42636091fa.40.1727331366162; Wed, 25 Sep 2024
 23:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BioRa6CRWURE7RrciZ65F5D8BT3HUSyNkK6cPbtojVjybSwdSmQ64gnhK_-4EpxtINCXBw_NuXahXlT2oNZ0jsRnaO0NnnaMHyFBovzR-V8=@protonmail.com>
In-Reply-To: <BioRa6CRWURE7RrciZ65F5D8BT3HUSyNkK6cPbtojVjybSwdSmQ64gnhK_-4EpxtINCXBw_NuXahXlT2oNZ0jsRnaO0NnnaMHyFBovzR-V8=@protonmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Sep 2024 08:15:55 +0200
Message-ID: <CACRpkdbXvk7wda304UECgOP3=QgcbR0KW7tindtOfPm=DPpS9Q@mail.gmail.com>
Subject: Re: kirkwood marvell sdio and commit 2761822c00e8
To: g4sra <g4sra@protonmail.com>, linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 8:02=E2=80=AFPM g4sra <g4sra@protonmail.com> wrote:

> I am using a Marvell Kirkwood SoC plug device (the chip also used in
> some NAS devices) which only has 512MB of memory.
> The distribution I am running is based on Debian which is on kernel
> version 6.1.0.
>
> However I use a custom kernel for efficiency.
>
> I cannot use anything above Kernel v6.7.9 as I get the following error
> on mounting the rootfs filesystem which is f2fs on SDHC.
>
> mvsdio f1090000.mvsdio: ran out of scatter segments
>
> This appears to be related to your commit.

Do you mean:
commit 2761822c00e8c271f10a10affdbd4917d900d7ea
"mmc: mvsdio: Use sg_miter for PIO"

> Can you please provide me with some guidance as how to troubleshoot
> your changes.

Can you try to just revert the commit and rebuild and test the
kernel without it? What happens?

Yours,
Linus Walleij
