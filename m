Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6013F9FB
	for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2025 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761078274; cv=none; b=ozO5j6gqecmhFVBKNJ/+eBL8yFA2r2655yVB6f3cHnaxjrdGZFzE/EkDbJ0GglQNk+J+lp5tiikS0cKQ/fOd7g/P2V7M+4C4FB83e5WViuduuSesWKsdkHs+4v7nE0E504tjVmWDd4mwdTjuRaLcfmHoWtbuIy5/Qtc0x5vQsLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761078274; c=relaxed/simple;
	bh=kPQFdy+Jg2aIknpd6QQ5YlJ5a1QLXsUzFyDqEIK6Obk=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=BjSwra4xMuelaKqAo+F4SktCe+GyBEPA8On1VAAne99zqSC326AWqG/k0R3fApq+JAgipkyx7snLbMEhY6mcD/f6QbWKd3q0vXxSItAXo8al8823wedFXiu3I9LWZBdjPwae4iZGjuJc+ndbH03qA1G3S9MDM8hOAiEdLYr8hKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=oDhE0St6; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="oDhE0St6"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id ED39D40BC6;
	Tue, 21 Oct 2025 22:24:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1761078263; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uRTIypVGOsnyZCsYMr5/fTetx/q6vvmb8JAu2MC9Kmw=;
	b=oDhE0St69+oyArqFdw9E/fR1mNbhDyo9hUeUb6Q99gndb1Ey3c0/E28+n07JcNtNduTtfL
	K7REEs6crI2rOmcHQqWNoCjfEtgJpVkp4u7JmEthW7B8NDjK848YCrzxH3v3HDvYyv9a+i
	8RBlXqKreA8w9+ONIBq97QR4GsZjzj2gXH3aZAfHT0sBPipyHt3wytxTXGqV4jjcKHBlSt
	eDqMUGeX/sxmfIQv8GgLJRgNU5HdM4tksi/INd5+DVJUfPeUxfAqi711rAnTwR9qcBjVQ4
	6E/A8pKZIOzqxVmnGSwptT2UgIrUEtIDvWVAIvKfuMaHLMfhyqYShQ4inbYyPA==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <1066e578-f543-4233-b556-ae458c9327a1@gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <1760924981-52339-1-git-send-email-shawn.lin@rock-chips.com> <1066e578-f543-4233-b556-ae458c9327a1@gmail.com>
Date: Tue, 21 Oct 2025 22:24:19 +0200
Cc: "Shawn Lin" <shawn.lin@rock-chips.com>, "Ulf Hansson" <ulf.hansson@linaro.org>, "Adrian Hunter" <adrian.hunter@intel.com>, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org
To: "Hugh Cole-Baker" <sigmaris@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <84a6b292-868d-c202-6e60-28f21390cc09@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?mmc=3A?=
 =?utf-8?q?_sdhci-of-dwcmshc=3A?= Change 
 =?utf-8?q?DLL=5FSTRBIN=5FTAPNUM=5FDEFAULT?= to 0x4
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None
X-Rspamd-Fuzzy: 69dcb66f27f50339b382001a23347050eeac735c9995c52c316482e551ae70497dfb99c03ee0e7f790e033079b1e0efc574aeaf25ee4704f2a12387171d4d0f4

Hello Hugh and Shawn.

On Tuesday, October 21, 2025 22:04 CEST, Hugh Cole-Baker <sigmaris@gmai=
l.com> wrote:
> On 20/10/2025 02:49, Shawn Lin wrote:
> > strbin signal delay under 0x8 configuration is not stable after mas=
sive
> > test. The recommandation of it should be 0x4.
> >=20
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > ---
> >=20
> >  drivers/mmc/host/sdhci-of-dwcmshc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host=
/sdhci-of-dwcmshc.c
> > index eebd453..5b61401 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -94,7 +94,7 @@
> >  #define DLL=5FTXCLK=5FTAPNUM=5FDEFAULT	0x10
> >  #define DLL=5FTXCLK=5FTAPNUM=5F90=5FDEGREES	0xA
> >  #define DLL=5FTXCLK=5FTAPNUM=5FFROM=5FSW	BIT(24)
> > -#define DLL=5FSTRBIN=5FTAPNUM=5FDEFAULT	0x8
> > +#define DLL=5FSTRBIN=5FTAPNUM=5FDEFAULT	0x4
> >  #define DLL=5FSTRBIN=5FTAPNUM=5FFROM=5FSW	BIT(24)
> >  #define DLL=5FSTRBIN=5FDELAY=5FNUM=5FSEL	BIT(26)
> >  #define DLL=5FSTRBIN=5FDELAY=5FNUM=5FOFFSET	16
>=20
> This patch gets the Foresee A3A444 eMMC on my NanoPC-T6 board to work=
 reliably
> in HS400 Enhanced Strobe mode; before this patch it would suffer from=
 I/O
> errors in HS400 mode as discussed in the other thread [1].
>=20
> Tested-by: Hugh Cole-Baker <sigmaris@gmail.com>

Those are great results, thanks for the testing, Hugh!  Of course,
huge thanks to Shawn for fixing the root cause of the issue, which
avoided the need for having a questionable HS200 quirk described
in the above-mentioned linux-rockchip thread. [1]

> [1]: https://lore.kernel.org/linux-rockchip/52537005-b8a3-c202-770c-5=
99efc6a4d17@manjaro.org/T/

