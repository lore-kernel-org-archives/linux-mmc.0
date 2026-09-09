Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC664388361
	for <linux-mmc@vger.kernel.org>; Wed,  9 Sep 2026 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979571; cv=none; b=MlxSuc0UBx6LjW+5JkfNolLW8ggFExw4f8oPlDi0TeBcN8Rg3pOY14GFfk5ucZarXCuqXTcdrAamDbaQiHS4KEFG1GT/tmTXngH+HfGc9B6fl87aKiX5w3kIPmk1vU1fgX5yFC9JJ8qpP114ghKz8kBLf/EEYeMdmmrSi4IK3BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979571; c=relaxed/simple;
	bh=jDBueHP5NbBAil/wBrmWxHDwXK6/nKGY7RNe1OQJuQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIqqem9EGkAv7jQdzkdB2DBVzCfL1Sh2UtIeuaXIQQ8hcSyeZTnvuapVe+DNn/aQyZWJStLr+xmdJ2yqkUoH7FAQSneGn1iihhhyefLw/apkPZEtf/08ljcVmhqll93KhptUAfSorXgBkoilYBTWLxdiVIJ6EFa3atPFCgEGT1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=AoxZVmWq; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="AoxZVmWq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=jDBu
	eHP5NbBAil/wBrmWxHDwXK6/nKGY7RNe1OQJuQ4=; b=AoxZVmWqD7EKmEyu3ZGf
	kdBtryISAJN/9Iocy7DNWRsjgDMBkIYMWSy0pCyd+e/Txfmpw9f6l3NhxgPDteu0
	tJLpTjg2QQlXLt2350JTW5sFJSoUtEsSOQz2CKuTftfUPT/77JFL/10azmVO+zlB
	lOjsLITyZh7QCxqi2frnacXn+sLkYPj1CeTVUMJWhxqI5cvv0vrbejj+MKfDF198
	wxsXkzu4uKhA6v7GVRbXh8ppHR1kgJR1attDCrRC0IQiEKLIGB41Ui12P188BP0T
	oa4mVy5Y8lfsQR1hg9/FxfM0eo7yGYB2puml6YrmCdJpnZi0u5b/5Udqt/JmHOYW
	5Q==
Received: (qmail 3229657 invoked from network); 9 Sep 2026 20:46:07 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Sep 2026 20:46:07 +0200
X-UD-Smtp-Session: l3s3148p1@qqOfQxFbTtkujnv0
Date: Wed, 9 Sep 2026 20:46:07 +0200
From: wsa+renesas <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 02/15] mmc: renesas_sdhi: Clean up whitespace and add
 OF table sentinels
Message-ID: <aqGpayOVRSNhYVkZ@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-3-biju.das.jz@bp.renesas.com>
 <apf-tTkYstvbe9YP@shikoro>
 <TY3PR01MB11346EAA3A32476F3164DE51886B52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M/Q3t/CIyIcT16E1"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346EAA3A32476F3164DE51886B52@TY3PR01MB11346.jpnprd01.prod.outlook.com>

--M/Q3t/CIyIcT16E1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Please let me know should we use single space separator or
> uniform tab for of_default_cfg, of_rz_compatible and
> of_rcar_gen1_compatible for uniformity among initializers??

Single space. IMHO there are only very few places where a single space
does not make sense. It usually does.


--M/Q3t/CIyIcT16E1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqhqWsACgkQFA3kzBSg
KbZY/A/9H2/QAyI7doakHagAaNtVWzAl7lcGAKLMwQJXixjYVbYkjLYwxAcCK8Mh
Z76T7rqItPukDiaT8NG2MUKRwSO8Yd+w9Jq7L55o+xUzhNhhgl4aCC8oE5h4k4Lc
HOC7BWslLwI3vzyOLrdAfAs+rHjrUtu2A8kFeCnuyAWFGOb7jpI2xdep4v7Xokqs
/S54gsqzCjYqXTXIJOKPdG8dxGKA133G6CjZ993hXDlfxe59jlXDY30CZdmSMhuO
XWJiWv++EkhXyOsVD9O4Tyn9ZYXyZVIx9cNIHHjDmXX6MEUja3N26wgMEEbiuFjZ
SWoJUXSj9n/44kBzJR9wGMrxnYDnqU+W2xe7fVzbo7SfLknbYL0cCRrbh/2ZNrtP
eZmn5/7wh2s33Dlutud9F9kHh9pdmrTMtaJ5eejaxzzN1GHUIwy8jwRVhdSt5OtD
oXWuoVqFn6w5EL7p0IOwYrKGiwbZu40cU2bciPn47wZzwXpJMqRhVu1Ev9H14HJD
ootmOPR8iWOO9OCfqWLjRWa8b6GJyIqNag8DmLPXjz8JYaccha92CxpoPh2FpEhp
h3KZ88Tj7D/b5l1dKHjHUa5yKtHBohMUFG0l8U8VVhnDuKkN3fwgOVkL2BgemDzz
zn3OtPKBuddm/VbhVSrnCNV7MJ9Ve7HV0mYbBag+5AF5Y1E/BkE=
=80P6
-----END PGP SIGNATURE-----

--M/Q3t/CIyIcT16E1--
