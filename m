From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: atmel-mci: Check pdata for NULL before dereferencing it
Date: Wed, 16 Mar 2016 12:38:20 +0100
Message-ID: <CAPDyKFpMj-OotuEkFkE-WtXmSMJEkBK8u-o-=EkLBZQBfaQzPg@mail.gmail.com>
References: <CAP+RiCA3J6xro_QzkGSUC6Pfrpe4jt2vE1DkU6QrDXbXpXYyzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAP+RiCA3J6xro_QzkGSUC6Pfrpe4jt2vE1DkU6QrDXbXpXYyzQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brent Taylor <motobud@gmail.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 13 March 2016 at 07:25, Brent Taylor <motobud@gmail.com> wrote:
> I'm using an at91sam9g20ek development board, and I ran into a kernel
> panic with 4.5.0-rc7:
>
> atmel_mci fffa8000.mmc: version: 0x210
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
> pgd = c0004000
> [00000004] *pgd=00000000
> Internal error: Oops: 5 [#1] ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.5.0-rc7 #5
> Hardware name: Atmel AT91SAM9
> task: c3838000 ti: c383c000 task.ti: c383c000
> PC is at atmci_probe+0x3f8/0x7c4
> LR is at dma_request_chan+0x134/0x158
> pc : [<c024c7ac>]    lr : [<c01b8488>]    psr: 60000013
> sp : c383de40  ip : 60000013  fp : 00000022
> r10: c3910b60  r9 : c38da900  r8 : 00000210
> r7 : c38da910  r6 : c38c14d0  r5 : 00000000  r4 : c398b110
> r3 : 00000000  r2 : 00000000  r1 : 00000001  r0 : ffffffed
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 0005317f  Table: 20004000  DAC: 00000053
> Process swapper (pid: 1, stack limit = 0xc383c190)
> Stack: (0xc383de40 to 0xc383e000)
> de40: c38db360 c398b110 c38dc5f0 c0404386 c398dfa0 00000000 c0486838 c38da910
> de60: c04ae2d0 c04ce424 00000000 00000000 c0486838 c04bbec0 00000000 c01e2318
> de80: c38da910 c04ae2d0 c04ce424 c01e0c54 c04ae2d0 c38da910 c38da910 c38da944
> dea0: c04ae2d0 c04a6568 c04b81c8 c01e0ee8 00000000 c04ae2d0 c01e0e80 c01df188
> dec0: c382d58c c38d8570 c04ae2d0 00000000 c398c180 c01e0194 c0418298 c041829b
> dee0: c04ae2d0 c047b1f4 00000000 c0497ea0 c0497ea0 c01e147c c39108a0 c047b1f4
> df00: 00000000 c00096c4 c382cb40 c387a280 c387a280 c0332170 c3ffcb00 c3ffcb83
> df20: c044baac c002a2a4 c03e5ae4 c382cb40 c382cb40 c044b2dc 00000065 00000006
> df40: 00000006 c044bac0 00000064 c044bac0 00000000 00000006 c048682c 00000006
> df60: c0486830 00000065 c0492978 c04bbec0 c0486838 c0468d20 00000006 00000006
> df80: 00000000 c046859c 00000000 c032c81c 00000000 00000000 00000000 00000000
> dfa0: 00000000 c032c824 00000000 c000a290 00000000 00000000 00000000 00000000
> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [<c024c7ac>] (atmci_probe) from [<c01e2318>] (platform_drv_probe+0x38/0x6c)
> [<c01e2318>] (platform_drv_probe) from [<c01e0c54>]
> (driver_probe_device+0x1ac/0x3d8)
> [<c01e0c54>] (driver_probe_device) from [<c01e0ee8>] (__driver_attach+0x68/0x8c)
> [<c01e0ee8>] (__driver_attach) from [<c01df188>] (bus_for_each_dev+0x68/0x8c)
> [<c01df188>] (bus_for_each_dev) from [<c01e0194>] (bus_add_driver+0x110/0x23c)
> [<c01e0194>] (bus_add_driver) from [<c01e147c>] (driver_register+0x9c/0xe0)
> [<c01e147c>] (driver_register) from [<c00096c4>] (do_one_initcall+0x118/0x1dc)
> [<c00096c4>] (do_one_initcall) from [<c0468d20>]
> (kernel_init_freeable+0xfc/0x1c0)
> [<c0468d20>] (kernel_init_freeable) from [<c032c824>] (kernel_init+0x8/0xe4)
> [<c032c824>] (kernel_init) from [<c000a290>] (ret_from_fork+0x14/0x24)
> Code: e5840030 1a000014 e59430c8 e5933058 (e5932004)
> ---[ end trace 607b62d4422f7087 ]---
>
> This occurs because the "host->pdev->dev.patform_data" is NULL because
> I'm using a device tree to setup all the devices.
>
> This patch checks pdata before dereferencing it.
>
> Signed-off-by: Brent Taylor <motobud <at> gmail.com>

As 4.5 is out, I have applied this for next but also adding a stable tag.

I also to the liberty to update the changelog as I think it was a bit
too verbose.

Thanks and kind regards
Uffe

>
> --- a/drivers/mmc/host/atmel-mci.c        2016-03-13 00:10:57.527773324 -0600
> +++ b/drivers/mmc/host/atmel-mci.c    2016-03-13 00:10:44.903433138 -0600
> @@ -2443,7 +2443,7 @@ static int atmci_configure_dma(struct at
>                 struct mci_platform_data *pdata = host->pdev->dev.platform_data;
>                 dma_cap_mask_t mask;
>
> -               if (!pdata->dma_filter)
> +               if (!pdata || !pdata->dma_filter)
>                         return -ENODEV;
>
>                 dma_cap_zero(mask);
