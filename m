Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463841D517A
	for <linux-mmc@vger.kernel.org>; Thu, 17 Oct 2024 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162991; cv=none; b=t3ngJ3t6xAqds9gXn06dq6v48EtVjnzqEhpqafdK7XoSeQ0lTzxh9eoRcpotil3N8fubFehzrehRo1lPv3a9GB0gZdH8hBx2TybX0j8INmqqutx4jxZFkZhN0zj0PXZcLw4dSljlSrIFb9L9dYw4dXQPmkbkxrGo52u9RiF6/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162991; c=relaxed/simple;
	bh=FBxEpMv95jAUtqrJmvMlDJmw8hCzAm/5/M7nERRARGA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvNF6OVBNVGyIJv4SC16/B6/sH3u4jwCUOOQi9+zgcH6LrYKfjlX2y+SvvfCPvSUCwJDASlMXm+6B6VgXpMlRwyn7fYSwVj/mJMmBJVap9mW8anqsGTjVXvqA8SQ2J751QpSuX/b5fwyrCnKXWYw7vnafXd9QS5+kvfi+CdJDVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dsc2CUd2; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dsc2CUd2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1729162980; x=1729422180;
	bh=FBxEpMv95jAUtqrJmvMlDJmw8hCzAm/5/M7nERRARGA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dsc2CUd2huQnURbHT2YcVLGZjRF5b0SJfwHJ6cPdoO1yUO15aamqhBa5oAaOs8YR5
	 y5At4xHRHzrqaLlUZ6zq+cHxAP7H0kr9HCLoh4OpCwB9uXANkkAJA4aSvTgh0x6tqi
	 MYA8Bjk4xu7iAsY7w5CDcrTNSAtdUM4juEFrgYhGVdxnaAfI73tPNWMG24HHL+ZqLW
	 F8TWaz0Rqj8omB53EbOMPF0q6Go6PWzCBflhyECDhqowgQqMqEjX6i8wSUDsbAcC+4
	 cLPzKdauY6I0lJDpYPbt6AfCO3yHi4PO2gVHzXpAono0nFcejLWuxgbiN7l1w4bHgi
	 NSCS8k8hVUsJQ==
Date: Thu, 17 Oct 2024 11:02:55 +0000
To: Shawn Lin <shawn.lin@rock-chips.com>
From: sydarn <sydarn@proton.me>
Cc: Adam Green <greena88@gmail.com>, regressions@lists.linux.dev, linux-kernel@vger.kernel.org, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: Re: Unable to handle kernel paging request at virtual address ffffffc08058e000
Message-ID: <ziwdBCnXuueftpsLEbuPLnsq81mkIIY8aMRd07gGqPHrJ7ivO0PYUJ3Ik5dcguC1YgM_So6u4OwgYXIChhUvXlZ2GuG5pTlfOsFFd7gQe18=@proton.me>
In-Reply-To: <3748add3-18e5-42ef-9d48-93650cfc0682@rock-chips.com>
References: <CAC8uq=Ppnmv98mpa1CrWLawWoPnu5abtU69v-=G-P7ysATQ2Pw@mail.gmail.com> <3748add3-18e5-42ef-9d48-93650cfc0682@rock-chips.com>
Feedback-ID: 92491476:user:proton
X-Pm-Message-ID: 790c47bfe94c8121b7c0ddd8365812c7fcfa5afc
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> =E5=9C=A8 2024/10/16 17:55, Adam Green =E5=86=99=E9=81=93:
>=20
> > Good morning,
> >=20
> > I would like to report a regression that appears to have been
> > introduced into the linux kernel since v6.9.
>=20
>=20
> I didn't see many patches for dw_mmc since 6.9. So I guess the fastest
> way is to do a bisect. Or maybe you could try reverting this commit
> first to see what will happen.
>=20
> commit 8396c793ffdf28bb8aee7cfe0891080f8cab7890
> Author: Sam Protsenko semen.protsenko@linaro.org
>=20
> Date: Wed Mar 6 17:20:52 2024 -0600
>=20
> mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K

We have reverted this commit and done some testing on 6.10.13. We have not =
had a panic so far. It was specifically prone to happen during our initiali=
zation process, I tested that 7 times successfully yesterday. It used to ha=
ppen more than 50% of time during that process.

> > My device is currently experiencing a panic booting the kernel/rootfs
> > from an SD card.
> >=20
> > The device is a Powkiddy RGB30 which is a portable handheld gaming
> > console with a Rockchip RK3566 SoC (arm64).
> >=20
> > I have tested a variety of devices from a couple of manufacturers with
> > the same SoC and they all have the same issue,
> > I have also tested, 6.12-rc3 and linux-next and the same issue appears =
present.
> >=20
> > A full UART dump can be found here: https://clbin.com/zLZAW
> >=20
> > [ 41.547983] Unable to handle kernel paging request at virtual
> > address ffffffc08058e000
> > [ 41.553426] Mem abort info:
> > [ 41.558231] ESR =3D 0x0000000096000007
> > [ 41.563115] EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [ 41.568135] SET =3D 0, FnV =3D 0
> > [ 41.572882] EA =3D 0, S1PTW =3D 0
> > [ 41.577575] FSC =3D 0x07: level 3 translation fault
> > [ 41.582404] Data abort info:
> > [ 41.586995] ISV =3D 0, ISS =3D 0x00000007, ISS2 =3D 0x00000000
> > [ 41.591848] CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > [ 41.596664] GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > [ 41.601457] swapper pgtable: 4k pages, 39-bit VAs, pgdp=3D000000000363=
e000
> > [ 41.606359] [ffffffc08058e000] pgd=3D1000000000225003,
> > p4d=3D1000000000225003, pud=3D1000000000225003, pmd=3D1000000000c8c003,
> > pte=3D0000000000000000
> > [ 41.616442] Internal error: Oops: 0000000096000007 [#1] PREEMPT SMP
> > [ 41.621544] Modules linked in: hci_uart btrtl bluetooth rfkill
> > [ 41.626678] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc=
2 #1
> > [ 41.631922] Hardware name: Powkiddy RGB30 (DT)
> > [ 41.636951] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> > [ 41.642330] pc : dw_mci_idmac_start_dma+0xa0/0x358
> > [ 41.647585] lr : __dw_mci_start_request+0x21c/0x6a0
> > [ 41.652827] sp : ffffffc080003da0
> > [ 41.657882] x29: ffffffc080003da0 x28: ffffff8001f06d80 x27: ffffffc08=
058d000
> > [ 41.663399] x26: ffffffc08058e000 x25: 0000000000002711 x24: 000000000=
0002000
> > [ 41.668864] x23: ffffff800167dc80 x22: 0000000080000012 x21: 000000000=
0001000
> > [ 41.674257] x20: 000000003b5d1000 x19: 0000000000001000 x18: 000000097=
2073a81
> > [ 41.679654] x17: ffffff9c39b47000 x16: ffffffc080000000 x15: 000000000=
0000001
> > [ 41.685074] x14: 0000000000000004 x13: 000001ba5087c8e8 x12: 000000000=
00001a8
> > [ 41.690506] x11: 0000000000000040 x10: ffffffe40628d890 x9 : 000000000=
0000000
> > [ 41.695972] x8 : ffffff803fd44080 x7 : 0000000008f0d180 x6 : 000000003=
b9ac9ff
> > [ 41.701495] x5 : 0000000000fffffe x4 : ffffffc08058de80 x3 : 00000000b=
2d05e00
> > [ 41.707073] x2 : ffffffe40546ab08 x1 : ffffffc08058e000 x0 : 000000000=
0001000
> > [ 41.712686] Call trace:
> > [ 41.717857] dw_mci_idmac_start_dma+0xa0/0x358
> > [ 41.723266] __dw_mci_start_request+0x21c/0x6a0
> > [ 41.728719] dw_mci_work_func+0x4c8/0x4d8
> > [ 41.734144] process_one_work+0x148/0x284
> > [ 41.739587] bh_worker+0x224/0x278
> > [ 41.744985] workqueue_softirq_action+0x78/0x88
> > [ 41.750545] tasklet_action+0x14/0x3c
> > [ 41.756023] handle_softirqs+0x100/0x23c
> > [ 41.761506] __do_softirq+0x14/0x20
> > [ 41.766917] ____do_softirq+0x10/0x20
> > [ 41.772301] call_on_irq_stack+0x24/0x54
> > [ 41.777689] do_softirq_own_stack+0x1c/0x40
> > [ 41.783106] irq_exit_rcu+0x94/0xd0
> > [ 41.788455] el1_interrupt+0x38/0x68
> > [ 41.793799] el1h_64_irq_handler+0x18/0x24
> > [ 41.799200] el1h_64_irq+0x68/0x6c
> > [ 41.804532] default_idle_call+0x28/0x58
> > [ 41.809931] do_idle+0x1fc/0x260
> > [ 41.815152] cpu_startup_entry+0x34/0x40
> > [ 41.820346] kernel_init+0x0/0x140
> > [ 41.825437] console_on_rootfs+0x0/0x6c
> > [ 41.830477] __primary_switched+0x80/0x88
> > [ 41.835501] Code: 54000280 d294f8c0 940e1f8c d503203f (b9400340)
> > [ 41.840748] ---[ end trace 0000000000000000 ]---
> > [ 41.845896] Kernel panic - not syncing: Oops: Fatal exception in inter=
rupt
> > [ 41.851321] SMP: stopping secondary CPUs
> > [ 41.856502] Kernel Offset: 0x2384800000 from 0xffffffc080000000
> > [ 41.861840] PHYS_OFFSET: 0x0
> > [ 41.866814] CPU features: 0x0c,00000014,00280928,4201720b
> > [ 41.872087] Memory Limit: none
> > [ 41.877119] Rebooting in 1 seconds..
> >=20
> > Best regards,
> >=20
> > Adam Green
