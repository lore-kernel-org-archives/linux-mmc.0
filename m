Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33802E1F11
	for <linux-mmc@vger.kernel.org>; Fri, 22 Aug 2025 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858206; cv=none; b=h3FcHJxPv/eAccThx/KMweTenhqJMr0f6W56i1QaOtDr1E/Da8eOQC57QWMsaAd3TSX8dFcyfpwo4NU3le6y3/YMVsuDzUDkQcPT41jlxLYb0MWO7Fv1+Ixl12i2y6/IfIDkgnMA5eYdXhZVOVgbe75BTGn2jRHla+dQq4DdXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858206; c=relaxed/simple;
	bh=n+uuSrn8u6juOkuP9SvbxcjWBcwiQZYJvcqO5SL+OHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fax/4jRhj7YrkV5R7AEbbhiH5kv2+0DOgjnR09SzDGhdxJ83ptVLWVdTNdQyRSV01MXoP4I6BayPe3Qa+bpuNtfM+B9JKNo5jdoK/NH5DjtXIeiFCASs5VgwJ+yN4Lj1+71AjFHjKg5jm9bhRg0gErZdylf0Js+lBOh0wUEoc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AzjHcS7o; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AzjHcS7o"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30cce8ec298so1563368fac.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Aug 2025 03:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755858204; x=1756463004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDx2DLdAKNYscUVXgj1y9NZCkQ1KxqDufjQBp2yX34A=;
        b=AzjHcS7ocdD9BJob+jDJJ5vf6RA2YrIzNyI92+gXM98brHvC8mzl5pVoq1QsbJ+KAM
         i4Pc9ZZXRfKvwYwRzXMoJJLXYPjGgbvL/RWrMy3tY0TdQgtNVdLP0ux0R/HhXbLsle4T
         GrYqaAW83HKZudx91JDdr+yjIJ0+I5qaqh3RK5cpJRMY2dRpsd0MahVNjsvPQLmA0evy
         hUhJilVWOrExPcOVaA7DzoN9ZzgCIIwbySvvGv3NDgIU9lJFAonFn3pcxDX4NAJJE2tv
         7t1LKEYmXJMp8dYJ7gFdBe5QGb6ZtLCRnQVVfpOxe1eRR/VYhWKcwtfEr94ihoZjW1HN
         L/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755858204; x=1756463004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDx2DLdAKNYscUVXgj1y9NZCkQ1KxqDufjQBp2yX34A=;
        b=T62oh2+wncsGpRB8TANNwPzxRvVhP+bnPVszd7FlunLK2Nx810v3LyFZIMGGz8EZze
         Up7l68/UftwMvFEHWzNbRH1WRa/EqUCceVPVpo96SuJVeoQJBJaR5xAv1KWCHT8fI+Vt
         +JvjdMK/1ylOVbiXA+s7bzEwmw0Uf68MNb05Vq146XAouBVhStIWBlihd1f6yg9lsFt1
         3UpnpjNL77MZ+sU2xWUijribpddBggMa4U3MX0+nlGWuPQqMZh1l+HwG3wuy8z5evLAD
         pkYKodfhUOFIYsW0OGfaGMEdSB7svXZiQSSo0WPutx7+UMpriBzZL7x7tqhZANRJA8ac
         upug==
X-Forwarded-Encrypted: i=1; AJvYcCWwTrkiGKw27wG8iZ8/AAMx5YibXLLwqWBVsyx79DZ4OEcBMSyznmxUh6GpO8HUU+3KOVFbC4kr9RI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2JSwEHKwr9nJiYLGxcAisnr1xfzVx6hOm2zTWZi5Q0nDKr3b3
	9eFKzhClFxfpmhTXCvjSjaOzjhmM64cBweRUAcwVREtcAQi7lzyxLBJfgCRyC5lvtnEV9vn+nDJ
	0NUAr0EL1gIQ4ROztLqE+sFEqS2oKHFxdzC6E09wEuMJMaLdUa8YE
X-Gm-Gg: ASbGncvEUSCktqHRYx0DdWLuyTi/Vc/WYLBedNkwObVNLD2oyflhIP2o/cbbte9RDS2
	gWdgWwPZgFDcgH7wcE2ZM+GTMTnLVEr5XYduYvsTI4feQnJNVXSPB3KtbA4WqO2YmFd4eYk7MiW
	k2fVwHScIrlmbs15aS/YR9hzBmvipsblOBMHQPXEFCDz6hDAKtV9iTUazKCVDFfGTyC0Dw7kXYX
	f6fTsbr
X-Google-Smtp-Source: AGHT+IGisCuaDpdsoUYA9pYgVpfMQpgdPrniDusu9dQcSD5V9YeojvAiAiIby9Q5FLmBXxfa6GuF5BNA8l3vdExQZ3w=
X-Received: by 2002:a05:690c:ec8:b0:71e:7ee9:839a with SMTP id
 00721157ae682-71fdc2f17e3mr24348107b3.2.1755857776818; Fri, 22 Aug 2025
 03:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821-pxav3-uhs-v4-0-bb588314f3c3@dujemihanovic.xyz>
In-Reply-To: <20250821-pxav3-uhs-v4-0-bb588314f3c3@dujemihanovic.xyz>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 22 Aug 2025 12:15:40 +0200
X-Gm-Features: Ac12FXyMkjhCU6n4TOiSQhHwXlqNLt3Ozl6PlHCodFGyP-HnVszxTjH0MYaKHjU
Message-ID: <CAPDyKFpGW58HSQkodWQqHaNU02OcaY2E7C1Kt=caLCdXkOvvuA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] mmc: sdhci-pxav3: pinctrl setting for fast bus clocks
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Aug 2025 at 13:20, Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz> =
wrote:
>
> Hello,
>
> This small series adds a pinctrl setting for fast MMC bus clocks to the
> pxav3 driver. On bus clocks above 100 MHz, driving the data pins at a
> higher current helps maintain signal quality.
>
> This series is related to Marvell PXA1908 SoC support merged into v6.17.
>
> Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v4:
> - Address maintainer comments:
>   - Fix if-else braces
> - Rebase on v6.17-rc2
> - Update trailers
> - Link to v3: https://lore.kernel.org/r/20250806-pxav3-uhs-v3-0-2f03fee38=
0b0@dujemihanovic.xyz
>
> Changes in v3:
> - Address maintainer comments:
>   - Refactor driver patch
> - Remove RFC tag
> - Update trailers
> - Link to v2: https://lore.kernel.org/r/20250801-pxav3-uhs-v2-0-afc1c428c=
776@dujemihanovic.xyz
>
> Changes in v2:
> - Address maintainer comments:
>   - Newline between properties in if:
>   - Don't try to lookup pinstates if pinctrl is NULL
>   - Only change pinstates if both are valid
>   - Replace dev_warn() with dev_dbg()
> - Link to v1: https://lore.kernel.org/r/20250718-pxav3-uhs-v1-0-2e451256f=
1f6@dujemihanovic.xyz
>
> ---
> Duje Mihanovi=C4=87 (2):
>       dt-bindings: mmc: sdhci-pxa: add state_uhs pinctrl
>       mmc: sdhci-pxav3: add state_uhs pinctrl setting
>
>  .../devicetree/bindings/mmc/sdhci-pxa.yaml         | 29 +++++++++++++--
>  drivers/mmc/host/sdhci-pxav3.c                     | 41 ++++++++++++++++=
+++++-
>  2 files changed, 66 insertions(+), 4 deletions(-)
> ---
> base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> change-id: 20250718-pxav3-uhs-d956bfed13f0
>
> Best regards,
> --
> Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
>
