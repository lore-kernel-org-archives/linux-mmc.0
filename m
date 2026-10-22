Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792654701;
	b=yKoIVW2vVy5jNpbwxbPTAVgVt8zCDDByCvwW9w63ZaNtu8afoipuegqPbTrbYKuDN/oE
	 z0oWWCTiljGKwS2aTjhUtdrbEOJ+ZYOGIBNmfJIwJ7inshL93AndJnI6wkOor3pClSr+C
	 lWTyxEb3yHjvA57GCK6hgX73eb2ZlIEickV+1OFqV/NefOni1wlydFCP6WozEbfc2TS7O
	 +mNrgrb+oH9XVCHNm/kN6zDEBKhE27mUGRIc7b6Fh+2ha+oRwveqqN/kKwPiamn4YFVmH
	 1uQFVqLNcp9xUcSo1o7avs55J+YeCAfEF5QMhNhLPCoDnsuCjNss8gS1ZZ4/rGu9HeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792654701;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=WnoNYrh8MOVI5Naq9oKQorrqR4sbrLyiz7U4v4AXZCE=;
	b=Y/GX5mSxhJg7Nz7NtlKg6YYPyaN6JLUFZJToavX9xOKsH5ha6vsKwCiaDsNbsL4sgJbe
	 GaXluXQEoqBjjsNhq2y6p4APOLj8SewiB5mVAzXct3ZbxUjZgiiRQlN8ui0G7Qdw8FHNi
	 CzVeD/5n91TQcUqg51ZyTfCRfYH6G/DnxzDP5Jc4C6aD3ePyEqXf8mr/fyAGaJQqn7hLP
	 NtSpe2NUHp91QelASG3mfyEZT97pO3eVD4h+AytUMYztN8HMezYGSBEKyHU/P04F1ltwR
	 pw1VRipMNYVAveU2eVDE0zQBqMjHhilMRp6QRlIHFrVds7WxYzky97doXQ1uHKv6jyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=ZEyUwzAR;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B548606A319;
	Thu, 22 Oct 2026 07:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B548606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=ZEyUwzAR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=WnoNYrh8MOVI5Naq9oKQorrqR4sbrLyiz7U4v4AXZCE=; b=ZEyUwzARHz47EcN8uXbOF0XTuA
	GafSTJMtAMhaWxo68Ky2tAuyNcvr5wuHLp8DWusSyEJVmh5AFDovAInOT1dY1KEDOlvC1A+UBRk9w
	c86FDr9qwHhzcU4JXi/b8SLVWkNRJ2YbVw5O+njeSXd/qp1DU3BTOvxsrYgOinZ/lCArbUsoLJ6n2
	Yzliopu+QLaQ9xrLhbOKATH2R+ktrtbbROzUojDub+NX/69SzMzD0z8EdcRxG5hXIarq8FuTcODk9
	uD2WKRfkLekwmmOazjrVXJc3PUNDowJ5qiFv980+1WoJKn+E6fL/lLBl7FHHwea54zuBJuYW388Pz
	ZdsNgirw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Elaine Zhang <zhangqing@rock-chips.com>, Cunhao Lu <1579567540@qq.com>
Cc: linux-clk <linux-clk@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mfd <mfd@lists.linux.dev>,
 linux-gpio <linux-gpio@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>,
 linux-serial <linux-serial@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 linux-stm32 <linux-stm32@st-md-mailman.stormreply.com>,
 linux-phy <linux-phy@lists.infradead.org>,
 linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 07/27] clk: rockchip: Add RK3572 clock and reset support
Date: Thu, 22 Oct 2026 09:38:06 +0200
Message-ID: <2117228.PIDvDuAF1L@diego>
In-Reply-To: <tencent_791C8CE4050020CEF9E536C9D3B4CA9C250A@qq.com>
References:
 <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <2339330.72vocr9iq0@diego>
 <tencent_791C8CE4050020CEF9E536C9D3B4CA9C250A@qq.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Donnerstag, 22. Oktober 2026, 08:09:02 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Cunhao Lu:
> Hi Heiko,
>=20
> > As you didn't write this driver on your own and even kept the original
> > author, please also credit the original author in the commit itself.
> >
> > This can be done for example with something like
> > git commit --amend --author=3D"Elaine Zhang <zhangqing@rock-chips.com>"
> > and in the commit also have both signed-offs-by, aka Elaine first
> > then yours below as the submitter, i.e. like
> >
> > +++++++++++
> > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > [document what changes you did inside the brackets]
> > Signed-off-by: Cunhao Lu <1579567540@qq.com>
> > +++++++++++
> >
> > The same applies to all commits coming from the Rockchip vendor kernel.
>=20
> Thanks for pointing this out, and sorry for missing the commit authorship.
>=20
> I'll review all patches and add the original authors' names where necessa=
ry.
> However, because the BSP I received does not include Git commit history, =
I can
> only identify them from the names noted in the file headers.

Rockchip has published a development branch based on 6.12 on github [0] .
This includes this clock driver [1] and most likely all the other parts as =
well.
You can use this to cross-reference.

If there are multiple authors changing the rk3572-specific parts of a file,
please use the first patch author from that history for your patch, as we
don't want to replicate the development history from that vendor kernel
tree.


Thanks
Heiko

[0] https://github.com/rockchip-linux/kernel/tree/develop-6.12
[1] https://github.com/rockchip-linux/kernel/blob/develop-6.12/drivers/clk/=
rockchip/clk-rk3572.c


