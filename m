Received: from zougloub.eu (zougloub.eu [69.70.16.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCF126FDA5
	for <linux-mmc@vger.kernel.org>; Thu, 12 Jun 2025 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.70.16.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740004; cv=none; b=ul2iXJJlmvYwJTa33c8XtlfdTaUiiZmQwGCX/Z4TPt8tQls1f8KdP8pHMjYOZFhzW8raEA/gcA2Pzf5uvMHQGS0Hi2pfqa9iy1qhobwb9q8Eewar+0wB1m7J7YHj6TxTCHvLWGjAiu1KoraC5NQc1ymWYmSU4NguQfizpUOa0xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740004; c=relaxed/simple;
	bh=nTGI95+Ny7Fc94P+2D13SL/vU3hEN/yhjKknOXMa7gI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=b1yI481TLiX4bkzMjcx67wHN4/LBk/OOoVyWYtS+jk7RMnDLdxNRxI8gPhzll2HuIqGW7vphExVXQB8wKNSrvi8H8srheR6A56/XravTtq+/y+re2d6TVnf58OxgoE1a7XQc49dQQZhMNG1M9t74RYTIBHzJO0gOX198sa7EfYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zougloub.eu; spf=pass smtp.mailfrom=zougloub.eu; dkim=pass (1024-bit key) header.d=zougloub.eu header.i=@zougloub.eu header.b=D++jgRbc; arc=none smtp.client-ip=69.70.16.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zougloub.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zougloub.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zougloub.eu header.i=@zougloub.eu header.b="D++jgRbc"
Received: from pouet.cJ (exmakhina.com [69.70.16.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by zougloub.eu (Postfix) with ESMTPSA id CA58770FACB2;
	Thu, 12 Jun 2025 10:53:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zougloub.eu;
	s=zougloub.eu; t=1749739999;
	bh=nTGI95+Ny7Fc94P+2D13SL/vU3hEN/yhjKknOXMa7gI=;
	h=Subject:From:To:Cc:Date;
	b=D++jgRbcEgBUt84fzFtoAj9Mr205UVEGTGb2+8yDK+0zx2oaxLSUVx4SHBzXcUpzB
	 Yr81n0gb9N67sFwaQYqineDGDG1RhuF8dav9FxdqBRH34SrjNm0KlRONm1UxupF4In
	 274DiBliXob59zbej/FAPdC6+pWnOIrSsOM1R/68=
Message-ID: <eaaab4af4cb6161c508a07734beabba27117ce4f.camel@zougloub.eu>
Subject: Clarification on safe power-off behavior of SD card without
 power-off notification extension
From: =?ISO-8859-1?Q?J=E9r=F4me?= Carretero <cJ-ko@zougloub.eu>
To: linux-mmc@vger.kernel.org, Avri Altman <avri.altman@wdc.com>, Ulf
 Hansson	 <ulf.hansson@linaro.org>
Cc: Vivien Didelot <vivien.didelot+linux@gmail.com>
Date: Thu, 12 Jun 2025 10:53:12 -0400
Autocrypt: addr=cJ@zougloub.eu; prefer-encrypt=mutual;
 keydata=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
 ZXJvIDxjSkByZXotbWV0ei5zdXBlbGVjLmZyPoh9BBMRAgA9AhsjBgsJCAcDAgQVAggDBBYCAwECH
 gECF4AWIQS8OqgR3MKGddOiFIEeNSHmalewWgUCYBdf5gUJGxbSMwAKCRAeNSHmalewWtlDAJ9brw
 aFR6vaVnBIS5EDoeNReYvgZACgqM7h6fB484xfoLrgUzs/ZqGiaaO0LErDqXLDtG1lIENhcnJldGV
 ybyAoSmFiYmVyIG9ubHkpIDxjSkB4aW0uY2E+iH0EExECAD0CGyMGCwkIBwMCBBUCCAMEFgIDAQIe
 AQIXgBYhBLw6qBHcwoZ106IUgR41IeZqV7BaBQJgF1/mBQkbFtIzAAoJEB41IeZqV7Bacb8An0Wk1
 An7xVo41IL+B/wpjkJGK0DgAKCL35xA1LgxNSewks+xrcUO/I5b/rQwSsOpcsO0bWUgQ2FycmV0ZX
 JvIDxKZXJvbWUuQ2FycmV0ZXJvQHN1cGVsZWMuZnI+iH0EExECAD0CGyMCHgECF4AGCwkIBwMCBBU
 CCAMEFgIDARYhBLw6qBHcwoZ106IUgR41IeZqV7BaBQJgF1/mBQkbFtIzAAoJEB41IeZqV7Ba6XkA
 n1NwjueFs0ftw5CP15kWGwV41A5uAKDeK//q9xOFq8yl16H6Gf6Rfog967Q1SsOpcsO0bWUgQ2Fyc
 mV0ZXJvIDxKZXJvbWUuQ2FycmV0ZXJvQG1ldHouc3VwZWxlYy5mcj6IfQQTEQIAPQIbIwYLCQgHAw
 IEFQIIAwQWAgMBAh4BAheAFiEEvDqoEdzChnXTohSBHjUh5mpXsFoFAmAXX+YFCRsW0jMACgkQHjU
 h5mpXsFrE2QCfbEGoChRKIGq/t1QOQbEu92LhP3EAoOKJSqWvCX4c4V+R08ijK3fxRURxtDdKw6ly
 w7RtZSBDYXJyZXRlcm8gKEpvYikgPEplcm9tZS5DYXJyZXRlcm9AY3NjYW5hZGEuY2E+iH0EExECA
 D0CGyMGCwkIBwMCBBUCCAMEFgIDAQIeAQIXgBYhBLw6qBHcwoZ106IUgR41IeZqV7BaBQJgF1/nBQ
 kbFtIzAAoJEB41IeZqV7BaIh0AoJjZ+fpMXcVBpE7YeB0azBGouL/zAKDKcKtrzkMAE6sOF9QcBeT
 iZUq9qLQ8SsOpcsO0bWUgQ2FycmV0ZXJvIDxKZXJvbWUuQ2FycmV0ZXJvQGluZ2VuaWV1cnMtc3Vw
 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
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-WRvhhx/tW6U06McUVtMe"
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-WRvhhx/tW6U06McUVtMe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf, Avri, list,



As I was inquiring with an FAE of an SD-card manufacturer on how to
reliably safely turn off power of their cards -- they're making SD
cards which do not implement power-off notification extension, nor
CMD48, but do perform background operations -- I was told that the way
to make sure that the card can be turned off (having stopped any
background work) is to issue GO_IDLE (CMD0) prior to turning off the
card.


As I'm not familiar with the Linux MMC code I went to do:
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -154,6 +154,10 @@ int __mmc_go_idle(struct mmc_host *host)
        cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
=20
        err =3D mmc_wait_for_cmd(host, &cmd, 0);
+
+       pr_info("%s: go idle %d\n",
+        mmc_hostname(host), err);
+
        mmc_delay(1);

Only to notice that the only time this is called is when the SD card is
inserted.


While I certainly can issue CMD0 by userspace according to their
recommendation and call it a day, I wanted to know what you think of
it: does it look odd (looking at what public information I can find
about SD cards, this "do CMD0 before unplugging" seems reasonable),
or is Linux missing some functionality?


Best regards,


--=20
J=C3=A9r=C3=B4me

--=-WRvhhx/tW6U06McUVtMe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJDBAABCAAtFiEEk5TkdsnFh9XvC+SieNwb2r75s3MFAmhK6dgPHGNqQHpvdWds
b3ViLmV1AAoJEHjcG9q++bNz5sQP/0YjX7rXRz1z7xdcOu+dk8KYKZROtB+WIIs2
c4irHng8B1fjKlT7HZ9A9vBCci2ab2fxdK/Q9zh1n/6MYPznTNrzihGLzsiDoQ3X
w7rLqiE6jXwynYBA9WJx4YkaP3QitlQrXsqQSTKEfLECH1SrMLUzmcls9zY+nlu+
rtseCLg36C08cgk/aSkbhCYQhswDJr46Jb+YdTjA8e6CA3NFv62FBEPngKYsENyI
TTbxO6LyluhD0QehLFa1rh+nuZGo95V7KT5AcejWKjD2p2zSZIREnZFwGaVsk9QG
U4/RjrvUrb4riOQnY1jz8QBOakmZO68zgCHXOJiD+E1iu0Hj99Y+20jcnn9Hvisw
o5kJjwOHoPRE24JeOYo3BnuPpVPbOJLVEeU/ntyQmtQbdmVnZkSnr62NyH5jw7zY
+Slh93fUzwrrbnmEV0zuRDb9SfwyvFgXtGIwN4d+sphO4Co0+yfj5UJyY7ebm7IW
FmjN14z+JIbaogA7Rf4UoJQfnpTYS/4GMsBI1on6h0bP8+vz3WcNIWzqXV2AzbGH
aNBlq80s7zplN1kB+2fPMCdsDD1UOSNwdvMIjnj8pybrcAZTIxI7RoJMeVN4XlRS
K9hLxZK4g5s4L5CpBR1oaZHjYsjtKeT93D7SyqwC0FhzyNtUjvubyzQbZXAtRJHF
pDIlrcGQ
=gQDc
-----END PGP SIGNATURE-----

--=-WRvhhx/tW6U06McUVtMe--
