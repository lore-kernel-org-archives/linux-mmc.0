Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CACF22B67B
	for <linux-mmc@vger.kernel.org>; Thu, 24 Oct 2024 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800549; cv=pass; b=h+0KTF+m28YMVXVO431iceJK0qSUK1RZBrDzoQTXXB+MhWjV++IGHfoh8/wSvqfmQVumwGsOUzi9+S0kgJJN/kjU+JZK4qw+0B1LFQSnYi18AFz8Iroxnqe+Cs7gF6wClh0PxAV9KKndmIQRxQuDRIN3JItwLdwGlm+BirZTxC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800549; c=relaxed/simple;
	bh=y9Ze0Rs/RrlEOSiDikKHf8VnLppfPHVvMpp7OvvXLoU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sjkThtKXIWFTulq1jg22EhiwF/JCRRQSPPN9PEGjKD8vOof0kqDWWAebWA3H0+4GPABSRAX5MqaQ3SCTOu5Qib84TM0H23NUlXkqIczLUpRiUg/QbnZARHeVMyXper6SOvQyOkkwurefDpCr+p7xwbQ//z9I6QJbUjY85chIEwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=kDbvvuXg; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=CgCp4s3m; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="kDbvvuXg";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="CgCp4s3m"
ARC-Seal: i=1; a=rsa-sha256; t=1729800536; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hJIjj9EEoNZyvo7wTIpvNr2NOlZEqfAdazSNZxQET+m1cnQT1dARtpQR9/msYVVqNn
    7rKPev80ZCw212fA2kYmJVnlFXyrEt0NHRdQalKac78UMa63IqgKYkGexLBl6cgEzOmX
    vYJTjHYfdGYSBLoiY+qVZ5lpIc+wg/cykcjEvBCRueOQhu44ALmzRiOLWSi8P/kXf6EJ
    uq5JiEnFOCO4raeNLveT2zsG029FrKeajEuSGsvBKWud8NdoE70u2RCoG11iMqcwrZZl
    XruxTOZv0BvfzQp+SBbQHdwttcvhmmagWGdlKwbDelwqO4331Qp5t0z7cKiL/gomh/vc
    c30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729800536;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=y9Ze0Rs/RrlEOSiDikKHf8VnLppfPHVvMpp7OvvXLoU=;
    b=tCx1lx52naKJMUIbPtGAO+YQKoNQlNQBqtmW2G7kVQdDcg3qpQoNmn0rxmFu8cZH00
    o72MQL66MoxaSArvUgLLuWfm/o/tVE6BBWIJ8jAUkn9arF5nFhj/vTS+Sg7W43TFEMxf
    bIwaGmveSEtfskvx6r8K7crKOnmFtErgoTmJ1AAIo2s7JYsTbdqHjBl+NSBaGuRfbRiI
    yy+/TEtn8zrFpCd+7/PfLou6D60yJ59ak5UlPQzRBA/5aCkRr5RrKRzwP/AA8yceElNd
    Bxr6lAuOESWzsjdrKSvUM5VowNLv2F9zTnR0g0hQTobttGdhL+NuBoFixnJ0lHa1Wetj
    BYcg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729800536;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=y9Ze0Rs/RrlEOSiDikKHf8VnLppfPHVvMpp7OvvXLoU=;
    b=kDbvvuXg5tEtBcBO+ShSQPrKqF5HbyA9b7sAAXfN1wIvUwzwewkVvQXW5h6cGNvO83
    swx5N76ZdSzSefVm0TYjVSt69M9aAXGQZWjjyPHpO/41BvRhwPSw7MYo2RefATDX33xc
    4OFHSAyiSYR3i7hLZmjtTXJFwkzTIBwG1u9AaROxOH1NVnynhGs41leTbp1idchOdprB
    jg8K74D5aAQBP6hKfVtK2gNuWH9MmBDE9yLuxRk6Qv/zOvX7smS5mWRJGhSONtHbAi5i
    mJD8B6r4Y+1+qB7f7bwSbpjLwOUuPpyOWwEkdaKgzV9x58YvSEmcA3p5r8+XaElz1f+l
    zSpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729800536;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=y9Ze0Rs/RrlEOSiDikKHf8VnLppfPHVvMpp7OvvXLoU=;
    b=CgCp4s3mMkBaokJPXtsSrW5Iq+J87UZ03TyIwDecI3zsZv5fZm0SuvTU4LXKtg87ds
    /aZA9lXC3IfdhyzXLWCg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSe9tgBDSDt0V0zNriHg+YfT0rGWYpI+wh+kpzZtBynObdN32R3IYC9YTJ7ZVUKg="
Received: from p200300c58718670d68cbcc3f1f585372.dip0.t-ipconnect.de
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209OK8uYP6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 24 Oct 2024 22:08:56 +0200 (CEST)
Message-ID: <a2ecff531910f11428b6830c8053872c4a6a19c2.camel@iokpp.de>
Subject: Re: [PATCH v4 2/5] mmc-utils: Add FFU mode 2
From: Bean Huo <beanhuo@iokpp.de>
To: Avri Altman <Avri.Altman@wdc.com>, "ulf.hansson@linaro.org"
	 <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	 <linux-mmc@vger.kernel.org>, "vfazio@xes-inc.com" <vfazio@xes-inc.com>
Cc: Bean Huo <beanhuo@micron.com>
Date: Thu, 24 Oct 2024 22:08:55 +0200
In-Reply-To: <DM6PR04MB6575BEE89D1BB00936AC702AFC4E2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241023143839.108572-1-beanhuo@iokpp.de>
	 <20241023143839.108572-3-beanhuo@iokpp.de>
	 <BL0PR04MB6564794698F1DF0223380CC0FC4E2@BL0PR04MB6564.namprd04.prod.outlook.com>
	 <eccc31a9689842d711e163a2d4d8b14f97100f83.camel@iokpp.de>
	 <11ab9fb918d7ceb15c75560086b0b988db2ad24d.camel@iokpp.de>
	 <DM6PR04MB6575BEE89D1BB00936AC702AFC4E2@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-24 at 18:19 +0000, Avri Altman wrote:
> > On Thu, 2024-10-24 at 11:04 +0200, Bean Huo wrote:
> > > On Thu, 2024-10-24 at 08:00 +0000, Avri Altman wrote:
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { do_ffu, -2,
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ffu", "<image =
name> <device> [chunk-bytes]\n"
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { do_ffu1, -2,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ffu1", "<image=
 name> <device> [chunk-bytes]\n"
> > > > Ah, but didn't we establish that the current API should be
> > > > retained
> > > > to act as the default mode?
> > > >=20
> > > > Thanks,
> > > > Avri
> > >=20
> > > Avri,
> > >=20
> > > Corret, the reason for updating the default FFU mode name from
> > > 'ffu'
> > > to
> > > 'ffu1' is to avoid the error: 'ERROR: in command 'ffu', 'ffu' is
> > > ambiguous' when using 'mmc ffu'. Without this change, the system
> > > will
> > > encounter ambiguity.
> > >=20
> > >=20
> > > I am considering a naming scheme like opt_ffu1 and opt_ffu2, that
> > > works well for maintaining consistency and keeping the names
> > > concise.
> > >=20
> > > ffu2 could become opt_ffu1 (indicating the first optimized or
> > > alternate FFU mode).
> > >=20
> > > ffu3 could become opt_ffu2.
> > > ffu4 could become opt_ffu3.
> > > ffu5 could become opt_ffu4.
> > >=20
> > > then keep default ffu name as it is used to be.
> > >=20
> > > how do you think?
> > >=20
> > >=20
> > >=20
> > > Kind regards,
> > > Bean
> >=20
> > Avri,
> >=20
> > how do you think about above my proposal of changing ffux to
> > opt_ffux?
> I don't really have a strong opinion about that.
> As long as the current mode stay the same.
>=20
> Thanks,
> Avri


To avoid ambiguity while keeping the default FFU mode as 'ffu', I
cannot use prefix ffu. I=E2=80=99m considering using the prefix opt_ffu for=
 the
optional FFU modes. This would allow us to differentiate between the
default FFU implementation and the various optimized or alternative
modes without using the "ffu" prefix directly.


opt_ffu1: First optional/optimized FFU mode
opt_ffu2: Second optional/optimized FFU mode
opt_ffu3, etc.

This would keep the default ffu unchanged while allowing us to add
clarity and scalability to the naming of other FFU modes.




Hi Ulf

What=E2=80=99s your thought on this approach?

Kind regards,=20
Bean

