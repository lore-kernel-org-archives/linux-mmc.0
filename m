Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC22388E67
	for <linux-mmc@vger.kernel.org>; Wed,  4 Mar 2026 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611531; cv=none; b=ZhxMykomXiirxOOetCL/vZjlJ7vSx+lvl0KZRgiC7Lo6MVOqmiBA1WUux4s274KDYVL0Bd8p5PRR6JIBujlaaZG/dgwM3W0P2KeUF2MXdVrqvsmKAQJ6w6iuzuOO1OAkpA7Gd2JotXzcj+rnzoK3daZrNLJAdjXXFBz6tO0ZPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611531; c=relaxed/simple;
	bh=KMi1ZzxBwygb+ShEqom6d2oRXjczeTMXv5/P1YKh2SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXQtJMyR3aht8xJqmDXJ3bfI5ueLH+d80ULIIMGmvE50qcFyIntD8HiqTgnPHMiOhmRIGnbJJBa2IAtwvKKlMUU5g2Z2KeNCW8dSiluk9COnblsKPP0X2dEvkicm+p/pjwbVUiz7Tgksexdh4tQ6O/7shWrirBFEDdQmDQl+Zco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4NwYnLG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4NwYnLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C154CC2BCB5
	for <linux-mmc@vger.kernel.org>; Wed,  4 Mar 2026 08:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772611530;
	bh=KMi1ZzxBwygb+ShEqom6d2oRXjczeTMXv5/P1YKh2SQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W4NwYnLG0di05yt/S1+9n2xrHsY7W+2kXru8ELMe8ZBbRcBCRbjYN6TZ0Js4SJBxE
	 /ix9UkvKYzX7CBv4QQV4+I25DlQH3/Ydj9N/zQ0WKjLdNHlkMPfutEvcJJ4YHOTtpX
	 uh6SlCkSkiQUZuF5YQk2Lx0SPxTlbx/Do6ZxCttRLgo6KHxRkYWZZAc2EpfRfbQmtk
	 2X27PNOJdwkY/M7vsaolVvM3nRY3e+odZrEqOTrLk2Ccic0iXD5Ov0tDo0YaZB1B4b
	 kV0VP39FAT87m2qbbW5xw6nuV2ulOMNZDYLVUvudGN6wXIoRc4twYeFuDexlCmaGh+
	 +Q5v4IG2Zh9PQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65f94011dfaso11097957a12.0
        for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2026 00:05:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSkYLJbYyGkpB0wDrcJ5BFPYvlmjsgUfAU4jbT+Cmnx55y11WqZoKgAB7+ZVd51nodhZwOqsjg0qE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+eS6MXyToSB4V8++4lLAuOCET+Rj1NVeDGqMa+meg+jVWlK0e
	llSjukluE4VsTVTotYDHAROXRWa9lWILKAv+pDaGE7UR8yBCZVoWO/EGgCrsdPgqyBPDbwTIWVd
	2MYOnOoYGwaRg14rg28yQXTOQnZ1WWaQ=
X-Received: by 2002:a05:6402:358d:b0:65f:bad8:9c6 with SMTP id
 4fb4d7f45d1cf-660efcb74femr610451a12.12.1772611529254; Wed, 04 Mar 2026
 00:05:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772529875.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1772529875.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 4 Mar 2026 16:05:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5xJZCMRXf-T4b85+LSXNFfb1dd=85kLWdV6R6zpcyShw@mail.gmail.com>
X-Gm-Features: AaiRm51nTmgkp3KgT1K3e3QreJcEQb2kKiJHBsHBXz9J6atuQZnYsSrKv8JfRhs
Message-ID: <CAAhV-H5xJZCMRXf-T4b85+LSXNFfb1dd=85kLWdV6R6zpcyShw@mail.gmail.com>
Subject: Re: [PATCH 0/3] mmc: Add Loongson-2K0300 SD/SDIO/eMMC controller support
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For the whole series:
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Tue, Mar 3, 2026 at 7:27=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn>=
 wrote:
>
> Hi all:
>
> The patchset describes two MMC controllers of the Loongson-2K0300 SoC,
> one providing an eMMC interface and the other exporting an SD/SDIO
> interface.
>
> Its hardware design is similar to that of the Loongson-2K2000, but it
> suffers from hardware defects such as missing CMD48 interrupts.
>
> Thanks.
> Binbin
>
> Binbin Zhou (3):
>   dt-bindings: mmc: loongson,ls2k0500-mmc: Add compatible for
>     Loongson-2K0300
>   mmc: loongson2: Gathering all SoCs private data together
>   mmc: loongson2: Add Loongson-2K0300 SD/SDIO/eMMC controller driver
>
>  .../bindings/mmc/loongson,ls2k0500-mmc.yaml   |  1 +
>  drivers/mmc/host/loongson2-mmc.c              | 59 ++++++++++++++-----
>  2 files changed, 44 insertions(+), 16 deletions(-)
>
>
> base-commit: 6a4a4c1cc0012590b8bebf6c95d51687d39b420c
> --
> 2.52.0
>
