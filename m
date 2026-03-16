Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01016277029;
	Mon, 16 Mar 2026 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773670587; cv=pass; b=cIKeJW2bN2vbCI4cdHib1GWBriaxiF0sFOY3227FAEAemc1c22GJZz+SFTHbVo5yNjE2iH9SEOwyuIl9tje3FMLiJyKQkqcuxBkwTHbaTR/HjA+oY0C/6wan1tBEIpRE9KQ5dQ1LxBzTfUwnmT7eEzG4T2QvlYJCLg2u/kS3+GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773670587; c=relaxed/simple;
	bh=NpVMtqLlmGsWSUPRgFf9PIhs+kzIhcLuPFDZf7In1fE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=O+vCyG0a526OCUzqaXXKQ6eOIan40DT9uLjtumkp65/IijO18O7BZIun4ll9z45MNH2vi6GgTqoX4HLm70hvZltLT57btIIkEnkDoA37RkX1W1gJEiYIPq7jLqjxczwaGHymfK2P8XoOWQw9MhaHU4yeRMaRlg1AOzZgyu8ozHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=oN0fzVNy; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="oN0fzVNy"
ARC-Seal: i=1; a=rsa-sha256; t=1773670541; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CoBposcMqazqFd1+xMKyvabTT8wgg0/mlnXpFVjUProCvzagZdnllfpSmovVInbeJJJPgZx3OLWkaaYT9LIske/e9av0zIReMrC8m7a1Pl01EbbEJkz88c1rYRbBfF7wJ8qKvaJtjNISZPXkXupV5DwJB2am0O3ga1z3qyk/NDA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773670541; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vrjx49qS1c4VRbEHROrOEzLDXMzMiH0SqTrCzD4Zhw0=; 
	b=Oi/oEkm15wuQuZmm1ZHgVO7d8npgjXXcRoloMg/ThozqN3AbERkVaykq5kPmpqum4TAi4aEZnpCUWKMZjs9+W7ogjU8M1avJ/s8QAww+A5Q2tEgChIl1lq4Rw7ppsD6FWd2JujBuulREiuBHHK1bjobXHF+8ojtuFVc4GmVMbr0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773670541;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:To:To:Cc:Cc:Subject:Subject:From:From:References:In-Reply-To:Reply-To;
	bh=vrjx49qS1c4VRbEHROrOEzLDXMzMiH0SqTrCzD4Zhw0=;
	b=oN0fzVNyApkUcWujXlHnfXDoJF2oqa/uKBB8YldIBrkm5ewDuyaa1btCyia3hbxn
	1vVV6CAR+IzFMgIusZzZJD5mBd6YydyXfZ9c1q7F84ZC2S6EqtTmhOPGt6+GcXWB57t
	CiBwgz5wqSz9b/KJia0JLu9LVE597/O9Ia/xxFF4=
Received: by mx.zohomail.com with SMTPS id 1773670539523525.2968412046828;
	Mon, 16 Mar 2026 07:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 22:15:27 +0800
Message-Id: <DH49Q7OQSIYM.1RD7H0L809JQV@pigmoral.tech>
To: "Jiayu Du" <jiayu.riscv@isrc.iscas.ac.cn>, <krzk@kernel.org>,
 <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Cc: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
 <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <gaohan@iscas.ac.cn>, <me@ziyao.cc>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH v4 3/3] riscv: dts: canaan: Add mmc nodes for K230
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260315054426.18383-1-jiayu.riscv@isrc.iscas.ac.cn>
 <20260315054426.18383-4-jiayu.riscv@isrc.iscas.ac.cn>
In-Reply-To: <20260315054426.18383-4-jiayu.riscv@isrc.iscas.ac.cn>
X-ZohoMailClient: External

Hi Jiayu,
Thanks for the new version. Just a friendly reminder.

On Sun Mar 15, 2026 at 1:44 PM CST, Jiayu Du wrote:
> Add MMC nodes to K230, including eMMC and SDIO. Enable HS200 eMMC
> on the SoM and SDIO high-speed on the board.
>
> Signed-off-by: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
> ---
>  .../boot/dts/canaan/k230-canmv-dshanpi.dts    | 56 +++++++++++++++++++
>  .../dts/canaan/k230-canmv-module-dshanpi.dtsi |  7 +++
>  arch/riscv/boot/dts/canaan/k230.dtsi          | 28 ++++++++++
>  3 files changed, 91 insertions(+)

[...]

> +
> +&sdio {
> +	bus-width =3D <4>;
> +	max-frequency =3D <50000000>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mmc1_pins>;
> +	vmmc-supply =3D <&vdd_3v3>;
> +	vqmmc-supply =3D <&vdd_3v3>;
> +	cap-sd-highspeed;
> +	no-1-8-v;
> +	status =3D "okay";
>  };
> =20

It seems the broken-cd property we discussed in the previous version is
not added, and also my Tested-by tag (for the whole series). Was this
intentional or just an oversight?

--=20
Best regards,
Junhui Liu

