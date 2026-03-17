Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ED4347BA7;
	Tue, 17 Mar 2026 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773730400; cv=pass; b=oLH8a14Ch/BVrVSU/3LUfYwLR0uJUWyrkpHR6/UCYhJ4xU9Tv7AIOCjj2Sr8xGECwRXHUdJuB0/YvKPgkQOnjkX4UVxr9+p3y3WFJuTdjLP5FbloUxeRqdxat1wXOwHkSb2aAeK03kQugCypV+gjVeyVDoeaOvoxSKb9PybE0Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773730400; c=relaxed/simple;
	bh=t1lemcuhNmcRliEdHa/lLCE5IkwxTqUwZS0pZ7M4mN0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UDrVBDddqcTskOFseYRM1dihOcLPn6vz3JxEMsLyLtjWZdC60LHAh2I7dN5rnSHKcaEOAYg/JFERFur6v1xJu7Xg9/45ZqBavg8K04CzcqMkSohYhfWrig5EAzelCCTuJKo/EZHTSLpc8DXYbbHMRvJVhBzlrhEQnNbZTYFSLZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=mzTpzJAz; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="mzTpzJAz"
ARC-Seal: i=1; a=rsa-sha256; t=1773730375; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O6F4vfO27BhBgsN3Ujy+LtSzFdCuHLO/IeOMoxw9yMu53IRZLX1XxN67TSpJV92anSu5AWt2LdJzbkoJwXCSzDgTlO2YPDtlRq8AGBIrZfrm39oYgsTIKl3P/a0IYLXn4hNm75s26AJCddxfpVC0BSDvGTKx/gCe8BKLR7zwrfc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773730375; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=r6x359z7LUVYIlGpCkt6UIl3c41zccuqshUShGS4DHY=; 
	b=e7R1IAjUPyDZ2Ye0k3mmjAM5TWsjKFUhVYfeniN/NkcYvbRBZB5SzupB2pQYUUk3KNr8Zps+7EAB1RsJNNXziC1jprgB9sJij8xpSCpsoAcCJHDc0ElX3duMK1/FkM2zrjKGrvymwgNzj/yIE70h1ju10AF4iLUcRe1rbs9kKjY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773730375;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:References:In-Reply-To:Reply-To;
	bh=r6x359z7LUVYIlGpCkt6UIl3c41zccuqshUShGS4DHY=;
	b=mzTpzJAzBRKZxiOK12kTEebg9Tk2UIrEvu6fEsRwoC7w3gM32G3kCOjiW2ZekerT
	jMq+pfu7laCjLfzycupCNZ1lv2HdmvSx9TcArqsnSFYsQzC9WBr57G7w5aGoytVYCaB
	oxK1IJiUOaSOeou/NJulhapgAgMhWLbjwFJ3noKs=
Received: by mx.zohomail.com with SMTPS id 1773730373624551.8839282460517;
	Mon, 16 Mar 2026 23:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 14:52:44 +0800
Message-Id: <DH4UXSB5ZT12.2ZL6R3FWUR6GN@pigmoral.tech>
Cc: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
 <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <gaohan@iscas.ac.cn>, <me@ziyao.cc>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH v4 3/3] riscv: dts: canaan: Add mmc nodes for K230
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Jiayu Du" <jiayu.riscv@isrc.iscas.ac.cn>, "Junhui Liu"
 <junhui.liu@pigmoral.tech>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260315054426.18383-1-jiayu.riscv@isrc.iscas.ac.cn>
 <20260315054426.18383-4-jiayu.riscv@isrc.iscas.ac.cn>
 <DH49Q7OQSIYM.1RD7H0L809JQV@pigmoral.tech>
 <abgp0PT4GHRwmaLy@duge-virtual-machine>
In-Reply-To: <abgp0PT4GHRwmaLy@duge-virtual-machine>
X-ZohoMailClient: External

On Tue Mar 17, 2026 at 12:03 AM CST, Jiayu Du wrote:
> On Mon, Mar 16, 2026 at 10:15:27PM +0800, Junhui Liu wrote:
>> Hi Jiayu,
>> Thanks for the new version. Just a friendly reminder.
>>=20
>> On Sun Mar 15, 2026 at 1:44 PM CST, Jiayu Du wrote:
>> > Add MMC nodes to K230, including eMMC and SDIO. Enable HS200 eMMC
>> > on the SoM and SDIO high-speed on the board.
>> >
>> > Signed-off-by: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
>> > ---
>> >  .../boot/dts/canaan/k230-canmv-dshanpi.dts    | 56 ++++++++++++++++++=
+
>> >  .../dts/canaan/k230-canmv-module-dshanpi.dtsi |  7 +++
>> >  arch/riscv/boot/dts/canaan/k230.dtsi          | 28 ++++++++++
>> >  3 files changed, 91 insertions(+)
>>=20
>> [...]
>>=20
>> > +
>> > +&sdio {
>> > +	bus-width =3D <4>;
>> > +	max-frequency =3D <50000000>;
>> > +	pinctrl-names =3D "default";
>> > +	pinctrl-0 =3D <&mmc1_pins>;
>> > +	vmmc-supply =3D <&vdd_3v3>;
>> > +	vqmmc-supply =3D <&vdd_3v3>;
>> > +	cap-sd-highspeed;
>> > +	no-1-8-v;
>> > +	status =3D "okay";
>> >  };
>> > =20
>>=20
>> It seems the broken-cd property we discussed in the previous version is
>> not added, and also my Tested-by tag (for the whole series). Was this
>> intentional or just an oversight?
>>=20
>
> Sorry for that, It was a oversight. I will fix both.
>
> And I will only add your Tested-by tags to patch [2/3] and [3/3].
> Is this correct?

That's fine, Thanks.

--=20
Best regards,
Junhui Liu

