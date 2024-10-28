Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235C71DB92E
	for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.216
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121332; cv=pass; b=Xj+X9z60CQDjzZ9RkDIvigSr4QGtVEJAN3uXXj+BpF5Mp5h5FzYl2bchgV0YD4dZBYWhX1nD+/EoFO3af+MOf2MDzJd/PzODsLirAudDSzr47rHQxvjqKxdpH6BkcKIrRNTc8/gN/b0dDJ8dIsmZslfy7eIi6Ttf3sGly503Yko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121332; c=relaxed/simple;
	bh=SUhG9csLlYKex3/aZkQRyWc8EwEtojWx+qUAgs3PYww=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h2zPTRIp2R8BdIO2KUgQm7FuYJz6JKYWq/f6IoJ/G7IUE9v599UELUPHFFN9fOlS1Wcy6Bgicr7ntR+/Im0JtBiWziwJOCSMr0q4fRsTzCNbPbkQW0SVVoghkfJZScJNDbctnxbrDG5dMvTIexzVcQ4Nc0Djx3wSwbMscFUp52k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=aSJ0gbSh; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=hrOT7VKJ; arc=pass smtp.client-ip=81.169.146.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="aSJ0gbSh";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="hrOT7VKJ"
ARC-Seal: i=1; a=rsa-sha256; t=1730121318; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=c/zvovB3zpT3Z3ikYAbd2XsGMaBaHEHFLGra+y0LVycubQu/3KuD7o1XG2q5Svl7/u
    DJdKSeB0OCMP4s06WL5gGIaLCEyk81eXW8u03NdPEdIJBUm8m95xo2PglM/Ayc2qFHnD
    sjDoMZqV4pr8y9nwmwEek902XlRNqmiFg1ScG/VFf8Y1BfGEibVtOuJst3BZFJGbz7dL
    SyWHKvNkw6HmxcAZKB65ZbqvMALxPji2n+ND5zLadYqOcX2KC/c6FHvd6CdCp04iJVQv
    TW69bJ5LyUf+t/nnWMM9k9Hir7LObWPK9msU2aG8CsvO9o1c+rRlpb8oMbBx6qmj6YQv
    478Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1730121318;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=SUhG9csLlYKex3/aZkQRyWc8EwEtojWx+qUAgs3PYww=;
    b=E3LSIGrrpfMGvFU7nfSIKPrrU9VtlniDeR7dMMDpql5p/XyjNU2/wzdKOgKKb4JMmK
    Mg3hn2bHu2KUHhsj4qxD1bH0jDwpV8Ipb8/kag+W3aC8mkCUiPDV+66AZtkNKr7zv+7+
    hsf7SVMuEm7wp5+JzpBXdYbmg0IDHorq9YpYz2bT4FGlKRR2I+yQ3Sf20KMq0i5Kzgh+
    SIToN3zPK4xg38QX6bYraf/UiNECiFzDZjjL/UFn13TP09Nnszs1m2asDwu/9sIz5lfB
    wVUnlPCLFvXwU7k6smLX82sZqvs59L8TeFuYqoqqvPbZf8Aq+BBfLHb50k0EcJ2UTjXj
    sFBw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1730121318;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=SUhG9csLlYKex3/aZkQRyWc8EwEtojWx+qUAgs3PYww=;
    b=aSJ0gbShWRb5h2MlCfzO12b0RJWA51FOmPQQtEpmngKjU3JM9xnaIqrT5vOI5N7u7i
    O/z7/RoAb3Z2vdVRaOZHHP+xolCuakAl1I7iFscfVjodEiopIovOg7yMC6jDTVvxHhkT
    nRzWHsSgS7Amquo8CbOgnHzwp5hYRkrHZJYI7JnBExLQVO1b81e6FbDKeE802HaYQqzN
    hrnyxA8yVireSwuNLs9c7BBsV0f7OPrjaOi411wEHlwVcf/2OHpIg2Wn4TG6BJpB+qEP
    mq4hSHlfsEVsKllU6E38EaeeXJNz4EKlfglWBYntZ1DhaS1dOabs5cJn8YeQ3Mh/0gdV
    CQMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1730121318;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=SUhG9csLlYKex3/aZkQRyWc8EwEtojWx+qUAgs3PYww=;
    b=hrOT7VKJxPWoGKA8yPeetvkSi1tOzcIERtFCL38TlcYGY435uKkWr52r/UtFUYEAoq
    IJXqArzHU/cKx/XIE+Dg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSe9tgBDSDt0V0DBslXBtZUxPOub3IZik"
Received: from [10.176.235.56]
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209SDFIguq
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 28 Oct 2024 14:15:18 +0100 (CET)
Message-ID: <b1b127b172c9accd25028f0263a09dee3386d15c.camel@iokpp.de>
Subject: Re: [PATCH v6 0/5] Add multiple FFU modes based on eMMC
 specification 6.6.18 for flexible firmware updates
From: Bean Huo <beanhuo@iokpp.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: avri.altman@wdc.com, linux-mmc@vger.kernel.org, vfazio@xes-inc.com
Date: Mon, 28 Oct 2024 14:15:17 +0100
In-Reply-To: <CAPDyKFrhcLHo5pVW1ZmuEBnHdkTkFG9yCcyWuQy4pTYWe=_sMQ@mail.gmail.com>
References: <20241025203454.162710-1-beanhuo@iokpp.de>
	 <CAPDyKFrhcLHo5pVW1ZmuEBnHdkTkFG9yCcyWuQy4pTYWe=_sMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-28 at 12:52 +0100, Ulf Hansson wrote:
> >=20
> > =C2=A0 mmc.1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 ++
> > =C2=A0 mmc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 20 +++
> > =C2=A0 mmc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0 mmc_cmds.c | 492 ++++++++++++++++++++++++++++++++++++++---------=
-
> > -----
> > =C2=A0 mmc_cmds.h |=C2=A0=C2=A0 4 +
> > =C2=A0 5 files changed, 389 insertions(+), 140 deletions(-)
> >=20
>=20
> The series applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git
> master, thanks!
>=20
> Kind regards
> Uffe


Thanks Uffe, have a good working day!


Kind regards,
Bean
