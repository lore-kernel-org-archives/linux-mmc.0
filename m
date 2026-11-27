Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795821728;
	b=glVDgOLX5mOHfP/lcp4xImFDT2My9WYZQ/GT869VbigrNdWMaIb+emSkcHVm7E3pzQdF
	 szL4VaBat68dMQRSjbXUTI0UysMo2B4NMSSB8s79aw4FH8UDih1uahkicTnbJb+YAzmTn
	 DxjKr2Gd3K0T4iEwl0Tos0xKIJSb6TKRCSyiLltfqrjXALXl5E7NL58tqlAt3Bx/xI7Q1
	 I3KbNjQgOLtzGjWZRuqojK8ibaeRcmC8dvj5fbx1jH04sKGKm84V5F0VlogTu+/zBPa9B
	 W1Pvw3fFzE27BHWhFq8/RUrgef9yJaXK/XNnB/G4hvz8es447R+UWgYjY5LUJAOQqmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795821728;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=4Jj7arnuaVZ1PVynNzLYmGCV2upmIWevRcqZdV9tnzc=;
	b=x5eI0frwy4Y576mwRAoVg9hWrQj4YRJkUx4cxlXA9XNyM0IaVidlF4MDbd04LtbB+Xbr
	 /rZlEWHdfSX2GVggZr8mn5dqOId7rB3FZpifb7rVReYOzEyuwSTsJX3+KXeLiMqI5I+i9
	 yl4GfDKxE0SoXFnqRhWUv9OzAtrfoJdhxe1O9bDd0tmGyJi036EsDzDSuqpwxwsw/30n+
	 fd/VIlY53L3MlszW9KOdt/WBYMnSvupQrZ5nsdsQKwv1XpBYMk6ucudEDxivZtMCO62jr
	 WjDh/WPZSEqHxK+uykK6rTDXFxKG8jexPM3Yc4YnyWUEtV2xh6Q0veyjT5UoiV9ONtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=VnKp2xL0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C17606A31C;
	Fri, 27 Nov 2026 23:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7C17606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=VnKp2xL0
ARC-Seal: i=1; a=rsa-sha256; t=1795821711; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Po/7cxETW0P+0BYgx5FsM/w+XgFXuoKm5rrrcemFG/9h2/TqqfzfbHFEEQgs5HIzCqOKgrzx6Tyk9D/1xj+xGrySwcUwl0uGEo9UGZxXl1yYYwLdQ/9xP340F8ErFNdDvzi6KZCkcikberz/oQPVs5+pi84Im3ysFGfn3zJlj4g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795821711; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4Jj7arnuaVZ1PVynNzLYmGCV2upmIWevRcqZdV9tnzc=; 
	b=gZ4TSlynipkGnxVaqBDA8iHVFuk9zQClQWeNxQ7qUETU9e4gS4o8APpVNiBG7bOBPcrTXknfNlIOEHP98/xA4idEwRdZXPld+3czAhK/Ul84ZCijHgJOAWxPCa0uhxKtP8zCWojDUQv5BA8RYmPC8AVRfscojt5snNX+4M7qN5k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=VnKp2xL0JcyufbPgc0WQ6uGE+jKzLX+p+s6R6Xr47eeXX+3Jc7FKSkdiA5nIsoHiHzb7oTikJ2eW7ZPUjMAHa49BdmBOaWjlZj4x8zP9ua7aAW4jjhAerespBpa44TWUeD5ly2iGuh7H+xSVnqFh1pbgN5K4RvaKgsiuA7Cf9r0=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=4Jj7arnuaVZ1PVynNzLYmGCV2upmIWevRcqZdV9tnzc=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795821708823875.3406304013236;
	Fri, 27 Nov 2026 15:21:48 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 233FF180918; Sat, 28 Nov 2026 00:21:44 +0100 (CET)
Date: Sat, 28 Nov 2026 00:21:44 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Shawn Lin <shawn.lin@linux.dev>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mmc: dw_mmc: add central watchdog and convert CTO
 onto it
Message-ID: <awoP1p0lw0bFglKX@venus>
References: <1787817486-137277-1-git-send-email-shawn.lin@rock-chips.com>
 <1787817486-137277-2-git-send-email-shawn.lin@rock-chips.com>
 <awRdY6Xw5scc5V7-@venus>
 <5b7318ff-b41e-45f6-8127-d42eab0dcb67@linux.dev>
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
	protocol="application/pgp-signature"; boundary="7u53mmt7egemklqt"
Content-Disposition: inline
In-Reply-To: <5b7318ff-b41e-45f6-8127-d42eab0dcb67@linux.dev>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.28.1.5.5/295.810.79
X-ZohoMailClient: External


--7u53mmt7egemklqt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/4] mmc: dw_mmc: add central watchdog and convert CTO
 onto it
MIME-Version: 1.0

Hi,

On Tue, Nov 24, 2026 at 08:46:54AM +0800, Shawn Lin wrote:
> Hi Sebastian
>=20
> =E5=9C=A8 2026/11/23 =E6=98=9F=E6=9C=9F=E4=B8=80 23:57, Sebastian Reichel=
 =E5=86=99=E9=81=93:
> > Hello Shawn,
> >=20
> > On Thu, Aug 27, 2026 at 03:58:03PM +0800, Shawn Lin wrote:
> > > +	if (host->wd_events =3D=3D DW_MCI_WD_DATA_EVENTS) {
> > > +		dev_warn(host->dev,
> > > +			 "Data timeout, state %d\n", host->state);
> >=20
> > This new warning is now printed during boot on RK3588 and RK3576
> > (the other message from here are printed at info level):
> >=20
> > Sige 5 (RK3576):
> > [   17.801623] mmc_host mmc2: Bus speed =3D 198000000Hz (req 200000000H=
z, actual 198000000HZ div =3D 0)
> > [   17.820103] dwmmc_rockchip 2a320000.mmc: Data timeout, state 3
> > [   17.853679] dwmmc_rockchip 2a320000.mmc: Data timeout, state 3
> > [   17.854003] dwmmc_rockchip 2a320000.mmc: Successfully tuned phase to=
 228
> >=20
> > Rock 5B (RK3588):
> > [    3.956249] mmc_host mmc1: Bus speed =3D 198000000Hz (req 200000000H=
z, actual 198000000HZ div =3D 0)
> > [    4.049033] dwmmc_rockchip fe2c0000.mmc: Data timeout, state 3
> > [    4.086338] dwmmc_rockchip fe2c0000.mmc: Data timeout, state 3
> > [    4.093284] dwmmc_rockchip fe2c0000.mmc: Successfully tuned phase to=
 102
> >=20
>=20
> This's a normal case on Rockchip platform that no interrupt happens
> during tuning. Because the driver is seeking valid sample phases,
> however, some phases could make the controller hung. So watchdog fires
> here. Keeping it as dev_warn() only adds noise to every boot.
> Alternatively we could downgrade the message to dev_dbg().

It sounds sensible to downgrade the warning, if timeouts are considered
normal behavior.

Greetings,

-- Sebastian

--7u53mmt7egemklqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmsKEIAACgkQ2O7X88g7
+ppt5g//fR67MbqXIq/UpdXSpTeUhTsLwSLg+z2kRufoOIjyDB/c1aWlruAfh4An
RwEYv/v1g6S+MkTpQKK7mpTEYMqtNM7p0YqDdV1gX/vLQx2Ef+E/Evnmk05pODxf
nG0d+6GxI59GEmJYjfqptLbgxwtghgu7gD94WZsdWjL1PAOSs4f9nkKocpZoSfjC
m3OeTzlyhLzs6elCJf/gYRy+Je6J7lei22fTcyXtgm+VACtoM1eLbg6RQ/JS/nnl
Yo+qgZgL5pqx3S8uvB/J/Xtai490uikWb2wS7hwiL1W56tKjz1ZBijDhZbq9q1eR
mZA2JPEuSGfo8whueYVMnPXIDk6taMN4v3XJAcKawezr09swErSi2rxNdpL+27VT
ioblJYUtdgmW96ZQSXVDOukPpddViEM0flI0LQ5vqHan3m0f64oQ3dvP00u6uM5B
W/6Q/nGQi694R/RvhydePVlPZ0cQ4ISs5Nha1Zk170ngSVhe5ddly/tmClewktxA
/hQUQWSXjViAIcLsvX9julqiBo2bTQhirJ/tT1ccxMzD7byUsWOKY6Ikr9frynoL
VG3vbSV+Melhe7zRFCGygfxR9KTp9WJ2j6lNVVUV7qqS8juQxYHOYZq9IyK1BEGc
iBpE09hAihsYdBCX3oz616caRZC97MAmtnmdxE9FkSymQ6m9gL4=
=DYfD
-----END PGP SIGNATURE-----

--7u53mmt7egemklqt--
