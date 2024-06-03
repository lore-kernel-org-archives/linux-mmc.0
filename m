Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016513C3EE
	for <linux-mmc@vger.kernel.org>; Mon,  3 Jun 2024 21:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450099; cv=none; b=PoNGJtLrsT3KLQjP8lRpKzfAmLL/DadVsG07SdimO4vzvZuvGExCtweGQ2loq+E7gyvFGMuZE4uUUlIZbDqtTuoe1yJ+E32rhhX38mdh9pivkXzZDlIjhbTcKFvoV+SOkxGU+R+eZU+SqcLI5yB6yQxls+wkeVTfHUIc7R8zc1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450099; c=relaxed/simple;
	bh=8fLyUWtbTma1ooOxElnhIR98PGZOq76cay9eo5GaaXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxQ5V2pKH5d7rHUyqNsa+ep1mQKzFYK9RZYYA21/SqhPTjzk8VyutVZLAYGswsret9VsFRax4pvDO75WTFH3R4g1ckzx/d9G1tQe8ddUyipUE/YlgTHZkigD4nwgdyLDrb+tpFqsxiLI2dY8YUhQq0crA4goqRUHR2YSqkh2Yqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=axmQoOla; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="axmQoOla"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a63359aaaa6so633553266b.2
        for <linux-mmc@vger.kernel.org>; Mon, 03 Jun 2024 14:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1717450096; x=1718054896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNGROccSaNHV2d77luxoSSDnNrRRXPLIEee9PuDipVk=;
        b=axmQoOlarNCsdom+xjE43tgb+Rv3ag/+yCXK9oPNvsrDXEhJ/K1+qXnEouxIEwA9B1
         dpXZGXLiNHoHj864vxdnLJ2dTNGYPGtXV/6He8JE+7k3XGeg6Udg35i8aKkbIgkF2QHx
         2jdznnJGrXFvIUT8haPIN6ZlzlmKejbA8Nz1WqHhq+nOlKzeN1C5Gjtyxp/1ZmMCsUsi
         NNkmM2B4Z4ImMBDHY1Ycprfbs4thuiPKca0/gM5TY7C76tKJzWSFAahWUy2+khiFs7Yg
         hRuE8O/13m+E6HVgACosHJ7iV+msA7WI3pC+MptyNXWb0ptGcf2ONNbh6g9xvNHsPehI
         B/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450096; x=1718054896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNGROccSaNHV2d77luxoSSDnNrRRXPLIEee9PuDipVk=;
        b=doN4KJq4DVAl26s0pjxLXrda8WsMdt3lcYdsm0IBLfbodPbNIvGsV6PPSIvcysNqyu
         H5CJ8EHzqOItkZSsLHNXBBUZZr4gMk7NAhNe4jartGuMxcTydoM2MduN5M6AZ3aucSxy
         9WgLQbXZ8VdThN8k77XDr23s6aYY8wuA2c7Q8pLb4PHhU2omPE0YobkErmD3o97izN2i
         raK+IyGoI3hA/B7jVAtKN1yldygxyQQ7fIzKeTkiy+XeJoujNMONRbMveSt2Y+kLuA+k
         O5rnMhqg7JAaPxw4WvmA8Cs1Kes6OKD/rgzP1cZSW1ZRkRyQhWNdc3YBoqCXJpkmoLFV
         D42w==
X-Forwarded-Encrypted: i=1; AJvYcCVF/3e9xho6hfP8BX1hUIt/hf4+bj23AaPkgLA74Wn/z0gc3h+VqVjomf8A80cC7oCsmub/P1biGVarWPVf+HmEGgJRK1Aox6w5
X-Gm-Message-State: AOJu0Yw1PFkuGuxyed533/V/dsDSYN/E7Zt63Fj6ANSnLQxWMq4N7PNy
	4ylNNxysmPtGvDAXMS7pA5foCxqIO4cZRkRISxCu8WUYPD6rAMRAU6BVsSNdfKcB33eiIxgmxdL
	Vk01NSmXvETCnNi0WpMzruDr+7D9P4LXr49srag==
X-Google-Smtp-Source: AGHT+IFUpE1yAnr+EA4tOHqhgT5Hywj4u0yMIFLXvPcXn2TUAiT8DAUt4icmaeZdmRG0hV7pksCURqf7oWnVHxOA/00=
X-Received: by 2002:a17:906:f592:b0:a68:fa24:9e82 with SMTP id
 a640c23a62f3a-a68fa249ebamr378786066b.38.1717450096008; Mon, 03 Jun 2024
 14:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ+vNU3Ns0RVtROcChGAhfO=XbpnzwQv1SehexbgHX6ST6-Piw@mail.gmail.com>
 <e0f38bc9-bcc2-4476-a5d4-4f2efaebc0c1@arm.com>
In-Reply-To: <e0f38bc9-bcc2-4476-a5d4-4f2efaebc0c1@arm.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 3 Jun 2024 14:28:04 -0700
Message-ID: <CAJ+vNU0jiVb4caYeQ5HYKZ-dqxcdG1K5pPisJZpfL4q7Sc3zvA@mail.gmail.com>
Subject: Re: obscure microsd detection issue between U-Boot and kernel
To: Christian Loehle <christian.loehle@arm.com>
Cc: u-boot <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Linux MMC List <linux-mmc@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 1:18=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 5/31/24 21:47, Tim Harvey wrote:
> > Greetings,
> >
> > I'm seeing an issue on an imx8mm board (imx8mm-venice-gw73xx) where
> > for a specific set of microsd cards if I have accessed the microsd in
> > U-Boot with UHS/1.8V the kernel will not recognize that microsd when
> > scanning.
> >
> > The issue does not occur with all microsd cards but seems to appear
> > with a large sample size of a specific card/model (Kingston SDC32 32GB
> > SDR104 card). I do not see a signal integrity issue on the scope.
> >
> > Instrumenting the kernel the issue is that the host reports a CRC
> > error as soon as the first mmc_send_if_cond call which occurs in
> > mmc_rescan_try_freq.
> >
> > I can avoid the issue by either not accessing the microsd in U-Boot or
> > by disabling UHS/1.8V mode in U-Boot therefore what I think is
> > happening is that U-Boot leaves the card in UHS/1.8V signalling mode
> > and when the kernel scans it sets the voltage back to 3.3V
> > standard/default and default timings then issues its clock cycles to
> > 'reset' the card and the card does not recognize the reset. I'm
> > wondering if this is because the reset is done via clock cycles after
> > the kernel has set the I/O voltage back to 3.3V when perhaps the card
> > is still in 1.8V mode (although I don't see how that would cause an
> > issue)?
>
> It will cause an issue for many cards and might break some cards.
>
> >
> > Is there some sort of MMC 'reset' I can/should do in U-Boot before
> > booting the kernel? Has anyone encountered anything like this before?
>
> There is no 'switching back' to 3.3V signalling from UHS 1.8V.
> The only way this can be done is therefore a full power-off.
> Is that done correctly for your system?
> AFAIR spec dictates 500ms of <0.5V on VCC. Note that  driving CLK/signal
> lines can also sustain the card somewhat, as leakage is only limited
> within operating voltage.

Hi Christian,

Are you saying the only way to properly reset from 1.8V is to have a
VDD supply on the microSD card that can be turned off before booting
to Linux? We have never had that before and never encountered
something like this.

Best Regards,

Tim
