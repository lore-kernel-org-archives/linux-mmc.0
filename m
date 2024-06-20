Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2841B14E9
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902134; cv=none; b=UPgnRYx4+aFnUJjfZ0IWZEWMR7HeGG9w1r1MpUFf6Frt/Lacbvi562StMyabkISMCMt2myhdc76FfT2Z242ESjj0yEVmDw8ZmadZxtzZRo49SJm5xfkaCYwopo9PTaWre9IzPrkf5+2LkGrpt7zTGjRC3Qm9LLF9PS2tgAqP5js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902134; c=relaxed/simple;
	bh=I7bOX4EPhYhRhKtXtPFBbh3iyAf1FydrXmebYqkFK6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZtvxkK/ilTOPun+j1U4Jn2KyvU99v8R4r3fPugHC4xrJkzHtrQG92mm93Nl0a+DFyYKkND/RiPNM8gSgd+vcX34E7cRFYGBezGgd4CaFXJjKVt41zVE/lqkmKIQO24A1ac5AKubIKquB0diIYfS1pL6Kc/y0vMHOyQwEmngAQPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=VqhNF8fe; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="VqhNF8fe"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f13dddf7eso138709066b.0
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 09:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1718902131; x=1719506931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuhHefUUm8pKU0wU1bUqlDeM6RQmXXcb16LWkj1LV2I=;
        b=VqhNF8feN//OkfO3/l7TPUb5k3KCWynna7Y2HeJvaRvDdKlZBKsN64C7HTUZ3vleVK
         uBHV+bhDJQ8FOJR5gZYjTs2WkF6hlt1moB9Xdq5uE0LL2WMqVXwDt8p3jTnEjgXpM5o6
         E1LTEh+UiwCoXJxmsQCtfgiQSQz0407YOlUXZ6obAf8sdMfIN6cpiqyncOFK/LjqO/Th
         J/KKEmRNpdwTOF7vQTV9GMI86/danh3LhPlCs1w2Irw7d03zzqp5aGbEjt73Fp8lcvPC
         jIeeV+s48icfMCAjnVyYMO4oZY33J3EQ6MjyW1A1EZjrgRoP4C5ehCNtRxYmj3fajs+p
         cT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718902131; x=1719506931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuhHefUUm8pKU0wU1bUqlDeM6RQmXXcb16LWkj1LV2I=;
        b=gulSJ/A3HyusYSx1qv9DF+AFkngKk9sAIC1O9P5TcMSNtYg+E/zesoB4NMh2v+Jsdh
         NoxP9dBKh1teayOzK2RvTH09Eh3yQi3XfWN2Ya0H1CnO4OCnbRYSJZj7Z9MXdI0Jg2rI
         1ey8argodmvT1HhHfOGA4Kmssz0LUTpQokMmH8mHaUriyz2Hj6jfy13DjprkKIOq/M77
         4EgHu50nK9ufbSSUMlR+BbyvZ17LdPqo043sxtUG7GrPCLRYkzIApsHIj+bSQJPHixpV
         GM9EaDanT27EsjFLvzNNaTAV703LABqoum+wAKQ4yXBDXhE3NTHWUPBfLkLg5UGyvejL
         468Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTfDhHNrxkUc14DZpO+NezTyl6v8dZNT0lkInUPUgQ50s8M2mUoS1ZKA0nvl8Mwe/j4se6JaCdGTlI6Cr92tiD6Kv5Mr7uF10w
X-Gm-Message-State: AOJu0YwXl0OLOLk/wTNNRjwxiVdNcK5NaBNeM7TMAIuF5gLGgT43WLVV
	uQqW1Yqn2zewO0t0RTTAKd3jIOoXaSpT3oA4B/xyi6GgEo9nlYYwcYH72FN135jPYOUwGVHDTwC
	P6VfFh+vWjcVHG1ZJMSKll4nTU+pE7vD2lGExeg==
X-Google-Smtp-Source: AGHT+IG/YK7lCt/BhcYSZJheGqmGA5MS3LJSB5zbfU3GsHzHNMnXHdJ0e3ycqdy65ry9myQB87RSiQ16uckmuWjxbas=
X-Received: by 2002:a17:907:8b9b:b0:a6f:b67d:959c with SMTP id
 a640c23a62f3a-a6fb67d9833mr263523266b.10.1718902130320; Thu, 20 Jun 2024
 09:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ+vNU3Ns0RVtROcChGAhfO=XbpnzwQv1SehexbgHX6ST6-Piw@mail.gmail.com>
 <e0f38bc9-bcc2-4476-a5d4-4f2efaebc0c1@arm.com> <CAJ+vNU0jiVb4caYeQ5HYKZ-dqxcdG1K5pPisJZpfL4q7Sc3zvA@mail.gmail.com>
 <50bfdbf9-2ab0-4111-bf2e-abe4c9ed86fb@arm.com> <D1R2ZW5Q12QQ.OU52AZIYS68O@walle.cc>
In-Reply-To: <D1R2ZW5Q12QQ.OU52AZIYS68O@walle.cc>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 20 Jun 2024 09:48:38 -0700
Message-ID: <CAJ+vNU2zu5jwr_jScDN3Xs9-PV0yKyPVqOLBK504i79veAu+Lw@mail.gmail.com>
Subject: Re: obscure microsd detection issue between U-Boot and kernel
To: Michael Walle <michael@walle.cc>, Christian Loehle <christian.loehle@arm.com>
Cc: u-boot <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Linux MMC List <linux-mmc@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 1:14=E2=80=AFAM Michael Walle <michael@walle.cc> wro=
te:
>
> On Tue Jun 4, 2024 at 9:47 AM CEST, Christian Loehle wrote:
> > On 6/3/24 22:28, Tim Harvey wrote:
> > > On Mon, Jun 3, 2024 at 1:18=E2=80=AFAM Christian Loehle
> > > <christian.loehle@arm.com> wrote:
> > >>
> > >> On 5/31/24 21:47, Tim Harvey wrote:
> > >>> Greetings,
> > >>>
> > >>> I'm seeing an issue on an imx8mm board (imx8mm-venice-gw73xx) where
> > >>> for a specific set of microsd cards if I have accessed the microsd =
in
> > >>> U-Boot with UHS/1.8V the kernel will not recognize that microsd whe=
n
> > >>> scanning.
> > >>>
> > >>> The issue does not occur with all microsd cards but seems to appear
> > >>> with a large sample size of a specific card/model (Kingston SDC32 3=
2GB
> > >>> SDR104 card). I do not see a signal integrity issue on the scope.
> > >>>
> > >>> Instrumenting the kernel the issue is that the host reports a CRC
> > >>> error as soon as the first mmc_send_if_cond call which occurs in
> > >>> mmc_rescan_try_freq.
> > >>>
> > >>> I can avoid the issue by either not accessing the microsd in U-Boot=
 or
> > >>> by disabling UHS/1.8V mode in U-Boot therefore what I think is
> > >>> happening is that U-Boot leaves the card in UHS/1.8V signalling mod=
e
> > >>> and when the kernel scans it sets the voltage back to 3.3V
> > >>> standard/default and default timings then issues its clock cycles t=
o
> > >>> 'reset' the card and the card does not recognize the reset. I'm
> > >>> wondering if this is because the reset is done via clock cycles aft=
er
> > >>> the kernel has set the I/O voltage back to 3.3V when perhaps the ca=
rd
> > >>> is still in 1.8V mode (although I don't see how that would cause an
> > >>> issue)?
> > >>
> > >> It will cause an issue for many cards and might break some cards.
> > >>
> > >>>
> > >>> Is there some sort of MMC 'reset' I can/should do in U-Boot before
> > >>> booting the kernel? Has anyone encountered anything like this befor=
e?
> > >>
> > >> There is no 'switching back' to 3.3V signalling from UHS 1.8V.
> > >> The only way this can be done is therefore a full power-off.
> > >> Is that done correctly for your system?
> > >> AFAIR spec dictates 500ms of <0.5V on VCC. Note that  driving CLK/si=
gnal
> > >> lines can also sustain the card somewhat, as leakage is only limited
> > >> within operating voltage.
> > >
> > > Hi Christian,
> > >
> > > Are you saying the only way to properly reset from 1.8V is to have a
> > > VDD supply on the microSD card that can be turned off before booting
> > > to Linux? We have never had that before and never encountered
> > > something like this.
> >
> > Yes, the only safe way to use UHS-I really anyway.
>
> I can second that. And also keep in mind that the actual supply
> voltage must be below that threshold. Thus, the power-off time also
> depends on the capacitance on that supply line after the power load
> switch. There are switches with dedicated output discharge circuits
> built-in.
>
> That being said, from my experience there are cards which will work
> when switching back from 1V8 to 3V3 signalling and some don't. I
> haven't digged deeper into that topic, though.
>
> -michael
>
> > You could disable UHS for u-boot but that still leaves (potentially)
> > problematic warm-reboots of the board.
> > Having a (software-controlled) switchable regulator on SD VCC is pretty
> > common for this reason and you should be able to find it in most dts
> > for host controllers with sd-uhs-* property.
> > I'm afraid that the relevant spec section isn't available in the
> > simplified version.
> >
> > Kind Regards,
> > Christian
>

Thanks for both of your responses here!

I have a situation where I can re-create a problem switching from 1.8V
back to 3.3V with a specific card on a board that has ESD protection
between the IMX8MM host and the microSD connector (Semtech
ECLAMP2410P.TCT [1]) but works just fine on a previous revision of
that same PCB that does not have the ESD protection added. Boards with
proper ESD protection are the first time I've seen this issue occur.
Does this make sense at all?

I believe that the MMC device is 'reset' via a series of CLK cycles
with CMD/DAT non-asserted so I'm having a difficult time understanding
how this wouldn't work if the host has been reset to 3.3V.

Best Regards,

Tim
[1] https://www.semtech.com/products/circuit-protection/esd-emi-filter-devi=
ces/eclamp2410p
