From: Petr Cvek <petr.cvek@tul.cz>
Subject: [BUG] dmaengine: pxa_dma: + mmc: pxamci: race condition with DMA
 error on tx channel
Date: Wed, 8 Mar 2017 07:57:08 +0100
Message-ID: <e749aff1-0ffc-c9ed-42b2-82397b4e8ba2@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Jarzmik <robert.jarzmik@free.fr>, vinod.koul@intel.com, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hello,

PXA27x DMA changes between:

	v4.7
	d52bd54db8be8999df6df5a776f38c4f8b5e9cea
and
	v4.10-rc5
	a4685d2f58e2230d4e27fb2ee581d7ea35e5d046

seems to expose a race condition while using PXA MMC driver on a PXA27x (magician.c machine).

The failure causes one line in the kernel log, after which the filesystem on SD card is inaccessible (and machine too).

	mmc0: DMA error on tx channel

I wasn't able to track the problem to a single patch as the problem occurs at random time (from the boot to like a half an hour) and it's maybe dependent on a level of a battery charge (maybe because of kernel log writes of charging messages).

It seems that most occurrency is during writes on an SD card. Using an SDHC card decreases the time to fail. After failure the OS is unavailable (rootfs in on the card).

>From my poking in the kernel source code it seems there is a probability that pxamci_irq() takes longer to call and its subsequent call pxamci_data_done() isn't fast enough to set [1]
	host->data = NULL;
>From the DMA side, the DMA done interrupt is generated:
	pxad_chan_handler() -> vchan_cookie_complete()
...where a tasklet for vchan_complete() is scheduled, where finally with interrupts enabled (can pxamci_irq() be called here?) the callback pxamci_dma_irq() is called.

>From my tests it seems at this point [2] the host->data is always NULL and rest of the callback is never called. It is called once with a nonempty host->data only just before the failure.

During the testing I put udelay(100) at the start of pxamci_dma_irq() and fail occurred after like 2 hours (when I for the first time tapped the touchscreen - higher CPU usage and interrupts).

[1] http://elixir.free-electrons.com/source/drivers/mmc/host/pxamci.c?v=4.10#L385
[2] http://elixir.free-electrons.com/source/drivers/mmc/host/pxamci.c?v=4.10#L561

Best regards,
Petr
