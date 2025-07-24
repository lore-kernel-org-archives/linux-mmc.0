Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E2299A94
	for <linux-mmc@vger.kernel.org>; Thu, 24 Jul 2025 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367653; cv=none; b=V4uF4XTc0YbCR8xzATmlMot3IOpH7qjIDVbJOpFTeCkItn26U9ahPhqFkaEFsqNg9jjhQ97KvScT45ZOq6UlqD+rGugSMkFL5TIRLNSLGLWh/KSnhRZyyV7ROi3CtyIVJMa50c6uJa6JMnpMVX1Sz9MppluQZsGdroHTszW1xXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367653; c=relaxed/simple;
	bh=O4WNtGDUo2NlB3tZAgDhMXfo+Wnyk4fvJ/WIZH+MP6w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=JY8LPTmqR1A92P7UrTZXv1oiHxMUBGQa0Vch3H/X/cSM6/MXftfByxVNbMitI7T1v/o2UwTKd1J+4LyFnMnwAbZ3ZVpxYhkPHwgNWxs5qZgCvSXPy8vYTzDZKoKkAUq5edzHGF2+cNZRpgDyNXMKSr6uuToSENC02a1XdnX4qKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=b3qnZT1Q; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="b3qnZT1Q"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1753367647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vSWCDARkpOjaDYsKpsfZfjcLEF48ac00xjqoBuquq4s=;
	b=b3qnZT1QxB8QF5PNh2xxMu6qhubQSSmORQUOlDWMe3S0tUbdUeEbmWKnUzYhNXjodx+r6q
	ZhjQWxmRHgboKIRwlQ4uc+5H0fKqItvlggSQLIbZMxLoanOsz8B0fyDBW7XY+aDLZ4VLcc
	5ZrLmIYZIHl3cOTdF3UfEmfOh8kRLJxebJPzx1L6uQEvoY8i2W4e5VizFtY/E7WMY5xg8u
	SEKO1Huph4D6eMUJ1ke0AY3pBOE6S0tJDBC4eBSee/on8oivEdRuQYB2X/cCgjFBrevLDW
	iGpUcHJAUYxF1GfiiUwbWwRmp6CdC9ZlMgRd5GvQu2rFJ/ZRgVj0mX9/om4lDA==
Content-Type: multipart/signed;
 boundary=10ba875293c34e6703c03aef8590a08d27428b09fff996c3495687db6730;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 24 Jul 2025 16:33:57 +0200
Message-Id: <DBKCYCNRNTMZ.1XJU81M6EE2D0@cknow.org>
Subject: Re: [PATCH v6 1/8] mmc: sdhci-of-dwcmshc: add common bulk optional
 clocks support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Adrian Hunter" <adrian.hunter@intel.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Chen Wang" <unicornxw@gmail.com>,
 <aou@eecs.berkeley.edu>, <conor+dt@kernel.org>, <guoren@kernel.org>,
 <inochiama@outlook.com>, <jszhang@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
 <paul.walmsley@sifive.com>, <robh@kernel.org>, <ulf.hansson@linaro.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <chao.wei@sophgo.com>, <haijiao.liu@sophgo.com>,
 <xiaoguang.xing@sophgo.com>, <tingzhu.wang@sophgo.com>
Cc: "Chen Wang" <unicorn_wang@outlook.com>, "Drew Fustini" <drew@pdp7.com>,
 <linux-rockchip@lists.infradead.org>
References: <cover.1722847198.git.unicorn_wang@outlook.com>
 <e57e8c51da81f176b49608269a884f840903e78e.1722847198.git.unicorn_wang@outlook.com> <f81b88df-9959-4968-a60a-b7efd3d5ea24@arm.com> <99899915-2730-41c7-b71a-f8d97bb6e59c@intel.com>
In-Reply-To: <99899915-2730-41c7-b71a-f8d97bb6e59c@intel.com>
X-Migadu-Flow: FLOW_OUT

--10ba875293c34e6703c03aef8590a08d27428b09fff996c3495687db6730
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Adrian,

On Wed Jul 23, 2025 at 7:33 AM CEST, Adrian Hunter wrote:
> On 22/07/2025 21:33, Robin Murphy wrote:
>> A bit late for a "review", but Diederik and I have just been
>> IRC-debugging a crash on RK3568 which by inspection seems to be caused
>> by this patch:
>>=20
>> On 2024-08-05 10:17 am, Chen Wang wrote:
>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>
>>> In addition to the required core clock and optional
>>> bus clock, the soc will expand its own clocks, so
>>> the bulk clock mechanism is abstracted.
>>>
>>> Note, I call the bulk clocks as "other clocks" due
>>> to the bus clock has been called as "optional".
>>>
>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>> Tested-by: Drew Fustini <drew@pdp7.com> # TH1520
>>> Tested-by: Inochi Amaoto <inochiama@outlook.com> # Duo and Huashan Pi
>>> ---
>> [...]
>>> +static int dwcmshc_get_enable_other_clks(struct device *dev,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dwcmshc_priv *pr=
iv,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int num_clks,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char * const clk_=
ids[])
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 int err;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (num_clks > DWCMSHC_MAX_OTHER_CLKS)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < num_clks; i++)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv->other_clks[i].id =3D =
clk_ids[i];
>>> +
>>> +=C2=A0=C2=A0=C2=A0 err =3D devm_clk_bulk_get_optional(dev, num_clks, p=
riv->other_clks);
>>=20
>> This leaves a pointer into "priv" in the devres list...
>>=20
>>> +=C2=A0=C2=A0=C2=A0 if (err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "failed to get=
 clocks %d\n", err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 err =3D clk_bulk_prepare_enable(num_clks, priv->oth=
er_clks);
>>> +=C2=A0=C2=A0=C2=A0 if (err)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "failed to ena=
ble clocks %d\n", err);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 priv->num_other_clks =3D num_clks;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return err;
>>> +}
>>> +
>>> =C2=A0 /*
>>> =C2=A0=C2=A0 * If DMA addr spans 128MB boundary, we split the DMA trans=
fer into two
>>> =C2=A0=C2=A0 * so that each DMA transfer doesn't exceed the boundary.
>> [...]
>>> @@ -1280,9 +1300,7 @@ static int dwcmshc_probe(struct platform_device *=
pdev)
>>> =C2=A0 err_clk:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(pltfm_host->clk);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(priv->bus_clk);
>>> -=C2=A0=C2=A0=C2=A0 if (rk_priv)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_bulk_disable_unprepare(=
RK35xx_MAX_CLKS,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rk_priv->ro=
ckchip_clks);
>>> +=C2=A0=C2=A0=C2=A0 clk_bulk_disable_unprepare(priv->num_other_clks, pr=
iv->other_clks);
>>> =C2=A0 free_pltfm:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdhci_pltfm_free(pdev);
>>=20
>> ...but upon, say, -EPROBE_DEFER from sdhci_setup_host() because a
>> regulator isn't ready yet, that "priv" is freed here, so by the time the
>> devres callbacks eventually run, that "devres->clks" pointer which used
>> to represent "priv->other_clocks" points to who knows what, and this
>> sort of thing happens:
>>=20
>> [=C2=A0=C2=A0 12.470827] Unable to handle kernel paging request at virtu=
al address 002df7b378917664
>> [=C2=A0=C2=A0 12.472104] Mem abort info:
>> [=C2=A0=C2=A0 12.472471]=C2=A0=C2=A0 ESR =3D 0x0000000096000004
>> [=C2=A0=C2=A0 12.475991]=C2=A0=C2=A0 EC =3D 0x25: DABT (current EL), IL =
=3D 32 bits
>> [=C2=A0=C2=A0 12.476657]=C2=A0=C2=A0 SET =3D 0, FnV =3D 0
>> [=C2=A0=C2=A0 12.477146]=C2=A0=C2=A0 EA =3D 0, S1PTW =3D 0
>> [=C2=A0=C2=A0 12.477547]=C2=A0=C2=A0 FSC =3D 0x04: level 0 translation f=
ault
>> [=C2=A0=C2=A0 12.478127] Data abort info:
>> [=C2=A0=C2=A0 12.478126] rockchip-gpio fdd60000.gpio: probed /pinctrl/gp=
io@fdd60000
>> [=C2=A0=C2=A0 12.478413]=C2=A0=C2=A0 ISV =3D 0, ISS =3D 0x00000004, ISS2=
 =3D 0x00000000
>> [=C2=A0=C2=A0 12.479826]=C2=A0=C2=A0 CM =3D 0, WnR =3D 0, TnD =3D 0, Tag=
Access =3D 0
>> [=C2=A0=C2=A0 12.480418]=C2=A0=C2=A0 GCS =3D 0, Overlay =3D 0, DirtyBit =
=3D 0, Xs =3D 0
>> [=C2=A0=C2=A0 12.481282] [002df7b378917664] address between user and ker=
nel address ranges
>> [=C2=A0=C2=A0 12.482421] Internal error: Oops: 0000000096000004 [#1]=C2=
=A0 SMP
>> [=C2=A0=C2=A0 12.482980] Modules linked in: sdhci_of_dwcmshc drm_dp_aux_=
bus gpio_rockchip(+) drm_display_helper dw_mmc_rockchip drm_client_lib sdhc=
i_pltfm drm_dma_helper fwnode_mdio sdhci dw_mmc_pltf
>> m libphy fixed rockchip_dfi drm_kms_helper cqhci pl330(+) phy_rockchip_n=
aneng_combphy dw_wdt phy_rockchip_snps_pcie3 phy_rockchip_inno_usb2 dw_mmc =
mdio_bus dwc3 ehci_platform ohci_platform
>> ehci_hcd drm ohci_hcd udc_core io_domain i2c_rk3x usbcore ulpi usb_commo=
n
>> [=C2=A0=C2=A0 12.486871] CPU: 0 UID: 0 PID: 64 Comm: kworker/u16:3 Not t=
ainted 6.16-rc7-arm64-cknow #1 PREEMPTLAZY=C2=A0 Debian 6.16~rc7-1
>> [=C2=A0=C2=A0 12.487901] Hardware name: FriendlyElec NanoPi R5S (DT)
>> [=C2=A0=C2=A0 12.488412] Workqueue: async async_run_entry_fn
>> [=C2=A0=C2=A0 12.488879] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT=
 -SSBS BTYPE=3D--)
>> [=C2=A0=C2=A0 12.489539] pc : __clk_put+0x2c/0x138
>> [=C2=A0=C2=A0 12.489913] lr : __clk_put+0x2c/0x138
>> [=C2=A0=C2=A0 12.490281] sp : ffff800080713b10
>> [=C2=A0=C2=A0 12.490607] x29: ffff800080713b10 x28: ffff0001f001a120 x27=
: 0000000000000000
>> [=C2=A0=C2=A0 12.491302] x26: ffff0001f98e01a0 x25: 0000000000000000 x24=
: ffff0001f0f35408
>> [=C2=A0=C2=A0 12.491995] x23: ffffa8da199b4b40 x22: ffff800080713bb0 x21=
: ffff0001f0f35010
>> [=C2=A0=C2=A0 12.492689] x20: ffff0001f94aafd0 x19: 0a2df7b378917634 x18=
: 00000000ffffffff
>> [=C2=A0=C2=A0 12.493381] x17: 3d4d455453595342 x16: 555300307075656b x15=
: ffff0001f4885650
>> [=C2=A0=C2=A0 12.494075] x14: 0000000000000000 x13: ffff0001f025b810 x12=
: 0000000000008000
>> [=C2=A0=C2=A0 12.494765] x11: ffffa8da1a73ef98 x10: ffffa8da1a460000 x9 =
: 0000000000000078
>> [=C2=A0=C2=A0 12.495454] x8 : 0000000000000049 x7 : ffffa8da18c2fbe0 x6 =
: 0000000000000001
>> [=C2=A0=C2=A0 12.496145] x5 : 0000000000000004 x4 : 000000006cb6bb63 x3 =
: 0000000000000000
>> [=C2=A0=C2=A0 12.496833] x2 : 0000000000000000 x1 : ffff0001f1365ac0 x0 =
: 0000000000000001
>> [=C2=A0=C2=A0 12.497524] Call trace:
>> [=C2=A0=C2=A0 12.497776]=C2=A0 __clk_put+0x2c/0x138 (P)
>> [=C2=A0=C2=A0 12.498154]=C2=A0 clk_put+0x18/0x30
>> [=C2=A0=C2=A0 12.498471]=C2=A0 clk_bulk_put+0x40/0x68
>> [=C2=A0=C2=A0 12.498825]=C2=A0 devm_clk_bulk_release+0x24/0x40
>> [=C2=A0=C2=A0 12.499248]=C2=A0 release_nodes+0x64/0xa0
>> [=C2=A0=C2=A0 12.499608]=C2=A0 devres_release_all+0x98/0xf8
>> [=C2=A0=C2=A0 12.500004]=C2=A0 device_unbind_cleanup+0x20/0x70
>> [=C2=A0=C2=A0 12.500426]=C2=A0 really_probe+0x1e8/0x3a0
>> [=C2=A0=C2=A0 12.500793]=C2=A0 __driver_probe_device+0x84/0x160
>> [=C2=A0=C2=A0 12.501225]=C2=A0 driver_probe_device+0x44/0x128
>> [=C2=A0=C2=A0 12.501640]=C2=A0 __driver_attach_async_helper+0x5c/0x108
>> [=C2=A0=C2=A0 12.502125]=C2=A0 async_run_entry_fn+0x40/0x180
>> [=C2=A0=C2=A0 12.502535]=C2=A0 process_one_work+0x23c/0x640
>> [=C2=A0=C2=A0 12.502939]=C2=A0 worker_thread+0x1b4/0x360
>> [=C2=A0=C2=A0 12.503315]=C2=A0 kthread+0x150/0x250
>> [=C2=A0=C2=A0 12.503646]=C2=A0 ret_from_fork+0x10/0x20
>> [=C2=A0=C2=A0 12.504015] Code: aa0003f3 b140041f 540006c8 97ffd9c4 (b940=
3260)
>> [=C2=A0=C2=A0 12.504598] ---[ end trace 0000000000000000 ]---
>>=20
>>=20
>> TBH I'm not sure what to do as a straight revert seems impractical by
>> now, so we hope someone else might have a good idea.
>
> Presumably the problem has gone away with:
>
> 	commit 91a001a1a0749e5d24606d46ac5dfd4433c00956
> 	Author: Binbin Zhou <zhoubinbin@loongson.cn>
> 	Date:   Sat Jun 7 15:39:01 2025 +0800
>
> 	    mmc: sdhci-of-dwcmshc: Drop the use of sdhci_pltfm_free()
>
> which is in next.
>
> In which case a separate fix is needed for stable.

Adding that patch to my 6.16-rc7 kernel indeed stopped the OOPSies.
Thanks!

Cheers,
  Diederik

--10ba875293c34e6703c03aef8590a08d27428b09fff996c3495687db6730
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaIJEWAAKCRDXblvOeH7b
bijXAP9BixcBCZOWoYa+qoaP08LdxEU4IJm+0TCwXa0PXjAcLQD9GRH01vnSY/VT
pqCikJaktgfsAkaLEv4LgrpdClBoTQ8=
=vWUa
-----END PGP SIGNATURE-----

--10ba875293c34e6703c03aef8590a08d27428b09fff996c3495687db6730--
