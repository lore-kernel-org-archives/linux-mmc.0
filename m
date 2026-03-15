Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1878A3659E8
	for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773584189; cv=pass; b=AwBnHmCJnzogF05yWYj7efN2COQQrB5RTuzx1hDNZ7hzbMeT7glJ0JGdGI94QjXqoJVnSqcFardfx42+uHUwIR47lG82EP3XCvMDmYpkcEuZAbqNgHVbQT5Rje3ZBsuFSfXcycJmM6xThAtzq0yFpG2hZkr5mwvwQxIBoAqeCLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773584189; c=relaxed/simple;
	bh=mWA34iVYtsZxFlURk464PNlVB9E9ZW/NryYidkK2fvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6HyZlJrYVDZhcx4ZOIVYPeQAjNiICEFR+a681gbxerhJV3tKGq0pw4lPQdQW8N9QEnrUvneoaz2jb/nimHyWedE1S4QKI/+cgMIbDzbQDjOCR4mN8LscceoFkCQ4mVyPswOgB1/m1GWbp1XvHu+uqatg4GPOPPIhs7E0epZvSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0szMHk/; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0szMHk/"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c0b6f22aa4so30583eec.3
        for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 07:16:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773584186; cv=none;
        d=google.com; s=arc-20240605;
        b=ab/EqcPm401+1Yg//0r711TFb0lgQ3FgkXz65TOtx0LA/J+P3WMoKuuqvVOOqVxI2O
         2LcBfrE+Q/uI+8gx/7oHJyyYENdilqBK6MbwA8gWZbfGXHDmd8swfOvSxDo+A6UujJc5
         kIA9kjEzfGpZuyehoU9z0mZh0Jkeac10XvYPnKYp4SGxf+Mv5ELsLmXkCS4p9a0kQR20
         NLIT37nLGZiPneLopuJ7+4+4WwIxhZSDeFheAUVQ20GAtACq4qOVMD2TCPUbEjgNwgRk
         Wnl1r3RAtZQrYBXkSabz5v/T31msWrUOnjhIYG4Jlh9A8aQHGhMDIxopk33SthJhal12
         O58w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=whZhDUq/FBiJBJ/cNSKAzeuvVF0J538ymXurk94T6YA=;
        fh=4FE3cQFb2TINje8gRQ9SUSu7TW/DiMTl79X42nLF6cw=;
        b=ZhrV3C1W5xMbCHEoOHlacMNgCLFUZdaa1wks+hctSJsekeJgRCgoXWfNUbkxID2yUy
         A1eZh2Ne0akFoCZQ5RInYEFWEK6zBxP/6fSezXMBenbZhuq6EWfZhFjNP9s+ELKoVgNH
         pebQW1DWB9UnAE4dT/PXINHZnsoScByjGwM54XA27uuaL2D162Tru2vKu3x/C4rIARjf
         4sYz8T3wlrnYTdcg4wmHaW0pr9s1JVCaHg2Gumy645ZHeptRwvcmBYZOwLlvH3iSC5Ml
         yb9aqhSVk7hKOU237mWv51QDjc+zNR8qUnwpARCl3lMQ0T2DgTSJKBVMttIcon0jHIcn
         ilSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773584186; x=1774188986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whZhDUq/FBiJBJ/cNSKAzeuvVF0J538ymXurk94T6YA=;
        b=Z0szMHk/sMl7ipw/RL8CAdT7U1qdtvOdWUK4+zFdG67ETskpQO+5gJI/XBuDzrbTvH
         o321yc8KR1m5rEoPUHDHemDJZztrfJDIFmL5xxi8v5Xc32iUNckZMJ2jAWZSlfyKWz2e
         7ujGw+iTDWRUfV6uAGaWCM7Z6KT6c66Qb7Q9R4CMzqWmyYvpcTKXCLhNUtwhReunmGRY
         ymm4poco5oGwz19UohmQ0jAQLw+dQpORPab882GAAoUN58coDiBEi4VDCTCW5ycAM4r9
         uAZcaHrguGkNmy8D6KorNRowZ11MGK+zc1vVwiJRw6dlTMOMyTB4Xa4AQr6RZi8pRnry
         WNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773584186; x=1774188986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=whZhDUq/FBiJBJ/cNSKAzeuvVF0J538ymXurk94T6YA=;
        b=JkyBdRgHijvPMJD5lPdLMPzDYSW++NDEvLAKsO34cRrqDZmnjD7t2UTMGM/L28zJ1I
         AatVYJ3V4Dnbsp27Yz3w9887DZ+hoVQsGnEM4xXkB/owOPNkAyuZ5H8VXyWaJwBjfZ4x
         wUTEcOjEtJ1r6hL/UXL6zIvbtZNvsYoRlbC12Hdfa/8IQQ8f/11IVvZhiUePmqW2K8wJ
         441oKzIrjdxtG+V0dX6Q/HzLPBVqcb+IPkt3NaRe0tbBHSApih10MjmEWsKzp8BGZZjm
         +eMAdSxxEi7wnXoIB/4Ivus17C+xABvF0HPfn10+ngVTqjznkZpf/xr0yzBj2YN8BabF
         7XSw==
X-Forwarded-Encrypted: i=1; AJvYcCW0+rQgzfH5E4Z+eRFXaZk2K7Pffx7xZxmGyzeAnvfIq+F8rt3iJX3csfp+kpLWZagu60btjlRGPTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoGEPfbb1Cj47lHoeDNfi0XteblRbf75k0JtXIFXvYphD6qkRO
	Zg73XBSqrvb76/ANvNcoUlTyf2Z8hFh4E24ew5n3RHq/WVZkRxIwTtzMtFfp2QP9ZBYzV9YJ3LN
	ui7cnlJM5CsNO+p67QGgCsG0YQGCkMmM=
X-Gm-Gg: ATEYQzz793hbACiJFTha35ipWCBFA0yLRKQkdo7eDi+0EAHcj4zAVCnYbMu5v3nQqOv
	0CrbKpJwl2akd1iDu+QbBnnQ98vqC2oX2q7l0BIwPCrgIFOmZDzj3zGV4IBamp0SIcjpe+et+o2
	8Vt9SiFzaSe6eapAT3kGNEyXL/QM+4L7ZWrtnXLEuj1Cc7P40+j6CPnMFdbQPVNCUvC9nlIWByp
	LV7k4ZUJvr56MAa+70612A98Fq9LPa1z6FVbglupPmoaVp+Jjc3AiD9sRGlFlbV/j5t7Q2VuW4t
	d4VvhkD4T6WPGMRzkn2Vi3Za1eaHV7NC9+YtYB/syCsqUZP6vbsv/gBYHjcecFj2a+s1iF5LA2U
	uqYdldVlYdCEF2mqlf5cgE4A=
X-Received: by 2002:a05:7301:578a:b0:2be:6e6:e47a with SMTP id
 5a478bee46e88-2bea51431b5mr2291637eec.0.1773584186089; Sun, 15 Mar 2026
 07:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315000627.29888-1-adriangarciacasado42@gmail.com>
In-Reply-To: <20260315000627.29888-1-adriangarciacasado42@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 15 Mar 2026 15:16:13 +0100
X-Gm-Features: AaiRm50qzpKipYXjjJwePGqfR6wS08mpC7gsxl2IjnN0L_XQvoyoGJSHbvyYSNM
Message-ID: <CANiq72=-_QUidBwgkm1S-Edm6Ye-3Uq9xFDcS_oZgVBEW9eUxQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH 7.0-rc3] Consolidation of sdhci-imx and Rust
 PinInit optimization
To: =?UTF-8?Q?Adri=C3=A1n_Garc=C3=ADa_Casado?= <adriangarciacasado42@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ulf.hansson@linaro.org, 
	linux-mmc@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2026 at 1:06=E2=80=AFAM Adri=C3=A1n Garc=C3=ADa Casado
<adriangarciacasado42@gmail.com> wrote:
>
>  drivers/block/rnull/rnull.rs                  |  101 +
>  drivers/mmc/core/quirks.h                     |  271 +
>  drivers/mmc/host/sdhci-esdhc-imx.c            | 2203 +++++++++
>  .../intel/iwlwifi/pcie/gen1_2/trans.c         | 4377 +++++++++++++++++
>  4 files changed, 6952 insertions(+)
>  create mode 100644 drivers/block/rnull/rnull.rs
>  create mode 100644 drivers/mmc/core/quirks.h
>  create mode 100644 drivers/mmc/host/sdhci-esdhc-imx.c
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.=
c

This adds existing files. If you wanted to send a diff to those files,
then please send individual patches with the proper diff, Cc's, etc.

  https://docs.kernel.org/process/submitting-patches.html

Cheers,
Miguel
