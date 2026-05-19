Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBFF348C7F
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197867; cv=pass; b=u1mUZug28Dth7lsvuquRDWQtYvvumYgy3hFJ2ijJuAG3enbTSKeQ7N77BDobmOBbrmA80GZgHnfjEmIPRVaSqW64bFV73v+X7Ti6T+HJF6iYNAL9s7hzS/TybOopFmtD73Xv9FhcTO6qJvBURTETWm370egfW9K+YQzgiSKrSsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197867; c=relaxed/simple;
	bh=a+6vVJmOZ3ZG/v6p+ChaawK/jURoxlUIsJFp9JcF6Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnqNzdc+RKjbPoqrUuWgFXKpbj7komN3PEVYwH/c8qaB6HLNtDXH/kYQ0HLLAJqKas32nE8CNeMUWiSughCuleJf3rA6W98GN1njxMiBy265tm5rzYXq0WCdkL0g9sstgyqS87tXvUENo5orLtF98NuHZ2V4EdAi/INAEbP9vbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBUMJ0D5; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBUMJ0D5"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so907278f8f.0
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 06:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779197862; cv=none;
        d=google.com; s=arc-20240605;
        b=FaW95urGlPX3NX+o1Wo+08iE4u76IABJoI5HZZGxsaJ5JVAYdEparzdJX2FCGtQhWo
         CM0PKKg1LqNYtD4Yv0oIrPzaYKWXuxgQqGsShjO+iIUaOV8sA9LkpImotVPExebd27Gl
         hALVD9xqHzhJGJ8nElW8M+2yYg1LG82IJ27SXWiv0rzgk8t8z/iVdxrpGhJMShAP1oxW
         AwQm7XrJtAFcbJqQR04aIGjmbBX7+5taJ1i2NZgnU2M9NdHpZbAlGuMQ9/ljw/usoZDi
         z8MKtQOypL+K71KTSVXaUeG89KRY7vGuIcPP/7HhPXIvr0df+ZhXtT+O2D5j7D+NjuCP
         Zjeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+/ja8jc+FHQMYyLaMU5qKpBDmFJx8YQVV0WGsvU+fWE=;
        fh=svdG7fXFJKcrabPOpdwqys2PtrUnVht3Dfj+PGli2Es=;
        b=g+piL0Y8E364FwSNgHgGCrN+v4LewiBdKHm/lwM9Ki18RhPopMSgBDqpyzLcVyjUpt
         I4zpMP2iS/JJ914i/x+q10adiehCzs6YrCdFXBTvzPlCqN7c/KjRnYWfqfv01jbahB4h
         cmaac7BMOSbiZL4O5AvniU7d5BoCJHI1UbWiRqx4m8GDCHI/4F4+2TM2Y/s2+J8REjh7
         +p/FUaMQDwTJ08c2/LrcfyMLJaEkMxgbVVxKUy+OL+qtqdHLlMP5gue2udpL8pCTDKYW
         /knj8+7RPOQw9ODW8qcY4JjKTQm7XZExhJ6KKQr2Mqr0LWCyBn/oHxoe2KQZ++lGP2+r
         Mi5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779197862; x=1779802662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/ja8jc+FHQMYyLaMU5qKpBDmFJx8YQVV0WGsvU+fWE=;
        b=eBUMJ0D5qz5yuUY2vA1ejwq6sp99nSXgj5qOPe57Pxoy/dgBM41o2zA3YFlbLk5lS0
         3KO0USOyZnalnhnkLaAJtpU6W0BAR3DF1vnl59RNsypd82qmIQ5VV/wPUKP8ZP/PF3Nk
         QTV7fbSicD61E+ehBaU5uoVgLLWYz10/NPkFtJ7KRIcymmZLGuf30WqmKR0nGf5Er3z6
         Px2QCL6bl+DfbsJQrUJ8vYj8vHt1t8lABrQyJ75Tl3h3I1I2g59IQN3JokcOsVSwpC/S
         Gi0hEV/UqtbVUr8IeB0kS4Q4YTr3LBU03fI/YbY8I6naR8OdX7jOvf4fZbppA+AYP2kQ
         /pgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197862; x=1779802662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+/ja8jc+FHQMYyLaMU5qKpBDmFJx8YQVV0WGsvU+fWE=;
        b=GRCJtKDOo4pnGG6s+ybvtsorSdH6kmRkM68IRvH0ifT09AiwujMHWB3ghM8iZJZ6E8
         hu13UEKnPkCEdPtGMl6FXJbue6ItJtxDJrtC5lN+gUBA1FHYfHyFxrcDk69Fm/ZxqBA2
         91chxf8kMqIYJ2hrDnKX7KccRBZTAAoqGPnTMjTxbZbG/pg1341cNA7wwyRgDghAxGed
         DVGbjMJIqc2GZIzcvNN1mW9VgNNdNU9wOYutZ5C24Jc6lhYA75iZdYKuu1tURmKNZFKI
         Quswwm+EWIA7UBIcaHipL1thnyUhQ4O76WoX2d2GD+LJ8y9hXxLkTjyrbTilMoLdpc9B
         Z8Cg==
X-Forwarded-Encrypted: i=1; AFNElJ9YT2PtmMP84DzYRRcjhA3csyxCY8yRYpwDS0OPLQapUD+5tVkVa0y0l7nH9v7XhdLoGwNk9fdqdgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcWBrVLnu36E+mm5iCFJm6WYYqFjZpywINQ64vZSjJk6Z6stNn
	uGcBDn/DZCEDOipps1ZzVvYf7jHXuKXsFoggXIstmP9OnVQGv3E9xSxtHkRAUzND4nOc/I9uNLG
	Ik20pRwcBSLmmxGVkLIvjoyZbuqpowvg=
X-Gm-Gg: Acq92OHLCe1XNaNpzWTDXAjIJ90Zhm7Tm1HNqqbKYsaMB02GUfarMaXlGs8aQoYxRaw
	/KqeyOYNd20FK60Qr2FyIQzxt6kpg9DkiPDB4wSpKHjT/ibPoi4+ocxMHeraV8M8Pn4WM3+UZHZ
	AZtUFK03EC2wXnNk4MahJT/NGFLF2CHJj7NFeYu/ZrwIR2VEs0bRvJYmbbYdP6XT7s0X4ePdelY
	5qWBtAuH3p3tu7MMxFKTQqS2A2ZzppJMFDPx1VvbmP6Zcg94xUUNi9fFBkk0HEN7lrCUJQ/Svj4
	Sh59BcS707b7xG525zZAsp/PHOfX2mQkl9ov4fozLHXtXx6Rd7e5VEf4JHzsfRI//7am
X-Received: by 2002:a05:6000:1ace:b0:43b:3b80:6776 with SMTP id
 ffacd0b85a97d-45e5c594c2cmr30428288f8f.30.1779197862459; Tue, 19 May 2026
 06:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514212024.1624517-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260514212024.1624517-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXDAJjWGRLQb6jfvzUPAWymmTC3yE89UPyiydykHN4u6w@mail.gmail.com>
In-Reply-To: <CAMuHMdXDAJjWGRLQb6jfvzUPAWymmTC3yE89UPyiydykHN4u6w@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 19 May 2026 14:37:16 +0100
X-Gm-Features: AVHnY4I3urEZt5J-xjsCBTxOrtCMrr3KZW2teP8VKCgNB9fs0VDzkYcmhM5yTss
Message-ID: <CA+V-a8uTXh2ieeBRCQC8Gzg_hCSFVFCOv0S_V+6MoGdX0F4VNA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: renesas_sdhi: Apply bad taps quirk to RZ/G2H
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulfh@kernel.org>, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Mon, May 18, 2026 at 2:07=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, 14 May 2026 at 23:20, Prabhakar <prabhakar.csengg@gmail.com> wrot=
e:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Apply the sdhi_quirks_bad_taps2367 quirk to the RZ/G2H (R8A774E1)
> > SoC.
> >
> > RZ/G2H is identical to the R-Car H3-N (R8A77951), which already uses
> > this quirk to avoid unreliable tuning tap positions. Use the same
> > quirk entry for RZ/G2H to ensure consistent SDHI tuning behaviour.
> >
> > Fixes: 31941342888d ("arm64: dts: renesas: r8a774e1: Add SDHI nodes")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > @@ -224,6 +224,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks=
_rzg2l =3D {
> >   */
> >  static const struct soc_device_attribute sdhi_quirks_match[]  =3D {
>
> This array is meant for quirks, i.e. to address issues on specific
> SoC variants that cannot just be identified by the compatible value.
>
Ok, I will drop it from the quirks list.

> >         { .soc_id =3D "r8a774a1", .revision =3D "ES1.[012]", .data =3D =
&sdhi_quirks_4tap_nohs400 },
> > +       { .soc_id =3D "r8a774e1", .data =3D &sdhi_quirks_bad_taps2367 }=
,
>
> Hence I think this should be RZ/G2H should be added to
> renesas_sdhi_internal_dmac_of_match[] instead, referring to
> of_r8a7795_compatible.
>
Ok I will add an entry in  renesas_sdhi_internal_dmac_of_match[] (same
for patches 2 and 3).

Cheers,
Prabhakar
