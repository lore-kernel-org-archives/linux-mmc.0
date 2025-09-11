Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C114C2D5952
	for <linux-mmc@vger.kernel.org>; Thu, 11 Sep 2025 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623761; cv=pass; b=g3V+vi75947w9EA7tYB02gOMjRoUK2YvfKE4vfkrTzvityo7fVSY4pgmtWaOFO7kY5nGxTKpDI0nI4CY/kpEyBUq+PcbzsqH2wl7A/wZMSbvgdDl0mCWHmaVYH85G3j75TlQwDX4wZkMaYMp4DuyLOs7jUx16MKQbGPtKHyG0tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623761; c=relaxed/simple;
	bh=1F/D1gyuyesrMpH+QLkpNelamiMJ1XRUIy9NSVyMD90=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fI3OudJaF6MjWOv1H5cbEj35lImdK+jimrXTHjHig7t2CmkSvGBR2Gyx6fzaH+YbKJ+uYsUVjiRthb7xn/FhSOR9wM08XBsljHZ2PWV5E6cagASsaq3s1BOoJxtNpqHSQkLcdEUrqFa0t84/uxotlVQPAGLOgaXBAgzri6FxgB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=atGMPiTE; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=qMZwjx0v; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="atGMPiTE";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="qMZwjx0v"
ARC-Seal: i=1; a=rsa-sha256; t=1757623749; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eInyhDJ9JbgeBOmEzOs0lu5fMAGzhUGepUjw+M7F50cSzSjLOv+6Gl2GTBD1DJ/jV/
    eXGLMoHjyLP88yWNzAClOlD0nwLDjUzC2Jj6L934cN7IDFbRpheMGYg96Vcb/82CKFti
    PtBtONpVwFfH9/aN/Cyz95loExzUDtFk45/CMTGKZxGznLBljXmSTD39C4eb89fA4pNe
    FEYr43DiJv72A8D+wwXLRpq4HjODvU/0m66HAXmbEuYy1NyVjd0RRKU+W1fnZ2YpvLs5
    8U5Cr4VIa06tn7loo99AkuEwjHFItnpaR83QaluNNVX8ce9DUQ/jYGLwMVP8nUbEIbu3
    ZXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757623749;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:To:From:Subject:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=1F/D1gyuyesrMpH+QLkpNelamiMJ1XRUIy9NSVyMD90=;
    b=VpQp+gWjYWt1UQOf+B7cSCYWOpIvzg68SFrfva+4hIsABrvRf/rVF1A56QR23yHwCg
    O0erF7Jmlrz0Bl9CtAPsjkbmo7xl3XMZVRQ5xNt+rpRKxY6FyIlg1dfAwbaY3fFHZ1g2
    Ufm97monQMN19YuGUbPFvRVVNgU0iP/xBwcIXGeqpYD+SqSjM0S7OVe7TfKD/5ScEnA3
    /iGoqnjmDiBFc8F8hd/maJpuOm9rNmbyMTmABF9kXcN3cTcZfMKFIOUOXQvIvYORgmK4
    yB/Gz7iAdMYPsaH/P9pZR65pR87JKjis+IATrN79XD9WrencA2B/7EjABPw8rd3hX6bC
    fOIg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757623749;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:To:From:Subject:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=1F/D1gyuyesrMpH+QLkpNelamiMJ1XRUIy9NSVyMD90=;
    b=atGMPiTEIS+Pgn4Bp6DQALGAHMhzjNiPyqJant+tIYe9mwmnaCNP1e/9YePPqpothT
    61cdPOpEpEGCyX2PULE4B+46ooOHXgMh3qFzy4Bq+HkNDHjJtRMJD6B+bM4DGg8YQMLK
    S2TRoWOXc4nDMLRVD8fTvwt5Pi7JweFwee7mGrlSDgqCT7OyCbkClIAkb7KyVXod/NRi
    O4CWVYV4teJiEKmEqILVVwTd0s8N690khXLOLbfICgqyuzdrLEoCraZeCDxHb5ZntRL8
    gbT2gq3LgP15uvWdt8VmjJdaKSJnnK+AN0ZawhrUf5ROecnDVgfcD4HTC6TcPk5GluKR
    wdvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757623749;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:To:From:Subject:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=1F/D1gyuyesrMpH+QLkpNelamiMJ1XRUIy9NSVyMD90=;
    b=qMZwjx0v1ZN4hokLh4my48WTq5+OT84TQoLH8zDqyQSHa3hcbMEsfQ4cp5+yTxKhBk
    3B7Nsj+Z/G3jjmqdFAAw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSe9tgBDSDt0V0zNriHg+YfT0rGXGpI/mZ2HgHiVT8M6sGoC4LL6DNwOPYTjt4g=="
Received: from p200300c5871f6a0dc7f568b405682751.dip0.t-ipconnect.de
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id z612c918BKn8heb
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 11 Sep 2025 22:49:08 +0200 (CEST)
Message-ID: <b8320bba2791f40fa8655fd4c7c4141c4706f691.camel@iokpp.de>
Subject: Re: [PATCH v2 0/2] mmc: core: RPMB code improvements
From: Bean Huo <beanhuo@iokpp.de>
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	jens.wiklander@linaro.org, Avri.Altman@sandisk.com
Date: Thu, 11 Sep 2025 22:49:08 +0200
In-Reply-To: <20250911204426.394260-1-beanhuo@iokpp.de>
References: <20250911204426.394260-1-beanhuo@iokpp.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


ignore this serials patch, since it mixed with our other patches, will send=
 v3.


On Thu, 2025-09-11 at 22:44 +0200, Bean Huo wrote:
> This patch series improves the RPMB frame handling code in the MMC block
> driver with several code quality enhancements.
>=20
>=20
> v1--v2:
> =C2=A0=C2=A0=C2=A0 1. Add fix tag
> =C2=A0=C2=A0=C2=A0 2. Oncorporate Avri's suggestions
>=20
> Bean Huo (2):
> =C2=A0 mmc: core: Fix variable shadowing in mmc_route_rpmb_frames()
> =C2=A0 mmc: core: Improve RPMB frame handling code
>=20
> =C2=A0drivers/mmc/core/block.c=C2=A0=C2=A0=C2=A0 |=C2=A0 34 +++---
> =C2=A0drivers/ufs/core/ufs-rpmb.c | 225 +++++++++++++++++++++++++++++++++=
+++
> =C2=A0drivers/ufs/core/ufs-rpmb.h |=C2=A0 26 +++++
> =C2=A03 files changed, 267 insertions(+), 18 deletions(-)
> =C2=A0create mode 100644 drivers/ufs/core/ufs-rpmb.c
> =C2=A0create mode 100644 drivers/ufs/core/ufs-rpmb.

