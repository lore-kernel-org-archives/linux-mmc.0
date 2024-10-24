Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F9C170A0A
	for <linux-mmc@vger.kernel.org>; Thu, 24 Oct 2024 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729760687; cv=pass; b=Vh96HSnvyvm1X4xlSbubAJ/EKQPqgeh9IqeXwaOQFCRDo7vrMWQJmdf4F25S6S5FTgkYs4xRLoVtZ5aW5DdO6fpX6xI6pu8YFmQs8xunuUWaycdTafUfxBaVLF3O7A76039Gp7iV1HHaumgP0v4mrgFxTIoPw6563lbGR9L7H1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729760687; c=relaxed/simple;
	bh=RRfDWJIOkqjPrhbh612PAoUIWzAgCuaBt5a29U417mA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HGHjoIjr9E6e7TbqyaRYiuucNM+QPK1aPffTJbAR/lHCuQdBrRcJFXFhfBuKtapvRDO+dLprh3+SJdB5AWs2Cek8wymRQEE/0UpeKudsTcNPmACgv5c+QxghrgRDQ61BEzSlOpZcle7JbFgd+ijb9jhx1pgCjc12r5rdLaF8uEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=Mqdglkn2; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=rJP8Xvju; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="Mqdglkn2";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="rJP8Xvju"
ARC-Seal: i=1; a=rsa-sha256; t=1729760677; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qG6nONkyQpGH5V5TlFJVfK1esLy7GTp6tH6sHk8TzMQVK5ams8GY7i3af4Hz0BkUg0
    Nulg2qNwglllNo4qTrH15rU2/ldPO3MsijC4jAmWc5pBDA2gLId1T81GZJ53SSlh/kd6
    yAyNp7fJZgFn48LLV+GSqGhdPaeljZRi4tklxh2kdVLdJEmttkO6bK4jwG2ac2mvQNDb
    PSwXyPq22ID+Ad1MlB111788qelQBJbq0CtxDFfI+rer6smSw8mka+yPMRsyvqpdS0bY
    oNjF0bIIzsxet0kKRC2NJXVmlINofgplytS8dt51ZRL5w+UiKUODRHuvoa1xa1JiLv2E
    MoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729760677;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RRfDWJIOkqjPrhbh612PAoUIWzAgCuaBt5a29U417mA=;
    b=MokwqXvHToALAJnHwCTuddofi86JVu63AMfZmkC2l7iKmDPqA0mxYgTP8txU2jJ3+G
    NQ2PGAn6B6hOTzESAvaHXFrBgpRnAjwamYs1IbNnBxwuL0nJHFeaPVF7zGLLk6nArcLb
    R2Tmum3Pq3AmnBSBhZT0XeBWH741WIMOrgMgPtl2IrtzOHSWwkHeswqwo5bVJhRyqjPj
    VI0hGaSsalrZZOepRpDZPZa5t7CfSTsc5RgBWH8R1ft9sTbFlvvBDLIk/TEaO1gNvReI
    sCpOgmWYWMTJEbCip7O4rNz+E73ha9HBQwphweDqlMcriP0m0HLvuFaRTt3HRWdw5QKs
    U0IQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729760677;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RRfDWJIOkqjPrhbh612PAoUIWzAgCuaBt5a29U417mA=;
    b=Mqdglkn2spLbm+ZcbVB7Sj0Yz58iNGJfZt6ggYnz1W8snJjrSTCsfApyOmBe0FYtJi
    Z4IjCWXaGUO4NmxPBCdwG5XjQwh4Rkj5DKFJtP1xJn1A8QSkP2+mD6H9/G9wCXIPnrLV
    KL2TT99+PBSpVzCLI3oopHpPjE2vyz09wugAk1zW4eneHQrY66xzHToJzWicmjTiI/sK
    7Vgt9kxr5Ilpn3dYLCV9YaH1J0uOdW1zo2bq/sz0zkqHOOwF/icqYsJMQHBfuHmKiQMt
    NKlfg8YtDV3ySLkiro3BLiVWR4GElaMMBW0fHlOq84aeSsh/tKUWR4IaQMlFP3BfMEm/
    MLdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729760677;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RRfDWJIOkqjPrhbh612PAoUIWzAgCuaBt5a29U417mA=;
    b=rJP8XvjuRGtQWVnnkyAK7Q9a4dQGlOORppHusnsbqC9nKOoPBUJ2gySkWiCbCkxO9P
    qWpvW3oLJd43KehBJ3CA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSe9tgBDSDt0V0DBslXBtZUxPOub3IZik"
Received: from [10.176.235.56]
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209O94aWDG
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 24 Oct 2024 11:04:36 +0200 (CEST)
Message-ID: <eccc31a9689842d711e163a2d4d8b14f97100f83.camel@iokpp.de>
Subject: Re: [PATCH v4 2/5] mmc-utils: Add FFU mode 2
From: Bean Huo <beanhuo@iokpp.de>
To: Avri Altman <Avri.Altman@wdc.com>, "ulf.hansson@linaro.org"
	 <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	 <linux-mmc@vger.kernel.org>, "vfazio@xes-inc.com" <vfazio@xes-inc.com>
Cc: Bean Huo <beanhuo@micron.com>
Date: Thu, 24 Oct 2024 11:04:36 +0200
In-Reply-To: <BL0PR04MB6564794698F1DF0223380CC0FC4E2@BL0PR04MB6564.namprd04.prod.outlook.com>
References: <20241023143839.108572-1-beanhuo@iokpp.de>
	 <20241023143839.108572-3-beanhuo@iokpp.de>
	 <BL0PR04MB6564794698F1DF0223380CC0FC4E2@BL0PR04MB6564.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-24 at 08:00 +0000, Avri Altman wrote:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { do_ffu, -2,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ffu", "<image name> =
<device> [chunk-bytes]\n"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { do_ffu1, -2,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ffu1", "<image name>=
 <device> [chunk-bytes]\n"
> Ah, but didn't we establish that the current API should be retained
> to act as the default mode?
>=20
> Thanks,
> Avri

Avri,=20

Corret, the reason for updating the default FFU mode name from 'ffu' to
'ffu1' is to avoid the error: 'ERROR: in command 'ffu', 'ffu' is
ambiguous' when using 'mmc ffu'. Without this change, the system will
encounter ambiguity.


I am considering a naming scheme like opt_ffu1 and opt_ffu2, that works
well for maintaining consistency and keeping the names concise.

ffu2 could become opt_ffu1 (indicating the first optimized or alternate
FFU mode).

ffu3 could become opt_ffu2.
ffu4 could become opt_ffu3.
ffu5 could become opt_ffu4.

then keep default ffu name as it is used to be.

how do you think?



Kind regards,
Bean
