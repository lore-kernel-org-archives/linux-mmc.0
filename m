From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: Devicetree: Initialization order of mmc block devices?
Date: Thu, 19 Jul 2012 10:07:32 +0200
Message-ID: <20120719100732.0197abf9@skate>
References: <5006571A.7060103@de.bosch.com>
	<CAJe_ZhcY78ah81zsfwXxE=bMG4o6v9RwZV_DQyUj7g=d-1hR_w@mail.gmail.com>
	<50068696.8070408@de.bosch.com>
	<CAJe_Zhfmn4dUHk6xtudwCEurigvX64xce3VAozdjDdpSWSbRkA@mail.gmail.com>
	<5006C40D.300@de.bosch.com>
	<5006CE33.2040205@boundarydevices.com>
	<5006D361.2070705@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:37131 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab2GSIHp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jul 2012 04:07:45 -0400
In-Reply-To: <5006D361.2070705@de.bosch.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Knut Wohlrab <knut.wohlrab@de.bosch.com>
Cc: Eric Nelson <eric.nelson@boundarydevices.com>, Jassi Brar <jaswinder.singh@linaro.org>, "Behme Dirk (CM-AI/PJ-CF32)" <Dirk.Behme@de.bosch.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Le Wed, 18 Jul 2012 17:16:49 +0200,
Knut Wohlrab <knut.wohlrab@de.bosch.com> a =C3=A9crit :

> No, because we have to know which will be the name of the root device=
=20
> _before_ we start the kernel. In our embedded device we start the ker=
nel=20
> with a bootloader (U-Boot) and pass the root device with the kernel=20
> command line parameter "root=3D/dev/mmcblk0p1". That is not possible =
if we=20
> do not know what will be the name of the root device (mmcblk0 or=20
> mmcblk1) when kernel try to mount it.

You can always work around this by having a minimal initramfs inside
your kernel, which contains a basic userspace environment that will
just locate the right location of the real root filesystem, mount it,
and switch to it. But I agree that it's a bit painful to have such a
complexity just to identify which device contains the root filesystem.

I also believe the root=3DUUID=3D... thing does not work when root=3D i=
s
parsed by the kernel, unless you have a GPT partition table or
something like that. With the old-style partition table, the UUIDs are
inside the filesystems, and the kernel does not know about them. At
least that was my understanding of the matter about a year ago when I
looked into this.

Best regards,

Thomas
--=20
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
