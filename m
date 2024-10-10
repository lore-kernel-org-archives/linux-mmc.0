Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A3363D5;
	Thu, 10 Oct 2024 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728541252; cv=none; b=UmAgOVrc+qrg4ruaLzFuGiLFP/HvoXjrLZu09hhkBOU0m4D2ifQD+rCCkBo3Ox2OQ38Mw8cNk1iZODg8dsERIg7qXufQk1cMDw35BcVCSPQPN2+GRzE3ib3Z6VColcGo5GjVVI1SzOpQNNezHEMUDJy8c+yy591BfIwrM6U9lVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728541252; c=relaxed/simple;
	bh=qaqjy/ICRcr20JFxDYHFKNro9NgmHt+cjomK7Sxh0bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HC6JqTZoLGYzLNlbEaEArt/3jqIfYYNpjOE6wVO02tDEthM9jDoE8nXT5CBuqcdbaESxEzBq05LZF1xi9mF1xHIpEEn3uolEQ705IpxuAAzUw0SkAjg4Hrz22x8y6cQ4BCgWFjX4nuOJIgDsxFEIT3q6EexEOT3rBgaVvFq1qwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQ/TREI9; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ/TREI9"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50abb0c511cso182758e0c.0;
        Wed, 09 Oct 2024 23:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728541248; x=1729146048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGVU427CrfGUSs9T9zYh1JpIasHS9WJriHVK/hUIGk8=;
        b=BQ/TREI98radq5Z0F+H1513r5svb7YeojmFzR05J9nndwsxSz0xzdIINzkSFEh9YW9
         gIdZJ9yNzIe1NwTVYYHBCfaJ2txZWikgE6NaeVahRI/Q352jaOw29Hawy3Qk1bETg0sQ
         KO83BfBa6a42KHFtj5568fnhjQ5z7nYVKMlGwkA/6ve7CpsHUQErkF2QMK5rXfpCg9k5
         FQuMEaIklxOkR2W0vA8+J/I9MKaoz4JygWQS9b5+bYgM3YbUKABxOBAVUiXUJ0FXk00a
         ktpHstNbeXLdUTBOmdjz40pcGxsOQevZXlxXD+mTjEuihy9vWnlKXmwL0gO1HBG6LMmz
         BMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728541248; x=1729146048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGVU427CrfGUSs9T9zYh1JpIasHS9WJriHVK/hUIGk8=;
        b=FMweDQ9Y3SSkEKzjUVlkkt4z4zBTUYvGEA/ZqpctkqpnyY8JmO6srOKpZkMf/F3gki
         UsrNJdi1RVlCx9TT+RO9HJPo3iPLQA3dx66/46Hy/6I/MIv9YdnxYAN/0hhp75G/UNci
         Lz8IRAkNBHzra0SV/iDPEdH2t8f+9x8JTvkeROGbULCpwVO1mXwpv0h1+oZ0ldW5ASrw
         y9tHGRlzoz+vnA9R/h3/xEyiVLXylzX7+ergybuC9rBG8+AkVhI/PmDcsdT7rb4iwyBB
         Cmwx6L/P7/BHfKIn/WKmw6OzAR1bBgpdjEIQ/FivTJlIeIgeiydkdSqxFOHZ+fc5j060
         UA9w==
X-Forwarded-Encrypted: i=1; AJvYcCUA7oL6XX+f1Ma3lN4ZzIbxYawEshoO24K7a+VkQwbXHBMoB99AZqq44uQYWZ9XU+JvUAf++rha5cBU@vger.kernel.org, AJvYcCWgExaSfxcRdlt4XURlhEOfqNutCbRyLY7BvV6gatHTVYsTS1vSFd6boydEsg4EN6GEpyXOWKyQ8YWiIT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym44OJdWxQUQZce3XV8gaAAdGD3wUFD161rfhGlAISibeWutmS
	2/5PARK9Jns1WH/6QjodrSpS5zWTtVCHNmM3VhWc5IV6SHHAN037s4pWVVRyT4bj88nXuo5Ldr+
	rIDCMFZWZdmlaOK8Hrvb6+6aS+rE=
X-Google-Smtp-Source: AGHT+IEt8hsG4lkLsNTH2fFPvHelYXZC61aPhg8KN5x7d3CTCt0KM9Jf3DkVxsBU5f8wJHl8FYvHBv8kT8B1KifFUXc=
X-Received: by 2002:a05:6122:311d:b0:4f6:aa3e:aa4c with SMTP id
 71dfb90a1353d-50cf089b3e5mr3984546e0c.3.1728541248017; Wed, 09 Oct 2024
 23:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913102836.6144-1-victorshihgli@gmail.com> <CAPDyKFoHrRGYkNCu0ev8iF6e8tQV7cbTAxm9jS0CCqvizmoWmw@mail.gmail.com>
In-Reply-To: <CAPDyKFoHrRGYkNCu0ev8iF6e8tQV7cbTAxm9jS0CCqvizmoWmw@mail.gmail.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Thu, 10 Oct 2024 14:20:38 +0800
Message-ID: <CAK00qKAUg5VFkxbrYUeFjRq+3UN2dcOZ0RJFDK2e3tCxKOJNLQ@mail.gmail.com>
Subject: Re: [PATCH V22 00/22] Add support UHS-II for GL9755 and GL9767
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:34=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Fri, 13 Sept 2024 at 12:28, Victor Shih <victorshihgli@gmail.com> wrot=
e:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 and GL9767
> > UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> >   Sequence[2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
> >   [2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
> >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> >   Setting Register Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy
> >   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.=
1
> >   Packet Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#7:  for core
> > patch#8-#20: for sdhci
> > patch#21:    for GL9755
> > patch#22:    for GL9767
>
> Patch 1 -> 6 applied for next, with some minor updates to patch2.
>
> Patch 7 needs some more work, I will comment on that separately.
>
> I am okay with patch 8 -> 22, but since there will be a re-spin for a
> new version, perhaps you can run a new round of checkpatch.pl to see
> if some of the warning that it reports can be fixed too.
>
> [...]
>
> Kind regards
> Uffe

Hi, Ulf

I really appreciate your reply and I will resend the new series of
patches before the end of next week.
Do I need to include patch 1 to patch 6 when re-sending the new series
of patches?
Or should patch 7 to patch 22 be sufficient?

Thanks, Victor Shih
