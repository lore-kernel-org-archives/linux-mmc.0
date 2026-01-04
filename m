Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186F241C63;
	Sun,  4 Jan 2026 06:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767506506; cv=pass; b=UahLzkGq90hwt7SAeiB3MbUMZmHFudqbl8TT1JkZVvKy06J/32Zi9YQ0/8tJmHHRie2obFw4A6gM62cgW84lG+7Yp87XdZnZBl2OSsEY+VM4iuSVolC7WEM3WRHMMGwZ6XiasR44Ar4qrd1bNFkb6JLTsKHdDv+3WXjLc0v1mMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767506506; c=relaxed/simple;
	bh=URHLHWBFkdAUYpQKDQWDpVl3NdTUFrIVR1FSydvHaaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6jQ471krcI/rxs9f2GTi1pLyRi3doAE3fI7KCpuhW3J7NERAS6GPJ5hvnTykC1wxciCgjDst5+45egGoIArjJGGrCNT0xzeOHrXwBtjVShosh8kAuY3gOC84naMngPnDqmATj6Y4phnpPvFpuPjfHvRiDli8WEywwqn6sGnAWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Z3WxcA0P; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Z3WxcA0P"
ARC-Seal: i=1; a=rsa-sha256; t=1767506492; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P2IOELIq3O0zOgMCr14QqhpYFt0xH5Yh3XvuT0XpD8oPQWY0SygTMT1TWBRKtFyH4pyzyVHqECfD6qkb/sLeJ7cH/5Jtg5Ahk75XQLmqAeS2XNEW2FJv2i8x8/iNOsjTob192Yar7PKFhC9ZvPhny7/YrjT2O2DMr1lA0ac7Y2k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767506492; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4Af/BJXu6IcVE7QFcvgpVB6QU2FAMBF4dB3yDzKUElA=; 
	b=FwhknFPmrEuPvEsr2ewVIJRaBu8nPpWxqTNNEAe9hgpmuhisBEAwKqqAXFhZxYrr2o34TKgY2e4gJ7gLmMNOJXtaiE/SivR6e7T4P8A+hlGHF3BLOWOVYNtXAh2ATaxh8diEFtFxYPFoCHkmspmnWNlf/Eo6m0Iu+sOCI9HbwEM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767506492;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=4Af/BJXu6IcVE7QFcvgpVB6QU2FAMBF4dB3yDzKUElA=;
	b=Z3WxcA0Po6tCVH+Nss0fId3ZKMakKWs8pzmXCDZv/F3LGYIFQIg9EW94zpmcz+aV
	RE6HNzgw+BXCd1j/6qUP4IA1PUedGQbvZjyYwvyKxP/JUs8id0AjoT7lqKuhXdQ22mF
	XLJ2h0uGRu26AqdyPvkP3x/BPcIuUEZP5bseZH7s=
Received: by mx.zohomail.com with SMTPS id 1767506488824204.47840428667007;
	Sat, 3 Jan 2026 22:01:28 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 3A8DC18086E; Sun, 04 Jan 2026 07:01:26 +0100 (CET)
Date: Sun, 4 Jan 2026 07:01:26 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "ping.gao" <ping.gao@samsung.com>, jh80.chung@samsung.com, 
	ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] MMC:dw_mmc:when enable biu_clk should check whether this
 clk is normal
Message-ID: <aVn9K96d5CD5m_Y4@venus>
References: <CGME20260104023451epcas5p391708610b5ce46d0e2a5f4bfbad01c71@epcas5p3.samsung.com>
 <20260104023857.213329-1-ping.gao@samsung.com>
 <b30a4977-7202-4771-8977-ff03e8453d16@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j2ranqqlns5n2kha"
Content-Disposition: inline
In-Reply-To: <b30a4977-7202-4771-8977-ff03e8453d16@rock-chips.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/267.489.64
X-ZohoMailClient: External


--j2ranqqlns5n2kha
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MMC:dw_mmc:when enable biu_clk should check whether this
 clk is normal
MIME-Version: 1.0

Hi,

On Sun, Jan 04, 2026 at 10:55:48AM +0800, Shawn Lin wrote:
> =E5=9C=A8 2026/01/04 =E6=98=9F=E6=9C=9F=E6=97=A5 10:38, ping.gao =E5=86=
=99=E9=81=93:
> > some vendor doesn't use biu_clk , enable it will panic
> > log is below:
>=20
> I still don't understand the real issue you tried to solve.
>=20
> host->biu_clk is got via devm_clk_get() in dw_mci_probe(). If
> succeed, immediately it's enabled a few lines below. Otherwise,
> dw_mci_probe() returns with failure. Seems you are not enabling it in
> runtime callbacks, but why clk_prepare_enable(host->biu_clk) is able
> to work when driver probed?

Based on the error and this patch, I believe what happens is:

1. dw_mci_probe() calls devm_clk_get(host->dev, "biu")
2. The clock does not exist on the platform from Ping Gao, so
   host->biu_clk gets an error pointer assigned
3. "biu clock not available" gets printed at debug level
4. the error is ignored, but the error pointer is still assigned to
   host->biu_clk
5. in the runtime PM handler clk_prepare_enable is called for
   host->biu_clk and thus for an error pointer

Instead of hacking this up even further (as this patch does),
the proper fix is to cleanup the probe function. I believe
the complete biu clock handling in it could be reduced to this:

	host->biu_clk =3D devm_clk_get_optional_enabled(host->dev, "biu");
    ret =3D PTR_ERR_OR_ZERO(host->biu_clk);
	if (ret)
		return dev_err_probe(host->dev, ret, "failed to get biu clock\n");

That will assign NULL to host->biu_clk when there is no clock
defined and it is fine to run clk_prepare_enable() with NULL
as clock pointer. Note, that this will handle the clock enabling
as part of devm, so you will also have to drop the
clk_disable_unprepare() calls from the err_clk_biu goto label
and the extra call from dw_mci_remove().

Something similar should probably be done for host->ciu_clk, which
seems to have the same incorrect logic.

Greetings,

-- Sebastian

> > [  438.400868] [7:   binder:436_2: 4998] Unable to handle kernel paging=
 request at virtual address fffffffffffffffe
> > [  438.400877] [7:   binder:436_2: 4998] Mem abort info:
> > [  438.400881] [7:   binder:436_2: 4998]   ESR =3D 0x0000000096000005
> > [  438.400887] [7:   binder:436_2: 4998]   EC =3D 0x25: DABT (current E=
L), IL =3D 32 bits
> > [  438.400894] [7:   binder:436_2: 4998]   SET =3D 0, FnV =3D 0
> > [  438.400899] [7:   binder:436_2: 4998]   EA =3D 0, S1PTW =3D 0
> > [  438.400904] [7:   binder:436_2: 4998]   FSC =3D 0x05: level 1 transl=
ation fault
> > ...
> > [  438.409424] [7:   binder:436_2: 4998] Call trace:
> > [  438.409429] [7:   binder:436_2: 4998]  clk_prepare+0x10/0x24
> > [  438.409439] [7:   binder:436_2: 4998]  dw_mci_runtime_resume+0x50/0x=
2d8 [dw_mmc_samsung cd210e210975263404c28fc89778f369f8398f0c]
> > [  438.409471] [7:   binder:436_2: 4998]  dw_mci_exynos_runtime_resume+=
0x18/0x58 [dw_mmc_exynos_samsung 2735a594c7c9c9e8c65b0b87523fbf70dcaabfff]
> > [  438.409496] [7:   binder:436_2: 4998]  pm_generic_runtime_resume+0x4=
0/0x58
> > [  438.409506] [7:   binder:436_2: 4998]  pm_runtime_force_resume+0x9c/=
0x134
> > [  438.409517] [7:   binder:436_2: 4998]  platform_pm_resume+0x40/0x8c
> > [  438.409529] [7:   binder:436_2: 4998]  dpm_run_callback+0x64/0x230
> > [  438.409540] [7:   binder:436_2: 4998]  __device_resume+0x1d8/0x394
> > [  438.409551] [7:   binder:436_2: 4998]  dpm_resume+0x110/0x2b8
> > [  438.409561] [7:   binder:436_2: 4998]  dpm_resume_end+0x1c/0x38
> > [  438.409570] [7:   binder:436_2: 4998]  suspend_devices_and_enter+0x8=
28/0xab0
> > [  438.409582] [7:   binder:436_2: 4998]  pm_suspend+0x334/0x618
> > [  438.409592] [7:   binder:436_2: 4998]  state_store+0x104/0x144
> > [  438.409601] [7:   binder:436_2: 4998]  kobj_attr_store+0x30/0x48
> > [  438.409610] [7:   binder:436_2: 4998]  sysfs_kf_write+0x54/0x6c
> > [  438.409619] [7:   binder:436_2: 4998]  kernfs_fop_write_iter+0x104/0=
x1a8
> > [  438.409628] [7:   binder:436_2: 4998]  vfs_write+0x24c/0x2f4
> > [  438.409640] [7:   binder:436_2: 4998]  ksys_write+0x78/0xe8
> > [  438.409652] [7:   binder:436_2: 4998]  __arm64_sys_write+0x1c/0x2c
> > [  438.409664] [7:   binder:436_2: 4998]  invoke_syscall+0x58/0x114
> > [  438.409676] [7:   binder:436_2: 4998]  el0_svc_common+0xac/0xe0
> > [  438.409687] [7:   binder:436_2: 4998]  do_el0_svc+0x1c/0x28
> > [  438.409698] [7:   binder:436_2: 4998]  el0_svc+0x38/0x68
> > [  438.409705] [7:   binder:436_2: 4998]  el0t_64_sync_handler+0x68/0xbc
> > [  438.409712] [7:   binder:436_2: 4998]  el0t_64_sync+0x1a8/0x1ac
> > Signed-off-by: ping.gao <ping.gao@samsung.com>
> > ---
> >   drivers/mmc/host/dw_mmc.c | 12 +++++++++---
> >   1 file changed, 9 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index c5db92bbb094..61f6986f15ef 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -3633,9 +3633,15 @@ int dw_mci_runtime_resume(struct device *dev)
> >   	if (host->slot &&
> >   	    (mmc_host_can_gpio_cd(host->slot->mmc) ||
> >   	     !mmc_card_is_removable(host->slot->mmc))) {
> > -		ret =3D clk_prepare_enable(host->biu_clk);
> > -		if (ret)
> > -			return ret;
> > +		if (IS_ERR(host->biu_clk)) {
> > +			dev_dbg(host->dev, "biu clock not available\n");
> > +		} else {
> > +			ret =3D clk_prepare_enable(host->biu_clk);
> > +			if (ret) {
> > +				dev_err(host->dev, "failed to enable biu clock\n");
> > +				goto err;
> > +			}
> > +		}
> >   	}
> >   	ret =3D clk_prepare_enable(host->ciu_clk);
>=20
>=20

--j2ranqqlns5n2kha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmlaAjIACgkQ2O7X88g7
+pqEMRAAhIoXTjfQlyNPVrjfg26ntDx5ffhpYWFLHYnL7RuH3wK4CF9jASlFXjt6
T+nVdesZik6mN/Qcc2m24DLVQ/8Rp60kFJOPwLG8eqsZ8tHkwD7O90hAgjBi4BWh
DS8veH/i50hf0mTZ0cgCMVEzweGpvtU3Z/x1+Bb2hH9zi6TarKXZy9GHcokoY/3L
WShXsKvW5LbpNk6uX1JjgcXPhcwB5ntP4BzvncXemSbnbS4s6dfY055PpIqZICVa
fTXZXD1gTbdmqHoc8rUKF0YOYkvwAjiXn4FYaoWXeFRr+eOaF66EIFHicXItMQCX
cvpF/GMGw78Tm1gA0N6dvxFOY/GdI6Qq8UYFqnPXfHd40KjQAISEtBXr0ReEWItf
qhTPSwDgE5IyACvzVtw2ezqpZdZyL/kFi78fHDmBlCWq3uRy7elNbGwvFF1qlCDF
eO0TkzJXXfSCpjATa4lpyoxWTvMy5pu2MziPK1t8yOj1mwybL5sgW+8Y+cXfBjee
jixp8nXQbU6R50UIlu92+eWIvXsTe0Jpvpk79QjagtPCz3YbvGt/CshGPsIawZ+W
w6AA/TrD7rbLHrIr2bRORI2TzGLkBfp2B5qDqvhed8opKs2pIe+/9rKkGjiNsrZ7
DkO8aTyVSt0gqRh8AXGo5o6gx6UbIb7n0Md8fwfFwPxqkmG54BE=
=vl49
-----END PGP SIGNATURE-----

--j2ranqqlns5n2kha--
