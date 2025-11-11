Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879133A79D3
	for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882637; cv=none; b=XruGjw7bua4vhT6YGQZXQRI19y1QwQS7X4Y7ZEmTz+beMclNtUNrsnMrFT5tvd/oSYdgjHJFSYwUxxy3Gohxx/DuefAbTBtv5dfU2jdHUgk9wPBOujMYYnaLDpjmZF+s58/qiHmIiT1ZeyOd1dnrvfkT8J2ZpDSTjwkc7XGgILs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882637; c=relaxed/simple;
	bh=3XQbVkwZrqmhPbBsPyvtA8KEuj8WFA9DwEI/sKza0bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRNf90elraRPwG4yAJS5OoPZzcWxtUz4a0iqQ7BuKlAlTueFC4EfbNO+0BXXFsDHVBpkN1d2qFTV9dBPBg8Ti13pqaETvvkfwmEQhk6AJZn7qoDzCMKY2VabJGTdjf7vz2xXyZdDPLnzYwrUt0m7UkOSqC1m5+RQnEa7IVIeYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=amyuVUt0; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="amyuVUt0"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-786a822e73aso48743097b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 09:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762882634; x=1763487434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LiXJIASBmNg2XD7Am6isLgqk4TUes5a0owJ+UegNck=;
        b=amyuVUt06R4oycjqOwahhguTT8nzwrsRFGmOsI2GNGkvY/HeP/QddtIPTJPCGJIzkz
         umDv/nQ2KbeioLJHXLg9ODe7kLis3818yRnqyEhyiZ2FTTjTtFrjVpSy6BtwEMQx9uVF
         Mp6kuqHgVA7Os2EjM9To/nK3odc2Eu3leoatcxO9hdaSRqpDoP2JOrqhhgYNA6rmosqh
         H6XxLVPNDxcp9mvdNOdx8HUbOKLkfpQShU7L+vFaj4Imts+BH7BN1g+BkIn/thiZ6CUq
         s3ccC99oYgMoIsAKtIHgJfj3lGwqAVCaUeQ+Q12s5wisNFwPapwHUHc1QiwtWzofRgkz
         IAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882634; x=1763487434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3LiXJIASBmNg2XD7Am6isLgqk4TUes5a0owJ+UegNck=;
        b=texITSCqgacw6BevKrYsRSq2L8W3YK3OcOlQTnRminZWGV9vtfAjxAdQIeepNqcnd9
         mKhfRJZxOiDRscDZoFISXVnC5Fq+ZOn/o/0cReEEhfWgh6ZxnO0lbOxiJqoGO/A/WOsA
         QPYaCNOEtz1osDtKQj9pmWsirdAPiURjejuPOX+X8jT2PJTJFsolaCoEywJEYoRNVJad
         ogXcgXwPDmT0dy1SW8fhuLKcwx8CMzijsDXOfj1j7BJRSdSTamQIt/4eiQRbKS136TQw
         uvY9x4fN/9oUNTeb18GIaSlSEDLKN8/idUDOcA2f5gw8QTuVYs7SITC9ayNlnDrwhV6K
         vPiQ==
X-Gm-Message-State: AOJu0Yz5i/Gurc9gU87mnEQxwvbYJ9f2zOXUg+SfV7reEsTsQQkdKN/+
	AxFMaHOL9P2+uSBw5QyC60c0aPx7NbG25hHS1XcpzU91iRZwVNlmO0OX4jz+sHYy5pzjRDKtf1i
	Vxwmu5D468CODtdR3YRralUyN82I2GZPK+uuVYTNrRw==
X-Gm-Gg: ASbGnctiuxwNGCCR52D3yQ1XWYO3bAb4IgYfyBbqsfIDg+28cGv87hN8lgGA4TXqLTH
	Lzp+ipzw1dYI17pf6mIRlPtoxtY5GdMJ1jeAWA/q4UtfKPPD/bnqZuJ1vAVA1VtIfxNpt13oubI
	maZnPaKx91le7WDYmhU3r5xK1flRBouI/0Xe9OxGVoPlX52onjtB2aUwU75unIsLtvBwI55/8V5
	HS8TNBoX0zRdzpxO4dCMVP9KPoOcHuN2BB1LzQ3DhLeQjaFv7re9Lc16n4Y5kyjbhs+lEgk
X-Google-Smtp-Source: AGHT+IG+yYRf82RpZJJUcr1T15gpABV3qxYy+sy42xlPm1Kbdh1Wi3B3I19Hxs57vmbvm1u6OOq/9wpwK0xy7dX2j9s=
X-Received: by 2002:a05:690c:688b:b0:788:c74:d038 with SMTP id
 00721157ae682-7880c74da71mr17790187b3.39.1762882634348; Tue, 11 Nov 2025
 09:37:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104200008.940057-1-peter@korsgaard.com>
In-Reply-To: <20251104200008.940057-1-peter@korsgaard.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 18:36:38 +0100
X-Gm-Features: AWmQ_bmSVoCRn2kX76_TjPI76ogWJk9z8bbiPiuAys0mTrRZJTk9N73B5gAGff0
Message-ID: <CAPDyKFoZNKLU406NM5jhd4f1CFAQxdTbwEXKWmCOnXbArBi29A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc-utils: lsmmc.c: print_mmc_cid(): correct
 year/month parsing
To: Peter Korsgaard <peter@korsgaard.com>
Cc: linux-mmc@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Nov 2025 at 21:00, Peter Korsgaard <peter@korsgaard.com> wrote:
>
> The parsing logic for the MMC manufacturing date had the year and month
> swapped.  From JESD84:
>
> The manufacturing date, MDT, is composed of two hexadecimal digits, four
> bits each, representing a two digits date code m/y; The =E2=80=9Cm=E2=80=
=9D field, most
> significant nibble, is the month code.  1 =3D January.  The =E2=80=9Cy=E2=
=80=9D field, least
> significant nibble, is the year code.
>
> Notice that this is the opposite of the SD bit ordering.
>
> Signed-off-by: Peter Korsgaard <peter@korsgaard.com>

Applied for mmc-utils master, thanks!

Kind regards
Uffe


> ---
>  lsmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lsmmc.c b/lsmmc.c
> index 799e1ea..7331c1b 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -589,7 +589,7 @@ static void print_mmc_cid(struct config *config, char=
 *cid)
>
>         parse_bin(cid, "8u6r2u8u48a4u4u32u4u4u7u1r",
>                 &mid, &cbx, &oid, &pnm[0], &prv_major, &prv_minor, &psn,
> -               &mdt_year, &mdt_month, &crc);
> +               &mdt_month, &mdt_year, &crc);
>
>         pnm[6] =3D '\0';
>
> --
> 2.39.5
>
