Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006478;
	b=mbTsoIMMRVklHECwSS+5heoK9kS2KHhK/j196svAGt4IzOHJ19umc0za5F8uEHtCEt+o
	 tiOiXjajymc91FoGY2ECVnpSImfqhGsL5ZEta5l6w8a1ZotLkprTnrXz9OF8MD2eRRmlS
	 xCoDp+500BhRoNiAjxflo8cmnsDrx3YokUJ4YZi2nyBdGNC9Dh4nj347GDC5pIJj/AkKH
	 imfX0xdkT8fvDD8WtWxokHlPjnjoIJGjP9CNMYEuPjFMxyCARutgA09h7itguOOt7qCBw
	 v3BrMgsvk/0H2D2mEdN2gIQB5wg0ch01CLYMC5fnS23mbKagZ00mAiZswjscg/Sb86A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006478;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+gyzgNhPsylvP06vZq5Elrbi2P3u4np1Q6XcqS10pRQ=;
	b=WxxWaWLGO7AhpiqDKvUMoNp46nvKIIDoz+C8csZmo97LSeI45TMPCUc79qeJteheadlK
	 zic1cam7WFuakkBF/DZ4U5pAEtnoVB2oAEK5a/cyh7X8TMgRMTw+YbgPSfNGR657yHqjh
	 TlksjwgV8GTrj+70N3YFBcZNzMeU3ULPrHFwD2DrM2c4D2CWmadVCciGPG11wJo6bhpXb
	 kqAdTY8WML8xoiBjbGj1vSTsz0gxIA0g6Dj0gqwK1ZBrK8yNZqgkiOUbFord0InN7j0h5
	 URbl/zxDFRrrYsHzAwa0pCXw1WczAKOV1EotUYoAgPTfUyWx2v1pJC4hpcij7H0EODg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=A+qPZ9qe;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981E4606A32C;
	Fri,  6 Nov 2026 23:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 981E4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=A+qPZ9qe
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE1B11650;
	Fri,  6 Nov 2026 15:07:53 -0800 (PST)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D216E3F632;
	Fri,  6 Nov 2026 15:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794006476; bh=RJP+8WlqG/AN8bbXr0dcvH9Qfm+ONJlgtpsBrXaYgLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A+qPZ9qeYrog5H0PV6WbMfxCMDh5jvpniOk24HubukGL/m5QIsiHJKgayOMaz+FGW
	 Kalpy6nnQROAErDm9Zk63zkruft/Zrg7oBdens2LnteHYp03qOBaDC4va0axjK3OJc
	 OGBxNk0eVUlHwUlF/0U98vTxcm2KOfheIRTFd85U=
Date: Sat, 7 Nov 2026 00:07:45 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Enzo Adriano <enzo.adriano.code@gmail.com>
Cc: krzk@kernel.org, Ulf Hansson <ulfh@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Maxime
 Ripard <mripard@kernel.org>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, Junhui Liu
 <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH] dt-bindings: mmc: describe the Allwinner A733 eMMC
 controller
Message-ID: <20261107000745.45b349d1@ryzen.lan>
In-Reply-To: <20261103-a733-mmc3-withdraw-reply@gmail.com>
References: <20261031020640-263f7b05-a7s-mmc-binding@gmail.com>
	<20261102-steady-grateful-chimera-e2363a@quoll>
	<20261103-a733-mmc3-withdraw-reply@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  2 Nov 2026 19:41:55 -0500
Enzo Adriano <enzo.adriano.code@gmail.com> wrote:

Hi,

> Hi Krzysztof,
>=20
> On Mon, Nov 02, 2026 at 08:27:19AM +0100, Krzysztof Kozlowski wrote:
> > On Fri, Oct 30, 2026 at 10:26:47PM -0400, Enzo Adriano wrote:
> >> AI assistance: Codex:gpt-6-astra.
> >
> > Drop, we do not advertise slop companies anymore.
> >
> >>
> >> Assisted-by: LLM
> > Drop
>=20
> Will do, here and in my other patches.
>=20
> >> This binding is a separate prerequisite for the disabled MMC3 node in
> >
> > How this can be a separate prerequisite? Binding without user is not a
> > prerequisite.
>=20
> You're right, it isn't. It should not have been posted apart from its
> user.
>=20
> >> the A733 DT v2. It does not add a sunxi-mmc driver match or claim an
> >> operational eMMC path.
> >
> > Hm? Why?
>=20
> Because I can't test one. None of my three Cubie A7S boards detects an
> eMMC, and their vendor device trees leave this controller disabled.
>=20
> [...]
>=20
> >> prerequisite-patch-id: 6fc03bfbd343042dd3b660938fcc09c5e7d48314
> >
> > So this cannot really be tested.
>=20
> Agreed. Those IDs came from my local tree and are no use to anyone else.
>=20
> I'm withdrawing this patch. Andr=C3=A9, you asked for the other MMC
> controllers because the IP is the same, but the manual documents a
> different descriptor layout for SMHC3 (A733 User Manual v1.00, tables
> 11-3 to 11-6), and I have no hardware to test it on. The next DT
> revision will describe MMC0-2 and leave SMHC3 out until someone can test
> driver support. If either of you would rather have it described now,
> tell me and I'll put it back, in the same series as its user.

Well, I was merely asking to list all instances that are the same. That
one MMC controller is using a different IP is new, so I wasn't aware of
that.
And we don't submit bindings for something that has no driver and
hasn't been tested. We have been bitten by subtle mistakes in the past,
which lead to broken bindings, so just wait until we have some user for
that. Adding to a binding and DT is always fine to do later.

Cheers,
Andre


>=20
> Sorry for the noise.
>=20
> Best regards,
> Enzo
>=20

