Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A9F1A23B9
	for <linux-mmc@vger.kernel.org>; Wed,  5 Nov 2025 07:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326441; cv=none; b=hWZNB0yu3jwYxWlVQqVyCixfP14ZCOauRAdeSaBxpmbPfEBnCkGBf6FkBA+0sj1kK+6EkbXSRBq0rannbLqNpzKEzlwZZ3NzaHHUyJdjPIzwVZL7lmwlQyKheWNVCECGtUm7PnusxLG4DZtdDs1bK5/xkfSln7T6aZrfa42eAeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326441; c=relaxed/simple;
	bh=/Tg1Lccqz4fVCRhIRHtfJ4sNOLBsD7xjWKExD1zeR7o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=iudwAW/pQ2BcmAWraOoO5jWoMTk2+Ok8SPpDMTGHF4BMreTtpxE6D2ndOX+5HIWVC/6q8BZUbeiGg5hoM8CNZzZhQE4RUn2HhLLvK6rE4crYYMa+9GM2q4JdH4P8u7Xj2iEm1kU2z8UaiQm65Rdgc9G4XJRPeGim94idbB46ib8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=quRoKRsw; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="quRoKRsw"
DKIM-Signature: a=rsa-sha256; b=quRoKRswxw7lS4b0m2z3P2dhDsiUtbIAOLunVjacLry+kSIG30+kGsJ9piWbnxPd5mxEWll46w2fb9+P7NL7Q+HJzRGVtTju5UxA7xNce4ot8LBiuqpns54FkEa1Io0FK/0LACtFlKL93PVnYe6Bqoc5U0KXO+Qh7BKns2J5ydZ6Ee1u5KpbUQ8sZ5jFARXdmAgWw+lg6AjsPWmIaXHCeMn2Vfm775OBkDFM5oACT4C9ge+npS4uk0mdhJpU4CYBxhxy+zTCEy5YM44aPQw0ZWQHEE4IOJ7r9nxOUQs7Y8fEx//6grqnte8qy3n9wE8OkQIHWav+kw8f2L+TELuUkQ==; s=purelymail2; d=purelymail.com; v=1; bh=/Tg1Lccqz4fVCRhIRHtfJ4sNOLBsD7xjWKExD1zeR7o=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: linux-mmc@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 999999398;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 05 Nov 2025 07:07:12 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.96)
	(envelope-from <peter@korsgaard.com>)
	id 1vGXbr-004f7J-0Z;
	Wed, 05 Nov 2025 08:07:11 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org,  Avri Altman <avri.altman@wdc.com>,  Ulf
 Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc-utils: lsmmc.c: print_mmc_cid(): correct
 year/month parsing
References: <20251104200008.940057-1-peter@korsgaard.com>
	<af77b269-a9e3-470b-a6bf-81636235bf5e@rock-chips.com>
Date: Wed, 05 Nov 2025 08:07:11 +0100
In-Reply-To: <af77b269-a9e3-470b-a6bf-81636235bf5e@rock-chips.com> (Shawn
	Lin's message of "Wed, 5 Nov 2025 10:04:12 +0800")
Message-ID: <87qzud6jq8.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>>>>> "Shawn" =3D=3D Shawn Lin <shawn.lin@rock-chips.com> writes:

Hi,

 > From the JESD84-B51, section 7.2.7,

 > For e=E2=80=A2MMC 4.41 and later devices, indicated by a value larger th=
an 4 in
 > EXT_CSD_REV [192], the 4-bit=E2=80=9Cy=E2=80=9D field shall roll over af=
ter 2012, so
 > that y=3D0 shall be used for 2013. See Table 77 for a list of valid y
 > values for specific e=E2=80=A2MMC versions.

 > So mdt_year + 1997 seems wrong, too.

That tweak is even not enough, E.G. I see the kernel does:

       if (card->ext_csd.rev >=3D 5) {
                /* Adjust production date as per JEDEC JESD84-B451 */
                if (card->cid.year < 2010)
                        card->cid.year +=3D 16;

2009 + 16 =3D 2025, so what will happen in a few months?

--=20
Bye, Peter Korsgaard
