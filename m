Received: from us-smtp-delivery-195.mimecast.com (us-smtp-delivery-195.mimecast.com [170.10.133.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B425553
	for <linux-mmc@vger.kernel.org>; Tue, 16 Jan 2024 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438111; cv=none; b=J61O1FQZrMR9Y9xCiy4HQEJXIKhIp4oLZYldQO10sHAXj2zDrcAciKju8cQntVsy+6wS979pf2WXXnuDYp0btPDY+imnHxievHjIqUMRCrNER87QsLRdo3TI1h/sAfUXLHvYx4tKe6T2Iset18suSkVKjpJUf3Rb00RhJfnARnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438111; c=relaxed/simple;
	bh=XU2de0bL5iZc/XR29GdbO7F835X1pnpxwYHeBVW7gxw=;
	h=Received:X-MC-Unique:Received:X-Virus-Scanned:Received:Received:
	 Received:From:Subject:To:Organization:Message-ID:Date:User-Agent:
	 MIME-Version:X-Clacks-Overhead:X-Mimecast-Spam-Score:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding; b=DJZ6pJ9IqlvWFTFBnKXDZo2cihQcDjiwJVYngfW078Wgtj/YJw2+5us7XXIB90DjaX+HAlhG0lar0ztOVajy/ftLhQ+RPvxP+s7eljzS5lrSH6i+h/KBRv1pLSOu45sHkx1uElajn4C+z9NgZeklDPvX8eOLZxXPaUjhOQ7Ga7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mbari.org; spf=pass smtp.mailfrom=mbari.org; arc=none smtp.client-ip=170.10.133.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mbari.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mbari.org
Received: from sleet.shore.mbari.org (sleet.shore.mbari.org [134.89.12.10])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-z3veNk-ZNOCiVWvH_c0i9A-1; Tue,
 16 Jan 2024 15:48:27 -0500
X-MC-Unique: z3veNk-ZNOCiVWvH_c0i9A-1
Received: from localhost (localhost [127.0.0.1])
	by sleet.shore.mbari.org (Postfix) with ESMTP id A013281288C4B
	for <linux-mmc@vger.kernel.org>; Tue, 16 Jan 2024 12:48:26 -0800 (PST)
X-Virus-Scanned: amavis at sleet.shore.mbari.org
Received: from sleet.shore.mbari.org ([127.0.0.1])
 by localhost (sleet.shore.mbari.org [127.0.0.1]) (amavis, port 10026)
 with ESMTP id y9St2jHHPjSB for <linux-mmc@vger.kernel.org>;
 Tue, 16 Jan 2024 12:48:26 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by sleet.shore.mbari.org (Postfix) with ESMTP id 8834E81288C49
	for <linux-mmc@vger.kernel.org>; Tue, 16 Jan 2024 12:48:26 -0800 (PST)
Received: from [192.168.6.194] (raven.shore.mbari.org [134.89.10.221])
	by sleet.shore.mbari.org (Postfix) with ESMTPSA
	for <linux-mmc@vger.kernel.org>; Tue, 16 Jan 2024 12:48:26 -0800 (PST)
From: Brent Roman <brent@mbari.org>
Subject: Regression in sdhci-pci-o2micro.c
To: linux-mmc@vger.kernel.org
Organization: MBARI
Message-ID: <890a5a17-5ebf-4d59-c71f-a5e37a601cbd@mbari.org>
Date: Tue, 16 Jan 2024 12:48:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:46.0) Gecko/20100101 Firefox/46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mbari.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

I have an Intel Hades Canyon NUC (NUC8i7HVK)
whose O2 Micro based SD-Card reader is no longer identified when its=20
Linux kernel is updated past 5.12

I "fixed" this by reverting a change from 5/9/21=C2=A0 (git=20
efc58a96adcd29cc37487a60582d9d08b34f6640)
that inserted proper error checking after all the PCI config space reads=20
in the device probe.
This would be code removed enclosed in #if 0 below:

 =C2=A0=C2=A0=C2=A0 case PCI_DEVICE_ID_O2_SEABIRD0:
 =C2=A0=C2=A0=C2=A0 case PCI_DEVICE_ID_O2_SEABIRD1:
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* UnLock WP */
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D pci_read_config_byte(chip->p=
dev,
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 O2_SD_LOCK_WP, &scratch);
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ret)
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return ret;

 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 scratch &=3D 0x7f;
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 pci_write_config_byte(chip->pdev, O2=
_SD_LOCK_WP, scratch);

 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D pci_read_config_dword(chip->=
pdev,
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 O2_SD_PLL_SETTING, &scratch_32);
#if 0
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ret)
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return ret;
#endif

 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if ((scratch_32 & 0xff000000) =3D=3D=
 0x01000000) {
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 scratch_32 &=3D 0=
x0000FFFF;
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 scratch_32 |=3D 0=
x1F340000;

 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 pci_write_config_=
dword(chip->pdev,
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O2_SD_PLL_SETTI=
NG, scratch_32);
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 } else {
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 scratch_32 &=3D 0=
x0000FFFF;
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 scratch_32 |=3D 0=
x25100000;

 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 pci_write_config_=
dword(chip->pdev,
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O2_SD_PLL_SETTI=
NG, scratch_32);

 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D pci_read_=
config_dword(chip->pdev,
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 O2_SD_FUNC_REG=
4,
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 &scratch_32);
#if 0
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ret)
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 return ret;
#endif
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 scratch_32 |=3D (=
1 << 22);
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 pci_write_config_=
dword(chip->pdev,
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O2_SD_FUNC_REG4=
, scratch_32);
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }

Both those pci_read_config_dword() calls return -EINVAL on my machine.
The driver had been working earlier precisely because it was ignoring=20
these error returns from pci_read_config_dword.
Have you seen this behavior before on any other hardware?

The SDcard reader identifies as:
03:00.0 SD Host controller: O2 Micro, Inc. SD/MMC Card Reader Controller=20
(rev 01)
03:00.0 0805: 1217:8621 (rev 01)

I've been unable to find /any/ information on this chip.
Do you have any you could share?=C2=A0 A datasheet would be ideal :-)

Also:
I've always had to operate this driver with debug_quirks2=3D4 to disable=20
ultra high-speed support.
Is this a known issue?
Or, could it be a symptom of the failing pci_read_configs curing probe?

Thanks for your attention,

--=20
  Brent Roman                                   MBARI
  Software Engineer               Tel: (831) 775-1808
  mailto:brent@mbari.org   http://www.mbari.org/~brent

