From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
Date: Mon, 19 Oct 2009 20:16:47 +0200
Message-ID: <4ADCAD0F.9010107@googlemail.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com> <4AD81DC2.4080607@googlemail.com> <42153.192.168.10.89.1255715021.squirrel@dbdmail.itg.ti.com> <4AD8C959.1000004@googlemail.com> <004701ca4ea5$aeacefe0$544ff780@am.dhcp.ti.com> <4b73d43f0910161426l7600f424w5b8345d16790dd21@mail.gmail.com> <4ADB4604.2090704@googlemail.com> <13B9B4C6EF24D648824FF11BE8967162039B3184F0@dlee02.ent.ti.com> <4b73d43f0910181717i9623184mc2b8c7d6ca0fb435@mail.gmail.com> <4b73d43f0910181724q11d40851wb2aed801d7ae85f6@mail.gmail.com> <005101ca50e1$11ef2770$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080806070404090402010602"
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <005101ca50e1$11ef2770$544ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Madhusudhan <madhu.cr@ti.com>, 'John Rigby' <jcrigby@gmail.com>, "'Woodruff, Richard'" <r-woodruff2@ti.com>, linux-mmc@vger.kernel.org, 'Steve Sakoman' <sakoman@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.
--------------080806070404090402010602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Madhusudhan wrote:
> Hi John,
> 
> So does the SDIO card interrupt mode work fine now?

(wrong attachment in previous mail :( sorry)

If somebody likes to test, my updated patch v2 in attachment. Compile 
tested only, testing and comments are welcome.

Cheers

Dirk

>   _____  
> 
> From: John Rigby [mailto:jcrigby@gmail.com] 
> Sent: Sunday, October 18, 2009 7:24 PM
> To: Woodruff, Richard
> Cc: Dirk Behme; Chikkature Rajashekar, Madhusudhan;
> linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; Steve Sakoman
> Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
> 
>  
> 
> Ok I was going to ask where you found that but I just rechecked the TRM and
> there it is in plain site:
> 
> 
> 
> When this bit is set to 1, the host controller automatically disables all
> the input buffers except the buffer of mmci_dat[1] outside of a transaction
> in order to detect asynchronous card interrupt on mmci_dat[1] line and
> minimize the leakage current of the buffers.
> 
> 
> In my defence, I did search the TRM for every occurance of dat1 but not
> dat[1].  Oh well live and learn and forget and repeat.
> 
> John
> 
> On Sun, Oct 18, 2009 at 6:17 PM, John Rigby <jcrigby@gmail.com> wrote:
>> Richard,
>>
>> MMCHS_CON.CPTL = 1  < Don't disable input buffer on DAT1 after
>> completion to allow seeing SDIO interrupt>
>>
>> Sounds exactly like what we need.
>>
>> Thanks
>> John
>>
>> On Sun, Oct 18, 2009 at 5:12 PM, Woodruff, Richard <r-woodruff2@ti.com>
> wrote:
>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>>> owner@vger.kernel.org] On Behalf Of Dirk Behme
>>>> Sent: Sunday, October 18, 2009 11:45 AM
>>>>> It would be funny if the TRM was wrong and the CIRQ bit is really
>>>>> cleared by writing 1 to it.  I'll try that.
>>> A while back I hunted down a few of the bits for this.  Maybe this will
> help some.
>>> SYSCONFIG.ENAWAKEUP = 1 < allow ocp wrapper to generate an interrupt to
> prcm>
>>> MMCHS_HCTL.IWE = 1 < route wake up to module ocp wrapper>
>>> MMCHS_CON.CPTL = 1  < Don't disable input buffer on DAT1 after completion
> to allow seeing SDIO interrupt>
>>> MMCHS_HCTL.IWE
>>> MMCHS_ISE.CIRQ_ENABLE <bit to write to enable interrupt at pin>
>>> MMCHS_STAT<bit to write for clear of SDIO interrupt>
>>> CCCCR - IRQ_ENABLE (think host stack will do this)
>>>
>>> Regards,
>>> Richard W.
>>>
> 
> 



--------------080806070404090402010602
Content-Type: text/plain;
 name="omap_hsmmc_sdio_irq_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap_hsmmc_sdio_irq_patch.txt"

Subject: [PATCH v2][RFC] OMAP HSMMC: Add SDIO interrupt support
Form: Dirk Behme <dirk.behme@googlemail.com>

At the moment, OMAP HSMMC driver supports only SDIO polling, resulting in poor
performance. Add support for SDIO interrupt handling. 

Signed-off-by: Dirk Behme <dirk.behme@googlemail.com>
---

Patch against recent omap-linux head "Linux omap got rebuilt from scratch"
274c94b29ee7c53609a756acca974e4742c59559

Compile tested only. Please comment and help testing.

Changes in v2:

- For testing only, hardcode IBG. This should be set only in SDIO and 4-bit
  mode. But how to detect this? mmc_card_sdio(host->mmc->card) doesn't seem
  to work here.

- Additonally, set CTPL. Is this needed for 1-bit mode?

 drivers/mmc/host/omap_hsmmc.c |   44 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

Index: linux-beagle/drivers/mmc/host/omap_hsmmc.c
===================================================================
--- linux-beagle.orig/drivers/mmc/host/omap_hsmmc.c
+++ linux-beagle/drivers/mmc/host/omap_hsmmc.c
@@ -65,6 +65,7 @@
 #define SDVSDET			0x00000400
 #define AUTOIDLE		0x1
 #define SDBP			(1 << 8)
+#define IBG			(1 << 19)
 #define DTO			0xe
 #define ICE			0x1
 #define ICS			0x2
@@ -76,6 +77,7 @@
 #define INT_EN_MASK		0x307F0033
 #define BWR_ENABLE		(1 << 4)
 #define BRR_ENABLE		(1 << 5)
+#define CIRQ_ENABLE		(1 << 8)
 #define INIT_STREAM		(1 << 1)
 #define DP_SELECT		(1 << 21)
 #define DDIR			(1 << 4)
@@ -84,9 +86,11 @@
 #define BCE			(1 << 1)
 #define FOUR_BIT		(1 << 1)
 #define DW8			(1 << 5)
+#define CTPL			(1 << 11)
 #define CC			0x1
 #define TC			0x02
 #define OD			0x1
+#define CIRQ			(1 <<  8)
 #define ERR			(1 << 15)
 #define CMD_TIMEOUT		(1 << 16)
 #define DATA_TIMEOUT		(1 << 20)
@@ -653,6 +657,15 @@ static irqreturn_t omap_hsmmc_irq(int ir
 	status = OMAP_HSMMC_READ(host->base, STAT);
 	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
 
+	if (status & CIRQ) {
+		dev_dbg(mmc_dev(host->mmc), "SDIO interrupt");
+		OMAP_HSMMC_WRITE(host->base, IE, OMAP_HSMMC_READ(host->base, IE)
+				 & ~(CIRQ_ENABLE));
+		mmc_signal_sdio_irq(host->mmc);
+		spin_unlock(&host->irq_lock);
+		return IRQ_HANDLED;
+	}
+
 	if (status & ERR) {
 #ifdef CONFIG_MMC_DEBUG
 		omap_hsmmc_report_irq(host, status);
@@ -1164,12 +1177,13 @@ static void omap_hsmmc_set_ios(struct mm
 		OMAP_HSMMC_WRITE(host->base, CON, con | DW8);
 		break;
 	case MMC_BUS_WIDTH_4:
-		OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
+		OMAP_HSMMC_WRITE(host->base, CON, (con | CTPL) & ~DW8);
 		OMAP_HSMMC_WRITE(host->base, HCTL,
-			OMAP_HSMMC_READ(host->base, HCTL) | FOUR_BIT);
+				 OMAP_HSMMC_READ(host->base, HCTL)
+				 | IBG | FOUR_BIT);
 		break;
 	case MMC_BUS_WIDTH_1:
-		OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
+		OMAP_HSMMC_WRITE(host->base, CON, (con | CTPL) & ~DW8);
 		OMAP_HSMMC_WRITE(host->base, HCTL,
 			OMAP_HSMMC_READ(host->base, HCTL) & ~FOUR_BIT);
 		break;
@@ -1512,6 +1526,24 @@ static int omap_hsmmc_disable_fclk(struc
 	return 0;
 }
 
+static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct omap_hsmmc_host *host = mmc_priv(mmc);
+	u32 ie, ise;
+
+	ise = OMAP_HSMMC_READ(host->base, ISE);
+	ie  = OMAP_HSMMC_READ(host->base, IE);
+
+	if (enable) {
+		OMAP_HSMMC_WRITE(host->base, ISE, ise | CIRQ_ENABLE);
+		OMAP_HSMMC_WRITE(host->base, IE,  ie  | CIRQ_ENABLE);
+	} else {
+		OMAP_HSMMC_WRITE(host->base, ISE, ise & ~CIRQ_ENABLE);
+		OMAP_HSMMC_WRITE(host->base, IE,  ie  & ~CIRQ_ENABLE);
+	}
+
+}
+
 static const struct mmc_host_ops omap_hsmmc_ops = {
 	.enable = omap_hsmmc_enable_fclk,
 	.disable = omap_hsmmc_disable_fclk,
@@ -1519,7 +1551,7 @@ static const struct mmc_host_ops omap_hs
 	.set_ios = omap_hsmmc_set_ios,
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
-	/* NYET -- enable_sdio_irq */
+	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };
 
 static const struct mmc_host_ops omap_hsmmc_ps_ops = {
@@ -1529,7 +1561,7 @@ static const struct mmc_host_ops omap_hs
 	.set_ios = omap_hsmmc_set_ios,
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
-	/* NYET -- enable_sdio_irq */
+	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -1734,7 +1766,7 @@ static int __init omap_hsmmc_probe(struc
 	mmc->max_seg_size = mmc->max_req_size;
 
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-		     MMC_CAP_WAIT_WHILE_BUSY;
+		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_SDIO_IRQ;
 
 	if (mmc_slot(host).wires >= 8)
 		mmc->caps |= MMC_CAP_8_BIT_DATA;

--------------080806070404090402010602--
