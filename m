Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8676E6F2F2
	for <linux-mmc@vger.kernel.org>; Thu, 12 Feb 2026 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892308; cv=none; b=hfyIU5d3CSjXfpKLHMwkXQe38ZPJV3Fxv7835Cn67ziCXZJalo49+7q5rBLVSN8yP5BFSgp+UjYaKm05WAD65SdMDYUmTYtY2MedTxYXCxFnEuFeeizczvSskMLWvjoWbrR9DSnFV10MjSNzOLUcjliawIlDpjgrZQfQPpQ5J1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892308; c=relaxed/simple;
	bh=HaEWXM3b8FGPAgoqcY9sQqxJ+qAzeeE9g7GbKzdtLWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ePJnl97mVK0z+u8mDMUYyqyB2xhQITkvfvbXvo4i414jtu8CedG5BeE9Ag4vM/eUDtCbpKYU3Eljbl52XGBgYokAJ1O6VJem4p6+uHhhBGadxdkgAC4Wpd0IPNk9cRHSByXFPcjNsgnZfG+8L3eaYy/iFYXoVBtMYm1HIXsWkiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eYsFrVJT; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eYsFrVJT"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260212103143epoutp034ecc716716bc396239c22e8f4f9deff6~TeSrSkfAi1100211002epoutp03Z
	for <linux-mmc@vger.kernel.org>; Thu, 12 Feb 2026 10:31:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260212103143epoutp034ecc716716bc396239c22e8f4f9deff6~TeSrSkfAi1100211002epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770892303;
	bh=HaEWXM3b8FGPAgoqcY9sQqxJ+qAzeeE9g7GbKzdtLWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYsFrVJTlGz1UkdI6Z5naGNsNTAzvnX7soPF/T74BlasZyI/xh2YGEmM/mAxgTgcn
	 uRLNcRItcLLy4KXhSeKES8kIpbHj9lv9iNpZOK+RoiVUJ+HWYm7aL7sMIPTusiu+x9
	 mBWdRtYYahz/RuRj+ifenq6dKuXizUpqmrebzX14=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260212103142epcas5p2c1a2fc86f4676e29513466a6c16a07dd~TeSq6FicP2581425814epcas5p2x;
	Thu, 12 Feb 2026 10:31:42 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fBWnB6DD9z2SSKd; Thu, 12 Feb
	2026 10:31:42 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260212103142epcas5p4bd370c87ca730d591a795fc8c562e350~TeSqq7x9k0745207452epcas5p40;
	Thu, 12 Feb 2026 10:31:42 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260212103142epsmtip262f9bc972facc734ce92068a6ca03a91~TeSqHfiwR0585205852epsmtip2z;
	Thu, 12 Feb 2026 10:31:42 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: shawn.lin@rock-chips.com, ulf.hansson@linaro.org,
	jh80.chung@samsung.com, sebastian.reichel@collabora.com,
	ping.gao@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	hy50.seo@samsung.com, kwangwon.min@samsung.com
Subject: Re: [PATCH] drivers: dw_mmc: Replace devm_clk_get with
 devm_clk_get_optional
Date: Thu, 12 Feb 2026 18:36:27 +0800
Message-ID: <20260212103627.3677417-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CMS-MailID: 20260212103142epcas5p4bd370c87ca730d591a795fc8c562e350
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260123085150epcas5p42f2cc04843ae7657380b2968261246cb
References: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>

=E5=9C=A8=202026/01/23=20=E6=98=9F=E6=9C=9F=E4=BA=94=2018:56,=20shawn=20lin=
=20=E5=86=99=E9=81=93:=0D=0D=0D=0A>=20=0D=0D=0D=0A>=20Hi=20Ping=20Gao=0D=0D=
=0D=0A>=20=0D=0D=0D=0A>=20=E5=9C=A8=202026/01/23=20=E6=98=9F=E6=9C=9F=E4=BA=
=94=2016:56,=20ping.gao=20=E5=86=99=E9=81=93:=0D=0D=0D=0A>=20>=20By=20using=
=20devm_clk_get_optional,=20if=20clk=20is=20optional=20for=20device=20and=
=20not=20define=20in=20dts=0D=0D=0D=0A>=20>=20it=20will=20return=20NULL,=20=
then=20clk_prepare_enable/clk_disable_unprepare=20for=20biu_clk=20is=20safe=
=20to=0D=0D=0D=0A>=20>=20bail=20out=20internally.=0D=0D=0D=0A>=20>=20=0D=0D=
=0D=0A>=20=0D=0D=0D=0A>=20Sorry=20for=20not=20noticing=20this=20patch=20as=
=20the=20versioning=20problem.=0D=0D=0D=0A>=20=0D=0D=0D=0A>=20You=20should=
=20improve=20the=20commit=20title=20to=20match=20the=20convention=20like:=
=0D=0D=0D=0A>=20mmc:=20dw_mmc:=20Using=20devm_clk_get_optional()=20for=20bi=
u_clk=0D=0D=0D=0A>=20=0D=0D=0D=0A>=20>=20before=20biu_clk=20in=20dwmmc=20dr=
iver=20devm_clk_get=20fail,=20but=20it's=20ERR_PTR,=0D=0D=0D=0A>=20>=20not=
=20null,it=20will=20panic=20when=20call=20clk_prepare=0D=0D=0D=0A>=20>=20lo=
g=20is=20below:=0D=0D=0D=0A>=20>=20=5B=20=20438.400868=5D=20=5B7:=20=20=20b=
inder:436_2:=204998=5D=20Unable=20to=20handle=20kernel=20paging=20request=
=20at=20virtual=20address=20fffffffffffffffe=0D=0D=0D=0A>=20>=20=5B=20=2043=
8.400877=5D=20=5B7:=20=20=20binder:436_2:=204998=5D=20Mem=20abort=20info:=
=0D=0D=0D=0A>=20>=20=5B=20=20438.400881=5D=20=5B7:=20=20=20binder:436_2:=20=
4998=5D=20=20=20ESR=20=3D=200x0000000096000005=0D=0D=0D=0A>=20>=20=5B=20=20=
438.400887=5D=20=5B7:=20=20=20binder:436_2:=204998=5D=20=20=20EC=20=3D=200x=
25:=20DABT=20(current=20EL),=20IL=20=3D=2032=20bits=0D=0D=0D=0A>=20>=20=5B=
=20=20438.400894=5D=20=5B7:=20=20=20binder:436_2:=204998=5D=20=20=20SET=20=
=3D=200,=20FnV=20=3D=200=0D=0D=0D=0A>=20>=20=5B=20=20438.400899=5D=20=5B7:=
=20=20=20binder:436_2:=204998=5D=20=20=20EA=20=3D=200,=20S1PTW=20=3D=200=0D=
=0D=0D=0A>=20>=20=5B=20=20438.400904=5D=20=5B7:=20=20=20binder:436_2:=20499=
8=5D=20=20=20FSC=20=3D=200x05:=20level=201=20translation=20fault=0D=0D=0D=
=0A>=20>=20...=0D=0D=0D=0A>=20=0D=0D=0D=0A>=20The=20timestamp=20could=20be=
=20trimmed.=0D=0D=0D=0A>=20=0D=0D=0D=0A>=20>=20=5B=20=20438.409424=5D=20=5B=
7:=20=20=20binder:436_2:=204998=5D=20Call=20trace:=0D=0D=0D=0A>=20>=20=5B=
=20=20438.409429=5D=20=5B7:=20=20=20binder:436_2:=204998=5D=20=20clk_prepar=
e+0x10/0x24=0D=0D=0D=0A>=20>=20=5B=20=20438.409439=5D=20=5B7:=20=20=20binde=
r:436_2:=204998=5D=20=20dw_mci_runtime_resume+0x50/0x2d8=20=5Bdw_mmc_samsun=
g=20cd210e210975263404c28fc89778f369f8398f0c=5D=0D=0D=0D=0A>=20>=20=5B=20=
=20438.409471=5D=20=5B7:=20=20=20binder:436_2:=204998=5D=20=20dw_mci_exynos=
_runtime_resume+0x18/0x58=20=5Bdw_mmc_exynos_samsung=202735a594c7c9c9e8c65b=
0b87523fbf70dcaabfff=5D=0D=0D=0D=0A>=20>=20=5B=20=20438.409496=5D=20=5B7:=
=20=20=20binder:436_2:=204998=5D=20=20pm_generic_runtime_resume+0x40/0x58=
=0D=0D=0D=0A>=20>=20=5B=20=20438.409506=5D=20=5B7:=20=20=20binder:436_2:=20=
4998=5D=20=20pm_runtime_force_resume+0x9c/0x134=0D=0D=0D=0A>=20>=20=5B=20=
=20438.409517=5D=20=5B7:=20=20=20binder:436_2:=204998=5D=20=20platform_pm_r=
esume+0x40/0x8c=0D=0D=0D=0A>=20>=20=5B=20=20438.409529=5D=20=5B7:=20=20=20b=
inder:436_2:=204998=5D=20=20dpm_run_callback+0x64/0x230=0D=0D=0D=0A>=20>=20=
=5B=20=20438.409540=5D=20=5B7:=20=20=20binder:436_2:=204998=5D=20=20__devic=
e_resume+0x1d8/0x394=0D=0D=0D=0A>=20>=20=5B=20=20438.409551=5D=20=5B7:=20=
=20=20binder:436_2:=204998=5D=20=20dpm_resume+0x110/0x2b8=0D=0D=0D=0A>=20>=
=20=5B=20=20438.409561=5D=20=5B7:=20=20=20binder:436_2:=204998=5D=20=20dpm_=
resume_end+0x1c/0x38=0D=0D=0D=0A>=20>=20=5B=20=20438.409570=5D=20=5B7:=20=
=20=20binder:436_2:=204998=5D=20=20suspend_devices_and_enter+0x828/0xab0=0D=
=0D=0D=0A>=20>=20=5B=20=20438.409582=5D=20=5B7:=20=20=20binder:436_2:=20499=
8=5D=20=20pm_suspend+0x334/0x618=0D=0D=0D=0A>=20>=20=5B=20=20438.409592=5D=
=20=5B7:=20=20=20binder:436_2:=204998=5D=20=20state_store+0x104/0x144=0D=0D=
=0D=0A>=20>=20=5B=20=20438.409601=5D=20=5B7:=20=20=20binder:436_2:=204998=
=5D=20=20kobj_attr_store+0x30/0x48=0D=0D=0D=0A>=20>=20=5B=20=20438.409610=
=5D=20=5B7:=20=20=20binder:436_2:=204998=5D=20=20sysfs_kf_write+0x54/0x6c=
=0D=0D=0D=0A>=20>=20=5B=20=20438.409619=5D=20=5B7:=20=20=20binder:436_2:=20=
4998=5D=20=20kernfs_fop_write_iter+0x104/0x1a8=0D=0D=0D=0A>=20>=20=5B=20=20=
438.409628=5D=20=5B7:=20=20=20binder:436_2:=204998=5D=20=20vfs_write+0x24c/=
0x2f4=0D=0D=0D=0A>=20>=20=5B=20=20438.409640=5D=20=5B7:=20=20=20binder:436_=
2:=204998=5D=20=20ksys_write+0x78/0xe8=0D=0D=0D=0A>=20>=20=5B=20=20438.4096=
52=5D=20=5B7:=20=20=20binder:436_2:=204998=5D=20=20__arm64_sys_write+0x1c/0=
x2c=0D=0D=0D=0A>=20>=20=5B=20=20438.409664=5D=20=5B7:=20=20=20binder:436_2:=
=204998=5D=20=20invoke_syscall+0x58/0x114=0D=0D=0D=0A>=20>=20=5B=20=20438.4=
09676=5D=20=5B7:=20=20=20binder:436_2:=204998=5D=20=20el0_svc_common+0xac/0=
xe0=0D=0D=0D=0A>=20>=20=5B=20=20438.409687=5D=20=5B7:=20=20=20binder:436_2:=
=204998=5D=20=20do_el0_svc+0x1c/0x28=0D=0D=0D=0A>=20>=20=5B=20=20438.409698=
=5D=20=5B7:=20=20=20binder:436_2:=204998=5D=20=20el0_svc+0x38/0x68=0D=0D=0D=
=0A>=20>=20=5B=20=20438.409705=5D=20=5B7:=20=20=20binder:436_2:=204998=5D=
=20=20el0t_64_sync_handler+0x68/0xbc=0D=0D=0D=0A>=20>=20=5B=20=20438.409712=
=5D=20=5B7:=20=20=20binder:436_2:=204998=5D=20=20el0t_64_sync+0x1a8/0x1ac=
=0D=0D=0D=0A>=20>=20=0D=0D=0D=0A>=20>=20Signed-off-by:=20ping.gao=20<ping.g=
ao=40samsung.com>=0D=0D=0D=0A>=20>=20---=0D=0D=0D=0A>=20>=20=20=20drivers/m=
mc/host/dw_mmc.c=20=7C=202=20+-=0D=0D=0D=0A>=20>=20=20=201=20file=20changed=
,=201=20insertion(+),=201=20deletion(-)=0D=0D=0D=0A>=20>=20=0D=0D=0D=0A>=20=
>=20diff=20--git=20a/drivers/mmc/host/dw_mmc.c=20b/drivers/mmc/host/dw_mmc.=
c=0D=0D=0D=0A>=20>=20index=20c5db92bbb094..6bcc1e7233c0=20100644=0D=0D=0D=
=0A>=20>=20---=20a/drivers/mmc/host/dw_mmc.c=0D=0D=0D=0A>=20>=20+++=20b/dri=
vers/mmc/host/dw_mmc.c=0D=0D=0D=0A>=20>=20=40=40=20-3375,7=20+3375,7=20=40=
=40=20int=20dw_mci_probe(struct=20dw_mci=20*host)=0D=0D=0D=0A>=20>=20=20=20=
=09=09=09=09=09=20=20=20=20=20=22platform=20data=20not=20available=5Cn=22);=
=0D=0D=0D=0A>=20>=20=20=20=09=7D=0D=0D=0D=0A>=20>=20=20=20=0D=0D=0D=0A>=20>=
=20-=09host->biu_clk=20=3D=20devm_clk_get(host->dev,=20=22biu=22);=0D=0D=0D=
=0A>=20>=20+=09host->biu_clk=20=3D=20devm_clk_get_optional(host->dev,=20=22=
biu=22);=0D=0D=0D=0A>=20=0D=0D=0D=0A>=20You=20change=20biu_clk=20to=20optio=
nal,=20so=20you=20need=20to=20update=0D=0D=0D=0A>=20Documentation/devicetre=
e/bindings/mmc/synopsys-dw-mshc.yaml=0D=0D=0D=0A>=20because=20minItems=20sa=
ys=202=20there.=0D=0D=0D=0A>=20=0D=0D=0D=0A>=20And=20you=20also=20change=20=
the=20behaviour=20of=20drivers/mmc/host/dw_mmc-k3.c=0D=0D=0D=0A>=20which=20=
tries=20to=20set/get=20biu_clk=20and=20setup=20cards,=20it's=20apparently=
=20rely=20on=0D=0D=0D=0A>=20dw_mmc=20core=20to=20make=20biu_clk=20a=20must=
=20one.=0D=0D=0D=0A>=20=0D=0D=0D=0A>=20So=20I=20suggest=20you=20at=20least=
=20need=20a=20extra=203rd=20patch=20to=20help=20dw_mmc-k3=0D=0D=0D=0A>=20id=
entify=20missing=20biu_clk=20case.=0D=0D=0D=0A>=20=0D=0D=0D=0A>=20For=20the=
=20next=20submission,=20please=20order=20the=20patchset=20as=0D=0D=0D=0A>=
=201.=20synopsys-dw-mshc.yaml=20change=0D=0D=0D=0A>=202.=20dw_mmc-k3=20chan=
ge=0D=0D=0D=0A>=203.=20dw_mmc.c=20change=0D=0D=0D=0A>=20=0D=0D=0D=0A=0D=0D=
=0D=0AHi,=20Shawn=20Lin:=0D=0D=0D=0AI'd=20like=20to=20talk=20to=20you=20abo=
ut=20next=20version=20=20patch=EF=BC=9A=0D=0D=0D=0A1.=20=20I=20think=20=22s=
ynopsys-dw-mshc.yaml=22=20needn't=20change=20,=20because=20biu=20must=20be=
=20set=20for=20hisilicon,=20they=20will=20set=20rate=20for=20biu_clk=0D=0D=
=0D=0A2.=20=20we=20should=20add=20another=20patch=20for=20hisilicon=20like=
=20below,=20do=20you=20agree?=0D=0D=0D=0Adiff=20--git=20a/drivers/mmc/host/=
dw_mmc.c=20b/drivers/mmc/host/dw_mmc.c=0D=0D=0D=0Aindex=206bcc1e7233c0..7a2=
149435894=20100644=0D=0D=0D=0A---=20a/drivers/mmc/host/dw_mmc.c=0D=0D=0D=0A=
+++=20b/drivers/mmc/host/dw_mmc.c=0D=0D=0D=0A=40=40=20-3383,6=20+3383,17=20=
=40=40=20int=20dw_mci_probe(struct=20dw_mci=20*host)=0D=0D=0D=0A=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20return=20ret=
;=0D=0D=0D=0A=0D=0D=0D=0A=20=20=20=20=20=20=20=20=7D=20else=20=7B=0D=0D=0D=
=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20const=20char=20*compatible=
_str=20=3D=20NULL;=0D=0D=0D=0A+=0D=0D=0D=0A+=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20if=20(of_property_read_string(host->dev->of_node,=20=22compa=
tible=22,=0D=0D=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20&compatible_str)=20=3D=3D=200)=20=7B=0D=0D=0D=0A+=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20if=20(strstr=
(compatible_str,=20=22hisilicon=22))=20=7B=0D=0D=0D=0A+=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
if=20(=21host->biu_clk)=20=7B=0D=0D=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20dev_err(host->dev,=20=22biu=20clock=20not=20available=20,it=20must=
=20be=20set=5Cn=22);=0D=0D=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
return=20-EINVAL;=0D=0D=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7D=0D=0D=0D=0A+=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7D=0D=0D=0D=0A=
+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7D=0D=0D=0D=0A=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20ret=20=3D=20clk_prepare_enable(host->bi=
u_clk);=0D=0D=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20if=20(re=
t)=20=7B=0D=0D=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20dev_err(host->dev,=20=22failed=20to=20enable=20biu=20cloc=
k=5Cn=22);=0D=0D=0D=0A--=0D=0D=0D=0Acould=20you=20please=20give=20me=20some=
=20advice?=20thanks.=0D=0D=0D=0AGaoping=0D=0D=0D=0A=0D=0D=0D=0A>=20>=20=20=
=20=09if=20(IS_ERR(host->biu_clk))=20=7B=0D=0D=0D=0A>=20>=20=20=20=09=09dev=
_dbg(host->dev,=20=22biu=20clock=20not=20available=5Cn=22);=0D=0D=0D=0A>=20=
>=20=20=20=09=09ret=20=3D=20PTR_ERR(host->biu_clk);=0D=0D=0D=0A>=20>=20=0D=
=0D=0D=0A
