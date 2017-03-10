From: Petr Cvek <petr.cvek@tul.cz>
Subject: Re: [BUG] dmaengine: pxa_dma: + mmc: pxamci: race condition with DMA
 error on tx channel
Date: Fri, 10 Mar 2017 01:49:12 +0100
Message-ID: <feb39d00-d40d-f935-751c-8119f40b4df4@tul.cz>
References: <e749aff1-0ffc-c9ed-42b2-82397b4e8ba2@tul.cz>
 <877f3zwwgo.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------9FA88B3F82D1FD32C9FE73EF"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <877f3zwwgo.fsf@belgarion.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, vinod.koul@intel.com, linux-mmc@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, Daniel Mack <daniel@zonque.org>
List-Id: linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.
--------------9FA88B3F82D1FD32C9FE73EF
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit

Dne 8.3.2017 v 17:43 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
> Hi Petr,
>> I wasn't able to track the problem to a single patch as the problem occurs at
>> random time (from the boot to like a half an hour) and it's maybe dependent on a
>> level of a battery charge (maybe because of kernel log writes of charging
>> messages).
> Mmmh, long reproduction time, that will be bad.

Sent log is for a machine which finally died when I tried to start an X server. These debug printks slow it down.

>> It seems that most occurrency is during writes on an SD card. Using an SDHC
>> card decreases the time to fail. After failure the OS is unavailable (rootfs
>> in on the card).
> Okay, let me try to make write loop on my SD card to see if I manage to
> reproduce this.
> 

I tried to enable and disable soundcard (other part which is using DMA), but it does not have any effect. Concurrent interrupts may have.

>> From my poking in the kernel source code it seems there is a probability that pxamci_irq() takes longer to call and its subsequent call pxamci_data_done() isn't fast enough to set [1]
>> 	host->data = NULL;
> 
>> From the DMA side, the DMA done interrupt is generated:
>> 	pxad_chan_handler() -> vchan_cookie_complete()
>> ...where a tasklet for vchan_complete() is scheduled
> At least that seems to hint the DMA part is sound so for.
> The bothering part is the log error "mmc0: DMA error on tx channel". I would
> need a bit of guidance here, with the same log with [1] applied.
> 

Probably some cooperation of the DMA engine and the PXA MMC (like that other mail I've sent to you with UDC and g_webcam). I made another version of debug kernel with my own asserts:

In pxamci_dma_irq() before dmaengine_tx_status() call I've put:

pr_info("!!!cookie=%x complete=%x used=%x\n", 
	host->dma_cookie,chan->completed_cookie,chan->cookie);

It gets called only ONCE, just before failure, which values like this:
	cookie=372 complete=371 used=372

vchan_cyclic_callback() is called only with the soundcard in my machine IMO. I first thought there is regression with vd_completed in pxad_chan_handler() being changed during vchan_cyclic_callback() but it seems not.

pxad_tx_status() returns DMA_IN_PROGRESS before the failure.

>> , where finally with interrupts enabled (can pxamci_irq() be called here?) the
>> callback pxamci_dma_irq() is called.
> When DMA completes, there is a tiny window, before pxamci_dma_irq() is called,
> when pxamci_irq() can be called, yes. As soon as the spinlock is taken in
> pxamci_dma_irq() is taken, no more races.
> 

Does pxamci_dma_irq() depend on pxamci_irq() -> pxamci_data_done() NULLing host->data?

>> From my tests it seems at this point [2] the host->data is always NULL and rest
>> of the callback is never called. It is called once with a nonempty host->data
>> only just before the failure.
>>
>> During the testing I put udelay(100) at the start of pxamci_dma_irq() and fail
>> occurred after like 2 hours (when I for the first time tapped the touchscreen -
>> higher CPU usage and interrupts).
> Mmm I would need more data here.
> 
> The biggest help I could get would be the pxa dma traces here :
> echo -n 'file pxa_dma.c +p' > /sys/kernel/debug/dynamic_debug/control
> echo -n 'file virt-dma.c +p' > /sys/kernel/debug/dynamic_debug/control
> 
> And then capture the last traces and send them to me.

Last traces before the failure are in the attachment. It was copied (by a continual dmesg dump) from a ssh terminal over infraport (/var/log/messages gets corrupted after MMC DMA error).

> 
> Cheers.
> 


--------------9FA88B3F82D1FD32C9FE73EF
Content-Type: text/x-log;
 name="dmesg_mmc.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg_mmc.log"

[ 1744.486438] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.488362] dma dma0chan1: pxad_chan_handler(): checking txd c25d9ae0[221]: completed=1 dcsr=0x2000000c
[ 1744.488422] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.490980] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.491072] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.491175] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c25d9da0[0] flags=0x1
[ 1744.491231] dma dma0chan1: pxad_tx_submit(): txd c25d9da0[222]: submitted (not linked)
[ 1744.491286] dma dma0chan1: pxad_issue_pending(): txd c25d9da0[222]
[ 1744.491311] dma dma0chan1: pxad_launch_chan(): desc=c25d9da0
[ 1744.491339] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.493261] dma dma0chan1: pxad_chan_handler(): checking txd c25d9da0[222]: completed=1 dcsr=0x2000000c
[ 1744.493322] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.515259] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.515364] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.515460] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c25d98c0[0] flags=0x1
[ 1744.515689] dma dma0chan1: pxad_tx_submit(): txd c25d98c0[223]: submitted (not linked)
[ 1744.515753] dma dma0chan1: pxad_issue_pending(): txd c25d98c0[223]
[ 1744.515780] dma dma0chan1: pxad_launch_chan(): desc=c25d98c0
[ 1744.515810] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.517984] dma dma0chan1: pxad_chan_handler(): checking txd c25d98c0[223]: completed=1 dcsr=0x2000000c
[ 1744.518049] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.523061] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.523136] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.523229] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c25d9b00[0] flags=0x1
[ 1744.523277] dma dma0chan1: pxad_tx_submit(): txd c25d9b00[224]: submitted (not linked)
[ 1744.523332] dma dma0chan1: pxad_issue_pending(): txd c25d9b00[224]
[ 1744.523357] dma dma0chan1: pxad_launch_chan(): desc=c25d9b00
[ 1744.523385] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.525304] dma dma0chan1: pxad_chan_handler(): checking txd c25d9b00[224]: completed=1 dcsr=0x2000000c
[ 1744.525362] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.529985] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.530102] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.530195] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c25d9600[0] flags=0x1
[ 1744.530232] dma dma0chan1: pxad_tx_submit(): txd c25d9600[225]: submitted (not linked)
[ 1744.530302] dma dma0chan1: pxad_issue_pending(): txd c25d9600[225]
[ 1744.530328] dma dma0chan1: pxad_launch_chan(): desc=c25d9600
[ 1744.530356] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.532278] dma dma0chan1: pxad_chan_handler(): checking txd c25d9600[225]: completed=1 dcsr=0x2000000c
[ 1744.532339] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.539374] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.539459] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.543232] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c25d9c60[0] flags=0x1
[ 1744.543329] dma dma0chan1: pxad_tx_submit(): txd c25d9c60[226]: submitted (not linked)
[ 1744.543418] dma dma0chan1: pxad_issue_pending(): txd c25d9c60[226]
[ 1744.543443] dma dma0chan1: pxad_launch_chan(): desc=c25d9c60
[ 1744.543475] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.545408] dma dma0chan1: pxad_chan_handler(): checking txd c25d9c60[226]: completed=1 dcsr=0x2000000c
[ 1744.545471] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.552053] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.552132] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.552223] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c25d9a40[0] flags=0x1
[ 1744.552260] dma dma0chan1: pxad_tx_submit(): txd c25d9a40[227]: submitted (not linked)
[ 1744.552329] dma dma0chan1: pxad_issue_pending(): txd c25d9a40[227]
[ 1744.552355] dma dma0chan1: pxad_launch_chan(): desc=c25d9a40
[ 1744.552383] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.554327] dma dma0chan1: pxad_chan_handler(): checking txd c25d9a40[227]: completed=1 dcsr=0x2000000c
[ 1744.554393] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.558435] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.564320] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.564431] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c25d9ce0[0] flags=0x1
[ 1744.564485] dma dma0chan1: pxad_tx_submit(): txd c25d9ce0[228]: submitted (not linked)
[ 1744.564782] dma dma0chan1: pxad_issue_pending(): txd c25d9ce0[228]
[ 1744.564813] dma dma0chan1: pxad_launch_chan(): desc=c25d9ce0
[ 1744.564844] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.566941] dma dma0chan1: pxad_chan_handler(): checking txd c25d9ce0[228]: completed=1 dcsr=0x2000000c
[ 1744.566999] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.570471] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.570715] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.570822] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c25d9800[0] flags=0x1
[ 1744.570858] dma dma0chan1: pxad_tx_submit(): txd c25d9800[229]: submitted (not linked)
[ 1744.570925] dma dma0chan1: pxad_issue_pending(): txd c25d9800[229]
[ 1744.570951] dma dma0chan1: pxad_launch_chan(): desc=c25d9800
[ 1744.570979] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.572909] dma dma0chan1: pxad_chan_handler(): checking txd c25d9800[229]: completed=1 dcsr=0x2000000c
[ 1744.572967] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.614160] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.614218] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.614296] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c25d98c0[0] flags=0x1
[ 1744.614333] dma dma0chan1: pxad_tx_submit(): txd c25d98c0[22a]: submitted (not linked)
[ 1744.614396] dma dma0chan1: pxad_issue_pending(): txd c25d98c0[22a]
[ 1744.614421] dma dma0chan1: pxad_launch_chan(): desc=c25d98c0
[ 1744.614449] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.616398] dma dma0chan1: pxad_chan_handler(): checking txd c25d98c0[22a]: completed=1 dcsr=0x2000000c
[ 1744.616462] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.618257] dma dma0chan0: pxad_get_config(): dev_addr=0x41100040 maxburst=32 width=1  dir=2
[ 1744.618316] dma dma0chan0: pxad_prep_slave_sg(): dir=2 flags=1
[ 1744.618379] dma dma0chan0: pxad_tx_prep(): vc=c39bfa30 txd=c25d9b00[0] flags=0x1
[ 1744.618415] dma dma0chan0: pxad_tx_submit(): txd c25d9b00[418f]: submitted (not linked)
[ 1744.618446] dma dma0chan0: pxad_issue_pending(): txd c25d9b00[418f]
[ 1744.618471] dma dma0chan0: pxad_launch_chan(): desc=c25d9b00
[ 1744.618499] dma dma0chan0: phy_enable(); phy=c393d0c0(12) misaligned=0
[ 1744.621330] dma dma0chan0: pxad_chan_handler(): checking txd c25d9b00[418f]: completed=1 dcsr=0x2000000c
[ 1744.621394] dma dma0chan0: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.622913] dma dma0chan0: pxad_get_config(): dev_addr=0x41100040 maxburst=32 width=1  dir=2
[ 1744.622969] dma dma0chan0: pxad_prep_slave_sg(): dir=2 flags=1
[ 1744.623052] dma dma0chan0: pxad_tx_prep(): vc=c39bfa30 txd=c25d9c60[0] flags=0x1
[ 1744.623090] dma dma0chan0: pxad_tx_submit(): txd c25d9c60[4190]: submitted (not linked)
[ 1744.623121] dma dma0chan0: pxad_issue_pending(): txd c25d9c60[4190]
[ 1744.623146] dma dma0chan0: pxad_launch_chan(): desc=c25d9c60
[ 1744.623175] dma dma0chan0: phy_enable(); phy=c393d0c0(12) misaligned=0
[ 1744.625671] dma dma0chan0: pxad_chan_handler(): checking txd c25d9c60[4190]: completed=1 dcsr=0x2000000c
[ 1744.625729] dma dma0chan0: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.628134] dma dma0chan0: pxad_get_config(): dev_addr=0x41100040 maxburst=32 width=1  dir=2
[ 1744.628196] dma dma0chan0: pxad_prep_slave_sg(): dir=2 flags=1
[ 1744.628278] dma dma0chan0: pxad_tx_prep(): vc=c39bfa30 txd=c25d9ce0[0] flags=0x1
[ 1744.628316] dma dma0chan0: pxad_tx_submit(): txd c25d9ce0[4191]: submitted (not linked)
[ 1744.628347] dma dma0chan0: pxad_issue_pending(): txd c25d9ce0[4191]
[ 1744.628371] dma dma0chan0: pxad_launch_chan(): desc=c25d9ce0
[ 1744.628399] dma dma0chan0: phy_enable(); phy=c393d0c0(12) misaligned=0
[ 1744.631024] dma dma0chan0: pxad_chan_handler(): checking txd c25d9ce0[4191]: completed=1 dcsr=0x2000000c
[ 1744.631083] dma dma0chan0: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.634950] dma dma0chan0: pxad_get_config(): dev_addr=0x41100040 maxburst=32 width=1  dir=2
[ 1744.635016] dma dma0chan0: pxad_prep_slave_sg(): dir=2 flags=1
[ 1744.635097] dma dma0chan0: pxad_tx_prep(): vc=c39bfa30 txd=c25d9d60[0] flags=0x1
[ 1744.635136] dma dma0chan0: pxad_tx_submit(): txd c25d9d60[4192]: submitted (not linked)
[ 1744.635167] dma dma0chan0: pxad_issue_pending(): txd c25d9d60[4192]
[ 1744.635192] dma dma0chan0: pxad_launch_chan(): desc=c25d9d60
[ 1744.635220] dma dma0chan0: phy_enable(); phy=c393d0c0(12) misaligned=0
[ 1744.637612] dma dma0chan0: pxad_chan_handler(): checking txd c25d9d60[4192]: completed=1 dcsr=0x2000000c
[ 1744.637674] dma dma0chan0: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.649254] dma dma0chan0: pxad_get_config(): dev_addr=0x41100040 maxburst=32 width=1  dir=2
[ 1744.649317] dma dma0chan0: pxad_prep_slave_sg(): dir=2 flags=1
[ 1744.649399] dma dma0chan0: pxad_tx_prep(): vc=c39bfa30 txd=c24fb640[0] flags=0x1
[ 1744.649437] dma dma0chan0: pxad_tx_submit(): txd c24fb640[4193]: submitted (not linked)
[ 1744.649469] dma dma0chan0: pxad_issue_pending(): txd c24fb640[4193]
[ 1744.649493] dma dma0chan0: pxad_launch_chan(): desc=c24fb640
[ 1744.649522] dma dma0chan0: phy_enable(); phy=c393d0c0(12) misaligned=0
[ 1744.652246] dma dma0chan0: pxad_chan_handler(): checking txd c24fb640[4193]: completed=1 dcsr=0x2000000c
[ 1744.652307] dma dma0chan0: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.660324] dma dma0chan0: pxad_get_config(): dev_addr=0x41100040 maxburst=32 width=1  dir=2
[ 1744.660383] dma dma0chan0: pxad_prep_slave_sg(): dir=2 flags=1
[ 1744.660469] dma dma0chan0: pxad_tx_prep(): vc=c39bfa30 txd=c24fbd20[0] flags=0x1
[ 1744.660742] dma dma0chan0: pxad_tx_submit(): txd c24fbd20[4194]: submitted (not linked)
[ 1744.660774] dma dma0chan0: pxad_issue_pending(): txd c24fbd20[4194]
[ 1744.660799] dma dma0chan0: pxad_launch_chan(): desc=c24fbd20
[ 1744.660828] dma dma0chan0: phy_enable(); phy=c393d0c0(12) misaligned=0
[ 1744.663174] dma dma0chan0: pxad_chan_handler(): checking txd c24fbd20[4194]: completed=1 dcsr=0x2000000c
[ 1744.663239] dma dma0chan0: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.667122] dma dma0chan0: pxad_get_config(): dev_addr=0x41100040 maxburst=32 width=1  dir=2
[ 1744.667185] dma dma0chan0: pxad_prep_slave_sg(): dir=2 flags=1
[ 1744.667268] dma dma0chan0: pxad_tx_prep(): vc=c39bfa30 txd=c24fb540[0] flags=0x1
[ 1744.667307] dma dma0chan0: pxad_tx_submit(): txd c24fb540[4195]: submitted (not linked)
[ 1744.667338] dma dma0chan0: pxad_issue_pending(): txd c24fb540[4195]
[ 1744.667363] dma dma0chan0: pxad_launch_chan(): desc=c24fb540
[ 1744.667391] dma dma0chan0: phy_enable(); phy=c393d0c0(12) misaligned=0
[ 1744.669743] dma dma0chan0: pxad_chan_handler(): checking txd c24fb540[4195]: completed=1 dcsr=0x2000000c
[ 1744.669803] dma dma0chan0: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.674144] dma dma0chan0: pxad_get_config(): dev_addr=0x41100040 maxburst=32 width=1  dir=2
[ 1744.674208] dma dma0chan0: pxad_prep_slave_sg(): dir=2 flags=1
[ 1744.674294] dma dma0chan0: pxad_tx_prep(): vc=c39bfa30 txd=c24fbf60[0] flags=0x1
[ 1744.674332] dma dma0chan0: pxad_tx_submit(): txd c24fbf60[4196]: submitted (not linked)
[ 1744.674363] dma dma0chan0: pxad_issue_pending(): txd c24fbf60[4196]
[ 1744.674387] dma dma0chan0: pxad_launch_chan(): desc=c24fbf60
[ 1744.674415] dma dma0chan0: phy_enable(); phy=c393d0c0(12) misaligned=0
[ 1744.676927] dma dma0chan0: pxad_chan_handler(): checking txd c24fbf60[4196]: completed=1 dcsr=0x2000000c
[ 1744.676987] dma dma0chan0: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.680962] dma dma0chan0: pxad_get_config(): dev_addr=0x41100040 maxburst=32 width=1  dir=2
[ 1744.681022] dma dma0chan0: pxad_prep_slave_sg(): dir=2 flags=1
[ 1744.681109] dma dma0chan0: pxad_tx_prep(): vc=c39bfa30 txd=c2593920[0] flags=0x1
[ 1744.681146] dma dma0chan0: pxad_tx_submit(): txd c2593920[4197]: submitted (not linked)
[ 1744.681179] dma dma0chan0: pxad_issue_pending(): txd c2593920[4197]
[ 1744.681204] dma dma0chan0: pxad_launch_chan(): desc=c2593920
[ 1744.681233] dma dma0chan0: phy_enable(); phy=c393d0c0(12) misaligned=0
[ 1744.683544] dma dma0chan0: pxad_chan_handler(): checking txd c2593920[4197]: completed=1 dcsr=0x2000000c
[ 1744.683604] dma dma0chan0: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.685019] dma dma0chan0: pxad_get_config(): dev_addr=0x41100040 maxburst=32 width=1  dir=2
[ 1744.685081] dma dma0chan0: pxad_prep_slave_sg(): dir=2 flags=1
[ 1744.685247] dma dma0chan0: pxad_tx_prep(): vc=c39bfa30 txd=c32c77c0[0] flags=0x1
[ 1744.685284] dma dma0chan0: pxad_tx_submit(): txd c32c77c0[4198]: submitted (not linked)
[ 1744.685316] dma dma0chan0: pxad_issue_pending(): txd c32c77c0[4198]
[ 1744.685340] dma dma0chan0: pxad_launch_chan(): desc=c32c77c0
[ 1744.685369] dma dma0chan0: phy_enable(); phy=c393d0c0(12) misaligned=0
[ 1744.687807] dma dma0chan0: pxad_chan_handler(): checking txd c32c77c0[4198]: completed=1 dcsr=0x2000000c
[ 1744.687864] dma dma0chan0: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.690083] dma dma0chan0: pxad_get_config(): dev_addr=0x41100040 maxburst=32 width=1  dir=2
[ 1744.690143] dma dma0chan0: pxad_prep_slave_sg(): dir=2 flags=1
[ 1744.690239] dma dma0chan0: pxad_tx_prep(): vc=c39bfa30 txd=c32c7e20[0] flags=0x1
[ 1744.690278] dma dma0chan0: pxad_tx_submit(): txd c32c7e20[4199]: submitted (not linked)
[ 1744.690309] dma dma0chan0: pxad_issue_pending(): txd c32c7e20[4199]
[ 1744.690335] dma dma0chan0: pxad_launch_chan(): desc=c32c7e20
[ 1744.690363] dma dma0chan0: phy_enable(); phy=c393d0c0(12) misaligned=0
[ 1744.692742] dma dma0chan0: pxad_chan_handler(): checking txd c32c7e20[4199]: completed=1 dcsr=0x2000000c
[ 1744.692804] dma dma0chan0: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.697989] dma dma0chan0: pxad_get_config(): dev_addr=0x41100040 maxburst=32 width=1  dir=2
[ 1744.698048] dma dma0chan0: pxad_prep_slave_sg(): dir=2 flags=1
[ 1744.698147] dma dma0chan0: pxad_tx_prep(): vc=c39bfa30 txd=c32c7ea0[0] flags=0x1
[ 1744.698188] dma dma0chan0: pxad_tx_submit(): txd c32c7ea0[419a]: submitted (not linked)
[ 1744.698219] dma dma0chan0: pxad_issue_pending(): txd c32c7ea0[419a]
[ 1744.698244] dma dma0chan0: pxad_launch_chan(): desc=c32c7ea0
[ 1744.698271] dma dma0chan0: phy_enable(); phy=c393d0c0(12) misaligned=0
[ 1744.700709] dma dma0chan0: pxad_chan_handler(): checking txd c32c7ea0[419a]: completed=1 dcsr=0x2000000c
[ 1744.700769] dma dma0chan0: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.703772] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.703832] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.703906] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c27c0020[0] flags=0x1
[ 1744.703944] dma dma0chan1: pxad_tx_submit(): txd c27c0020[22b]: submitted (not linked)
[ 1744.704016] dma dma0chan1: pxad_issue_pending(): txd c27c0020[22b]
[ 1744.704046] dma dma0chan1: pxad_launch_chan(): desc=c27c0020
[ 1744.704075] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.706172] dma dma0chan1: pxad_chan_handler(): checking txd c27c0020[22b]: completed=1 dcsr=0x2000000c
[ 1744.706229] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.715827] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.715885] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.715962] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c27c0480[0] flags=0x1
[ 1744.715999] dma dma0chan1: pxad_tx_submit(): txd c27c0480[22c]: submitted (not linked)
[ 1744.716066] dma dma0chan1: pxad_issue_pending(): txd c27c0480[22c]
[ 1744.716091] dma dma0chan1: pxad_launch_chan(): desc=c27c0480
[ 1744.716120] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.718052] dma dma0chan1: pxad_chan_handler(): checking txd c27c0480[22c]: completed=1 dcsr=0x2000000c
[ 1744.718110] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.724194] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.724255] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.724335] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c24fa440[0] flags=0x1
[ 1744.724370] dma dma0chan1: pxad_tx_submit(): txd c24fa440[22d]: submitted (not linked)
[ 1744.724447] dma dma0chan1: pxad_issue_pending(): txd c24fa440[22d]
[ 1744.724474] dma dma0chan1: pxad_launch_chan(): desc=c24fa440
[ 1744.724502] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.726476] dma dma0chan1: pxad_chan_handler(): checking txd c24fa440[22d]: completed=1 dcsr=0x2000000c
[ 1744.726535] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.730882] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.730942] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.731032] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c24fa800[0] flags=0x1
[ 1744.731067] dma dma0chan1: pxad_tx_submit(): txd c24fa800[22e]: submitted (not linked)
[ 1744.731131] dma dma0chan1: pxad_issue_pending(): txd c24fa800[22e]
[ 1744.731156] dma dma0chan1: pxad_launch_chan(): desc=c24fa800
[ 1744.731184] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.733124] dma dma0chan1: pxad_chan_handler(): checking txd c24fa800[22e]: completed=1 dcsr=0x2000000c
[ 1744.733185] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.738034] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.738094] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.738186] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c24fa880[0] flags=0x1
[ 1744.738221] dma dma0chan1: pxad_tx_submit(): txd c24fa880[22f]: submitted (not linked)
[ 1744.738287] dma dma0chan1: pxad_issue_pending(): txd c24fa880[22f]
[ 1744.738312] dma dma0chan1: pxad_launch_chan(): desc=c24fa880
[ 1744.738340] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.740314] dma dma0chan1: pxad_chan_handler(): checking txd c24fa880[22f]: completed=1 dcsr=0x2000000c
[ 1744.740375] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.745047] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.745105] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.745198] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c24fa900[0] flags=0x1
[ 1744.745233] dma dma0chan1: pxad_tx_submit(): txd c24fa900[230]: submitted (not linked)
[ 1744.745303] dma dma0chan1: pxad_issue_pending(): txd c24fa900[230]
[ 1744.745329] dma dma0chan1: pxad_launch_chan(): desc=c24fa900
[ 1744.745358] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.747331] dma dma0chan1: pxad_chan_handler(): checking txd c24fa900[230]: completed=1 dcsr=0x2000000c
[ 1744.747391] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.750498] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.750755] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.750840] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c24fa980[0] flags=0x1
[ 1744.750876] dma dma0chan1: pxad_tx_submit(): txd c24fa980[231]: submitted (not linked)
[ 1744.750941] dma dma0chan1: pxad_issue_pending(): txd c24fa980[231]
[ 1744.750967] dma dma0chan1: pxad_launch_chan(): desc=c24fa980
[ 1744.750996] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.752917] dma dma0chan1: pxad_chan_handler(): checking txd c24fa980[231]: completed=1 dcsr=0x2000000c
[ 1744.752975] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.757762] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.757820] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.757907] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c24faa00[0] flags=0x1
[ 1744.757944] dma dma0chan1: pxad_tx_submit(): txd c24faa00[232]: submitted (not linked)
[ 1744.758002] dma dma0chan1: pxad_issue_pending(): txd c24faa00[232]
[ 1744.758027] dma dma0chan1: pxad_launch_chan(): desc=c24faa00
[ 1744.758054] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.759976] dma dma0chan1: pxad_chan_handler(): checking txd c24faa00[232]: completed=1 dcsr=0x2000000c
[ 1744.760034] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.763064] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.763122] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.763216] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c24faa80[0] flags=0x1
[ 1744.763251] dma dma0chan1: pxad_tx_submit(): txd c24faa80[233]: submitted (not linked)
[ 1744.763322] dma dma0chan1: pxad_issue_pending(): txd c24faa80[233]
[ 1744.763347] dma dma0chan1: pxad_launch_chan(): desc=c24faa80
[ 1744.763376] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.765349] dma dma0chan1: pxad_chan_handler(): checking txd c24faa80[233]: completed=1 dcsr=0x2000000c
[ 1744.765412] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.772298] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.772355] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.772449] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c24faba0[0] flags=0x1
[ 1744.772485] dma dma0chan1: pxad_tx_submit(): txd c24faba0[234]: submitted (not linked)
[ 1744.772834] dma dma0chan1: pxad_issue_pending(): txd c24faba0[234]
[ 1744.772861] dma dma0chan1: pxad_launch_chan(): desc=c24faba0
[ 1744.772891] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.775009] dma dma0chan1: pxad_chan_handler(): checking txd c24faba0[234]: completed=1 dcsr=0x2000000c
[ 1744.775066] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.778048] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.778110] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.778203] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c24fac20[0] flags=0x1
[ 1744.778239] dma dma0chan1: pxad_tx_submit(): txd c24fac20[235]: submitted (not linked)
[ 1744.778308] dma dma0chan1: pxad_issue_pending(): txd c24fac20[235]
[ 1744.778333] dma dma0chan1: pxad_launch_chan(): desc=c24fac20
[ 1744.778361] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.780298] dma dma0chan1: pxad_chan_handler(): checking txd c24fac20[235]: completed=1 dcsr=0x2000000c
[ 1744.780356] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.782944] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.783004] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.783081] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c24faca0[0] flags=0x1
[ 1744.783117] dma dma0chan1: pxad_tx_submit(): txd c24faca0[236]: submitted (not linked)
[ 1744.783178] dma dma0chan1: pxad_issue_pending(): txd c24faca0[236]
[ 1744.783205] dma dma0chan1: pxad_launch_chan(): desc=c24faca0
[ 1744.783233] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.785163] dma dma0chan1: pxad_chan_handler(): checking txd c24faca0[236]: completed=1 dcsr=0x2000000c
[ 1744.785222] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.790232] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.790292] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.790385] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c24fad20[0] flags=0x1
[ 1744.790421] dma dma0chan1: pxad_tx_submit(): txd c24fad20[237]: submitted (not linked)
[ 1744.790483] dma dma0chan1: pxad_issue_pending(): txd c24fad20[237]
[ 1744.790508] dma dma0chan1: pxad_launch_chan(): desc=c24fad20
[ 1744.790536] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.792486] dma dma0chan1: pxad_chan_handler(): checking txd c24fad20[237]: completed=1 dcsr=0x2000000c
[ 1744.792543] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.796450] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.796711] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.796803] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c24fada0[0] flags=0x1
[ 1744.796839] dma dma0chan1: pxad_tx_submit(): txd c24fada0[238]: submitted (not linked)
[ 1744.796901] dma dma0chan1: pxad_issue_pending(): txd c24fada0[238]
[ 1744.796926] dma dma0chan1: pxad_launch_chan(): desc=c24fada0
[ 1744.796956] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.798894] dma dma0chan1: pxad_chan_handler(): checking txd c24fada0[238]: completed=1 dcsr=0x2000000c
[ 1744.798950] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.805444] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.805707] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.805799] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c24fae20[0] flags=0x1
[ 1744.805835] dma dma0chan1: pxad_tx_submit(): txd c24fae20[239]: submitted (not linked)
[ 1744.805900] dma dma0chan1: pxad_issue_pending(): txd c24fae20[239]
[ 1744.805925] dma dma0chan1: pxad_launch_chan(): desc=c24fae20
[ 1744.805954] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.807888] dma dma0chan1: pxad_chan_handler(): checking txd c24fae20[239]: completed=1 dcsr=0x2000000c
[ 1744.807947] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.814156] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.814233] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.814313] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c24fa800[0] flags=0x1
[ 1744.814364] dma dma0chan1: pxad_tx_submit(): txd c24fa800[23a]: submitted (not linked)
[ 1744.814420] dma dma0chan1: pxad_issue_pending(): txd c24fa800[23a]
[ 1744.814446] dma dma0chan1: pxad_launch_chan(): desc=c24fa800
[ 1744.814474] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.816416] dma dma0chan1: pxad_chan_handler(): checking txd c24fa800[23a]: completed=1 dcsr=0x2000000c
[ 1744.816479] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 1744.822095] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 1744.822188] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 1744.822301] dma dma0chan1: pxad_tx_prep(): vc=c39bfb30 txd=c24fa880[0] flags=0x1
[ 1744.822337] dma dma0chan1: pxad_tx_submit(): txd c24fa880[23b]: submitted (not linked)
[ 1744.822406] dma dma0chan1: pxad_issue_pending(): txd c24fa880[23b]
[ 1744.822431] dma dma0chan1: pxad_launch_chan(): desc=c24fa880
[ 1744.822460] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 1744.823948] dma dma0chan1: pxad_residue(): txd c24fa880[23b] sw_desc=c24fa880: 1024
[ 1744.823992] mmc0: DMA error on tx channel

--------------9FA88B3F82D1FD32C9FE73EF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--------------9FA88B3F82D1FD32C9FE73EF--
