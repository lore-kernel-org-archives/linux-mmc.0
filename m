From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: next/master boot: 179 boots: 11 failed, 167 passed with 1 offline
 (next-20180731)
Date: Wed, 1 Aug 2018 10:19:38 +0200
Message-ID: <c50e3311-9dca-c64b-ca58-6a44e3559e98@st.com>
References: <5b607cc4.1c69fb81.6c1d6.6534@mx.google.com>
 <20180731160623.GH5719@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------F161F5249C1A089E1A9FD8F4"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180731160623.GH5719@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel-build-reports@lists.linaro.org, khilman@baylibre.com, linux-mmc@vger.kernel.org, linux-next@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

--------------F161F5249C1A089E1A9FD8F4
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

hi Mark, Ulf

When I see log, I think the patch in attachment could fix this issue
, but like I've not qcom board I can't test if it's fixed :-(.

Ulf: for patch delivery, you prefer a patch delivery on mailing list ?

BR
Ludo

On 07/31/2018 06:06 PM, Mark Brown wrote:
> On Tue, Jul 31, 2018 at 08:14:12AM -0700, kernelci.org bot wrote:
> 
> Today's -next fails to boot on a variety of Qualcomm 32 bit platforms:
> 
>>      multi_v7_defconfig:
>>          qcom-apq8064-cm-qs600:
>>              lab-baylibre-seattle: new failure (last pass: next-20180730)
>>          qcom-apq8064-ifc6410:
>>              lab-baylibre-seattle: new failure (last pass: next-20180730)
>>
>>      qcom_defconfig:
>>          qcom-apq8064-cm-qs600:
>>              lab-baylibre-seattle: new failure (last pass: next-20180730)
> 
> The logs are all somewhat similar, for example:
> 
>     https://storage.kernelci.org/next/master/next-20180731/arm/multi_v7_defconfig/lab-baylibre-seattle/boot-qcom-apq8064-cm-qs600.html
> 
> detects a DMA problem during MMCI initialization:
> 
> [    2.237566] mmci-pl18x 121c0000.sdcc: mmc2: PL180 manf 51 rev0 at 0x121c0000 irq 32,0 (pio)
> [    2.244790] mmci-pl18x 121c0000.sdcc: DMA channels RX dma2chan1, TX dma2chan2
> [    2.271722] mmci-pl18x 12400000.sdcc: error during DMA transfer!
> [    2.271757] mmci-pl18x 12400000.sdcc: buggy DMA detected. Taking evasive action.
> [    2.276798] ------------[ cut here ]------------
> [    2.284185] WARNING: CPU: 0 PID: 0 at ../include/linux/dma-mapping.h:551 bam_free_chan+0x2d8/0x2e0
> [    2.288772] Modules linked in:
> [    2.297534] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-rc7-next-20180731 #1
> 
> then panics:
> 
> [    2.513796] ------------[ cut here ]------------
> [    2.518367] kernel BUG at ../mm/vmalloc.c:1608!
> [    2.522968] Internal error: Oops - BUG: 0 [#1] SMP ARM
> 
> trying to release the DMA channel.  I've not done any bisection or
> anything but I do note 8bb2299d2d0b5cc (mmc: mmci: Add and implement a
> ->dma_setup() callback for qcom dml) and some related commits in the MMC
> tree.
> 
> More details for each of the failed boots at:
> 
>    https://kernelci.org/boot/id/5b6054f559b5144b9396baa9/
>    https://kernelci.org/boot/id/5b60551259b5144abb96bab6/
>    https://kernelci.org/boot/id/5b6054e259b5144b1e96bab2/
> 
> including full logs, details of the build and so on.
> 

--------------F161F5249C1A089E1A9FD8F4
Content-Type: text/x-patch;
	name="0001-mmc-mmci-fix-qcom-dma-issue-during-mmci-init-with-ne.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-mmc-mmci-fix-qcom-dma-issue-during-mmci-init-with-ne.pa";
	filename*1="tch"

>From 063f66ebe1ac47bc77222f997e5f5ad0f1ce385a Mon Sep 17 00:00:00 2001
From: Ludovic Barre <ludovic.barre@st.com>
Date: Tue, 31 Jul 2018 19:00:10 +0200
Subject: [PATCH 1/1] mmc: mmci: fix qcom dma issue during mmci init with new
 dma_setup callback

This patch fixes qcom dma issue during mmci init.
Like init callback of qcom variant is not set, the qcom dma
is not correctly initialized and fail while dma transfer
("buggy DMA detected. Taking evasive action").

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 1 +
 drivers/mmc/host/mmci.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 71e9336..1841d250 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -208,6 +208,7 @@ static struct variant_data variant_qcom = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.init			= qcom_variant_init,
 };
 
 /* Busy detection for the ST Micro variant */
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 517591d..696a066 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -338,3 +338,4 @@ struct mmci_host {
 #endif
 };
 
+void qcom_variant_init(struct mmci_host *host);
-- 
2.7.4


--------------F161F5249C1A089E1A9FD8F4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--------------F161F5249C1A089E1A9FD8F4--
