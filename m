Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5602E636;
	Mon, 15 Apr 2024 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169052; cv=none; b=jRFub415ZEsxNbYa3C5122TDn0B/yPTinAjK562ltayqIhv9FI2iDksUfU4zVUbm/FNiQ/OOIJaLQjeUVYFbnvnSPa5CIBx8RtVht7Az3PW20K9XgqzNgTa4Fxsml0rqbINWxqIUHeJl+gay2aEgZOq+qN71qfIRYsdO0QZ0AtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169052; c=relaxed/simple;
	bh=O/LXhHdIuk+5RLCFyEoNdcCt+G4VnSEDmmm2d5TmYtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwW+EHSS5kyW/XFaFFtKS+kDHaVo2I/Gn1u1n1VnS3IF1kDlpci0Mg2AJ3OBs7yJfDWA+dewmPT3T5oIASQfkVNlOS1dzT+l3m6XHkd+YnzY239FbfF8CUfkcMVWfrew7TZEiVjV7IdH3+4NBYrliYkzjQlg0LWil5B5/0PoE5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkXS3i+z; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkXS3i+z"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d6c9678cbdso36032841fa.2;
        Mon, 15 Apr 2024 01:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713169046; x=1713773846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUG/DctB/fZfsqh6wSYfUDJnWx87z8kgoCdpg44dAk8=;
        b=GkXS3i+zaOvTBVGEosB2c7YONSkLYrNWPj+b14DcG+4YF9/cNxT+aq7GLHjluEZfSC
         2aBJ1+KpgSZGTkjL9G3qEsx/E4id/Foef6y/t1td6QGnVWt4ovSw9Mn2bQc2ArE99Lsu
         ZptxpexYQhtTr+MDYQQhH4sB4BZcjLJKALW49H47ABz38g7e99VkUkoaHBwnk62I40/y
         DgIX8rua0ioj7NEfaiT7L6TsG1oZbBCpMeTCNa+62mKhY0Yb0wl7YFIEv8gRQELtJ7qN
         9xFD3Ws3rHJd9BGQktxGakAB9lVIsq9hzid/otTlsOfz+BlRazTnZytxxuiEKsl0qi4N
         h7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713169046; x=1713773846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUG/DctB/fZfsqh6wSYfUDJnWx87z8kgoCdpg44dAk8=;
        b=KiWfJ/tzXCxi0MA6C+fsrozhGBkQCe13/nSYS6XPk96np1Eky4sce++cUMRzHr0gia
         QvCy1bJ47M2OjzQCswW40V4E9nk3GrIsnggVnskeq0Wcn4yzk1fxQ2dGuxYYAG7jyrpP
         R14r6Lalzz5MeMUc2De/60v6hItC6Jjpc2dk7rvtBTTOCCgYcDXoO5vcWASsjhsev9cO
         2fQjyisGL9rjJBwpYeA4XvPo/s6dDWT3XSy/ezPtjYqd2sRZuC9+Ra5CyGla1VKTFpPq
         YOJLjlR3YPPmlZqNkEBs1AmyNAr5z3vLIURTW2NQVNUjQb3zNL+UFh5DmK+8WoKT2BWA
         WLVg==
X-Forwarded-Encrypted: i=1; AJvYcCU+2t3CtVMMdAhHQ+DZHDS7jLtNOJnaw/cAH/qEJ9AYwXrPmNVmt46wTZMpPVx064XICq0MLzzrNioPFO6l/0PlsiYWlDjw9X84uoxUBpZWGJ7apIEPusI9GX71SS4uiEdq4m7aiF3C
X-Gm-Message-State: AOJu0Yx3vCrKTZfNgHmmNYg2vP1afplnqKSlAQf+G9BAsGFql6S+EbyE
	yPrIyJqhRc6VMXB1Xnzv7PutxZtvjHDwmaCYiuR5PBAJ4hZ/oAWnyKfuYFjWZkbPQf+63Yrdl60
	0YqC/8tqVGsdqncLQASdCS52VhT4=
X-Google-Smtp-Source: AGHT+IGkLf+iDna+H8AmnwCyO/OBb5GbuojkmPuKGrmbNCuy7zYjdnuENCqnAyM64KVtBQu3OeOskDN9ksygYcg8Q+4=
X-Received: by 2002:a2e:6e0d:0:b0:2d8:85ae:a70b with SMTP id
 j13-20020a2e6e0d000000b002d885aea70bmr4815557ljc.46.1713169045769; Mon, 15
 Apr 2024 01:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415070620.133143-1-richard.xnu.clark@gmail.com>
 <52c08a01-8357-44dd-b727-a06438ec6c30@intel.com> <ZhzVmmndefd5zDFh@shell.armlinux.org.uk>
In-Reply-To: <ZhzVmmndefd5zDFh@shell.armlinux.org.uk>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Mon, 15 Apr 2024 16:17:14 +0800
Message-ID: <CAJNi4rO16FDmRUCWyK=+DF5TbfryJLsX3VUN3j1mAeas7Rh84w@mail.gmail.com>
Subject: Re: [PATCH] sdhci: Fix SD card detection issue
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 3:22=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Apr 15, 2024 at 10:18:39AM +0300, Adrian Hunter wrote:
> > On 15/04/24 10:06, Richard Clark wrote:
> > > The mmc_gpio_get_cd(...) will return 0 called from sdhci_get_cd(...),=
 which means
> > > the card is not present. Actually, the card detection pin is active l=
ow by default
> > > according to the SDHCI psec, thus the card detection result is not co=
rrect, more
> >
> > SDHCI spec covers the SDHCI lines.  GPIO is separate.
>
> ... and the key bit of information that should be mentioned is in the
> case of a GPIO, the GPIO library can be told if a GPIO is active-high
> or active-low in either firmware or via the GPIO lookup data, and this
> should be used instead of drivers inventing their own "quirking".
>
Agree! But unfortunately, it seems I can't find the right place to
handle this from either firmware or via the GPIO lookup data. Will be
appreciated if any suggestion about that?!

> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
