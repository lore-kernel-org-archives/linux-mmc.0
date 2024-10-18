Received: from mail-m10141.netease.com (mail-m10141.netease.com [154.81.10.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85023165F1E;
	Fri, 18 Oct 2024 04:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729225160; cv=none; b=lVBOPGSKuvBx5DT+FTLaTQ1sA9gNyrsKa9pb4ksDZNqfy2oLEoI7NU+8sjCmoJK3YYjfYrvlL3Ggm7yEH4SE50+LUObK4QOMwdP9+v3etTbKFfIalHuJ0RLpYXyYF0bs5asqBYO8c7+M+C+5oVa2oxLwu+AklNy7oJcDwjfMeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729225160; c=relaxed/simple;
	bh=BUiy21cS6Brfx5h3p8aAttFwfe6fWSH3rsa4w1fuvV8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uw7qTQcHvqxzapeQ5AsU9mNb2V3ZIcbzdsuME/ui/sHqgLp0t9M1luAqdjPyg2mh/BZBBqfjgrNkn4Yarj1ZiF4JsmxWpRUUXa8zNYlWdXiC1phyaGwReHXywidkqvoj2Hj4xeqAKkNnUvS3ZhD1oXJm8sq58jxZs4mchxsoHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SLAPIISC; arc=none smtp.client-ip=154.81.10.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SLAPIISC"
DKIM-Signature: a=rsa-sha256;
	b=SLAPIISCE2N7VT0Fnhx/VIoV2y2GvJFx7wB9z8kc/hf5yA/oj+j6h1jZT8uL+tuJaU4DRDbHGnlCkY3i37ozjEsqTGPl+yjVQ8A1KKz/Qlhlq+SS4Ptcsmhn2CaaTA4qQwPL+VFfK8Bq1SJbyP2ba2GrQKAb9Uek7YjDWRZ7XSA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=s+5jK+keJIN0GTF30RnOJY7PdGLvdWvWAMkiOpBl2t0=;
	h=date:mime-version:subject:message-id:from;
Received: from lintao?rock-chips.com (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with SMTP id 830D32A0571;
	Fri, 18 Oct 2024 11:42:52 +0800 (CST)
Message-ID: <eb1d15dd-8e85-4a9b-9b8b-ee005c446bf6@rock-chips.com>
Date: Fri, 18 Oct 2024 11:42:51 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>, sydarn@proton.me, linux-mmc@vger.kernel.org
Subject: Re: Unable to handle kernel paging request at virtual address
 ffffffc08058e000
To: Adam Green <greena88@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
References: <CAC8uq=Ppnmv98mpa1CrWLawWoPnu5abtU69v-=G-P7ysATQ2Pw@mail.gmail.com>
 <3748add3-18e5-42ef-9d48-93650cfc0682@rock-chips.com>
 <CAC8uq=O=519iRpcs7p+jZaKngkCDuawLz8NVZYORY6qfGPifZg@mail.gmail.com>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAC8uq=O=519iRpcs7p+jZaKngkCDuawLz8NVZYORY6qfGPifZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0tOHVZLT0xJS0sfHk8fQkJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a929db89abd03aakunm830d32a0571
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OFE6GSo5DjIfAzYyFzYpTCtI
	KioaFEpVSlVKTElCSUlJQkxOS0tJVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUxMS0k3Bg++

+ Sam

在 2024/10/18 8:06, Adam Green 写道:
> Hi Shawn,
> 
> I can confirm that after reverting
> 
> commit 8396c793ffdf28bb8aee7cfe0891080f8cab7890
> Author: Sam Protsenko <semen.protsenko@linaro.org>
> Date:   Wed Mar 6 17:20:52 2024 -0600
> 
>      mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K
> 
> that the problem does appear to have resolved itself, I tested this on
> a variety of devices.
> 

I'm confused about the patch. Doesn't max_seg_size stand for max bytes
per IDMA descriptor can handle?  How can it be equal to max_req_size
which should be max_seq_size * max_segs（max_segs is IDMAC descriptors 
number can be used） ?

  /* Each descriptor can transfer up to 4KB of data in chained mode */
  #define DW_MCI_DESC_DATA_LENGTH 0x1000


> Best regards,
> 
> Adam
> 
> On Wed, 16 Oct 2024 at 11:13, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> 在 2024/10/16 17:55, Adam Green 写道:
>>> Good morning,
>>>
>>> I would like to report a regression that appears to have been
>>> introduced into the linux kernel since v6.9.
>>>
>>
>> I didn't see many patches for dw_mmc since 6.9. So I guess the fastest
>> way is to do a bisect. Or maybe you could try reverting this commit
>> first to see what will happen.
>>
>> commit 8396c793ffdf28bb8aee7cfe0891080f8cab7890
>> Author: Sam Protsenko <semen.protsenko@linaro.org>
>> Date:   Wed Mar 6 17:20:52 2024 -0600
>>
>>       mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K
>>
>>
>>> My device is currently experiencing a panic booting the kernel/rootfs
>>> from an SD card.
>>>
>>> The device is a Powkiddy RGB30 which is a portable handheld gaming
>>> console with a Rockchip RK3566 SoC (arm64).
>>>
>>> I have tested a variety of devices from a couple of manufacturers with
>>> the same SoC and they all have the same issue,
>>> I have also tested, 6.12-rc3 and linux-next and the same issue appears present.
>>>
>>> A full UART dump can be found here: https://clbin.com/zLZAW
>>>
>>> [   41.547983] Unable to handle kernel paging request at virtual
>>> address ffffffc08058e000
>>> [   41.553426] Mem abort info:
>>> [   41.558231]   ESR = 0x0000000096000007
>>> [   41.563115]   EC = 0x25: DABT (current EL), IL = 32 bits
>>> [   41.568135]   SET = 0, FnV = 0
>>> [   41.572882]   EA = 0, S1PTW = 0
>>> [   41.577575]   FSC = 0x07: level 3 translation fault
>>> [   41.582404] Data abort info:
>>> [   41.586995]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
>>> [   41.591848]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>> [   41.596664]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>> [   41.601457] swapper pgtable: 4k pages, 39-bit VAs, pgdp=000000000363e000
>>> [   41.606359] [ffffffc08058e000] pgd=1000000000225003,
>>> p4d=1000000000225003, pud=1000000000225003, pmd=1000000000c8c003,
>>> pte=0000000000000000
>>> [   41.616442] Internal error: Oops: 0000000096000007 [#1] PREEMPT SMP
>>> [   41.621544] Modules linked in: hci_uart btrtl bluetooth rfkill
>>> [   41.626678] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc2 #1
>>> [   41.631922] Hardware name: Powkiddy RGB30 (DT)
>>> [   41.636951] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [   41.642330] pc : dw_mci_idmac_start_dma+0xa0/0x358
>>> [   41.647585] lr : __dw_mci_start_request+0x21c/0x6a0
>>> [   41.652827] sp : ffffffc080003da0
>>> [   41.657882] x29: ffffffc080003da0 x28: ffffff8001f06d80 x27: ffffffc08058d000
>>> [   41.663399] x26: ffffffc08058e000 x25: 0000000000002711 x24: 0000000000002000
>>> [   41.668864] x23: ffffff800167dc80 x22: 0000000080000012 x21: 0000000000001000
>>> [   41.674257] x20: 000000003b5d1000 x19: 0000000000001000 x18: 0000000972073a81
>>> [   41.679654] x17: ffffff9c39b47000 x16: ffffffc080000000 x15: 0000000000000001
>>> [   41.685074] x14: 0000000000000004 x13: 000001ba5087c8e8 x12: 00000000000001a8
>>> [   41.690506] x11: 0000000000000040 x10: ffffffe40628d890 x9 : 0000000000000000
>>> [   41.695972] x8 : ffffff803fd44080 x7 : 0000000008f0d180 x6 : 000000003b9ac9ff
>>> [   41.701495] x5 : 0000000000fffffe x4 : ffffffc08058de80 x3 : 00000000b2d05e00
>>> [   41.707073] x2 : ffffffe40546ab08 x1 : ffffffc08058e000 x0 : 0000000000001000
>>> [   41.712686] Call trace:
>>> [   41.717857]  dw_mci_idmac_start_dma+0xa0/0x358
>>> [   41.723266]  __dw_mci_start_request+0x21c/0x6a0
>>> [   41.728719]  dw_mci_work_func+0x4c8/0x4d8
>>> [   41.734144]  process_one_work+0x148/0x284
>>> [   41.739587]  bh_worker+0x224/0x278
>>> [   41.744985]  workqueue_softirq_action+0x78/0x88
>>> [   41.750545]  tasklet_action+0x14/0x3c
>>> [   41.756023]  handle_softirqs+0x100/0x23c
>>> [   41.761506]  __do_softirq+0x14/0x20
>>> [   41.766917]  ____do_softirq+0x10/0x20
>>> [   41.772301]  call_on_irq_stack+0x24/0x54
>>> [   41.777689]  do_softirq_own_stack+0x1c/0x40
>>> [   41.783106]  irq_exit_rcu+0x94/0xd0
>>> [   41.788455]  el1_interrupt+0x38/0x68
>>> [   41.793799]  el1h_64_irq_handler+0x18/0x24
>>> [   41.799200]  el1h_64_irq+0x68/0x6c
>>> [   41.804532]  default_idle_call+0x28/0x58
>>> [   41.809931]  do_idle+0x1fc/0x260
>>> [   41.815152]  cpu_startup_entry+0x34/0x40
>>> [   41.820346]  kernel_init+0x0/0x140
>>> [   41.825437]  console_on_rootfs+0x0/0x6c
>>> [   41.830477]  __primary_switched+0x80/0x88
>>> [   41.835501] Code: 54000280 d294f8c0 940e1f8c d503203f (b9400340)
>>> [   41.840748] ---[ end trace 0000000000000000 ]---
>>> [   41.845896] Kernel panic - not syncing: Oops: Fatal exception in interrupt
>>> [   41.851321] SMP: stopping secondary CPUs
>>> [   41.856502] Kernel Offset: 0x2384800000 from 0xffffffc080000000
>>> [   41.861840] PHYS_OFFSET: 0x0
>>> [   41.866814] CPU features: 0x0c,00000014,00280928,4201720b
>>> [   41.872087] Memory Limit: none
>>> [   41.877119] Rebooting in 1 seconds..
>>>
>>> Best regards,
>>>
>>> Adam Green
>>

