Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8372F22
	for <linux-mmc@vger.kernel.org>; Wed,  2 Oct 2024 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906169; cv=none; b=OYRV3p1FelxCo1KZ3VMYTzM+TZ1fVZ1Ei6CdiJi5ix0qNEWmc9RvuF6gK6ZIox/OftjDP9vmKJUMPjSae+yy8hJDZiCuPE4rkMNqOmrFC1+wQBqLMy1dEduOHqBB1EEYFnaO1VUoQv9+6+8yBU3lX/InBnxUh5OHtK/SQah8TCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906169; c=relaxed/simple;
	bh=h0EBJ5lNu/jJJVuBHSnFz5qqW/dBFft5gPiqC+7OkQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6g9W6bsNwxf7H1YmSsyoJVwLeTptSjwP0AkoAkkQkNTE/lbjo4Dz0kdQtz+w0chPFbtWs8fCLzVfIXmmk+dy5Fu7i2J7BMjhjbvi8g7AtWMdK1sWYHx4YUNgcmmjvuTw1hE4KohSg3aCJ721a5i6twUMOXDIq+4crGhcmDWBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q4bu//2Q; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q4bu//2Q"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e1651f48c31so317442276.0
        for <linux-mmc@vger.kernel.org>; Wed, 02 Oct 2024 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727906166; x=1728510966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0EBJ5lNu/jJJVuBHSnFz5qqW/dBFft5gPiqC+7OkQE=;
        b=q4bu//2QEzekr8PdvgB+0ggdBmBW5s3lZ68DqkbVIITSuhzkq7z17Yhw2l4EdgArA+
         dGu3F9maZWxmiYl1zPB0dyngFv305oL4mLtb9BkhxL5sGOtCcQHklC3uVMaFb8JbANaA
         CBF8W3D72s/M04BmDAEypfKYy/zHEjC/XtxrnylNW9aNhoH0Cl2iXvnZxhVwqQLOnWn6
         U8QJ+wAgsrcolCpsaFCt7a12ZvqOmvreTgxrkkWbp7CFrDEZK1b+RuTNo1xw/OGzqZOq
         MRDaIJS1+PHNJ6GKsj4Xabk9M0lvsEOoWTCaUzMXPc8qpwGSiymoa37EqSL7ChfWhTHK
         0efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727906166; x=1728510966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0EBJ5lNu/jJJVuBHSnFz5qqW/dBFft5gPiqC+7OkQE=;
        b=qAklOsum8OxsOBPUo0OHiI+hQXZtKvF//o5Oq5beceGEmm3hebtUVQMcF+2YjPMBAv
         gBt/XB3VGstfm45IHH6bz8LjrFbYhLyeqTr64bsvZKOXjxIc75RCCrwGxn1FEV85tEwd
         eBU3nq/77WC2FwcTHi3PPJN2RBu5271i6ZhEtZVsItGozoUXWANNcy4zlu1xmBum8z+P
         bhTTwGmVin8ECc/2K1XeyhnLUP9JMppVigJJ12Jn33D6dxkmW0KVKQxyKg5OTOrdnSar
         c+rrdQjxgjdaFzps2cJHc53DZf/+6VTlNOstiI0fLxrnKspLv0Rfk2s/xUyrK2FwwZZ7
         iYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtgzjFjowDekLvTHDU/5zARov8SyckKlfOMQ/hjpCvO3f9UJ3o+3VC9KRiXswlXNol2kKqN9d5T90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsHuqdUDZYK0veANJS72N675ng0GRHbwaKRr47jQcIiaVlB1ec
	ThJBS4uvsZoft43G4SCBSfkfjBl0NCjnv0jA/yNXzN4AAILms+A9YbTmSkKGx8yHv76cR9qJO4k
	lDp9q0NhtUMqk0bWOabedf8mLwv1nEeeNZtbLTg==
X-Google-Smtp-Source: AGHT+IFRD5Rwum9K8DL674IifKjdfllmqQlH2FJ5zW9tVqEuOQNeCWTFnfrU70tmiCM2rMmiZ5ejF92CDM0MocFZHCE=
X-Received: by 2002:a05:6902:1b8e:b0:e25:fc6f:9cc0 with SMTP id
 3f1490d57ef6-e2638385365mr3826517276.9.1727906165882; Wed, 02 Oct 2024
 14:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912152538.1.I858c2a0bf83606c8b59ba1ab6944978a398d2ac5@changeid>
 <4920950.GXAFRqVoOG@diego>
In-Reply-To: <4920950.GXAFRqVoOG@diego>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 2 Oct 2024 23:55:29 +0200
Message-ID: <CAPDyKFosf_+m9j8YgHa-PsC2SV8+Aou2O6bTbMfzGBpQ2sY8YA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: rockchip: Keep controller working for card detect
To: Kever Yang <kever.yang@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Sept 2024 at 13:52, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Donnerstag, 12. September 2024, 09:26:14 CEST schrieb Kever Yang:
> > In order to make the SD card hotplug working we need the card detect
> > function logic inside the controller always working. The runtime PM wil=
l
> > gate the clock and the power domain, which stops controller working whe=
n
> > no data transfer happen.
> >
> > So lets skip enable runtime PM when the card needs to detected by the
> > controller and the card is removable.
> >
> > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>
> So for the change itself this looks good, i.e. it fixes an issue for baor=
ds relying
> on the on-chip-card-detect.
>
>
> But for boards doing that, the controller will be running _all the time_
> even if there is never any card inserted.
>
> So relying on the on-soc card-detect will effectively increase the power-
> consumption of the board - even it it'll never use any sd-card?

Good point! A better option is to use a polling based mechanism - and
we have MMC_CAP_NEEDS_POLL for exactly that.

Moreover, on DT based platforms one can even use the "broken-cd"
property to indicate this.

[...]

Kind regards
Uffe
