Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61B320605A;
	Wed, 16 Oct 2024 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072567; cv=none; b=QmGmT9Yvu7dQrNR/8aMjUL3yOFgXBz7ucZV8PrMSjtnapML4t/kEF/U7kbShW9CazcZDIMYQQS4Yf+4biRiqyVU9O/zAPU8ltoHnB/ObCpMKVNKob9dVIcBS/2IsmDftXSgPOfof0WOrJn72WzX4bOKMtONR11PSOucjOBzzHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072567; c=relaxed/simple;
	bh=OyaDcQWeWDMNXD4XJ0lliYzzd5Widg/W6p5haR+rPnM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tkQBg5k4TrrwAhFqOiAOUyexg/S4TTz0GIxljxmOBjUXiI8QwXs67AFex13Ws4sLa2qAUB2zYvpqhzRGC89RHaofmdux+A5GFsqYHVN5VI64B6Y6ium0G4BHa2vggXussx3k7EYRZlQrSRfgtX8F/+SfhhI2Ow1wkfPMb4Trr0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BW3YTrGz; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW3YTrGz"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a26a5d6bfso287563266b.1;
        Wed, 16 Oct 2024 02:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729072564; x=1729677364; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I9Dk398NJFynNgEuEoYMoZMW+PxuCplcELYFZehVVxQ=;
        b=BW3YTrGzUjwvtu08x7aeb6WiM3vWDk+qUgk3XHpliFrxA8KdMDQlwSeMDX4zv3NDQR
         BwbECAQu9Co3ZedPvoZofBaLTFuTJ4sW2RmoC98wiQ/A+KXDosiF8+QdwYB42tn83lCt
         clftJot0WZSo4NTKZTwmAJR6rs/Q40YSEbf9RXD7QNRdyqFdu7J1Sn084Q/lFJAFiUFJ
         TnvDOyza0NOzVHaW8sBrY86xPIjKiefDUPuy9xllnP/U7yzV8cJyD+JkwGA08JbN1axM
         hXW0UCjSb1gV7fOIybYVrXJme4tL9J6kbghe4HQ04+RQutajk8B7+Zp+QNFNQXfYZOLF
         R6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729072564; x=1729677364;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I9Dk398NJFynNgEuEoYMoZMW+PxuCplcELYFZehVVxQ=;
        b=Spy6GfE3P2K0bjudODQNmyIImMhh9zNjPHdocnMtjaDjxv3uzHbj+s6nLFw3cJt30S
         IZNt3wudqFW5zMQ9SqLnaf0hr6r83Xr2txIHJi3wUeMZ6RU+IXAIIsy7F8QzKVQfE0gx
         8Yvvn7gf+WbZ/zZfKUtljyeRrGSsENP1lVIVr+bOoRpgSjz6lt0aGHMbLt+exzXixuoo
         LtdyM3A1DsGYI4K8O/hchc0SwUKCyZG32Xd3m/qTvHq2kfhP+g3BWMFknig0trKgGte+
         5INs125rYPqaO7LRbYxqk4uctJgVYdLW1/ggB2bSDfnEn5OuI93Y95TEihCO8YdOg79z
         sB1w==
X-Forwarded-Encrypted: i=1; AJvYcCW94HzOEQadSpW81pgSq3bkfACKoBwa8lNnvB79vR0gGlz6VIogiobUzk/BO6Feba8T4n6pg74TOkD6l1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyABrvvVj+nY7oCjnD7CuAEJFvZHF+XIlICx6qWqU27VFnriA7P
	x5BAu/5UMJn9QGKVnd7BEtm7pzjcm7VbXtkPwLJU6hnv5Ep4vyDZInvKt4Jef9O326q/9cbWhou
	OiusBMyk01S0LjMZ8Gs8/B9Ceo9bCFqy7y5s=
X-Google-Smtp-Source: AGHT+IH1DBOS0TpZDMFlnMjSSySR0I4oWJRyhNUfYKtNOpBAC9JSpyG+cJdwsn71m55gNBxDbDesiZ55p6k8DfTcAS0=
X-Received: by 2002:a17:907:26c2:b0:a99:40e3:23e8 with SMTP id
 a640c23a62f3a-a99e3e4c342mr1426169866b.51.1729072563860; Wed, 16 Oct 2024
 02:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Adam Green <greena88@gmail.com>
Date: Wed, 16 Oct 2024 10:55:53 +0100
Message-ID: <CAC8uq=Ppnmv98mpa1CrWLawWoPnu5abtU69v-=G-P7ysATQ2Pw@mail.gmail.com>
Subject: Unable to handle kernel paging request at virtual address ffffffc08058e000
To: linux-mmc@vger.kernel.org
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, 
	"shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, sydarn@proton.me
Content-Type: text/plain; charset="UTF-8"

Good morning,

I would like to report a regression that appears to have been
introduced into the linux kernel since v6.9.

My device is currently experiencing a panic booting the kernel/rootfs
from an SD card.

The device is a Powkiddy RGB30 which is a portable handheld gaming
console with a Rockchip RK3566 SoC (arm64).

I have tested a variety of devices from a couple of manufacturers with
the same SoC and they all have the same issue,
I have also tested, 6.12-rc3 and linux-next and the same issue appears present.

A full UART dump can be found here: https://clbin.com/zLZAW

[   41.547983] Unable to handle kernel paging request at virtual
address ffffffc08058e000
[   41.553426] Mem abort info:
[   41.558231]   ESR = 0x0000000096000007
[   41.563115]   EC = 0x25: DABT (current EL), IL = 32 bits
[   41.568135]   SET = 0, FnV = 0
[   41.572882]   EA = 0, S1PTW = 0
[   41.577575]   FSC = 0x07: level 3 translation fault
[   41.582404] Data abort info:
[   41.586995]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
[   41.591848]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   41.596664]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   41.601457] swapper pgtable: 4k pages, 39-bit VAs, pgdp=000000000363e000
[   41.606359] [ffffffc08058e000] pgd=1000000000225003,
p4d=1000000000225003, pud=1000000000225003, pmd=1000000000c8c003,
pte=0000000000000000
[   41.616442] Internal error: Oops: 0000000096000007 [#1] PREEMPT SMP
[   41.621544] Modules linked in: hci_uart btrtl bluetooth rfkill
[   41.626678] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc2 #1
[   41.631922] Hardware name: Powkiddy RGB30 (DT)
[   41.636951] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   41.642330] pc : dw_mci_idmac_start_dma+0xa0/0x358
[   41.647585] lr : __dw_mci_start_request+0x21c/0x6a0
[   41.652827] sp : ffffffc080003da0
[   41.657882] x29: ffffffc080003da0 x28: ffffff8001f06d80 x27: ffffffc08058d000
[   41.663399] x26: ffffffc08058e000 x25: 0000000000002711 x24: 0000000000002000
[   41.668864] x23: ffffff800167dc80 x22: 0000000080000012 x21: 0000000000001000
[   41.674257] x20: 000000003b5d1000 x19: 0000000000001000 x18: 0000000972073a81
[   41.679654] x17: ffffff9c39b47000 x16: ffffffc080000000 x15: 0000000000000001
[   41.685074] x14: 0000000000000004 x13: 000001ba5087c8e8 x12: 00000000000001a8
[   41.690506] x11: 0000000000000040 x10: ffffffe40628d890 x9 : 0000000000000000
[   41.695972] x8 : ffffff803fd44080 x7 : 0000000008f0d180 x6 : 000000003b9ac9ff
[   41.701495] x5 : 0000000000fffffe x4 : ffffffc08058de80 x3 : 00000000b2d05e00
[   41.707073] x2 : ffffffe40546ab08 x1 : ffffffc08058e000 x0 : 0000000000001000
[   41.712686] Call trace:
[   41.717857]  dw_mci_idmac_start_dma+0xa0/0x358
[   41.723266]  __dw_mci_start_request+0x21c/0x6a0
[   41.728719]  dw_mci_work_func+0x4c8/0x4d8
[   41.734144]  process_one_work+0x148/0x284
[   41.739587]  bh_worker+0x224/0x278
[   41.744985]  workqueue_softirq_action+0x78/0x88
[   41.750545]  tasklet_action+0x14/0x3c
[   41.756023]  handle_softirqs+0x100/0x23c
[   41.761506]  __do_softirq+0x14/0x20
[   41.766917]  ____do_softirq+0x10/0x20
[   41.772301]  call_on_irq_stack+0x24/0x54
[   41.777689]  do_softirq_own_stack+0x1c/0x40
[   41.783106]  irq_exit_rcu+0x94/0xd0
[   41.788455]  el1_interrupt+0x38/0x68
[   41.793799]  el1h_64_irq_handler+0x18/0x24
[   41.799200]  el1h_64_irq+0x68/0x6c
[   41.804532]  default_idle_call+0x28/0x58
[   41.809931]  do_idle+0x1fc/0x260
[   41.815152]  cpu_startup_entry+0x34/0x40
[   41.820346]  kernel_init+0x0/0x140
[   41.825437]  console_on_rootfs+0x0/0x6c
[   41.830477]  __primary_switched+0x80/0x88
[   41.835501] Code: 54000280 d294f8c0 940e1f8c d503203f (b9400340)
[   41.840748] ---[ end trace 0000000000000000 ]---
[   41.845896] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[   41.851321] SMP: stopping secondary CPUs
[   41.856502] Kernel Offset: 0x2384800000 from 0xffffffc080000000
[   41.861840] PHYS_OFFSET: 0x0
[   41.866814] CPU features: 0x0c,00000014,00280928,4201720b
[   41.872087] Memory Limit: none
[   41.877119] Rebooting in 1 seconds..

Best regards,

Adam Green
