Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDDF24466B
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925571; cv=none; b=r5KhYLFPaQJLG9At+uX+NzbDtHunNu7FDllFxf8W6tXrQu8h3HBdy+HXMZ1JB0O0w7BUjEwW2OZA8u27x1vM/GxMg+EpSOJ57e8uNgRGlflvctBQnGyljDsJvUQ0lhYTh+H/2t2mB9TteT5wzNrgPwZ3Xwht6Rfnkxx9tW5asxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925571; c=relaxed/simple;
	bh=UcHmwn1TYbgAgdsr2pglxCwUR0tcKPNVHmODeLgjiHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHgR54J1pXs3trdx6dt2HSTMRlFNYy22sdk0kge9K1yoFnaUGU8Vt+LpQHRE7C/uDtlFPhXmC7D07jXdcXUcBnl3Eq9KrBL6Y59u/zf5NF5IrDiG1vP6jArTuL5hHbOGLgXzG+Q/8sBYw6SUXug2sDwqbA4TjXeASN+mpryWNqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff+w4bVK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff+w4bVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57E5C2BC86
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 16:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768925570;
	bh=UcHmwn1TYbgAgdsr2pglxCwUR0tcKPNVHmODeLgjiHY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ff+w4bVKLQzcagNup+eOFORpT1yuQKc8EkXYqtvPo2IARJNTQCqh+emWw+fG1Eidb
	 QBS91Jr4pb7iXxeZYd4SYTPQHzzOcd2c+mKPSOzWveYTDRdBGABjAE28K9M+YkUkGV
	 T+WybMSthkAohp93Zmi9Gznug5ZPEt3L4K2QcXlfr9tqeOiXyH+v7uhum6loc5/MMJ
	 ZEQy9XGKebbCN/fuEpBzqrxUqVZn9BlASSVsTd1biJUVeOBBo2SXniB+nEhP61FZaP
	 OeM9B5Ka9QE41nTYdF3p8hRtG6OksLWMwqxCVyupFY+I2aPRr8jWTEbKLrBa0c1fem
	 nME+wh7InEnfQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so966768366b.2
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 08:12:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWM9OW/WlFaOGp0RUgUOcTScm84mOKlv9vAfEmy8x6JDw2+S6laWkJxL6QhnFHvUizRrQXfPZsDYvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwj/qzES+dggPNYbAwN0zeNwK3Q7LaVg/jnvjp/s7fPqL3Gfg2
	JoIDZIg1IPwLeCAykTEH6Tcf00zzsSZPj+KePy8e4of+T7ehYnp/NG1519vWA0tJf14vC7aEyVm
	lQ7Jb1VyN2QWSv/CMtYrnxaV5xILgHg==
X-Received: by 2002:a17:907:9495:b0:b87:d664:860f with SMTP id
 a640c23a62f3a-b8800364e56mr203884366b.51.1768925569451; Tue, 20 Jan 2026
 08:12:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
 <87tswhswsp.fsf@bootlin.com> <CAL_JsqJ7_yKRTCOrxcq0QDy_MRMCRMQqhH=TKiBs=nubqNN9HA@mail.gmail.com>
 <87ikcws57d.fsf@bootlin.com>
In-Reply-To: <87ikcws57d.fsf@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 20 Jan 2026 10:12:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKQO1XjPELmfd2xStto1xFbnno5GLr7KheNcn6hZM9L5Q@mail.gmail.com>
X-Gm-Features: AZwV_Qiq51kWXEGrScowLw75flgyDCvIcgtUbbfsaaGBjWwlXhd42mhTMjoSRsk
Message-ID: <CAL_JsqKQO1XjPELmfd2xStto1xFbnno5GLr7KheNcn6hZM9L5Q@mail.gmail.com>
Subject: Re: [PATCH 00/10] dt-bindings: mtd: Partition binding fixes and restructuring
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Brian Norris <computersforpeace@gmail.com>, Kamal Dasu <kdasu.kdev@gmail.com>, 
	William Zhang <william.zhang@broadcom.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Simon Glass <sjg@chromium.org>, Linus Walleij <linusw@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marcus Folkesson <marcus.folkesson@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>, 
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 8:56=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hello,
>
> >> The series does not apply cleanly, I tried mtd/next and then
> >> v6.19-rc1. Can you please rebase it and fix the conflicts (at least 2
> >> patches fail, and then I stopped)?
> >
> > I rebased on mtd/next and sent v2. I only saw one conflict though, and
> > that was with seama.yaml. That's going to conflict with Linus' tree,
> > but the resolution is take the deleted file.
>
> I didn't see where this seama file was modified, except for Linus W.'s
> address change. Is there an -rc I need to pull? Or an immutable tag?

That's the only modification and it is in 6.19-rc2.

> Maybe this series applies on top of your next branch? I can give an ack
> for the full series if that's the case and you can take it.
>
> I generally try my best to avoid conflicts at merge.

That's not really necessary for trivial merge resolutions like this one.

Rob
