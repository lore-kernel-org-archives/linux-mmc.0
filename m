Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8048A1FDF9D
	for <linux-mmc@vger.kernel.org>; Thu, 24 Oct 2024 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779550; cv=pass; b=IG9tpVbp6QMByGFpCc6rwcsS6WDr2ZaLRjeDZxJHX5WSqjFmv1IwtGLqRyUbduYpSZ6yV55i/xBQXvBpUXJl4GIeCRIBL/JV6Lijez48lppSCy+bbm6yEJ0wq0kBn3WWBPHmqH5vsE9pZOAUtUY2aGx4Ou9mr929ZaVi0AsPJic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779550; c=relaxed/simple;
	bh=ux/eVMc3yvVSmwqXKQqYBjixW0ioZO4elH8hFaAIVUM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rLfTuoxeE7LougGuIClkq58jOO9DS0RUq1XwJTiOLTj8OVU9qFhFQfAnxOU0kwb5kgCGz5bZjXXX2NMGMf7hesajI9Ra+x5KLCg+nKG15Cgq7h6a+rL+iCQuc5UE/BJdPuox4vOTiukeSJ62GTC++F4ar0hCYw4r+gDjlux7FlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=S2IEFPY+; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=QD1hqlLJ; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="S2IEFPY+";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="QD1hqlLJ"
ARC-Seal: i=1; a=rsa-sha256; t=1729779535; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kPZRo+O9Oi/f4hPre7pgNN2xwodDbDLTjEbFdNCrqtP/4vFmhKfqd/3Qcz95s+kqvL
    h5WUX5YenHDS8XOf3Thy1uQ7K14fNi2+C5I3ckFgKyn3l61McPM6pahbIHvyT7dy+kYB
    hg3Mr0zcwj3kyK8LwYkOCgYdhb+5wUaItjh94BIRCmja87WXCXLOE9bRonAuBycuxlAm
    SnDIrvZx0STFN5gQJpaVDu0DRllmz4zOCbanjwSclO+mkxKQbJFQx1lzkST27bC2qKLN
    jnHr/vGg+/x9Fb0a7Yy6GKNCUWdCUxfjXj7ZP6GTdVPIOh0j9rfuK/8KQtwnjh1lOie5
    5uQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729779535;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ux/eVMc3yvVSmwqXKQqYBjixW0ioZO4elH8hFaAIVUM=;
    b=eFbQedL2fIr6YrD51XpBE0lGoZi62BRf/HmJd28t5qWeeJhL6+mC8coJFdWzXY8lqa
    Ldj9P0ablcUuJKE+Ddthn12wUqoSbmzJ6OJsz5u91u5qnPViNilYalpiVT/u9wmF4BZc
    /AtYNGdgxrWUY7eV5oVd3xWuQQO0+g2UjUc9AYwvob+XRXmtRNLfs4alt2WHZv6eEpIb
    2nUxUetOrrKUA/fD1w0NcoSb9z1tWsrwLQZzxHRufkiPWZVIWVlvpJ7m2iTRSDWCsM+d
    8bR2ugWLYmqPChklBRzHQe0uCDn8U/J2c4+4jhLbXbjwmM9PKEmJoju0d7Zf1hyqiXiz
    ATgA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729779535;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ux/eVMc3yvVSmwqXKQqYBjixW0ioZO4elH8hFaAIVUM=;
    b=S2IEFPY+UIl7Qzq3NVugPMSmyM9jwLGeMt14jp+cSbRUX6ROffkgPu5qSTZySz+V2J
    4RS20kfHYB3AkOevQONw0KUEXjgzQYbNssmBAQPjX56eoTziyjOOyEVr8mQqum8hM20N
    OxOknFeBewCbVH61Jn7xpAYQ2zEvA1PVLb1/5TC50RSm7BcYo5InGyYuD7qzP0dXRhBe
    VtPbJVnuaBv0LFWrlJr6iIN3PD+JlM/C0HkHACrgAtfukFn012mCNK+qMCo+uO6Y7NM8
    e24zN0qBRccSlsDC/hZpGxt4blXy4aEUcjwe83DKsi8mtEIZwC62UB5UE2qgkjG41ZUw
    mzXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729779535;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ux/eVMc3yvVSmwqXKQqYBjixW0ioZO4elH8hFaAIVUM=;
    b=QD1hqlLJUrEfnkWHn8ybHoencbeA3lX7au8caIm5/Q6ByIbVExz5tlnsZ9l7Nx/AB8
    60jhYKHe5IfAEbDrjjBQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSe9tgBDSDt0V0DBslXBtZUxPOub3IZik"
Received: from [10.176.235.56]
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209OEIsXht
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 24 Oct 2024 16:18:54 +0200 (CEST)
Message-ID: <11ab9fb918d7ceb15c75560086b0b988db2ad24d.camel@iokpp.de>
Subject: Re: [PATCH v4 2/5] mmc-utils: Add FFU mode 2
From: Bean Huo <beanhuo@iokpp.de>
To: Avri Altman <Avri.Altman@wdc.com>, "ulf.hansson@linaro.org"
	 <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	 <linux-mmc@vger.kernel.org>, "vfazio@xes-inc.com" <vfazio@xes-inc.com>
Cc: Bean Huo <beanhuo@micron.com>
Date: Thu, 24 Oct 2024 16:18:54 +0200
In-Reply-To: <eccc31a9689842d711e163a2d4d8b14f97100f83.camel@iokpp.de>
References: <20241023143839.108572-1-beanhuo@iokpp.de>
	 <20241023143839.108572-3-beanhuo@iokpp.de>
	 <BL0PR04MB6564794698F1DF0223380CC0FC4E2@BL0PR04MB6564.namprd04.prod.outlook.com>
	 <eccc31a9689842d711e163a2d4d8b14f97100f83.camel@iokpp.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-24 at 11:04 +0200, Bean Huo wrote:
> On Thu, 2024-10-24 at 08:00 +0000, Avri Altman wrote:
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { do_ffu, -2,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ffu", "<image name=
> <device> [chunk-bytes]\n"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { do_ffu1, -2,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ffu1", "<image nam=
e> <device> [chunk-bytes]\n"
> > Ah, but didn't we establish that the current API should be retained
> > to act as the default mode?
> >=20
> > Thanks,
> > Avri
>=20
> Avri,=20
>=20
> Corret, the reason for updating the default FFU mode name from 'ffu'
> to
> 'ffu1' is to avoid the error: 'ERROR: in command 'ffu', 'ffu' is
> ambiguous' when using 'mmc ffu'. Without this change, the system will
> encounter ambiguity.
>=20
>=20
> I am considering a naming scheme like opt_ffu1 and opt_ffu2, that
> works
> well for maintaining consistency and keeping the names concise.
>=20
> ffu2 could become opt_ffu1 (indicating the first optimized or
> alternate
> FFU mode).
>=20
> ffu3 could become opt_ffu2.
> ffu4 could become opt_ffu3.
> ffu5 could become opt_ffu4.
>=20
> then keep default ffu name as it is used to be.
>=20
> how do you think?
>=20
>=20
>=20
> Kind regards,
> Bean

Avri,=20

how do you think about above my proposal of changing ffux to opt_ffux?

Kind regards,
Bean
