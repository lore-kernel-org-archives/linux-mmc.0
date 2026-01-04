Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDACE22083;
	Sun,  4 Jan 2026 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767538104; cv=pass; b=VRd/5L+WWK23x0dBDy2D33+w2/0nUw0LxFyDI0YSk+ezqFMn89sBpbusbgydcRi/epiw+qujDVy0y/pXfl2fPYv7XVCf1QJOEnjA9DNnyLfwfyc0VxH/HOIzUFIoopCBZDNsJSTDYqzIukdvb/mBlv7w4OIGvb6fxMbLYhLxToI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767538104; c=relaxed/simple;
	bh=YTITEhCNqwlxKUqe2pWbNCHz6tShJh2FaK2tg2EvYFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLBz5eyLNZvn6PgC8fT4CHPlKoC6/IT+00emsllCdeNVW3gN+dpsRpT7zv/dnBRPtWiY1tiiqLJUdjBJ+2IFpWvO7rP6pdjV7m6LCd5MHDy0jlQtOfBhB0ShOZYkp3yUFpV1skyckZlzBdOeWfX0Gipa3NNIfvVEoxlkf6I9G40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=DU61HuuL; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="DU61HuuL"
ARC-Seal: i=1; a=rsa-sha256; t=1767538090; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KtkBQrfz1jrktJfru4q8Jv5AuIf4fhUC6dLzCeukkBhmvnbEd0UZRy+pRlPw2Se6KK69+fogzH77L5x7DmcuGjse+mKqt2oLktfMbyuO6jdYCsiTB/HhM98yXEJry9CPz9nR6crk5dox0TEUsZ7SbfjNJs/SEQkrthoMW7+enpg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767538090; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=P4eK1JLCWdaCTbiEk4xTkqOa3+UPdQKR/uq7C/VRIDo=; 
	b=gti8BP3ggd0zGeM7kRJW6/RFnHudbgIo47Tzbd9L19rz9f3yr54um/XC9NGLShqDpKViXUAT8AzPYFwGrx+iGpULGGsS/wEeIgs5oOIRDLycIy942jcNudj3xlSaTLyipBV/QNi0o4QC7+dh+AVEb+t/fBWhl+cyPpmTsx23YRg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767538090;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=P4eK1JLCWdaCTbiEk4xTkqOa3+UPdQKR/uq7C/VRIDo=;
	b=DU61HuuL1nIJEsDvP23LC/E9lGmDhwBxk7pWiEGVfywRVm4OhUiT0KAAySg1rLk7
	fcHtprvD0SuQEy/gXwIdZQNlqF7jCQGSBh/h76fAc6vccrTYyNK13iRCaYxDP3JmdsH
	YAR2uiqp8J76IkSda7uyqDYu5LlwCfabzPjYG3gc=
Received: by mx.zohomail.com with SMTPS id 1767538087600667.4107331436755;
	Sun, 4 Jan 2026 06:48:07 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id D3DC018054E; Sun, 04 Jan 2026 15:48:04 +0100 (CET)
Date: Sun, 4 Jan 2026 15:48:04 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "ping.gao" <ping.gao@samsung.com>, jh80.chung@samsung.com, 
	ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] MMC:dw_mmc:when enable biu_clk should check whether this
 clk is normal
Message-ID: <aVp5IMvHKR8CtqSz@venus>
References: <CGME20260104023451epcas5p391708610b5ce46d0e2a5f4bfbad01c71@epcas5p3.samsung.com>
 <20260104023857.213329-1-ping.gao@samsung.com>
 <b30a4977-7202-4771-8977-ff03e8453d16@rock-chips.com>
 <aVn9K96d5CD5m_Y4@venus>
 <59dd1721-8913-4d62-9201-72bd17985b48@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wg7uzrzsjfjkwg3x"
Content-Disposition: inline
In-Reply-To: <59dd1721-8913-4d62-9201-72bd17985b48@rock-chips.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/267.516.64
X-ZohoMailClient: External


--wg7uzrzsjfjkwg3x
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MMC:dw_mmc:when enable biu_clk should check whether this
 clk is normal
MIME-Version: 1.0

Hi,

On Sun, Jan 04, 2026 at 03:38:42PM +0800, Shawn Lin wrote:
> Hi Sevastian,
>=20
> =E5=9C=A8 2026/01/04 =E6=98=9F=E6=9C=9F=E6=97=A5 14:01, Sebastian Reichel=
 =E5=86=99=E9=81=93:
> > Hi,
> >=20
> > On Sun, Jan 04, 2026 at 10:55:48AM +0800, Shawn Lin wrote:
> > > =E5=9C=A8 2026/01/04 =E6=98=9F=E6=9C=9F=E6=97=A5 10:38, ping.gao =E5=
=86=99=E9=81=93:
> > > > some vendor doesn't use biu_clk , enable it will panic
> > > > log is below:
> > >=20
> > > I still don't understand the real issue you tried to solve.
> > >=20
> > > host->biu_clk is got via devm_clk_get() in dw_mci_probe(). If
> > > succeed, immediately it's enabled a few lines below. Otherwise,
> > > dw_mci_probe() returns with failure. Seems you are not enabling it in
> > > runtime callbacks, but why clk_prepare_enable(host->biu_clk) is able
> > > to work when driver probed?
> >=20
> > Based on the error and this patch, I believe what happens is:
> >=20
> > 1. dw_mci_probe() calls devm_clk_get(host->dev, "biu")
> > 2. The clock does not exist on the platform from Ping Gao, so
> >     host->biu_clk gets an error pointer assigned
> > 3. "biu clock not available" gets printed at debug level
> > 4. the error is ignored, but the error pointer is still assigned to
> >     host->biu_clk
> > 5. in the runtime PM handler clk_prepare_enable is called for
> >     host->biu_clk and thus for an error pointer
> >=20
>=20
> Thanks for the details. For example,
> 1. dw_mci_exynos_probe() enables runtime PM before calling
> dw_mci_pltfm_register()->dw_mci_probe().
> 2. biu_clk gets an error and propagate it to dw_mci_pltfm_register(),

The error propagation does not happen. This is the current code in
dw_mci_probe():

    host->biu_clk =3D devm_clk_get(host->dev, "biu");
	if (IS_ERR(host->biu_clk)) {
		dev_dbg(host->dev, "biu clock not available\n");
		ret =3D PTR_ERR(host->biu_clk);
		if (ret =3D=3D -EPROBE_DEFER)
			return ret;
        /* --- no return here --- */
	} else {
		ret =3D clk_prepare_enable(host->biu_clk);
		if (ret) {
			dev_err(host->dev, "failed to enable biu clock\n");
			return ret;
		}
    }

This code continues probing for any error code that is not
-EPROBE_DEFER. My understanding is, that this has been done
intensionally, since the clock does not exist on some platforms.

Effectively this is an open coded devm_clk_get_optional with
the difference that you may not use any clk_* operations on the
error code. A minimal fix would be to assign "host->biu_clk =3D NULL;"
at the end of the error handling code, which would open code
more of the devm_clk_get_optional() behaviour.

Obviously there is no point in having this open coded and the
helper existed since ages, so I strongly suggest to just use
that. Either devm_clk_get_optional() or even better
devm_clk_get_optional_enabled(). This results in:

 - less code, which is easier to understand
 - fixing the bug at hand
 - proper error handling for errors that are neither -EPROBE_DEFER
   nor -ENOENT.
 - better error/debug messaging behaviour for -EPROBE_DEFER when
   using dev_err_probe() instead of the dev_dbg print.

Greetings,

-- Sebastian

> 3. runtime PM is disabled in dw_mci_exynos_probe() later if seeing error.
>=20
> Does that mean runtime PM handler is called between step 2 and step 3?
> If that is the case, how could we allow this happen because the the
> controller's configuaration isn't been finished yet. Or maybe I
> misunderstand your point?
>=20
>=20
> > Instead of hacking this up even further (as this patch does),
> > the proper fix is to cleanup the probe function. I believe
> > the complete biu clock handling in it could be reduced to this:
> >=20
> > 	host->biu_clk =3D devm_clk_get_optional_enabled(host->dev, "biu");
> >      ret =3D PTR_ERR_OR_ZERO(host->biu_clk);
> > 	if (ret)
> > 		return dev_err_probe(host->dev, ret, "failed to get biu clock\n");
> >=20
> > That will assign NULL to host->biu_clk when there is no clock
> > defined and it is fine to run clk_prepare_enable() with NULL
> > as clock pointer. Note, that this will handle the clock enabling
> > as part of devm, so you will also have to drop the
> > clk_disable_unprepare() calls from the err_clk_biu goto label
> > and the extra call from dw_mci_remove().
> >=20
> > Something similar should probably be done for host->ciu_clk, which
> > seems to have the same incorrect logic.
> >=20
> > Greetings,
> >=20
> > -- Sebastian
> >=20
> > > > [  438.400868] [7:   binder:436_2: 4998] Unable to handle kernel pa=
ging request at virtual address fffffffffffffffe
> > > > [  438.400877] [7:   binder:436_2: 4998] Mem abort info:
> > > > [  438.400881] [7:   binder:436_2: 4998]   ESR =3D 0x00000000960000=
05
> > > > [  438.400887] [7:   binder:436_2: 4998]   EC =3D 0x25: DABT (curre=
nt EL), IL =3D 32 bits
> > > > [  438.400894] [7:   binder:436_2: 4998]   SET =3D 0, FnV =3D 0
> > > > [  438.400899] [7:   binder:436_2: 4998]   EA =3D 0, S1PTW =3D 0
> > > > [  438.400904] [7:   binder:436_2: 4998]   FSC =3D 0x05: level 1 tr=
anslation fault
> > > > ...
> > > > [  438.409424] [7:   binder:436_2: 4998] Call trace:
> > > > [  438.409429] [7:   binder:436_2: 4998]  clk_prepare+0x10/0x24
> > > > [  438.409439] [7:   binder:436_2: 4998]  dw_mci_runtime_resume+0x5=
0/0x2d8 [dw_mmc_samsung cd210e210975263404c28fc89778f369f8398f0c]
> > > > [  438.409471] [7:   binder:436_2: 4998]  dw_mci_exynos_runtime_res=
ume+0x18/0x58 [dw_mmc_exynos_samsung 2735a594c7c9c9e8c65b0b87523fbf70dcaabf=
ff]
> > > > [  438.409496] [7:   binder:436_2: 4998]  pm_generic_runtime_resume=
+0x40/0x58
> > > > [  438.409506] [7:   binder:436_2: 4998]  pm_runtime_force_resume+0=
x9c/0x134
> > > > [  438.409517] [7:   binder:436_2: 4998]  platform_pm_resume+0x40/0=
x8c
> > > > [  438.409529] [7:   binder:436_2: 4998]  dpm_run_callback+0x64/0x2=
30
> > > > [  438.409540] [7:   binder:436_2: 4998]  __device_resume+0x1d8/0x3=
94
> > > > [  438.409551] [7:   binder:436_2: 4998]  dpm_resume+0x110/0x2b8
> > > > [  438.409561] [7:   binder:436_2: 4998]  dpm_resume_end+0x1c/0x38
> > > > [  438.409570] [7:   binder:436_2: 4998]  suspend_devices_and_enter=
+0x828/0xab0
> > > > [  438.409582] [7:   binder:436_2: 4998]  pm_suspend+0x334/0x618
> > > > [  438.409592] [7:   binder:436_2: 4998]  state_store+0x104/0x144
> > > > [  438.409601] [7:   binder:436_2: 4998]  kobj_attr_store+0x30/0x48
> > > > [  438.409610] [7:   binder:436_2: 4998]  sysfs_kf_write+0x54/0x6c
> > > > [  438.409619] [7:   binder:436_2: 4998]  kernfs_fop_write_iter+0x1=
04/0x1a8
> > > > [  438.409628] [7:   binder:436_2: 4998]  vfs_write+0x24c/0x2f4
> > > > [  438.409640] [7:   binder:436_2: 4998]  ksys_write+0x78/0xe8
> > > > [  438.409652] [7:   binder:436_2: 4998]  __arm64_sys_write+0x1c/0x=
2c
> > > > [  438.409664] [7:   binder:436_2: 4998]  invoke_syscall+0x58/0x114
> > > > [  438.409676] [7:   binder:436_2: 4998]  el0_svc_common+0xac/0xe0
> > > > [  438.409687] [7:   binder:436_2: 4998]  do_el0_svc+0x1c/0x28
> > > > [  438.409698] [7:   binder:436_2: 4998]  el0_svc+0x38/0x68
> > > > [  438.409705] [7:   binder:436_2: 4998]  el0t_64_sync_handler+0x68=
/0xbc
> > > > [  438.409712] [7:   binder:436_2: 4998]  el0t_64_sync+0x1a8/0x1ac
> > > > Signed-off-by: ping.gao <ping.gao@samsung.com>
> > > > ---
> > > >    drivers/mmc/host/dw_mmc.c | 12 +++++++++---
> > > >    1 file changed, 9 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > > > index c5db92bbb094..61f6986f15ef 100644
> > > > --- a/drivers/mmc/host/dw_mmc.c
> > > > +++ b/drivers/mmc/host/dw_mmc.c
> > > > @@ -3633,9 +3633,15 @@ int dw_mci_runtime_resume(struct device *dev)
> > > >    	if (host->slot &&
> > > >    	    (mmc_host_can_gpio_cd(host->slot->mmc) ||
> > > >    	     !mmc_card_is_removable(host->slot->mmc))) {
> > > > -		ret =3D clk_prepare_enable(host->biu_clk);
> > > > -		if (ret)
> > > > -			return ret;
> > > > +		if (IS_ERR(host->biu_clk)) {
> > > > +			dev_dbg(host->dev, "biu clock not available\n");
> > > > +		} else {
> > > > +			ret =3D clk_prepare_enable(host->biu_clk);
> > > > +			if (ret) {
> > > > +				dev_err(host->dev, "failed to enable biu clock\n");
> > > > +				goto err;
> > > > +			}
> > > > +		}
> > > >    	}
> > > >    	ret =3D clk_prepare_enable(host->ciu_clk);
> > >=20
> > >=20
>=20

--wg7uzrzsjfjkwg3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmlafaEACgkQ2O7X88g7
+pruvw//aa+zgBGpn4q8pNu5kQywniKjQhns4ixEVzVU6wDSieCcpy7+VGO5gGK+
6FHCAFARkMcAbCQwzweC3tzbDJ8z2oJZJZbGKPcBrsZJe0cj9mm2Lv4Qa7qjvLmQ
mJfTUQ2BSII7/qoAzQb3Fuyq/v1mWNa+up7el2Cm3THPOvCzPa3sm/unxmbNQtBO
RwZmbGKxcetAiC9m6aQEDVzXDxkA9Z6YHeqX2wFhSmUseLEGtgsEB8p7irl7I1Ma
KZWIqszz2oVZl7P3gn0tWFY8I/SQCOz8220K8FrUHQZn+DDMhnMREj2gTAh4pzRr
P9WOz5Qv2IunRCqZrfdAj1h9ubvXFO+pvEC48XtZBrVAoHRZYcF7tOCkvE/5mzsx
O0ucx6sHrjl7z+DcIOGVrG+KSiT+/owXNFDq1EM2VUwoJVZXrK7X2Badnd9stEH2
bCRAOK70w0hec1uSvXO9mUVwEF2BidVgTXWJKYieOiJv2apJ/EAPeZUOeqHcnV0P
9styZAZmPqcdcR/vUuWXtpSIeKBKh6BPsl8P83I0HJ8/dh1gBXqUIchSgw+1OjEI
Fptm8eKCMa6hsriYzu/LOSB03PH7LvclauDcx1qPwEAXYN5BRKrfnrXjIeZese3z
NTLD+Qo4yj4BnI9nSmSpB5aSCfyYE4no8T4VrXT70dTU5eHJF0s=
=hDmS
-----END PGP SIGNATURE-----

--wg7uzrzsjfjkwg3x--
