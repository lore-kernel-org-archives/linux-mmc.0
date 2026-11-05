Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.167
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793849580;
	b=IAUpYASy60mNd98HvwHtBn4OSReUh24FBkxn4FF+pUHk9UyD3/n19T/4woCwnP7XSCwD
	 wh5QSGkNmWn/Z0j2JnegqFHyur/GYE6klZP46IqKxZhO5q5oeE3wXhkKBcLQlOvCd8NmQ
	 uTgx701IpZwX2cYU1QQeRSdwLpqX2ZwNIAG5/sgVEtokvy+NDuBl4idr2YzO3loS/XY9n
	 IfG+YJFtdletULrZbj2mOnUkg/wSE+Hu+Ei/FKa0KUfGSf6as6Jk9pYc993YiGF3zF4sw
	 lwkXl6yX7K1ONXKoQbBNCInJHXhY6xCu3/YXdfDSOyLHLTK9nY3SVnbWyPfJAVBWNzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793849580;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=jIzkVeBI9b3PEm/Tr6PfIipXlg8et2MLSXZyIQ53oIE=;
	b=5shcsBPXOZGvOQhGso2QkMn65bf6CkYEBkz8oxf5Vxbr3qWJXV9HULZbWGluvKIWGg6B
	 yvWITBwa0dKjGWi0+5l0bfrjexg4Odq73IQg8HQMJUiMFUjARW4j/JsUYfeBO2HlporSk
	 y2OT3rF2gmKm0tavR8Ic9Jnlt7nOgFQcvRfq+dmZcSEelP0tRLS+BCbzcfQSu4BVDXqG4
	 jpn/EIW7QX6Rl2Y6Se3ADpSHMEA1Bdv7ptu5RTiEE1jWp7Us8hvn0HUOXRQtpRZHL5wN5
	 MzQmTmECVSbirLwyuahYc7VFcY+b5eXgBfchC6CLx5bGMbNacy0dK2wZ5KjENU2GoLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=lwFiiNKB;
	arc=none smtp.remote-ip=185.70.43.167
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CBA606A31B
	for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2026 03:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4CBA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=lwFiiNKB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1793849576; x=1794108776;
	bh=jIzkVeBI9b3PEm/Tr6PfIipXlg8et2MLSXZyIQ53oIE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lwFiiNKBs+wTOTOekItXMHg+620VO3If6nc9oABez1PyHXOZNYoMFQz9a1D+YilRe
	 N2tsOooKbaLFpTa3OvMNA0oD/ZuphvcB/qNOM4/+9tUaw/cXZt3M3ycSQ4Dgeusysm
	 +D6UE9xLk7qaJ8RCusMdArzoNblhhBEnSrMip24WMpTpx7m46AfAnNiLrl2Aaj03ut
	 2NV7mybIcLBPfJBo0D8s0N8HNC93JoADYXSxfHOABXEoxicv5efOGwjWwR7LroNI2E
	 uWzgj7pYcvvMEwqs+qFIY38SqQEAzsfdGImScwHSSmXfUGbpQ9FhkJZ7zfofTqzI7H
	 LeAGk8vJrv6eQ==
Date: Thu, 05 Nov 2026 03:32:49 +0000
To: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "rafael@kernel.org" <rafael@kernel.org>
From: Kyle Baedke <kylebaedke@protonmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Genesys GL9750 (17a0:9750) does not respond after its PCIe  slot is powered back on from D3cold, on s2idle resume and at runtime  (ASUS Vivobook 14 Flip TP3407SA, kernel 7.3.1)
Message-ID: <vqOfI4cXijz1Ft480-_mX3XkrTT_-oQ78Xy6CPrXD_r5R06i7H03y3szJFA7JAVs9YsW93_hUQ0hz5bTYItb7RUml3cGwxPmW9gPFIcNY-8=@protonmail.com>
In-Reply-To: <x4G_0cgWnHWJtmgP4iX3hFfwwbWDyVuO9Ps8Pv_Rnq4VguufBRLzZex1IxGuTtaYfU7tS7U8RbKjB2I54HxfEmPk3gzKWvYDAyuZXrtWbDU=@protonmail.com>
References: <x4G_0cgWnHWJtmgP4iX3hFfwwbWDyVuO9Ps8Pv_Rnq4VguufBRLzZex1IxGuTtaYfU7tS7U8RbKjB2I54HxfEmPk3gzKWvYDAyuZXrtWbDU=@protonmail.com>
Feedback-ID: 212527205:user:proton
X-Pm-Message-ID: e3f05f633c40ddf18529b7d5aa15b834ff41ae80
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wednesday, November 4th, 2026 at 2:52 PM, Kyle Baedke <kylebaedke@proton=
mail.com> wrote:
First copy was in html mode this should be in plaintext
> The GL9750 SD host controller in my laptop is dead after its PCIe slot ha=
s
> been powered off and back on through the root port's ACPI power resource.
> This happens on resume from s2idle, and I can also reproduce it at runtim=
e
> with no sleep involved. In both cases the link below the root port never
> comes up, so the device reads as all-ones. The sdhci errors are a
> consequence of that. I'm writing to the sdhci maintainers because the
> device is driven by sdhci-pci-gli, but the failure occurs before the
> driver can talk to the device.
>=20
> =3D=3D System =3D=3D
>=20
> =C2=A0 Laptop: =C2=A0 =C2=A0ASUS Vivobook 14 Flip TP3407SA
> =C2=A0 BIOS: =C2=A0 =C2=A0 =C2=A0TP3407SA.308, 03/05/2026 (the latest ava=
ilable)
> =C2=A0 Kernel: =C2=A0 =C2=A07.3.1 (NixOS 26.11), x86_64
> =C2=A0 Device: =C2=A0 =C2=A00000:2c:00.0 =C2=A0Genesys Logic GL9750 [17a0=
:9750] rev 1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0subsystem 1043:202f
> =C2=A0 Upstream: =C2=A0root port 0000:00:1c.4 (ACPI \_SB.PC00.RP05), link=
 2.5GT/s x1
> =C2=A0 Cmdline: =C2=A0 intel_iommu=3Don iommu=3Dpt pcie_aspm.policy=3Dpow=
ersave
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(the relevant parameters)
> =C2=A0 Sleep: =C2=A0 =C2=A0 /sys/power/mem_sleep =3D [s2idle] deep. Selec=
ting "deep" (S3)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hangs the machine and nee=
ds power to be cut to recover, so
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s2idle is the only usable=
 sleep mode.
>=20
> The root port's ACPI node has power resources (power_resources_D0 and
> power_resources_D3hot in sysfs). The endpoint's ACPI node has none.
>=20
> Other firmware/kernel messages seen at boot:
>=20
> =C2=A0 ACPI: \_SB_.PEPD: Duplicate LPS0 _DSM functions (mask: 0x1)
> =C2=A0 pci 0000:00:1c.4: mask Replay Timer Timeout Correctable Errors due=
 to
> =C2=A0 =C2=A0 =C2=A0 0000:2c:00.0 hardware defect
>=20
> =3D=3D Symptom =3D=3D
>=20
> After the slot is powered back on, config space reads of the device retur=
n
> ffff, the port's Link Status stays 0x1011 (Data Link Layer Link Active =
=3D 0,
> not training), and sdhci reports:
>=20
> =C2=A0 mmc0: sdhci: Version: 0x0000ffff =C2=A0 (register dump is all 0xff=
)
> =C2=A0 mmc0: enable PCI MSI failed, error=3D-22
> =C2=A0 mmc0: Reset 0x1 never completed.
> =C2=A0 mmc0: 3.3V regulator output did not become stable
> =C2=A0 mmc0: Controller never released inhibit bit(s).
>=20
> On a healthy boot the port's Link Status is 0x3011.
>=20
> =3D=3D Resume trace =3D=3D
>=20
> Captured with rtcwake -m mem -s 15 (s2idle), pm_debug_messages=3D1 and
> dynamic debug enabled for drivers/pci/*, drivers/acpi/power.c and
> drivers/acpi/device_pm.c:
>=20
> =C2=A0 [ =C2=A0145.370215] sdhci-pci 0000:2c:00.0: PCI PM: Suspend power =
state: D3hot
> =C2=A0 [ =C2=A0145.406917] ACPI: \_SB_.PC00.RP05.PXP_: ACPI: PM: Power re=
source turned off
> =C2=A0 [ =C2=A0145.406948] pcieport 0000:00:1c.4: PCI PM: Suspend power s=
tate: D3cold
> =C2=A0 ...
> =C2=A0 [ =C2=A0159.865842] ACPI: \_SB_.PC00.RP05: PM: Power state change:=
 D3cold -> D0
> =C2=A0 [ =C2=A0160.263869] ACPI: \_SB_.PC00.RP05.PXP_: ACPI: PM: Power re=
source turned on
> =C2=A0 [ =C2=A0160.264234] ACPI: \_SB_.PC00.RP05: PM: Power state changed=
 to D0
> =C2=A0 [ =C2=A0160.264241] pcieport 0000:00:1c.4: power state changed by =
ACPI to D0
> =C2=A0 [ =C2=A0160.276459] pcieport 0000:00:1c.4: ready 0ms after power u=
p D3hot->D0uninitialized
> =C2=A0 [ =C2=A0160.276866] pcieport 0000:00:1c.4: waiting 100 ms for down=
stream link, after activation
> =C2=A0 [ =C2=A0161.297053] pcieport 0000:00:1c.4: Data Link Layer Link Ac=
tive not set in 100 msec
> =C2=A0 [ =C2=A0161.303943] sdhci-pci 0000:2c:00.0: restore config 0x3c: 0=
xffffffff -> 0x000001ff
> =C2=A0 [ =C2=A0161.321478] mmc0: enable PCI MSI failed, error=3D-22
> =C2=A0 [ =C2=A0161.421611] mmc0: Reset 0x1 never completed.
> =C2=A0 [ =C2=A0161.741170] mmc0: 3.3V regulator output did not become sta=
ble
>=20
> The slot was off for about 15 s (145.407 to 160.264), so this is not a
> short-off-time problem.
>=20
> =3D=3D Reproduction without suspend =3D=3D
>=20
> From a healthy boot (device alive, no SD card inserted):
>=20
> =C2=A0 echo 1 =C2=A0 =C2=A0> /sys/bus/pci/devices/0000:2c:00.0/remove
> =C2=A0 echo 1 =C2=A0 =C2=A0> /sys/bus/pci/devices/0000:00:1c.4/d3cold_all=
owed
> =C2=A0 echo auto > /sys/bus/pci/devices/0000:00:1c.4/power/control
> =C2=A0 # the root port's power_state reached D3cold after about 2 s
> =C2=A0 sleep 1
> =C2=A0 echo on =C2=A0 > /sys/bus/pci/devices/0000:00:1c.4/power/control
> =C2=A0 # port is D0 again, but its Link Status is 0x1011 (DLActive =3D 0)
> =C2=A0 echo 1 =C2=A0 =C2=A0> /sys/bus/pci/rescan =C2=A0 =C2=A0 # repeated=
 once per second for 15 s
>=20
> The device never reappears, and Link Status stays 0x1011 for the whole
> 15 s. This uses only a 1 s off time.
>=20
> =3D=3D What I tried =3D=3D
>=20
> Suspend variants, each run with rtcwake -m mem -s 15 (s2idle), no SD card
> inserted. All of these failed on the first cycle:
>=20
> =C2=A0 - no changes
> =C2=A0 - endpoint power/control=3Don
> =C2=A0 - root port power/control=3Don
> =C2=A0 - endpoint link/l1_2_aspm and link/l1_2_pcipm set to 0
> =C2=A0 - endpoint link/l1_aspm, l1_1_aspm, l1_2_aspm, l1_1_pcipm, l1_2_pc=
ipm
> =C2=A0 =C2=A0 all set to 0
> =C2=A0 - endpoint removed before suspend, rescanned after resume
>=20
> This one passed 10/10 cycles (device alive 2 s and 8 s after resume, port
> Link Status 0x3011 each time):
>=20
> =C2=A0 - d3cold_allowed=3D0 on both the endpoint and the root port, set j=
ust
> =C2=A0 =C2=A0 before suspend and restored to 1 right after resume
>=20
> Recovery attempted after a failed resume, with the root port held in D0
> (power/control=3Don) and the rescan polled for 15 s per stage. None broug=
ht
> the device back, and Link Status stayed 0x1011 throughout:
>=20
> =C2=A0 - remove + rescan
> =C2=A0 - secondary bus reset on the root port, then rescan
> =C2=A0 - Link Disable / enable on the root port, then rescan
>=20
> =3D=3D Questions =3D=3D
>=20
> 1. Is this a known issue with this device or this platform's slot power-o=
n
> =C2=A0 =C2=A0method?
> 2. What additional tracing would help (ACPI AML debugging, GPIO/pinctrl
> =C2=A0 =C2=A0state before and after the power resource turns on, anything=
 else)?
>=20
> I can build and test patches on this machine.
>=20
> Thanks,
> Kyle
>=20
> Sent with Proton Mail secure email.
