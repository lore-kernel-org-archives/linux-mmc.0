Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795449490;
	b=UMhRsqGdjKw+dqiWyKgz2J95poxBJ2DVnW6TE/65bCaTegAqlYkkLvNu/Ea3gsz8rA2H
	 cCFbz4hoT8SI/SwTVTR3PQennw9e//bBb0cvU+eV/u1oPnXsSLbQdaLBdnls9EEIvojlO
	 2LlySc/o+5Okf4hBVgKawS91EYkNLCU6Mpec+AiFsff0rz9ZK5Hb0wgSWmyvI/SZZKuIs
	 L0xz74pYZcZDr9WjZbbWAbgDaxPPAPHWhi7HvHh8bZT+xsasB/5sWXrAlaEyhSip0UTtm
	 yzfp2v7yQjIkid+hHZydf6Takig4Usz8FfhxgjeCmLybS3bnGGgKDZw/e+I7uPfq0xA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449490;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=Eyxh1hEZsAyseeXNRudrDoljPbAu7lArqp12eub0Uiw=;
	b=ndO4iQhtNQww1MdbdTHEWWrh1feRa+xl6qLiNVDug4Ges29/xP+Mw8t9bJ86QrSLhkD1
	 56RGN9ikGnJvuXcM6ywcd7bIfh3OwIZr5jrD9VBzFSDPBmBWo+wArMlex1y/XfRM9sDhh
	 3cQHYr+Mt7s72FL6aE2vojQa8j9QyeqSflYKRehtG0xhAjtotXHVTesruM/wsoskizdkF
	 fh1RDuqEdVJ4fmMKOW2/t8uLK904xCZF9CvPsHavMX8tpkzt9OhoYd3OO0Q25YlirkAgV
	 BNcQZPZYj6mW0cqABAeZOPWHP6oBC/+puYmlmqaciB5hY9d/po7k1c4kB5Pvr4t+zRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=j8N210qI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E781C606A31E;
	Mon, 23 Nov 2026 15:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E781C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=j8N210qI
ARC-Seal: i=1; a=rsa-sha256; t=1795449448; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IJq+7h6/QZIZtDQaFGULBMS3RB7Q0FpvdsSPgYsnPdD2cwJgyKo3iSlwteY4JJXl4uPEfdKVgoCAXhjUwN50z86T9Ivz4NN5uNLe4zsMe5NwS4Ba6UFAxpKDpvZ9eR64ZFDxViDVPU9xgbFAYjXss0FvQfoehg9OQjsHMp1sdMQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795449448; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Eyxh1hEZsAyseeXNRudrDoljPbAu7lArqp12eub0Uiw=; 
	b=I9whJXSeM3JO3Quz0gOZkp7X73h9oC+xLXIyL8B0vUgC7J3SpodbuJVRdUPSSv+fuGDybDMIlm9jkWkLJx8FQJPcNHb8Jm67x7jRwOmnmilKTtjUwIxdK/gHJl/RZtiPpvDiMrFAY3Jc7jRwDih3FXHLtSEfSB5bpUUfzwNJvpg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=j8N210qIWeCJtN1NXecuwDAf0h308Qmhsw9q4orz5AgBR8cC7ya11nsQli7KJxVo+1uhmMsKFPf+BN+sP4wIU62AGGAUdNN7GJ3Azq/R622uzkKGZBSzA2fB1uqkOTzcPTvlW5YJ9BASzmRuhcjuX1bzlNIwGaJYAosnI+OpJTk=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=Eyxh1hEZsAyseeXNRudrDoljPbAu7lArqp12eub0Uiw=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795449444640910.3807170275704;
	Mon, 23 Nov 2026 07:57:24 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 25CB618044C; Mon, 23 Nov 2026 16:57:10 +0100 (CET)
Date: Mon, 23 Nov 2026 16:57:10 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mmc: dw_mmc: add central watchdog and convert CTO
 onto it
Message-ID: <awRdY6Xw5scc5V7-@venus>
References: <1787817486-137277-1-git-send-email-shawn.lin@rock-chips.com>
 <1787817486-137277-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qho7i2axl5cadfjp"
Content-Disposition: inline
In-Reply-To: <1787817486-137277-2-git-send-email-shawn.lin@rock-chips.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.423.79
X-ZohoMailClient: External


--qho7i2axl5cadfjp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 1/4] mmc: dw_mmc: add central watchdog and convert CTO
 onto it
MIME-Version: 1.0

Hello Shawn,

On Thu, Aug 27, 2026 at 03:58:03PM +0800, Shawn Lin wrote:
> +	if (host->wd_events == DW_MCI_WD_DATA_EVENTS) {
> +		dev_warn(host->dev,
> +			 "Data timeout, state %d\n", host->state);

This new warning is now printed during boot on RK3588 and RK3576
(the other message from here are printed at info level):

Sige 5 (RK3576):
[   17.801623] mmc_host mmc2: Bus speed = 198000000Hz (req 200000000Hz, actual 198000000HZ div = 0)
[   17.820103] dwmmc_rockchip 2a320000.mmc: Data timeout, state 3
[   17.853679] dwmmc_rockchip 2a320000.mmc: Data timeout, state 3
[   17.854003] dwmmc_rockchip 2a320000.mmc: Successfully tuned phase to 228

Rock 5B (RK3588):
[    3.956249] mmc_host mmc1: Bus speed = 198000000Hz (req 200000000Hz, actual 198000000HZ div = 0)
[    4.049033] dwmmc_rockchip fe2c0000.mmc: Data timeout, state 3
[    4.086338] dwmmc_rockchip fe2c0000.mmc: Data timeout, state 3
[    4.093284] dwmmc_rockchip fe2c0000.mmc: Successfully tuned phase to 102

Greetings,

-- Sebastian

--qho7i2axl5cadfjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmsEYk4ACgkQ2O7X88g7
+po5VQ/9F/v1dR9FHMW0+l181dZXmg1DjRRIurLUOl72TcokNjfEQyGB6TN5PtJZ
PDH5UJgzmgKhjleEOdjXEdFKLj5Bu2FOfreyJlBdi+pfpt3AwlZ9pB9AvDNbk8QR
GGrr0BKcGmuwU8n7ywxJ51LlWcjKHTu8D+ezC6p2f/jYv9uduenA+WgeiXJKcZ/b
TVIqpWZuSgYeN5CTTjne/2oG80gZMZxjLsgkNGt4RGwTdtiDoSWT7zeE+fMUx5n/
OHJbrb+JNrmwnN07ZbtcGaediRAl+aYyYemN+VYRR0eyBvsjUtoInQrVSgHAMudx
O6yhUxCMiL78j5MGcalf2xjV1C9pZCAl/6AcpjWQ7DfBjoBmMxVmElON3AzIiD86
d9WHCocP+wCPhuZwVUtOhbosfJ6KQWQ0i/2wj/UvgFUgergWugMB2MpznIDu9/JP
yyZw1Made2Bi1SROFgZJKRKL7LeZxp1asx4r/A29Ro57O0HmsxVy7H1soJNE6vFO
SYgGRc4meQH7NFqFZE73dIKYMoNGQ2cnS5H5ZeqM7kMN+nWTyLiCMdQeXARir1tn
XbJZe8RhhGHwftDAbIeXOzOtsvg+G7wmZ9pFDKahWbyqkbkUQ5n//jBhy4RlL4tT
o6zZMNNL0P9QceEcKXKFNC3JDxdmNbJNH9N/KgJ8LqCRsqR3oQY=
=yIi9
-----END PGP SIGNATURE-----

--qho7i2axl5cadfjp--
