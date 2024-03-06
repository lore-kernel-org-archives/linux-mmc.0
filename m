Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D542173185
	for <linux-mmc@vger.kernel.org>; Wed,  6 Mar 2024 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730241; cv=none; b=NCBfcJT5pqerPYnZkTMr6AqLKLxOnlIM736LGqp7TQnhDSDoKePKSTvOXg+aW4ZIa06tC4LG7ZT4FiXPIQvEiTxX/2yhNp47pXBpqkKtD69QlOo92j84qXaBIGfypuhWaLyeEqIrBN4ORJMKO6yWukaELK8ausVFPh6i7h7FWcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730241; c=relaxed/simple;
	bh=0SzVCSc+6IVgdLQjBVikpTpZ5IdNQX3I6EMVPlgDMbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psE/oHcL6iGjfoY/mfNZPFi+Hrfx1/y2ufb5K2J4PhD/boLc3t6SLjhO1ju6Q6F3LtcLPKWA1CXCLMKnz6+zoP/Bq2dS2BMsESjX223/IWF5uicI9Mtw4ZfS4y3KYAdKhWLARzkQfMpwVkdwbxC359mouphjUzhKVXYgYpUEtV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D7rLAIdH; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7rLAIdH"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc742543119so6893791276.0
        for <linux-mmc@vger.kernel.org>; Wed, 06 Mar 2024 05:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709730239; x=1710335039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBiDejV3EtOMJmuMxDeh773rkjpBFgTE/mtHVi8J4f4=;
        b=D7rLAIdH2G5/jUCqjM1rkWiWQLQ/DgFRDS9MXjPcuiXudanm5mQJErhiDT5dmExSbV
         YujPOOJFWTrri1ZrgDugdTp6kok3Jc7fGS5TcSmbmxxfu+c1TlZS/0fbmjTGG0/NF4uE
         PGLF47GjeV8T6C8YUAwrigc6HoRj4s+Ow31mBHqkPse3AL603YBp9PsJbNZ7fpiWAZSS
         HZ9kiUiEEZhbWoxZI48MgycEXqAItAvM4T4sh/9sccibVTRGhcqVCEqhcaCVXylpHQVr
         R7/4OheYnaRSRi10ygpsaWTl4xwYL8x3FJKYpw1X5bTl4CyE2tQIhszFnZsGzNtByWZv
         dCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730239; x=1710335039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBiDejV3EtOMJmuMxDeh773rkjpBFgTE/mtHVi8J4f4=;
        b=lGZGSqFVc8Fh7RPVAcQgn6giH0qj4yekdHjty0vbDu8Z/al4SW+iOiQmCkl3mcU712
         WtmLOvtNhxTt5x98SuKzL/KLjLB5XuCTlelee6LqCBB2QuyLpzhPO1okCNt6Z9dmjhL4
         6BMDqv7ys5kH/mGM/aqGicbV944XMoDoponA6Mowz0A/j/u3tykxG5CiUp6VOE8bK1Ou
         1Q/07G25asyVslkVcsDmChCYU4Rzv9OADzaiByGwpReAibZYO/SB+PgUzAnKvwIpzw53
         AWkd1kkHpHpI1PLqumCsgLP5erY5gX5vvawfi41gxEZjz43+bTB5o6cQ9+YT3hzqgij+
         f4YA==
X-Forwarded-Encrypted: i=1; AJvYcCVnUx+k9LndMu0KrLqNYyDaYtw8seSwbLNEZF1jcCpmuCmZ6rV8yEHKWepiye+C28lq2GmSRG4245VWAjFimm9m43uw+FBOvZdp
X-Gm-Message-State: AOJu0YxOA3aShDYgekreifgzneQKgnzUZzvcVYm+ULlS4lBEAjKAqIgt
	Lpn126CT1X6NwKrqfuzd6AJHPxeRQAMP06sROF8hY01sy9o8/VsmTynJmKLVmpqhVxX2t32Posw
	lVef8NOTLKqSWVRcZJdiOGFcVsbhZcDYLCe5Spg==
X-Google-Smtp-Source: AGHT+IGoznzaO9Xw4qNyGRElOSvHFz7f8QVovTmZFfDUeysoa5V9mZ6cAUmshhXwf2lLcYtw5uLKyTLOhjYMd2NX47k=
X-Received: by 2002:a25:290:0:b0:dcc:2da:e44e with SMTP id 138-20020a250290000000b00dcc02dae44emr10903650ybc.61.1709730238839;
 Wed, 06 Mar 2024 05:03:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org> <Zegx5PCtg6hs8zyp@trax>
In-Reply-To: <Zegx5PCtg6hs8zyp@trax>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 14:03:47 +0100
Message-ID: <CACRpkdYS-5mDjNP2zJ2J=_k_uboyVGK61Z1XWHcUh26HT6WKmQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: part_switch: fixes switch on gp3 partition
To: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 10:05=E2=80=AFAM Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:

> That looked strange as there should be support for 4 GP but this code
> kind of convinced me of the opposite.
>
>         if (idata->rpmb) {
>                 /* Support multiple RPMB partitions */
>                 target_part =3D idata->rpmb->part_index;
>                 target_part |=3D EXT_CSD_PART_CONFIG_ACC_RPMB;
>         }
>
> So if we apply the fix that you propose, how are multiple RPMB
> partitions (ie, 4) going to be identified as RPMB? Unless there can't be
> more than 3?

Sorry for writing bad code comments.

This comment means:

"support multiple RPMB partitions [on the same Linux system]"

not:

"support multiple RPMB partitions [on the same eMMC device]"

Yours,
Linus Walleij
