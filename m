From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] mmc: pxamci: call mmc_remove_host() before freeing
	resources
Date: Wed, 2 Dec 2009 08:50:44 +0800
Message-ID: <f17812d70912011650h48a6c391s426ffc8b4b653fc8@mail.gmail.com>
References: <1259687838-31722-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:56065 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbZLBAu6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2009 19:50:58 -0500
In-Reply-To: <1259687838-31722-1-git-send-email-daniel@caiaq.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-kernel@vger.kernel.org, Pierre Ossman <pierre@ossman.eu>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@kernel.org

On Wed, Dec 2, 2009 at 1:17 AM, Daniel Mack <daniel@caiaq.de> wrote:
> mmc_remove_host() will cause the mmc core to switch off the bus power=
 by
> eventually calling pxamci_set_ios(). This function uses the regulator=
 or
> the GPIO which have been freed already.
>
> This causes the following Oops on module unload.
>
> [ =C2=A0 49.519649] Unable to handle kernel paging request at virtual=
 address 30303a70
> [ =C2=A0 49.526878] pgd =3D c7084000
> [ =C2=A0 49.529563] [30303a70] *pgd=3D00000000
> [ =C2=A0 49.533136] Internal error: Oops: 5 [#1]
> [ =C2=A0 49.537025] last sysfs file: /sys/devices/platform/pxa27x-ohc=
i/usb1/1-1/1-1:1.0/host0/target0:0:0/0:0:0:0/scsi_level
> [ =C2=A0 49.547471] Modules linked in: pxamci(-) eeti_ts
> [ =C2=A0 49.552061] CPU: 0 =C2=A0 =C2=A0Not tainted =C2=A0(2.6.32-rc8=
 #322)
> [ =C2=A0 49.557001] PC is at regulator_is_enabled+0x3c/0xbc
> [ =C2=A0 49.561846] LR is at regulator_is_enabled+0x30/0xbc
> [ =C2=A0 49.566691] pc : [<c01a2448>] =C2=A0 =C2=A0lr : [<c01a243c>] =
=C2=A0 =C2=A0psr: 60000013
> [ =C2=A0 49.566702] sp : c7083e70 =C2=A0ip : 30303a30 =C2=A0fp : 0000=
0000
> [ =C2=A0 49.578093] r10: c705e200 =C2=A0r9 : c7082000 =C2=A0r8 : c705=
e2e0
> [ =C2=A0 49.583280] r7 : c7061340 =C2=A0r6 : c7061340 =C2=A0r5 : c708=
3e70 =C2=A0r4 : 00000000
> [ =C2=A0 49.589759] r3 : c04dc434 =C2=A0r2 : c04dc434 =C2=A0r1 : c03e=
ecea =C2=A0r0 : 00000047
> [ =C2=A0 49.596241] Flags: nZCv =C2=A0IRQs on =C2=A0FIQs on =C2=A0Mod=
e SVC_32 =C2=A0ISA ARM =C2=A0Segment user
> [ =C2=A0 49.603329] Control: 0000397f =C2=A0Table: a7084018 =C2=A0DAC=
: 00000015
> [ =C2=A0 49.609031] Process rmmod (pid: 1101, stack limit =3D 0xc7082=
278)
> [ =C2=A0 49.614908] Stack: (0xc7083e70 to 0xc7084000)
> [ =C2=A0 49.619238] 3e60: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 c7082000 c703c4f8 c705ea00 c04f4074
> [ =C2=A0 49.627366] 3e80: 00000000 c705e3a0 ffffffff c0247ddc c70361a=
0 00000000 c705e3a0 ffffffff
> [ =C2=A0 49.635499] 3ea0: c705e200 bf006400 c78c4f00 c705e200 c705e3a=
0 ffffffff c705e200 ffffffff
> [ =C2=A0 49.643633] 3ec0: c04d8ac8 c02476d0 ffffffff c0247c60 c705e20=
0 c0248678 c705e200 c0249064
> [ =C2=A0 49.651765] 3ee0: ffffffff bf006204 c04d8ad0 c04d8ad0 c04d8ac=
8 bf007490 00000880 c00440c4
> [ =C2=A0 49.659898] 3f00: 0000b748 c01c5708 bf007490 c01c44c8 c04d8ac=
8 c04d8afc bf007490 c01c4570
> [ =C2=A0 49.668031] 3f20: bf007490 bf00750c c04f4258 c01c37a4 0000000=
0 bf00750c c7083f44 c007b014
> [ =C2=A0 49.676162] 3f40: 4000d000 6d617870 08006963 00000001 0000000=
0 c7085000 00000001 00000000
> [ =C2=A0 49.684287] 3f60: 4000d000 c7083f8c 00000001 bea01a54 0000540=
1 c7ab1400 c00440c4 00082000
> [ =C2=A0 49.692420] 3f80: bf00750c 00000880 c7083f8c 00000000 4000cfa=
8 00000000 00000880 bea01cc8
> [ =C2=A0 49.700552] 3fa0: 00000081 c0043f40 00000000 00000880 bea01cc=
8 00000880 00000006 00000000
> [ =C2=A0 49.708677] 3fc0: 00000000 00000880 bea01cc8 00000081 0000009=
7 0000cca4 0000b748 00000000
> [ =C2=A0 49.716802] 3fe0: 4001a4f0 bea01cc0 00018bf4 4001a4fc 2000001=
0 bea01cc8 a063e021 a063e421
> [ =C2=A0 49.724958] [<c01a2448>] (regulator_is_enabled+0x3c/0xbc) fro=
m [<c0247ddc>] (mmc_regulator_set_ocr+0x14/0xd8)
> [ =C2=A0 49.734836] [<c0247ddc>] (mmc_regulator_set_ocr+0x14/0xd8) fr=
om [<bf006400>] (pxamci_set_ios+0xd8/0x17c [pxamci])
> [ =C2=A0 49.745044] [<bf006400>] (pxamci_set_ios+0xd8/0x17c [pxamci])=
 from [<c02476d0>] (mmc_power_off+0x50/0x58)
> [ =C2=A0 49.754555] [<c02476d0>] (mmc_power_off+0x50/0x58) from [<c02=
47c60>] (mmc_detach_bus+0x68/0xc4)
> [ =C2=A0 49.763207] [<c0247c60>] (mmc_detach_bus+0x68/0xc4) from [<c0=
248678>] (mmc_stop_host+0xd4/0x1bc)
> [ =C2=A0 49.771944] [<c0248678>] (mmc_stop_host+0xd4/0x1bc) from [<c0=
249064>] (mmc_remove_host+0xc/0x20)
> [ =C2=A0 49.780681] [<c0249064>] (mmc_remove_host+0xc/0x20) from [<bf=
006204>] (pxamci_remove+0xc8/0x174 [pxamci])
> [ =C2=A0 49.790211] [<bf006204>] (pxamci_remove+0xc8/0x174 [pxamci]) =
from [<c01c5708>] (platform_drv_remove+0x1c/0x24)
> [ =C2=A0 49.800164] [<c01c5708>] (platform_drv_remove+0x1c/0x24) from=
 [<c01c44c8>] (__device_release_driver+0x7c/0xc4)
> [ =C2=A0 49.810110] [<c01c44c8>] (__device_release_driver+0x7c/0xc4) =
from [<c01c4570>] (driver_detach+0x60/0x8c)
> [ =C2=A0 49.819535] [<c01c4570>] (driver_detach+0x60/0x8c) from [<c01=
c37a4>] (bus_remove_driver+0x90/0xcc)
> [ =C2=A0 49.828452] [<c01c37a4>] (bus_remove_driver+0x90/0xcc) from [=
<c007b014>] (sys_delete_module+0x1d8/0x254)
> [ =C2=A0 49.837891] [<c007b014>] (sys_delete_module+0x1d8/0x254) from=
 [<c0043f40>] (ret_fast_syscall+0x0/0x28)
> [ =C2=A0 49.847145] Code: eb06c53a e596c030 e1a0500d e59f106c (e59c00=
40)
> [ =C2=A0 49.853566] ---[ end trace b5fa66a00cea142f ]---
>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Reported-by: Sven Neumann <s.neumann@raumfeld.com>
> Cc: Pierre Ossman <pierre@ossman.eu>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: stable@kernel.org
> ---
> =C2=A0drivers/mmc/host/pxamci.c | =C2=A0 =C2=A04 ++--

Looks like a correct fix to me.

Acked-by: Eric Miao <eric.y.miao@gmail.com>
