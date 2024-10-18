Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E66163;
	Fri, 18 Oct 2024 00:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729209996; cv=none; b=LM9kxcYiYqdwImiD5ppPcN1jSZTxNWRXfr9LqBxknAPxXrRt2dPCACtHTAWrrcCEqxjEKObXfHc410VmwjfYCQaQ8ryyk958ZeNgNEejRYeKxP85yJurbPRecTqk3LKcwZdLdFl1IvLKSZPQ9wIDrcDyH/v8JV5pIs6z5xR51nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729209996; c=relaxed/simple;
	bh=H6xshl3cAlvW6/QQ9FxnJ+S3Q72o1WYPBibQ9mwMkKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzYpU/VhICk5UKAtCJJUoFEgH1b0WnkCc8Ra5+N28HR8wiY2qMPVEGlBNZO++vzRy1LFlAzs5bL2s+Apb0KacFxg5SUw1R2i5N+tNEedzACwwxbQMbvAML+ThSZzcz/vetMP6UDGEFH92oBweDNDjQui7HrV5a2xSnRkWS4UkHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2upI3Vi; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2upI3Vi"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99f629a7aaso268953966b.1;
        Thu, 17 Oct 2024 17:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729209993; x=1729814793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNw7sAgdWlGtM5VTjhVdQ8AXHr/R2EoJLtajoD5H0k8=;
        b=j2upI3ViIxJZfw43Unp+nBY8zKpXBG76RI9NSTJrWTmQLniQLRWDT9MY+trKVuKu9c
         eEVLyqtTbiyXZmhITwx8gtteeFrzhLNWprnAdBsMC5vmSS982csRIpyYiODm11uHrv+U
         n+QPhXwoJMPmF7aJQtMFhw8oRNOFCGAfcuSl0hDDNLrAfRfJ4r3bopPTm1vYPcJa+bes
         4344ecOV0rlCP7307+L9ceP6I1QY8E9a4RrR7LuD+tIpAlbmfrtAragNdEivOSzy69cb
         vbDqY8NvgOEy4HIWMUrS4sXTSShr0W3Vtp1gtTPdo8JcdiAeFMJ+UFcodA0X/TBERLoD
         tvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729209993; x=1729814793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNw7sAgdWlGtM5VTjhVdQ8AXHr/R2EoJLtajoD5H0k8=;
        b=w3GtlISg4cRyS/aPwtpvrVywVXOYm6V8Tpu3ESKEcMteFX/GUe+UAzNKjajY46NXao
         PSw4Gk7g9BbZAhK5CwHmfhWF3bgsk+scIXmp3R3Y4lxJJ/HfZ5EDLqPq9HtGNiozOMs1
         8dWrMqmTztt3YfIrABY9Wog/I+OZE4UZ4byHXg0Z9J81TEzAelzymVDXbvBLwnszSppn
         w+PoSCAcGly3O/ZWEyzj4IVwNr5On89rcUs4UvvaELii6EJ8Ehxorj+fC29RqJuWDaIn
         k/W9f/3RlNOKjqQzzxEtvkyU/FaP3lgOtTWZsLdtFznOksB4obp6GCMLsl4hw0vuvvWD
         P3iw==
X-Forwarded-Encrypted: i=1; AJvYcCWE6zL4MhsC6J6abE7czbqVgHLbQWghGFP66FKtzl8tpemH9rwcuThgjk2MMUaqVTJA+SJg3UITQWad@vger.kernel.org, AJvYcCXfDay/GpdOtLFooSO8nwE4RH3q0pN6YoOXCBq9PatwOFMAZom0/iUbpcw04UMfKLpYCmUQx/NuA4Qg5b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoJa/J4UJkiRIy6DgQW883MLAm3Uf5fcsYhbCDPJH9m4FoTTFJ
	MfCVqAZQeoFjCF8+LY128coaslE+/3hOlyu5PEJTN7sljlWT2ggzw82Wp/CppeIj54ZbL5tQ/nb
	qLvdppnN1sWCM5w4UtyMyN5ZvJz4q2Soa/m8=
X-Google-Smtp-Source: AGHT+IE3G+wfjPawkXm5j8jTbobX3vxxYNhvVPeuJ1d809QQ3xGto8AGRUgX7zlbPptAc1TL+z8AVr5AFCvddAbtYpE=
X-Received: by 2002:a17:907:7213:b0:a99:4112:5e6e with SMTP id
 a640c23a62f3a-a9a4c2c5301mr549660466b.3.1729209992785; Thu, 17 Oct 2024
 17:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC8uq=Ppnmv98mpa1CrWLawWoPnu5abtU69v-=G-P7ysATQ2Pw@mail.gmail.com>
 <3748add3-18e5-42ef-9d48-93650cfc0682@rock-chips.com>
In-Reply-To: <3748add3-18e5-42ef-9d48-93650cfc0682@rock-chips.com>
From: Adam Green <greena88@gmail.com>
Date: Fri, 18 Oct 2024 01:06:21 +0100
Message-ID: <CAC8uq=O=519iRpcs7p+jZaKngkCDuawLz8NVZYORY6qfGPifZg@mail.gmail.com>
Subject: Re: Unable to handle kernel paging request at virtual address ffffffc08058e000
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, sydarn@proton.me, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

I can confirm that after reverting

commit 8396c793ffdf28bb8aee7cfe0891080f8cab7890
Author: Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed Mar 6 17:20:52 2024 -0600

    mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K

that the problem does appear to have resolved itself, I tested this on
a variety of devices.

Best regards,

Adam

On Wed, 16 Oct 2024 at 11:13, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> =E5=9C=A8 2024/10/16 17:55, Adam Green =E5=86=99=E9=81=93:
> > Good morning,
> >
> > I would like to report a regression that appears to have been
> > introduced into the linux kernel since v6.9.
> >
>
> I didn't see many patches for dw_mmc since 6.9. So I guess the fastest
> way is to do a bisect. Or maybe you could try reverting this commit
> first to see what will happen.
>
> commit 8396c793ffdf28bb8aee7cfe0891080f8cab7890
> Author: Sam Protsenko <semen.protsenko@linaro.org>
> Date:   Wed Mar 6 17:20:52 2024 -0600
>
>      mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K
>
>
> > My device is currently experiencing a panic booting the kernel/rootfs
> > from an SD card.
> >
> > The device is a Powkiddy RGB30 which is a portable handheld gaming
> > console with a Rockchip RK3566 SoC (arm64).
> >
> > I have tested a variety of devices from a couple of manufacturers with
> > the same SoC and they all have the same issue,
> > I have also tested, 6.12-rc3 and linux-next and the same issue appears =
present.
> >
> > A full UART dump can be found here: https://clbin.com/zLZAW
> >
> > [   41.547983] Unable to handle kernel paging request at virtual
> > address ffffffc08058e000
> > [   41.553426] Mem abort info:
> > [   41.558231]   ESR =3D 0x0000000096000007
> > [   41.563115]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [   41.568135]   SET =3D 0, FnV =3D 0
> > [   41.572882]   EA =3D 0, S1PTW =3D 0
> > [   41.577575]   FSC =3D 0x07: level 3 translation fault
> > [   41.582404] Data abort info:
> > [   41.586995]   ISV =3D 0, ISS =3D 0x00000007, ISS2 =3D 0x00000000
> > [   41.591848]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > [   41.596664]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > [   41.601457] swapper pgtable: 4k pages, 39-bit VAs, pgdp=3D0000000003=
63e000
> > [   41.606359] [ffffffc08058e000] pgd=3D1000000000225003,
> > p4d=3D1000000000225003, pud=3D1000000000225003, pmd=3D1000000000c8c003,
> > pte=3D0000000000000000
> > [   41.616442] Internal error: Oops: 0000000096000007 [#1] PREEMPT SMP
> > [   41.621544] Modules linked in: hci_uart btrtl bluetooth rfkill
> > [   41.626678] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-=
rc2 #1
> > [   41.631922] Hardware name: Powkiddy RGB30 (DT)
> > [   41.636951] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [   41.642330] pc : dw_mci_idmac_start_dma+0xa0/0x358
> > [   41.647585] lr : __dw_mci_start_request+0x21c/0x6a0
> > [   41.652827] sp : ffffffc080003da0
> > [   41.657882] x29: ffffffc080003da0 x28: ffffff8001f06d80 x27: ffffffc=
08058d000
> > [   41.663399] x26: ffffffc08058e000 x25: 0000000000002711 x24: 0000000=
000002000
> > [   41.668864] x23: ffffff800167dc80 x22: 0000000080000012 x21: 0000000=
000001000
> > [   41.674257] x20: 000000003b5d1000 x19: 0000000000001000 x18: 0000000=
972073a81
> > [   41.679654] x17: ffffff9c39b47000 x16: ffffffc080000000 x15: 0000000=
000000001
> > [   41.685074] x14: 0000000000000004 x13: 000001ba5087c8e8 x12: 0000000=
0000001a8
> > [   41.690506] x11: 0000000000000040 x10: ffffffe40628d890 x9 : 0000000=
000000000
> > [   41.695972] x8 : ffffff803fd44080 x7 : 0000000008f0d180 x6 : 0000000=
03b9ac9ff
> > [   41.701495] x5 : 0000000000fffffe x4 : ffffffc08058de80 x3 : 0000000=
0b2d05e00
> > [   41.707073] x2 : ffffffe40546ab08 x1 : ffffffc08058e000 x0 : 0000000=
000001000
> > [   41.712686] Call trace:
> > [   41.717857]  dw_mci_idmac_start_dma+0xa0/0x358
> > [   41.723266]  __dw_mci_start_request+0x21c/0x6a0
> > [   41.728719]  dw_mci_work_func+0x4c8/0x4d8
> > [   41.734144]  process_one_work+0x148/0x284
> > [   41.739587]  bh_worker+0x224/0x278
> > [   41.744985]  workqueue_softirq_action+0x78/0x88
> > [   41.750545]  tasklet_action+0x14/0x3c
> > [   41.756023]  handle_softirqs+0x100/0x23c
> > [   41.761506]  __do_softirq+0x14/0x20
> > [   41.766917]  ____do_softirq+0x10/0x20
> > [   41.772301]  call_on_irq_stack+0x24/0x54
> > [   41.777689]  do_softirq_own_stack+0x1c/0x40
> > [   41.783106]  irq_exit_rcu+0x94/0xd0
> > [   41.788455]  el1_interrupt+0x38/0x68
> > [   41.793799]  el1h_64_irq_handler+0x18/0x24
> > [   41.799200]  el1h_64_irq+0x68/0x6c
> > [   41.804532]  default_idle_call+0x28/0x58
> > [   41.809931]  do_idle+0x1fc/0x260
> > [   41.815152]  cpu_startup_entry+0x34/0x40
> > [   41.820346]  kernel_init+0x0/0x140
> > [   41.825437]  console_on_rootfs+0x0/0x6c
> > [   41.830477]  __primary_switched+0x80/0x88
> > [   41.835501] Code: 54000280 d294f8c0 940e1f8c d503203f (b9400340)
> > [   41.840748] ---[ end trace 0000000000000000 ]---
> > [   41.845896] Kernel panic - not syncing: Oops: Fatal exception in int=
errupt
> > [   41.851321] SMP: stopping secondary CPUs
> > [   41.856502] Kernel Offset: 0x2384800000 from 0xffffffc080000000
> > [   41.861840] PHYS_OFFSET: 0x0
> > [   41.866814] CPU features: 0x0c,00000014,00280928,4201720b
> > [   41.872087] Memory Limit: none
> > [   41.877119] Rebooting in 1 seconds..
> >
> > Best regards,
> >
> > Adam Green
>
