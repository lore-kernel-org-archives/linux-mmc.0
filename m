Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795218128;
	b=n2b8oCusUeKh5fIKqpzAhSITjtoEsb1Z7rfBMUTD8nSImyD21c9Bfln47SujlPkUbHX7
	 PeSIQ5UO54ih+7jNDOPj7DHGoPoMTbwAMMPPVuMxJA66x+sU1QKy4flxVzcCwe7cAjIDG
	 D0Xsk+PkgHst4O8oY3TmopPgUwTZq9htud142BiT9fc2tDZX3dtK1g4Sn5Lc8cXT7Itcx
	 PXZxGxRUW9YIePPQAzhQWp0W78fR5IgaBzGrVBVj0eLGMRPzNPByT0J1WYFlIL9d0klBo
	 2f/o7OpMOSlq3jsSSmkzKONAJ2qsG5VapoN4a3e9NBvemzdniQvtMUMvo+iHMtyxj6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795218128;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S7LC5+O0gPIzlvIYmMoL75N4NxGXX6L+XaqmXwxOvHc=;
	b=n20yuccuRqFSOlPihMqJ5J5IQI8XMy13jwOVjhc/hEKCan67+4nqnBgU2aYDg8lXy6S3
	 Ck5VJ7ee/zBkyimWbv27dscBFTO3ebCg3ZNuYX7fa2Mm5w8arVMsk1YevLbXx+NiZbeV6
	 oOtsLLpZ5Ot0rAt33kCCPC2H/3d+/76mNSUibGNwT3R+urC8ela+rqSOapwuWBwd9afCH
	 MYX4U0y0+0agr7feD2VxRP0iVSCalzWbzV6P9onUhsWw4FimY8sCSp4abAPnWEQIJccH3
	 agnLPy52K6yRdWPdVCv2FKkgUIbTmry1K5oAkS8/taOiU643ouHLKIjhxMeZ8ms3pgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RAQ67eMy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34F606A6B8
	for <linux-mmc@vger.kernel.org>; Fri, 20 Nov 2026 23:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RAQ67eMy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC311F000F2
	for <linux-mmc@vger.kernel.org>; Fri, 20 Nov 2026 23:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795218128;
	bh=S7LC5+O0gPIzlvIYmMoL75N4NxGXX6L+XaqmXwxOvHc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RAQ67eMywgE332fhYohvqo18Wweys2uYQmcIuRT/cgpjgRkkCZGCzLrgsRMXBs5f5
	 VUqLis6Ml712hYaIdPxSNb6ygNc6uQ6tRfeFZOANjY3xhmQ0azeKqiUzOvXn1Bri8I
	 6okBSGA5dtS+sXb3aLWsQBLOAnMlSUcU2ytHvuRTe9MWXPZ0NBFGlJCCdQW2XprFzH
	 dXgwGMnpDAbtMY6OYqP9IHZ78DBaxLn5X6jh4dyn6fajN8IKlZFONV++lRetea3Tyj
	 dEEWRbTt5WFixM0zRI+/QWALrMQHMbZEp7LMY/VbKIneWK0TTbacnV1ITmJhqJw0Cx
	 2rKyamYMt1ZHA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be416e603cso1081400e87.2
        for <linux-mmc@vger.kernel.org>; Fri, 20 Nov 2026 15:42:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHh/VhYsdixsXUcU8DTeZzCeXRwFqXgd0Ktq5y6gQ30JtgRyQ3ej/imD8hj5XMC9KZZJ5d/KpWe6GQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Vq4FNN6csvE1Es6I3uaX9pJ7eHybamKvcQPq5HAOWN8YCKDek
	OAWhs0ygK556h6cSMiOia0JMIq7bwZZTpTbKGYEq/zO1jIPHfWPUQs/5ueZAuYxLv6L+yOhkit+
	Vw394OmmMXCCncdKQ6cN7lpo/xQKrg8k=
X-Received: by 2002:a05:6512:b9d:b0:5be:4386:806d with SMTP id
 2adb3069b0e04-5c1bc81c57fmr1520126e87.53.1795218126802; Fri, 20 Nov 2026
 15:42:06 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119152559.3051943-1-arnd@kernel.org>
In-Reply-To: <20261119152559.3051943-1-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 21 Nov 2026 00:41:53 +0100
X-Gmail-Original-Message-ID: <CAD++jLmPShVb4AZTvCrJgfb10zu3-E3Bk0P15MjJVr-kJDdmnA@mail.gmail.com>
X-Gm-Features: Aa3M54p2CuwMy-65rVSAcUGsTlY1ZtgWyp0fU29FGMI1mNtLRSX4RLDd6N_h69c
Message-ID: <CAD++jLmPShVb4AZTvCrJgfb10zu3-E3Bk0P15MjJVr-kJDdmnA@mail.gmail.com>
Subject: Re: [PATCH] [v3] mmc: sh_mmcif: rework sg_miter handling
To: Arnd Bergmann <arnd@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulfh@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Adrian Hunter <adrian.hunter@intel.com>, Frank Li <Frank.Li@nxp.com>, 
	Runyu Xiao <runyu.xiao@seu.edu.cn>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Pan Chuang <panchuang@vivo.com>, Samarth Narang <samarth.colleges@gmail.com>, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 4:26=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This driver is the only one that uses sg_miter_next() to get a persistent
> mapping across interrupts, which prevents us from converting the internal
> kmap() to a local mapping using SG_MITER_LOCAL flag.
>
> Linus previously attempted to use atomic mappings here, which failed
> for the same reason. I gave it another try, with a mapping that is only
> active during a single sh_mmcif_mread_block()/sh_mmcif_mwrite_block() cal=
l.
>
> This is mainly a revert of the patch that fixed the command 18 timeout,
> but tries to solve the problem by updating and checking data->bytes_xfere=
d
> to keep track of when the transfer is finished.
>
> Instead of calling sg_miter_stop() on error or completion, this now
> always stops the iterator after the data transfer and restarts it during
> the following interrupt.
>
> As sashiko-bot comments, there is an inconsistency with the size of
> each transfer: The mmc core expects a transfer of size data->blksz, but
> the actual transfer is host->blocksize, which is read from a hardware
> register. To keep the behavior as close as possible to what it was before=
,
> I still advance the data->bytes_xfered and sgm->consumed values by
> the requested transfer size for single-block read/write, but advance
> them by the actually copied number of bytes for the partial transfers
> in the multi-block requests.
>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Fixes: 4d4a2c71b862 ("mmc: sh_mmcif: Advance sg_miter before reading bloc=
ks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

It looks right to me so:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
