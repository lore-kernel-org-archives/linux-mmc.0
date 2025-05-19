Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880C3647;
	Mon, 19 May 2025 00:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747614639; cv=none; b=DpLkYhX6EUoB6lnyH9HJWhHD3FdTCIRyRmZBfCHuagrqPKVC61+1u+uNuAypJ+oyQydpxMJ2QlgJ/ch2MDXguuPmGPxVQ0iKfkZXsoXJlFFRpuIbBmnYt1nzEYgoOhai06sZzhy4+nKyRUBh+vI9ME9oxARA8hVd4+XD8HH2Pgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747614639; c=relaxed/simple;
	bh=77cgIMDcmdpoj7u9MW6cGrdMx12B10ZtExO7zFr5mpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/wcUturChedGsmwCCdSo8YocyBBvwHlo29RiETGH7EfdqIkxNA9PICYKDnofy8KrBkzpXlZW3eg71G8v6OqTWLTqXRNONiNufyuqRuAlJPkGe2zxwPGyDhZheJXBkhIbGvUeP22b3AMqEuqc367QIaXkY5dYE+7SU67AGq7HFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtgX7Pqh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtgX7Pqh"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-601ad859ec0so2146502a12.0;
        Sun, 18 May 2025 17:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747614636; x=1748219436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zZ0c40jKjgoeIz9/1kYziaj3iHfaPjGRI99QCa579w=;
        b=WtgX7PqhKH8LSDDo42oadTbuRmQP3SpPGkA7Q10TUC9LpwCge+oU7lgfkRFOXZ179h
         OllLvZj/fSMtKdlyAajMdbTGAU+N913yZXjhYQMEX/kdCJlYLCmPxcdyvSSn2P0fTCon
         aEjpK3zveBt2Ufv1h7CG71002++1qYkGNDL14dWN4c/cMDhCuLeD6euyNGT78/acgtaE
         gHFrjaK5JU7oz8OhY9eNks4Jmp+VmatksqeSkqLio5y/BuoWHXFw4S6az5mjOSZm+I6l
         XTezQH8DrJtZyKZUGUN948WQX+eNVcH4E+byC9gZr/AjB1HqeuLj6HVgQhpDi6GaU18E
         QNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747614636; x=1748219436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zZ0c40jKjgoeIz9/1kYziaj3iHfaPjGRI99QCa579w=;
        b=YM7406Td5f3ZoyHnsJYewDlSCFLRtGsA2UmTj1jBAQi1SsTwluOpTrgRGb3C7f0zDt
         U5snq1hxHpDykviy4ux8wvroXRobB1VmwTrVY4r49QDzCvHWZ1HPPc1hiRZPnvYtgPYX
         neeB0owwIoZ5EKxoyM4VfvIJvke6R5qrqotL8ux1Meqh597t5lvgFS4Mn61XZok2VaoL
         AXUg5zniT3egxSIA8n2rLg/lMcYzRokl+wdmdKJPmg9x/uxqHmc0clpBPGHIT/O6pSo+
         itYIZMtB7diiXOYhk8gSf1CFwx64s2IzDwwR0ZUtFrYLNPULwYm2C5XAtF5Ff26Vu1Tu
         1M2w==
X-Forwarded-Encrypted: i=1; AJvYcCVlVdiGDzlk85rYUQ9fagbSHyN7uip0nsTtC1U0jkOcqMBGHZA/vCxTWPZCVVwFO9U2UslsxHsZe1X5@vger.kernel.org, AJvYcCWNqhWttB7EzmQtsBiHat6h2AzJJTfXhB+tH1xb3t+tgkrSHnhZiYJNJKX33m12EwkYRpxEfne9nE/7N7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvtqKtO+p8vSIWkgeoueoS0Oz8nMRtD5YlC3fLwwVCM3I9aavp
	Wgc3LpSM2Yy+G3XSj1/iuMCRoMHCj1NoQVhoQqya58SL6pYg8yfwXebBqa39zuDPx7H91717ERs
	UMw0DPURijRB5IYUcga3pSIzBXuk0THc=
X-Gm-Gg: ASbGnctu8yrdv3zX4hyQ6SQ+ybeQGiFUAPeb5td37/WdXBKEyYTJmKsC7aWaqg6yjVO
	B9bOjToLj8rkViDCcgWYmsQ6ZDE9mxD+3dkIaUsLwDeIUP5TId+/AWr8G+bnbXQb81hqUBFavMW
	dCOSop/jcuk5nHekm0Mx/qlnDMl9TLgHL+
X-Google-Smtp-Source: AGHT+IG0JdoFcsroNTrhTPd2Y2eeFajo8woP1y65TWcnzJNLIb3V/XYqMW9UAqYolimHY/C4f96WgU0qnhGEjlGrNOY=
X-Received: by 2002:a17:907:f496:b0:ad4:d0bf:f4a9 with SMTP id
 a640c23a62f3a-ad52d4cd771mr974896166b.21.1747614635747; Sun, 18 May 2025
 17:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516092716.3918-1-victorshihgli@gmail.com>
In-Reply-To: <20250516092716.3918-1-victorshihgli@gmail.com>
From: Ben Chuang <benchuanggli@gmail.com>
Date: Mon, 19 May 2025 08:30:24 +0800
X-Gm-Features: AX0GCFvd_Y36qTnQjTl-mdiM7794fHMBTyb7UOUec0P-lKMasuCd1UFL_CdxXc4
Message-ID: <CACT4zj-aev64sXTjw1CyHY-C9avAD2_jj9JqtrCDp+-SH+05pA@mail.gmail.com>
Subject: Re: [PATCH V1 0/2] Adjust some error messages for SD UHS-II
 initialization process
To: Victor Shih <victorshihgli@gmail.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

These patches were contributed by Victor alone. Please remove my
'Signed-off-by'.

Best regards,
Ben Chuang

On Fri, May 16, 2025 at 5:27=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Summary
> =3D=3D=3D=3D=3D=3D=3D
> It is normal that errors will occur when using non-UHS-II card to enter
> the UHS-II card initialization process. We should not be producing error
> messages and register dumps. Therefore, switch the error messages to debu=
g
> mode and register dumps to dynamic debug mode.
>
> Patch structure
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> patch#1: for core
> patch#2: for sdhci
>
> Changes in v1 (May. 16, 2025)
> * Rebase on latest mmc/next.
> * Patch#1: Adjust some error messages for SD UHS-II cards.
> * Patch#2: Adjust some error messages and register dump for SD UHS-II car=
d
>
> Victor Shih (2):
>   mmc: core: Adjust some error messages for SD UHS-II cards
>   mmc: sdhci-uhs2: Adjust some error messages and register dump for SD
>     UHS-II card
>
>  drivers/mmc/core/sd_uhs2.c    |  8 ++++++--
>  drivers/mmc/host/sdhci-uhs2.c | 18 +++++++++---------
>  drivers/mmc/host/sdhci.h      | 16 ++++++++++++++++
>  3 files changed, 31 insertions(+), 11 deletions(-)
>
> --
> 2.43.0
>
