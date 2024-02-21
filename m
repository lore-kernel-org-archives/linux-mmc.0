Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E778126F37
	for <linux-mmc@vger.kernel.org>; Wed, 21 Feb 2024 21:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550726; cv=none; b=r5ue/n5U1K4hGQezYOQZvgPynFT0mUaKvP8uyJsXzOj2EHnu3bO1iUI0Pc75Mzd+Zo3GU62jWNlUeA9ltzwuP8XC2XD2sQflxebJYUjFcaMMysWyu1P2a8ljOIiSbl4XfI5IJQ4tUiTsZrPgV6cUywSYyy+F3DpprHYiZ4fYMa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550726; c=relaxed/simple;
	bh=vwcCEdPIttWiNnK38OUvrS0LIv8EPoiVoGqCGSZN+Ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aG0NSZilQzrojYvb1vmJlnhShJYzyp2yzQZ/uU2gwJkU7kqNpy277cTn+ihZ8Ynid1b2NR9TZCQFN6GWQE0vZeT+WFezhDET6FfLsfUAoaMbXha7c86X812aJsIOqN2ZuRL30r5CyN9hTPr5Wd85ersmnmvcF83immOR/vJLo60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KYtTh/tM; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KYtTh/tM"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso7892972276.3
        for <linux-mmc@vger.kernel.org>; Wed, 21 Feb 2024 13:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708550722; x=1709155522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQcwsvUVgzwUHzVYq2OUwFRsg7S9zwWdnAGogtH5/+c=;
        b=KYtTh/tMfJTsTc1y6dP8tFA/q548E6QS1sFLhJInyi8VYfynZHFK8Nmr5B/8YTrVRp
         gRMX3VJjb8bT5xnFExOW7JYcyqaCPkg6llkwW5eLB4dMbmgpj01Vdc+TEi51KkBiuoDi
         fElxgHErKjwrUtdeM8OYUJD1u/c4s6PU2E4YYIc123pgMXVggCLhFxxkT3884vqEd2hW
         CUclIIQDBKJHc+rfYbfmZdyfGCgFBsZ/SFqy3RFrej0rGhlH1KZ8Otj+u32NIcev7G/i
         VjRu0jrbHJa6UdHvxahSeqXtYWlO6Vlj1ydMLsL1XLGPt5Ci1sK5BWBveSUgvR0vcRf3
         DOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550722; x=1709155522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQcwsvUVgzwUHzVYq2OUwFRsg7S9zwWdnAGogtH5/+c=;
        b=u6LjmLxdLKG/OpPu+OX+2wR0J64A2AlCD1i+UB7f0eDgyKAbrZDJobS+oUXcPfLh5P
         R1+HrQxwOStf0LWKUrrSfk8OklrxMhMsUkOuFl0D0sjV9l+SuGbmeCXBFHJwNma4uiPF
         JPdDxCaRLvZ84SCuR6JaMGRPJZqZJsLg/n7EixAhlku9xAeOfOLucZFhgTyEplhprLEN
         uzUk1oRAKilc1EhJX9Z5XeRckc0/yXQ7DyA1ga/s05vZbsvWIDqMZiFdmBf5BQVBhZ86
         9yGLlSnN4/ny22BfrQV3o30/GXGobocitWW3EiaxbjSDOJz6wEvjjXmk8OSijY3EqWI8
         k7kg==
X-Forwarded-Encrypted: i=1; AJvYcCX8ISk/8cUr4FATQvLVa4iy9Jvap4OtdnEwF25rM09nyg5J7K3L1B7iZLnv4h+uwZxQOgdfKKnMHUM13oeBOSYf5oXt6H9GALyP
X-Gm-Message-State: AOJu0YzZHhqO+trkR0mKABM+TXj9SK0Git5kwA6CpnIaWW18j625AUXV
	1S/rs21qn8Gi2ZUyKRPjepyrGBAXa4ViUmhFPN0asnbqRyxXc4bugJ85bORTCUO0RWXclyQi/5f
	7YzWYJXJg0Hdux4ilo161SN3kYW2si2p9M8vqJg==
X-Google-Smtp-Source: AGHT+IH4UPI5wpOTg15rGTFngizg01v5P2orm8RiQzbgP6QMedeTpOkK8y3JHAR2cnL/aWUbEuMgAt7gdxYB8HxLYEo=
X-Received: by 2002:a81:b614:0:b0:607:f4b9:11aa with SMTP id
 u20-20020a81b614000000b00607f4b911aamr17260454ywh.21.1708550722698; Wed, 21
 Feb 2024 13:25:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127-mmc-proper-kmap-v2-0-d8e732aa97d1@linaro.org>
 <20240127-mmc-proper-kmap-v2-9-d8e732aa97d1@linaro.org> <7f40cb40-1a1-532-75fc-d3376ed27a@linux-m68k.org>
 <CACRpkdZpyefnTyKEJXru_HZG8xcJF66Eb2pZhbk+HVvfzdh4yw@mail.gmail.com> <CAMuHMdWwuH-mPm1TJTfvf3FXSd_zj+yP7OL6uB=-TrqNOT+W_Q@mail.gmail.com>
In-Reply-To: <CAMuHMdWwuH-mPm1TJTfvf3FXSd_zj+yP7OL6uB=-TrqNOT+W_Q@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Feb 2024 22:25:11 +0100
Message-ID: <CACRpkdaks_7PWpXF=wssP2x+tZce5SFsGTCddgxjJQ9erHp-6Q@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] mmc: sh_mmcif: Use sg_miter for PIO
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Adrian Hunter <adrian.hunter@intel.com>, 
	Angelo Dureghello <angelo.dureghello@timesys.com>, linux-mmc@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:50=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

> > I've sent a patch, can you test?
> > https://lore.kernel.org/linux-mmc/20240220-fix-sh-mmcif-v1-1-b9d08a787c=
1f@linaro.org/T/#u
>
> While that patch fixes the BUG, it does not make the eMMC work fully.
> It spews:
>
>     sh_mmcif ee200000.mmc: Timeout waiting for 2 on CMD18
>
> and no or limited data is read ("hd /dev/mmcblk..." blocks after no
> or two lines of output).
>
> I still need to revert 27b57277d9ba to restore proper operation.

Halfway there. I looked at the code again and now I think I found the
problem causing CMD18 to time out.

I've send a new 2-patch series:
https://lore.kernel.org/linux-mmc/20240221-fix-sh-mmcif-v2-0-5e521eb25ae4@l=
inaro.org/

Yours,
Linus Walleij
