Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE41A706E
	for <linux-mmc@vger.kernel.org>; Thu,  3 Oct 2024 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971974; cv=none; b=K6j0WMlrSOfpmGHLrAv2+MhiN2B79/epS5Qy3iJJDGJ99jSx0HlXnxUjHnF6q3bGL2osuZjLoBD9fluag1u19XGhTOqi6SnqBvQM0T1fmi5V7CTB+ACPSbZn5vBzku9Iz3a8Nd9B0anPyxUGXuXmfAUPXwy1j0ZdYelBhWr5vQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971974; c=relaxed/simple;
	bh=GcXwkHgM9OrxvHiAzOCcbAr+s/g33IlRvMgQQ25Rj6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITsq7kxqZM8yD2C/wq0XFC68p1vBASvC/+5GOHLukBWV7w9ipd8BvzT6QIDN1kgVzJfb+JZJKxEGuWiFOmCpQ1jIAf8a16uuGVeIYWfZ4VieAnmrVTIZbz1EGDx9F+BWjzPrDxXqam9iYHuW1XlOslTnixnH4WrEzb6NeNG2PuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w4q5NAqA; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w4q5NAqA"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e232e260c2so9905107b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 03 Oct 2024 09:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727971972; x=1728576772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GcXwkHgM9OrxvHiAzOCcbAr+s/g33IlRvMgQQ25Rj6o=;
        b=w4q5NAqAyVEfEX1uymZZIC0KbSTz5IoAXPeooMD0yizUf+W9MGew2HtONO+v5nTnAl
         7+Wr/G5Nck64dI3o74a6u8dYDctWfBd9MG+X1QNd21pag7Yc7o6WXSdZix3JCT1T2NEj
         z/V5bjJvzZjAYMoALuRNLQKiqkSaaPhNOEFyPuxhhhxwTnGmcOCvnpuQOqDZa0ts1/vE
         iA0WA4sMzGiWNWa/1c5hnoPlVz5bWbePMuxFZmOlb7FGVAqIFghdX3zeoWOTiW9a7xQ9
         tIKPcUlQ+M3cIOoT2rsdB70640TVdPKZ3oAT+Xgnv54fi1C9vRUSIPQIzQ7iM7spAHch
         LdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727971972; x=1728576772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcXwkHgM9OrxvHiAzOCcbAr+s/g33IlRvMgQQ25Rj6o=;
        b=JrO0Hg7rq9JRO4YYri6xRE+AKoJQKiyCCHtXyCuTHo7TMeBONU6ed0kzlbb9maNCRU
         z5N8EbOabBGhAVQfG/CVvEJ3A5NSi8U9K4vSN5Z6vjzAGFzG094w41PrbYfcMxcynZxD
         82/qBUplmEJZN1P/s5S4z11WYQRCL1drNQ+U9u3kRSrf7oZDWifa2vC5cQt+ui4yv8OI
         h82tdRgW3cmkYFIFTvD6HPaTqUOqF0we1kfsHYQDpHs6xv+wNBzuLIQ2lnay08HiNRcr
         x7fWQd7ENM78+kAVcI5azRxcm58qP2TLQK/JSGN1HYF3+o6tW2HITSPaUXUGdRyRO67X
         Z+Xw==
X-Forwarded-Encrypted: i=1; AJvYcCW5AFtt9Q/ytf+JYveyjljbdyZTuQzagNvx0YKhrNhnWOqbNzEaBPQJa7NheAFSUWun0qNz9HmJyoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz/TMKZzVAxnff1ayHnmu4AGLY94gcsmo+wXXtNAchC+ZjxYJu
	XpfPeTjVpbYdk9gqUOLAlBmGJAx3m0XegAtK+R4eurBgn4zzse7ZzamFFG1FwpE+S9jUe/F5/iC
	ewTEbfVhItY2FTER4aWmu+A1miz/n0/LjAopZeb7u08NzoZbc
X-Google-Smtp-Source: AGHT+IGao64dalgUO859dv5RXcVquiNMoH+IHutEVxmWuOJgxU4+FWinUOPcmzCG2rCbOOQgWMhAvhJw8FK5xxMi3f0=
X-Received: by 2002:a05:690c:f86:b0:6e2:ad08:48fc with SMTP id
 00721157ae682-6e2ad08692fmr49097517b3.4.1727971971857; Thu, 03 Oct 2024
 09:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908102018.3711527-1-avri.altman@wdc.com> <e157fc58-a571-4e57-b885-e011b7abdf28@intel.com>
 <DM6PR04MB65757BAB092322ACCE642A6DFC9A2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAPDyKFqJaAob7xceSkNe3aNogT55OoY5WRdPsFs450Sy3GhM2g@mail.gmail.com>
 <DM6PR04MB6575AE090B4E4F14DAE2A209FC682@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB6575428FD40ED3CF919AB302FC772@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575428FD40ED3CF919AB302FC772@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Oct 2024 18:12:15 +0200
Message-ID: <CAPDyKFp940xfWk=pVb-UOex6LwOrut7pxBm80yPda11D+u4-Fw@mail.gmail.com>
Subject: Re: [PATCH v7 00/10] Add SDUC Support
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ricky WU <ricky_wu@realtek.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Christian Loehle <christian.loehle@arm.com>, 
	Michael Wu <michael@allwinnertech.com>, Wenchao Chen <wenchao.chen@unisoc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Oct 2024 at 09:03, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > > > Ulf,
> > > > Am I expected to do something more?
> > >
> > > No, I just need some more time to review this, sorry.
> > >
> > > I am also heading to LPC next week, so hopefully I will get to review
> > > the series before that...
> > A gentle ping.
> Another one.

Thanks for pinging and my apologies for the long delay!

I have looked through the series and provided you with a few comments,
mostly very minor things. That said, I have no further comments and
will be awaiting a new and final version from you that I can apply.

Kind regards
Uffe
