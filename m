From: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Subject: [PATCH v2 4/4] ARM: pxa168/gplugd: Add support for SD port 1
Date: Sun, 17 Mar 2013 13:20:06 -0500
Message-ID: <1363544406-3837-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <1363544206-3671-1-git-send-email-tanmay.upadhyay@einfochips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1363544206-3671-1-git-send-email-tanmay.upadhyay@einfochips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: eric.y.miao@gmail.com, haojian.zhuang@gmail.com
Cc: prakity@marvell.com, linux-mmc@vger.kernel.org, Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

v2 - after sdhci-pxav1 driver is merged with sdhci-pxav2, pass
     pxav1_controller = 1
   - as sdhci device numbering now starts from 1, call
     pxa168_add_sdh accordingly

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Reviewed-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/gplugd.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index 5c3d61e..d821368 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -155,6 +155,11 @@ struct pxa168_eth_platform_data gplugd_eth_platform_data = {
 	.init        = gplugd_eth_init,
 };
 
+struct sdhci_pxa_platdata gplugd_sdh_platdata = {
+	.delay_in_ms = 5,
+	.pxav1_controller = 1,
+};
+
 static void __init select_disp_freq(void)
 {
 	/* set GPIO 35 & clear GPIO 85 to set LCD External Clock to 74.25 MHz */
@@ -188,6 +193,7 @@ static void __init gplugd_init(void)
 	platform_device_register(&pxa168_device_gpio);
 
 	pxa168_add_eth(&gplugd_eth_platform_data);
+	pxa168_add_sdh(1, &gplugd_sdh_platdata);
 }
 
 MACHINE_START(GPLUGD, "PXA168-based GuruPlug Display (gplugD) Platform")
-- 
1.7.9.5

*************************************************************************************************************************************************************
eInfochips Business Disclaimer : This e-mail message and all attachments transmitted with it are intended solely for the use of the addressee and may contain legally privileged and confidential information. If the reader of this message is not the intended recipient, or an employee or agent responsible for delivering this message to the intended recipient, you are hereby notified that any dissemination, distribution, copying, or other use of this message or its attachments is strictly prohibited. If you have received this message in error, please notify the sender immediately by replying to this message and please delete it from your computer. Any views expressed in this message are those of the individual sender unless otherwise stated. Company has taken enough precautions to prevent the 
 spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
*************************************************************************************************************************************************************


---------------------------------------------------------------------------------------------
Notice: 
This message has been scanned by Trend Micro Mail Security scanner and is believed to be clean
---------------------------------------------------------------------------------------------
