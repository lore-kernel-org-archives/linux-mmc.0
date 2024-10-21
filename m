Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADBB2746A
	for <linux-mmc@vger.kernel.org>; Mon, 21 Oct 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516568; cv=pass; b=E3I1wSSs2cKyk7B3nql0lyxEVMxixbqGRYs8x863/pLFONZHPwiqCPwlpPNax9BBqRy3t38o7wHAKUPolz8CaCtm8RFy+Zby/6C59FOWlo7j6nqiM3nBNmzqoAn3yc3JiIEsUdnAbZECn70K/HNSXwj5ezdql2Z4o2ulUlqu5Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516568; c=relaxed/simple;
	bh=mHL8dCu89Es3NubrvLMmf+jAghUzn9yeaI/4sygFxp4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YfFmo1BU/PRO2ZlENr3I3cc33xLziz+mv6IsEEztyRjsPTMr8Ld5MMiMnigVXw13rtzMN8rZfC+RDbyODOkwiXU/pGDDNPp+/enNy51ebzv7kR/TRj60vzpVziz6beTgrYPMORQ1LXofPRxPyGihrHT0uwLNQtpd2uKD0B+geAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=jS/jD32g; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=FDCWwsIi; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="jS/jD32g";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="FDCWwsIi"
ARC-Seal: i=1; a=rsa-sha256; t=1729516379; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jNrU5CrlFxG8TF/GMVgW5ljgtb+qbcGKScZFrZHQ/aVcWs88X3xZkwOL13NBWXGGBu
    FkPJD6cXOk2PUPzdj+0a1QNdACC//VTLsJMVUjZ3E7BTO5PC+ni17J+3T2oBJg0vPrnA
    u+vuWDQ4x3NzYDRGZjXivTgg0g1W2EcTh0mwNUPNRWeC6eD0M6qRKDvmk3I2WsteruAm
    a7SDm6HK7kExU/Szhx5ER63YsFoZXCTmaUTToutVo6qnjhn1WPQViPi6OeuOllTn2KE4
    J6pJlim2balpa9TmWJ4B5jK6cQkPUKOhvIxLccm+pyUG1mEmmKx+QlIJrhWX9it9YXj6
    hZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729516379;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mHL8dCu89Es3NubrvLMmf+jAghUzn9yeaI/4sygFxp4=;
    b=konV5F2UA3gVhwDSg4rJ/Kq8rbvvg9mSQvOUJ0fuvQJTjyRwu+Yy1F0omcao+6QjXS
    E0v4OeeioDgrDidTem7a773BtXNmzD6ufxM1nAAmTrJUzLGvSYvbuRCITyw1HHb7YfS6
    gRKjbLgsYF6DuOaS3CIySeExCUkQ6EQXYGwHO6/2GVBZnbdkTQsmtPg7OymCzCpKxt6o
    AitguzSwW0NLycALhPZN7uh2xmZ6zBD5MI5wcv6qKy1WYeUYmdE9w2VruBRQEDVRbt1T
    eAqvCN/6V/PJHjSiRIc2YaUgjr4gOlKXt2l/KZBP4x/rwyVSEGAiQcLrxZRdjRz4y5G5
    XSuQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729516379;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mHL8dCu89Es3NubrvLMmf+jAghUzn9yeaI/4sygFxp4=;
    b=jS/jD32gsLppAQwF0cNiZ/YAJZoTrW2ZQazPo0Py8Z0l4otD78/ffieFzRGQn6JG+R
    9IwBKwKGXNWGwoeKheeSpDI9yt7ZCAI+Z0gcP/niCj1r5VaOFhf0VibmR62R2P8HkJKY
    DfhmvzGDD29tg78CMMmJiYKq4p6drERxl/MRXegwLa6JP4mI6I4Tzd/pBcsFQ9ahdA/8
    lgqYJs/44J3eF66gf8s3F5WM4B0SlvKJ4WjdfXlJMs0f4M7XXF8Kk8Pf6DA5rjwTa/Bj
    1KLdV+DXrZPVZOHLtqqXnAAjBEExZgi4PHZDJ6+8p92w79S6pdtlXeLpF1boDkhxD6vN
    uc1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729516379;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mHL8dCu89Es3NubrvLMmf+jAghUzn9yeaI/4sygFxp4=;
    b=FDCWwsIigiNDK5ZTVj1fzAQesCMZLY2DhP98mIhtPX+YCQ+S2w79Fp6omFbXK482Ue
    1kc4WAXRa5XCkngORCCw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSe9tgBDSDt0V0DBslXBtZUxPOub3IZik"
Received: from [10.176.235.56]
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209LDCxLOC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 21 Oct 2024 15:12:59 +0200 (CEST)
Message-ID: <332ded5a7c24624ac943c35a01fad77a538d708b.camel@iokpp.de>
Subject: Re: [RESENT PATCH v3 1/5] mmc-utils: Refactor common FFU code into
 functions to support additional FFU modes
From: Bean Huo <beanhuo@iokpp.de>
To: Avri Altman <Avri.Altman@wdc.com>, "ulf.hansson@linaro.org"
	 <ulf.hansson@linaro.org>, "vfazio@xes-inc.com" <vfazio@xes-inc.com>, 
	"linux-mmc@vger.kernel.org"
	 <linux-mmc@vger.kernel.org>
Cc: Bean Huo <beanhuo@micron.com>
Date: Mon, 21 Oct 2024 15:12:58 +0200
In-Reply-To: <DM6PR04MB65750CCD89F9371C3493E36CFC432@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241013210925.123632-1-beanhuo@iokpp.de>
	 <20241013210925.123632-2-beanhuo@iokpp.de>
	 <DM6PR04MB657548AECCE954C3FCE9DEBDFC442@DM6PR04MB6575.namprd04.prod.outlook.com>
	 <3d418d89c5d4f420ecf7ea2a15e391a189774386.camel@iokpp.de>
	 <DM6PR04MB65753FE73F3EA2476DF90EACFC432@DM6PR04MB6575.namprd04.prod.outlook.com>
	 <01c3fc6c911c648dba42ecd0290c9a9b9ff92918.camel@iokpp.de>
	 <DM6PR04MB65750CCD89F9371C3493E36CFC432@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-21 at 13:02 +0000, Avri Altman wrote:
> > Reduced Duplication: Each do_ffu<x>() avoids repeating the same
> > logic.
> > Improved Maintainability: Changes only need to be made in one
> > location.
> > Clear Separation: Common operations remain consistent across all
> > modes.
> >=20
> >=20
> > The approach you suggested is to sperate them at the begigning of
> > do_ffu<x>, then pass the different parameters to each different
> > function:
> >=20
> > It risks unnecessary duplication and increased complexity, as seen
> > in this
> > structure:
> >=20
> > void do_ffu1() {
> > =C2=A0=C2=A0=C2=A0=C2=A0 // Duplicate logic here
> > =C2=A0=C2=A0=C2=A0=C2=A0 do_ffu_prepare(ffu1);
> > =C2=A0=C2=A0=C2=A0=C2=A0 ffu_is_supported();
> > =C2=A0=C2=A0=C2=A0=C2=A0 do_ffu_download(ffu_structure);
> > =C2=A0=C2=A0=C2=A0=C2=A0 do_ffu_installation();
> > }
> >=20
> > void do_ffu2() {
> > =C2=A0=C2=A0=C2=A0=C2=A0 // Duplicate logic here
> > =C2=A0=C2=A0=C2=A0=C2=A0 do_ffu_prepare(ffu2);
> > =C2=A0=C2=A0=C2=A0=C2=A0 ffu_is_supported();
> > =C2=A0=C2=A0=C2=A0=C2=A0 do_ffu_download(ffu_structure);
> > =C2=A0=C2=A0=C2=A0=C2=A0 do_ffu_installation();
> > }
> >=20
> > Please tell me was the second one what you expected?
> I see that you still think that the ffu_mode is better.
> I don't want to block the progress of the series - as I am aware that
> there are customers that are waiting.
> Please feel free to add my Acked-by tag to the whole series.
>=20
> Thanks,
> Avri


Thanks, I plan to send out the v4 patch this week and will incorporate
your inputs inline as possible as it can.

Kind regards,
Bean
