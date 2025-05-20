Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1F24BBFA
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747772612; cv=none; b=gUkfxESbRPBM2RkgTGtOBCsfcaryaMMp//te4FdJlUIFg+L6C6MRIyiU0NS4OM/mCX2P0Y6VdT4eFM5m7Uz+8gLmsWraOOFQMH2j2MNmehLt7wWt/G9ilq4mCJth1cG/jX3VdW7Dr8TRe7/JsBDPNKbxpjjOtJAahVdfhsHZhOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747772612; c=relaxed/simple;
	bh=oYpaPErouim5e8jjbN1s5ypfsN55rf1ipfr8rTDawBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVBX7vFxJjrpmN1mNjWdq3379/l4mIpf2OflFkGtIB6B6t6YIvOa+FOtkEU2xerdz82X50qnEN0cW2pZ7Y/mNRqmAOdm0rizriQfVs+sDOuHm7BU6l0rgcvgNjjL3URKm1moUQdjt8R7b8xeeW4I5LOS7Tt4UFWFPlvxnaBb5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0r+kv3/; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0r+kv3/"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476ae781d21so59381021cf.3
        for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747772609; x=1748377409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXXPip/Q04crlMPesamVwv1y1I72yIpwUIynmj5zYbk=;
        b=A0r+kv3/LAL7ptSe/HyDgPzBu2L6nguNSr/lLPQ2drq2C9HB7n0HcONw6lCjcFLTRa
         w2LZHn1rczslNeNQ0GU1uKsn0VV9RzmmA6nMzQeZeaHR+ls3IGMXtdYwUQB8/q4X+Etz
         ZUjy4peNmdmHjc3yN/GWw06jmSbC8GGAMFlHzLzN4ptwf479I726Wkh/Km/g6hhyf8uc
         GkOPP5+A578Yi9Fr5QIpdE20olo0TiZMr3H2Bp0QQPYoVv5l3FfMT6lcoKY7/dQDlLfO
         dKDMjCp91Ey5cNvK82D6eaagtNctHrTryuFu9Nxv9dsQKgk5bSbtkkJgfUjeL3DLacjn
         sabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747772609; x=1748377409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXXPip/Q04crlMPesamVwv1y1I72yIpwUIynmj5zYbk=;
        b=W9MTgIVc88w0kgjmd6X53Lk2HQ5p0v2+1x4IpUySiK7OgQs5WUFDLix57tfUcYmYOc
         bs7zO43NeCg08OQO8DVQ2q91eZsRQDvKQzlKjDIdZ4p557zVa98O6/+d4zVDtpkrrroo
         MECOqsH7kwS+FgSP/IIvlXm4diQFgFx49p32jOGI7wEODKeldBrGmzqAjklN8ma1971H
         s63A9cZbfjDNT4kecuA6qRjTx8pBgExUJuA1UY1PVrsb+g5SLyltnd1UCFGp095GkyI+
         ZOVhfdIpnGi1fsr3cHc7TsHrshnUVHqOV5MrmWamv6HM9O2ZHnbY502fV3iTkCS7Qxgr
         LxKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI+3mrehUdausc6nF48YToEwBsLLAepVVS4uZYfp+IMYB9qyr4qSMS+WZqaYawPhdRPl3X9l7inPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9mgSxa/BBVXHzl+EhpHaEtCkt4cCDgcgJGYgwLYc8ymvlsrgT
	cOVdrt3Vv8jlY8ODlRxQtYmK0rRZkc5xXVc1QU7dHh9TaKJhR+MUPJP/tA8IPnTjOyFSzy26Pmr
	TVyWiLWYdtmWWMEgHMzYj/tBqv38A7S8=
X-Gm-Gg: ASbGncte7ShzCcTrwZE26bCsQgm64FWfmriqh/aI73M1iu3En+23QmvJ6XujbqM4+c5
	qLFzAYpEUh016f8kbynkwS1lr2EL3NlVxbNk8aCTZAM9GE5oo57i5eiHvTN+a3rEyrBRipj8F/r
	ua3lsjqVyYX+0vcL0GTTrNNPfUEV6z6Jp+fDanUFYBxFymvw0C9TRGnxEGouj+jPTcHQ==
X-Google-Smtp-Source: AGHT+IEJ4vVT8ay7Rc5gU4eCtGme7kuzMxrgPCXqV3qQQua5p+VJt/G4/ZF+BZp6aIbzN5ys9+yz32NzXP2hFVNO0Ks=
X-Received: by 2002:a05:622a:40c3:b0:476:a895:7e87 with SMTP id
 d75a77b69052e-494b096c66amr288661741cf.48.1747772609635; Tue, 20 May 2025
 13:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747739323.git.zhoubinbin@loongson.cn> <67c3e1fa54a40ae118214791df1cc9c5de0a9df0.1747739323.git.zhoubinbin@loongson.cn>
In-Reply-To: <67c3e1fa54a40ae118214791df1cc9c5de0a9df0.1747739323.git.zhoubinbin@loongson.cn>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 21 May 2025 00:23:26 +0400
X-Gm-Features: AX0GCFtf2YSTe_hKsmfua2Jzoz_owjF9LkM_JltRGzGcTmNuKMlxJ1Tt0sqplNI
Message-ID: <CABjd4Yw9m9zBsVz5+Sgw=uaxAbhBWuKY5XbE0QUNgRL-2dAKAQ@mail.gmail.com>
Subject: Re: [PATCH 32/36] mmc: wmt-sdmmc: Use devm_mmc_alloc_host() helper
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Huacai Chen <chenhuacai@kernel.org>, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 3:47=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
>
> Use new function devm_mmc_alloc_host() to simplify the code.
>
> Cc: Alexey Charkov <alchark@gmail.com>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/mmc/host/wmt-sdmmc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Tested on my VIA APC Rock board (WonderMedia WM8950 based).

Acked-by: Alexey Charkov <alchark@gmail.com>

Thanks a lot!

Best regards,
Alexey
