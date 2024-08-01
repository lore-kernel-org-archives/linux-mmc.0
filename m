Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E88189521
	for <linux-mmc@vger.kernel.org>; Thu,  1 Aug 2024 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510115; cv=none; b=Yvru+C9h0y+BlPuQT2r1lY9rvlYx2tnNr/RuXl69cA45q0gw5hnPRQNFfHWCtZBeJ/aLzq1jQsh33TShoiU9CY2fEEHNH2l1BuvmzHwvm1ZRTElmyaOqdsXMqvrdtKqgowDelTWgkz3xCOkXk+iAN5rbTKJpsUXm9MegQDvaXug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510115; c=relaxed/simple;
	bh=g3fbGLXxnN8HuP9/j5G2k31tdMCc7CckYnzOENzs6L0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffqXXRKe8spBLnK7lgBWY1LZd1pGzG7mvaHvB0J4/msgoXVRHHFblgYrSUSunkFLm8yyQw4GOse8b204QquMQfuq0/Urh89Yhi2DfuTIpHO+Eq1g6D8ClxwUSu1Vk8j4QchK34ZZZuuzR9Wjo9xNI6hfi1e/yMrtry0dkCNIZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V3k5McLm; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V3k5McLm"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e0bad5cc8aeso2329549276.1
        for <linux-mmc@vger.kernel.org>; Thu, 01 Aug 2024 04:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722510111; x=1723114911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vCcLyMZB4BhJ0Pln52cjsKvPBcYk1gjn8i0NFzDnpv4=;
        b=V3k5McLmtaa4jzcuy03hf50iyn4opdob6Vz806EJL8aBc5QX9jc+W+TAofZ9xjbGd3
         XPsjOHnv5VxA9+4ka7sjMv/FsG18yUVAnZtFXrswUonfvpi/4SueU77/D3XyDJiTgrrh
         T14+6PX0DIQsbEI+IwW800R9g7GC93fg4w5easd/uZhasKGCwo2kt7IcjKM13SDfp4Ya
         pBXMEuwYDsrNeGDEdzvl8SEDx82TOw9aLHhaPjngH7AV+JU311Rj5PxOPfu8/4G1enAK
         BSGJsJFZPotgY8AZ0oYpI+0w04iQ09g4/yO8VglM2Ro9XmJA37y4yzEz3tq34eQrRdv9
         OCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510111; x=1723114911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCcLyMZB4BhJ0Pln52cjsKvPBcYk1gjn8i0NFzDnpv4=;
        b=C7VNbe2UFwxS2S6KCuIZHqxLwkldutjTh4FYHU64dzNTS40w/gyap/+687VMtO8k34
         mfOsTJWgyOBZ/P8SOr5hRdObwg69IpP30bXLs34gk/2iPS4OcC4GrKbbhshV/d9FqOuv
         /+Oop8NdeiXVnzWcdSaYEI5mlcjzg+pzABcc9FuPCIc6Qbw6uF+UubEaJpjBBn1EYS19
         GIc6LN1XBBCBJZRFrp5X9VUWYFI/LnintNF/GtNDoXj7JhruQkfBRVg9jxNQglV/OPhh
         fSlm0WVaR5yuHL7moofNpiyLos6DVo6gqDqdoPT1Ogo5wEVVtqzHIrgnX+HhMN5+79Xo
         bDjA==
X-Gm-Message-State: AOJu0YxKdjaDzsUSOzoDkraRprlU+CNoviVS5PU6T/UA2y9KE0BkfABX
	8iV+rxAtbXfpg3F8k+NrN69rl3GnxZye5bK1pbxpdu2LFzMD5+8sIzmlbiOOBR41J4VZaAzl2j4
	TsxnLbyPxMdwNv1OSfPWDbJQVCm4f5oFZ+dNEhg==
X-Google-Smtp-Source: AGHT+IF65rx9q1/o3ByNh8wzqqwEif4Ew09KvL872ahY/4Qsu4VKNdPCff99i1h0SN+7KqwYWZNqRrxuMzndxpDZDQw=
X-Received: by 2002:a05:6902:1608:b0:e0b:3f85:33fd with SMTP id
 3f1490d57ef6-e0bcd3b122emr2300378276.54.1722510111000; Thu, 01 Aug 2024
 04:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZpxwXEKy1bAOCes_@378c8c72e398>
In-Reply-To: <ZpxwXEKy1bAOCes_@378c8c72e398>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 1 Aug 2024 13:01:15 +0200
Message-ID: <CAPDyKFpa2EkKX11ZzCA7rDW_Bi4EGEGB0cB7LquyZcHR4n3MXw@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: create mandir during install
To: Rudi Heitbaum <rudi@heitbaum.com>
Cc: linux-mmc@vger.kernel.org, avri.altman@wdc.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Jul 2024 at 04:20, Rudi Heitbaum <rudi@heitbaum.com> wrote:
>
> fixes install faikure when mandir is not already created
>
>   install -m 644 mmc.1 /usr/share/man/man1
>   install: cannot create regular file '/usr/share/man/man1': No such file or directory
>
> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index 9e14a5c..06ae0f7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -53,6 +53,7 @@ clean:
>  install: $(progs)
>         $(INSTALL) -m755 -d $(DESTDIR)$(bindir)
>         $(INSTALL) $(progs) $(DESTDIR)$(bindir)
> +       $(INSTALL) -m755 -d $(DESTDIR)$(mandir)/man1
>         $(INSTALL) -m 644 mmc.1 $(DESTDIR)$(mandir)/man1
>
>  -include $(foreach obj,$(objects), $(dir $(obj))/.$(notdir $(obj)).d)
> --
> 2.43.0
>
