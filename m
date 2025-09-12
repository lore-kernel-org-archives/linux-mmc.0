Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BB8311C20
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689128; cv=pass; b=uMI45gWJWF4C9hlb9KFwMPV3mPosxxPcm+2elD+/eu8Y96sKjYB4yUZ2v8c7yfxOG+TTDYodOm2hUPp9enHbT4ddmZCOIEuXwTgFn1ukON1hQ75kLvMz31W6E4ScS6LeL7V3Pyy+O1QagpEbD6NBvnuj0sWG4osdAgUI2Jcf1c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689128; c=relaxed/simple;
	bh=+G04sv0+/mypPCwoJJcqpFm4Y1wH16iEgKgNOty7qmE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WM7nfjT5yPAmVAL/ubTPG8K1IvJ1zc0RcZcpmovT3H3NkOdiOdq9Cp78l7AEKQP6b2MXk86DZacWAGeWik0IXfbJsDEIEmZ6cs2GoacfHyKoFqTc6vXkhyVV6ZUxc1b3oCHdelJbDUrRRh7uw0uUqxDjMAerE1Rrt53Brl8arKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=J4gEr48P; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=zua0LIZq; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="J4gEr48P";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="zua0LIZq"
ARC-Seal: i=1; a=rsa-sha256; t=1757689114; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JFfEWhpMfPJ2FfKC8HvGhe6uJRcIuna0wvD9YqDDYJOWB5vrWUKMJk0CHoGjlXADTW
    MLxi7lb1VnMolQojschsh7hnKUX87agkwMsc0jMKnThApEEfws15WHljHkcDgRWUK2VT
    KPM2N7LOcCL+tMaOEHP+HGmz7Xw/b+zusqGODnU3skNLVafb/wQZ0lY9qyjY6ot6zPlb
    2pWVc6MGZs+ay5572f2FPcEIC4Z4gBuDzNSbeDqbRAEgsOZh8J+RxfxaQDuEdCX9Ac3I
    JvROnqEeuS7HQpCGCwgaqmoDRx9z7UqfLE83ZicaOD3UzWuEEGzBBv69YS39SuEYPFDr
    Zuow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757689114;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+G04sv0+/mypPCwoJJcqpFm4Y1wH16iEgKgNOty7qmE=;
    b=UCanYse76bRKMgvwLsm7n5qVHx9gRAxXPDiNQ6dIb8uEIejuDbJsFib55jUVo32jI+
    WFk78YI6W/Q13VUrKdcL8Kym2pEhSrOIoz2EYbfxA0EZvDkXH+3bXDPrkjlakoVT97zw
    V87oGlAgzZJ6IlMeJZSssfaKSATFUc1WROm0A/Ti4sWODpoHnVBifCYcCCQ+GhkIwQYC
    u1GvboN0IZU3EVETDn5h6UcKvNjU9vjdM9ONK0fvcEWvkbY93mDYxmJBp5QgOsVloBeb
    awPDB5NPMcdES8TJYkGJxfzI3TMnrmHs5GZfxdejZnT63fOBdgYP1oIEgvopZ8QT1476
    pnnw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757689114;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+G04sv0+/mypPCwoJJcqpFm4Y1wH16iEgKgNOty7qmE=;
    b=J4gEr48PYK/EZXEXa4iDqicZJhu3ythgfkr1FtK9TqYW3kqwF7ggURqngZhHTNKS22
    G1xluvNhDfXEYW30tSMBNzwqaTAsqyDB1wIXbNpz/Nh0lw6D4PdH/xBz3dEoB413zAbq
    D9lvCNPvn4AXiAZYglJh9g4eWIk2MKiFr7BRFXAuyqV8JW5oRYAGgUTwdpi1DVdJbQhw
    auMpvlkKGgB+8SoHL/Xk9TAFFoDpqySU+J0Q1/X/mMy83XqBRpJWtoJGN7+D/TZB3A+C
    hgJUDp99FxXsdT9Hs5aSs/Hm3e/EUeqX2ZWJpT5eWeWaJmk+ZnaD+TgYDkfJZfGc4Z5e
    xbXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757689114;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+G04sv0+/mypPCwoJJcqpFm4Y1wH16iEgKgNOty7qmE=;
    b=zua0LIZqRbRRFLPgPP8UO9zwJMPDluhupLWIuECaYizno8dHiyPvHX9AAcPq8W7LMu
    ISStZwQkXM6BAddFOBBw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSe9tgBDSDt0V0DBslXBtZUxPOub3IZqk"
Received: from [10.176.235.211]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id z612c918CEwXlet
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 12 Sep 2025 16:58:33 +0200 (CEST)
Message-ID: <e5cd6dc08acbdec25a4452240c2484ef74005c95.camel@iokpp.de>
Subject: Re: [PATCH v3 0/2] mmc: core: RPMB code improvements
From: Bean Huo <beanhuo@iokpp.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, jens.wiklander@linaro.org, 
	Avri.Altman@sandisk.com
Date: Fri, 12 Sep 2025 16:58:32 +0200
In-Reply-To: <CAPDyKFoEVZaL_mWZMkmOWu5pa-bsSYkKes_H-wNwWdMwAjis6A@mail.gmail.com>
References: <20250911210606.446355-1-beanhuo@iokpp.de>
	 <CAPDyKFoEVZaL_mWZMkmOWu5pa-bsSYkKes_H-wNwWdMwAjis6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-12 at 15:34 +0200, Ulf Hansson wrote:
> >=20
> > =C2=A0 drivers/mmc/core/block.c | 34 ++++++++++++++++------------------
> > =C2=A0 1 file changed, 16 insertions(+), 18 deletions(-)
> >=20
> > --
> > 2.34.1
> >=20
>=20
> Applied for next, but dropping the Fixes-tag from patch 1 (it's just a
> nice improvement of the code, not really fixing an error, right?),
> thanks!
>=20
> Kind regards
> Uffe

thanks, Uffe.

kind regards,=20
Bean
