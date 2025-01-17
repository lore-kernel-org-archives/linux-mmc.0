Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEF31FDE04
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jan 2025 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737113926; cv=none; b=l2wbUgGmI/91qvQ6FE7yJt5wG5E4FDpk9xcCZ4iJ0ikG20YXISQ7M2JBZwtzoNkoN8GAM2t1oL5u9E2TnuP04blQlnAA71XC/G5J/v3h2cgIf6AxTkE/iwvfhcNX6vw78P+VT3PF9hsF3rsnSND9ZQGAOvi/k/+z5S5cV9o89SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737113926; c=relaxed/simple;
	bh=fLGaZiT3PSBqioSmEJWStZYw9gvjWK37jBfIINbqe0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/t2LEnU+fAxFY5zOMaGqPD87EQSUfZU0z6xN9aYBYCDKSQeMaVKGVUfPCXnqv7iRkox60qm9DPiF0AwlfaPdN7iDfK1gSbIczIxjW7DAiUbYGFN3A3U8yMGc/nArED4gqzRBwfyUiJ4jkpcWXH+No7Y2LnlGxw4e+FRqLMMteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dBVEb5R2; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBVEb5R2"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e5447fae695so3528534276.2
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jan 2025 03:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737113924; x=1737718724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XzCZNx3on1jnFp091epTZtekQFvjw42tcnUEZIhGy9k=;
        b=dBVEb5R2Hec2wOnlzCbGAkjDaxRV3sju2emvipN+Df6DlFWcTOmd1CXN7TjPc3j5fp
         grpXJ8+sDX+XvRG6PGd8iNHIB1Ypmxo+ThAHfpM2C8Bf7/IsX2+Rf1Qj+r2khWQ12zkY
         xvyn6lHT9jDe0Ca4c4Nscvfpl8sLfIc8c4+y3+IUimRgSzoRB7x4kduncE3mLz6PXoAU
         NgCY4SLWMGUQkxDXVMG1KrWJtM3+x92SfWXNW2mz2HEfLZ1/9z3K5oMmmrYgy6itWyFJ
         j49+XnJGMymBb+DKQsggNVy6wyzFN2pzkKRaEEFy3QQgUyy2ThiPpR42m1B7kDF2ZVJU
         ZxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737113924; x=1737718724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzCZNx3on1jnFp091epTZtekQFvjw42tcnUEZIhGy9k=;
        b=fmBhxZ6LdoTEdk9dTG8v2j3jF1sHU6cOt46EEx31nBT5pd7otg4KaWppy71ynGV7EC
         aN6MsHTtelOMzyk2wA9sMcVjubxwvQAWDk+o4uenRcYldAyoCNB8ls924j2SK9oHjInH
         NswGb9MHLSaJx2wNVjZP/Nc/ywbpgm2i8lEuE4hMyeH7i+Lp+nTMuGpz+gKbwc5TgM6T
         YWWjoEQHp8tMKl5Xs5QklU6bozBfFmb+oJzhjM1erUcI4TfSpTT9XUuewQc7kBobJ1t8
         m5EXVNK+Tyjzps7MUuPP2xlt9S/n6g1zRCiFGWkKwo1DhLC0DJqH3WZQvPmckNRnnq3Y
         Bh4w==
X-Gm-Message-State: AOJu0YypLX+G5DYbRCM+wIBv2p4nzjdsn17Z5LK4RMWiuSp6kxDcHWzJ
	pk0/3NPIrrrFKIV/ZUof1PWtQh2Yn8RS4AJa+5itlQX4zZPVG3cCE8yAsNdswI5RAED4lLegEOw
	lzE/aYHQlb+rUjo17Rp5OBh6dwBRPvFuJi8l84w==
X-Gm-Gg: ASbGncs7WctqyIvHYW19cswJ8gABBFTT1p2pYW4/+Zb9be0/rChpSHsyw/YrH09f8DE
	41TYgDX4eY8KcuNGsCjP28u9jzlcKfoYbTbUzcDQ=
X-Google-Smtp-Source: AGHT+IE2RZBPb2WELsKKW445Jmq/IpzPfVWkAjugOUnYXZubHTEc44/9NUhP0+yZ+r7aeoP6ALPeTs36mDaILsp24RM=
X-Received: by 2002:a05:6902:1b01:b0:e57:3f2a:5e39 with SMTP id
 3f1490d57ef6-e57b1360c3bmr1490068276.41.1737113924032; Fri, 17 Jan 2025
 03:38:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105121407.71566-1-avri.altman@wdc.com>
In-Reply-To: <20250105121407.71566-1-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Jan 2025 12:38:08 +0100
X-Gm-Features: AbW1kvZFlyZLWEKDaKh82Efqh4OHQo-VoiwV--JXXvfy9n1Prk5ORec59MjABhQ
Message-ID: <CAPDyKFprAFgUxkXOX8mQvwQ5Un4O4vs4WB8ZJb4BrNY802pQ0Q@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Add ffu modes documentation
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Bean Huo <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Jan 2025 at 13:16, Avri Altman <avri.altman@wdc.com> wrote:
>
> Add documentation entries for the recently added optional ffu modes,
> specifically, to exist in https://mmc-utils.readthedocs.io/en/latest/.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> Cc: Bean Huo <beanhuo@micron.com>

Applied for master, thanks!

Kind regards
Uffe


> ---
>  docs/HOWTO.rst | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
> index 0ce7279..095a9bd 100644
> --- a/docs/HOWTO.rst
> +++ b/docs/HOWTO.rst
> @@ -35,7 +35,20 @@ Running mmc-utils
>          Print SCR data from <device path>. The device path should specify the scr file directory.
>
>      ``ffu <image name> <device> [chunk-bytes]``
> -        Run Field Firmware Update with <image name> on <device>. [chunk-bytes] is optional and defaults to its max - 512k. Should be in decimal bytes and sector aligned.
> +      Default mode.  Run Field Firmware Update with `<image name>` on `<device>`. `[chunk-bytes]` is optional and defaults to its max - 512k. Should be in decimal bytes and sector aligned.
> +
> +    ``opt_ffu1 <image name> <device> [chunk-bytes]``
> +      Optional FFU mode 1, it's the same as 'ffu', but uses CMD23+CMD25 for repeated downloads and remains in FFU mode until completion.
> +
> +    ``opt_ffu2 <image name> <device> [chunk-bytes]``
> +      Optional FFU mode 2, uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.
> +
> +    ``opt_ffu3 <image name> <device> [chunk-bytes]``
> +      Optional FFU mode 3, uses CMD24 Single-block write for downloading, exiting FFU mode after each block written.
> +
> +    ``opt_ffu4 <image name> <device> [chunk-bytes]``
> +      Optional FFU mode 4, uses CMD24 Single-block write for repeated downloads, remaining in FFU mode until completion.
> +
>
>      ``erase <type> <start address> <end address> <device>``
>          Send Erase CMD38 with specific argument to the <device>. NOTE!: This will delete all user data in the specified region of the device. <type> must be one of: legacy, discard, secure-erase, secure-trim1, secure-trim2, or trim.
> --
> 2.25.1
>
