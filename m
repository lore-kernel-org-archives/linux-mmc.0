From: Roger Tseng <rogerable@realtek.com>
Subject: Re: [PATCH] mmc: rtsx: fix incorrect last byte in R2 response
Date: Thu, 14 Aug 2014 06:06:20 +0000
Message-ID: <1407996435.6245.15.camel@debian-rtk5880>
References: <1407745936-18513-1-git-send-email-rogerable@realtek.com>
 <CAPDyKFrTbiHxYgW5YCR48DKX8arxuxK3rz7k_H-waGEMiPFjSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <CAPDyKFrTbiHxYgW5YCR48DKX8arxuxK3rz7k_H-waGEMiPFjSg@mail.gmail.com>
Content-Language: zh-TW
Content-ID: <8BD32206F24D7E48BDA853A613E1CBDE@realtek.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei_wang <wei_wang@realsil.com.cn>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 2014-08-13 at 17:09 +0200, Ulf Hansson wrote:
> On 11 August 2014 10:32,  <rogerable@realtek.com> wrote:
> > From: Roger Tseng <rogerable@realtek.com>
> >
> > Current code erroneously fill the last byte of R2 response with an undefined
> > value. In addition, it is impossible to obtain the real values since the
> > controller actually 'offloads' the last byte(CRC7, end bit) while receiving R2
> > response. This could cause mmc stack to obtain inconsistent CID from the same
> > card after resume and misidentify it as a different card.
> >
> > Fix by assigning a dummy value 0x01 to the last byte of R2 response.
> >
> > Signed-off-by: Roger Tseng <rogerable@realtek.com>
> 
> Thanks! Queued for 3.18.
> 
> I guess this should go for stable as well?
Yes. However, since rtsx_usb* is present in 3.16 and later, this patch
will not apply on 3.15.y or older. Should I separately send an adapted
version to stable?

By the way, according to Dan's comment I would like to add a few word
to explain the code. Would you help fix it up by following diff?

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 54849d8..ca31279 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -412,7 +412,13 @@ static void sd_send_cmd_get_rsp(struct
realtek_pci_sdmmc *host,
 	}
 
 	if (rsp_type == SD_RSP_TYPE_R2) {
+		/*
+		 * The controller offloads the last byte {CRC-7, stop bit 1'b1}
+		 * of response type R2. Assign a dummy CRC, 0, and stop bit to
+		 * the byte(ptr[16], goes into the LSB of resp[3] later).
+		 */
 		ptr[16] = 1;
+
 		for (i = 0; i < 4; i++) {
 			cmd->resp[i] = get_unaligned_be32(ptr + 1 + i * 4);
 			dev_dbg(sdmmc_dev(host), "cmd->resp[%d] = 0x%08x\n",
diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c
b/drivers/mmc/host/rtsx_usb_sdmmc.c
index ca08df1..727a88d 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -435,7 +435,13 @@ static void sd_send_cmd_get_rsp(struct
rtsx_usb_sdmmc *host,
 	}
 
 	if (rsp_type == SD_RSP_TYPE_R2) {
+		/*
+		 * The controller offloads the last byte {CRC-7, stop bit 1'b1}
+		 * of response type R2. Assign a dummy CRC, 0, and stop bit to
+		 * the byte(ptr[16], goes into the LSB of resp[3] later).
+		 */
 		ptr[16] = 1;
+
 		for (i = 0; i < 4; i++) {
 			cmd->resp[i] = get_unaligned_be32(ptr + 1 + i * 4);
 			dev_dbg(sdmmc_dev(host), "cmd->resp[%d] = 0x%08x\n",

-- 
Best regards,
Roger Tseng
