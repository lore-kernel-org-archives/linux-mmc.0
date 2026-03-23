Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D72D2848A0
	for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 02:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774234440; cv=pass; b=M1IcCGJuatjBVIcbgyYeFgXdS2DZlorv+T2z+q9Ou1PG5VWNy2z6wAl+QLV1opDKTMlBHF9KWVkpHc2Ldb6ZvlKbqgML5+niJPdHBR1CSg8m6+tEkkt3eHvZihX2ElcqgkB/R8dN9D+47X8GB/DBVrqdl4uEk0xMm8hY+jX9Z+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774234440; c=relaxed/simple;
	bh=Xo7X24KURKwbCzAPV/YiMB2riIeW/RY3dANwUw5/k3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnNxj4Z/nsQ557j/LoS3q+KL9OXCnggbPfz1voP7xt/Zbvq/6c/22mQdJ180jHc5lxtk4BbIqetckUC1cKGWMZpKVbYyEtzahUTIRnzFsEcOV+oCpn70WRTJhzvk7+IvczmdmBIRV5QLeWPszhrHSPZ9hz739moSXC0MpPvJFgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHwR+hxV; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHwR+hxV"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a27daa652fso3562355e87.0
        for <linux-mmc@vger.kernel.org>; Sun, 22 Mar 2026 19:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774234437; cv=none;
        d=google.com; s=arc-20240605;
        b=Ib2c26al1P0oVI+r8yaxpeYplMN0F8FxoixdIsBvGnA8uy1p63lbpCOKwGoUtacCgM
         b6hTX8sVakdu8APypd1l0HmgatqLxvc0uXtBgDhkKSYgpcKj8NOkg1XdyaQy0lGvlLdF
         yHYcqJw/TG9gD+YRE75dYIUXXvx0+dhAVOeGqJiqbDE7mBRtRAem/0WiGl3BiVZBGBYb
         rAZwomiC4dUkZCBzbn9BAjeWpIjNZaJr1kvaq7zlAf0RdsSQUxS423Jsfhir0UjhZszN
         718fl2bmTgJuU/ieJjA0uaOQ3GBe/ZwcvyTt1roLqHB6fT099RLRalZ5/W0v6tDKg8q5
         oujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xo7X24KURKwbCzAPV/YiMB2riIeW/RY3dANwUw5/k3Q=;
        fh=g5qb8nzxsbul6GjMzWpmB6HgvB+cTcLmkoGfjQErFNc=;
        b=FQnSYUoWbSoQkFoXexaezeQ+0AMm5EFEWLHBkxneBPDCBwVWphLIxa50gsfKxeV4OK
         4cAkIc+jBZgApcx647J5DMOI4dUAraubBINQ4fQ6rJHwgEJxjUEX+CXXfg9HosOSWdrp
         F+VOWR3xUpdalm4h+V3uY9bG3mttBJSacleHFr+Ov657BAgeXKQp7JJ/blSImYpZ3lvT
         6hiW+zwfESZjL3iVTCRo8+MTqz4D4O4nbFYE9xG1jHF4owBXO3mpBY3xRDpVTn0r2KPq
         C4pAR+iNiGuKsyjj90PxdomDX6gb2OTzkGzICDYcKCetBVz4cG1mrgSctcwSQMfK45/O
         AIUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774234437; x=1774839237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xo7X24KURKwbCzAPV/YiMB2riIeW/RY3dANwUw5/k3Q=;
        b=UHwR+hxVnlhKTn0AGjqfrPdOlYqC/f5LvyuDwEyr10r/vsIqZ4vFFMpItZRbcbd7hH
         F7dj//XO71hnsVN+TmlS4NbNachC6lKxcVnmPP7qVx7UNVasZHbzcVePIdGnm4OIu6sW
         C/ZDF9SECVI3q/WqUBeOJUYhn/cqIiCnk6fSatXsYlcGU+V7eRD+Xvj89FPvpLdofnuy
         CM7ScqyaUrrpCd1MefuNOb63rnqSypvxKGmgNO6JZr7mcecgpj+ipbwTIdiYflMT/YLk
         2lhv8UC9X9DajPyUf2Sfp5QK37duEB/lUOipjBBJcf7Bna3gXxLvjTIXdKIVrUwZEjhW
         8qhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774234437; x=1774839237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xo7X24KURKwbCzAPV/YiMB2riIeW/RY3dANwUw5/k3Q=;
        b=bAy7rEtmLfE5vNoQMNoEBJKH/sS+VHuk862h7PDxkPhHL0YWH+HOv1iaj/U9cPk6j3
         qQdwN83/wZUXRjovJPXG2MgoSe/cP4P/2bfg5gM0dtJq33eBuABETsTLogFC/odQ6MoO
         XIG/AmrAGzYrasj6R9BQNc7XoSu2M2mM5KKOFyTqsJRgNK38oubkpoefSB1Cinxjt5FG
         Ne1gpuQ0bX2A1qIB80j1b70ZJZP5No1PJi/xsYC8EtyO+xlm2mSsSdUcUWc+ujKa7Nl4
         8mPwMPsFJVt+Tp+8wny7gaNCV2C7EMIz8tvFO3S7m3HFqwJMdJJRBGWFmN6NAEWJQO16
         tDqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWclh8D5DLJBcTWSL2ThZNYewJOTWF8Q9ViL51XL5RoaCMRdKL8INOVq+aLFQtWmuItKiWHwzHnN7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUL0ZucmoaZyW0I6AjbY+GqbaECp+Vaz7NMPQxlE7uoolLVZuJ
	AaNMDmTDHk47Eu2ABvHYFxaTbWomslR5V7nG47nwy040E2qRYeJ2TDE745+xJUYqhmd+72gJCXY
	OUuVYqdO/iyK66xsnUSouIgA5w+5D+PA=
X-Gm-Gg: ATEYQzze9F0G1IbZKe7PFUxtUjJTXeTCCE4TAkAOdiSYXM7S2FSG7cTYucByAvfsdDI
	nA4XTQg6rzR4UBIasReCW3k3jr2vw+Ht+0O0rWsi/n8o4N7M+oJbQ4ixWgA2kYJCqwKHDd1kaia
	533VgkamEDa22qOoJBPzJgeejx3KMjuz5ORb3OEjZ/X/e+P0QWukgut8lxZ1cWlZp/AnxUpNraf
	iWw7uwey2W5d3/PILj4R3pG/3CuEejJK7nDeBSLMyroe/IsLfC6EnGSDyuCw4li0OPv5kVivMm1
	MMvtg/x0AOJoVQq5oW4MILKv9LCqawx4iCA/86f4ab3YoeBqslttbqI42r2StKdSIKGTKo8=
X-Received: by 2002:a05:6512:682:b0:5a1:18f0:930b with SMTP id
 2adb3069b0e04-5a285b6dd90mr3277193e87.42.1774234436995; Sun, 22 Mar 2026
 19:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319200945.23333-1-adriangarciacasado42@gmail.com>
 <CAOMZO5DcaucpKj2=gO5kP3vd=f==ydzB+3FbGB4Jwg19Vi8fpg@mail.gmail.com> <DU2PR04MB8567934E6CAB063DE5CA0F3AED4BA@DU2PR04MB8567.eurprd04.prod.outlook.com>
In-Reply-To: <DU2PR04MB8567934E6CAB063DE5CA0F3AED4BA@DU2PR04MB8567.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 22 Mar 2026 23:53:45 -0300
X-Gm-Features: AaiRm53JnagsrSa0mVy9Yk82B1cInf3CYkgQHDyLxpH2kT6hRQZKDibglWpZf8Q
Message-ID: <CAOMZO5CJ3m9ucMVPB8qYhfaLYMTfRNF2VEoAmfbyJ2dFF80DEg@mail.gmail.com>
Subject: Re: Re: [PATCH v8 3/3] mmc: sdhci-esdhc-imx: remove redundant mx25
 handling and consolidate soc data
To: Luke Wang <ziniu.wang_1@nxp.com>
Cc: =?UTF-8?Q?Adri=C3=A1n_Garc=C3=ADa_Casado?= <adriangarciacasado42@gmail.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Bough Chen <haibo.chen@nxp.com>, Frank Li <frank.li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luke,

On Sun, Mar 22, 2026 at 11:38=E2=80=AFPM Luke Wang <ziniu.wang_1@nxp.com> w=
rote:

> Hi Fabio,
>
> The option to remove the imx25-related code was actually suggested by me =
during the v4 patch discussion.
>
> "
> The original use of is_imx25_esdhc() to avoid setting DMA SELECT bits was=
 because mx25 doesn't support ADMA, introduced in commit 9a0985b78d70.
>
> However, before that commit, imx25 was already using SDHCI_QUIRK_BROKEN_A=
DMA to disable ADMA (commit 97e4ba6a5ea9), which theoretically should preve=
nt the DMA SELECT bits from being set.
>
> The actual reason DMA SELECT was being set incorrectly was due to a bug: =
u32 new_val was used without being initialized, causing DMA SELECT to poten=
tially be set to random values.
>
> The new_val initialization issue was fixed in commit 81a0a8bc380d, but th=
at fix was made for a different reason - it was not recognized at that time=
 that the DMA SELECT issue was also caused by the uninitialized new_val. As=
 a result, the is_imx25_esdhc() check was preserved.
>
> After the new_val initialization fix, is_imx25_esdhc() should no longer b=
e necessary. So merging mx25 and mx35 is indeed valid. If you'd like, you c=
an go further and remove the is_imx25_esdhc() related code entirely.
> "

Ok, thanks for the clarification.

This explanation should be part of the commit message.
