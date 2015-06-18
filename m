From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2 4/7] USB: mos7720: rename DCR
Date: Thu, 18 Jun 2015 17:47:50 +0530
Message-ID: <1434629873-11668-5-git-send-email-sudipm.mukherjee@gmail.com>
References: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36729 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932242AbbFRMSh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Jun 2015 08:18:37 -0400
In-Reply-To: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Howells <dhowells@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-am33-list@redhat.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

While building with mn10300 it failed with:
error: expected identifier before '(' token
 #define __SYSREG(ADDR, TYPE) (*(volatile TYPE *)(ADDR))
note: in expansion of macro '__SYSREG'
 #define DCR   __SYSREG(0xc0000030, u16) /* Debug control register */

mn10300 has a register named as DCR, so when this driver used an enum
named as DCR, build failed.
Just rename the DCR in the driver to parport_DCR.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/usb/serial/mos7720.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 4f70df3..3263125 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -135,7 +135,7 @@ enum mos_regs {
 	DLM,
 	DPR,              /* parallel port regs */
 	DSR,
-	DCR,
+	parport_DCR,
 	ECR,
 	SP1_REG,          /* device control regs */
 	SP2_REG,          /* serial port 2 (7720 only) */
@@ -164,7 +164,7 @@ static inline __u16 get_reg_index(enum mos_regs reg)
 		0x01,		/* DLM */
 		0x00,		/* DPR */
 		0x01,		/* DSR */
-		0x02,		/* DCR */
+		0x02,		/* parport_DCR */
 		0x0a,		/* ECR */
 		0x01,		/* SP1_REG */
 		0x02,		/* SP2_REG (7720 only) */
@@ -510,7 +510,7 @@ static void parport_mos7715_write_control(struct parport *pp, unsigned char d)
 	if (parport_prologue(pp) < 0)
 		return;
 	data = ((__u8)d & 0x0f) | (mos_parport->shadowDCR & 0xf0);
-	write_mos_reg(mos_parport->serial, dummy, DCR, data);
+	write_mos_reg(mos_parport->serial, dummy, parport_DCR, data);
 	mos_parport->shadowDCR = data;
 	parport_epilogue(pp);
 }
@@ -543,7 +543,7 @@ static unsigned char parport_mos7715_frob_control(struct parport *pp,
 	if (parport_prologue(pp) < 0)
 		return 0;
 	mos_parport->shadowDCR = (mos_parport->shadowDCR & (~mask)) ^ val;
-	write_mos_reg(mos_parport->serial, dummy, DCR, mos_parport->shadowDCR);
+	write_mos_reg(mos_parport->serial, dummy, parport_DCR, mos_parport->shadowDCR);
 	dcr = mos_parport->shadowDCR & 0x0f;
 	parport_epilogue(pp);
 	return dcr;
@@ -581,7 +581,7 @@ static void parport_mos7715_data_forward(struct parport *pp)
 		return;
 	mos7715_change_mode(mos_parport, PS2);
 	mos_parport->shadowDCR &=  ~0x20;
-	write_mos_reg(mos_parport->serial, dummy, DCR, mos_parport->shadowDCR);
+	write_mos_reg(mos_parport->serial, dummy, parport_DCR, mos_parport->shadowDCR);
 	parport_epilogue(pp);
 }
 
@@ -593,7 +593,7 @@ static void parport_mos7715_data_reverse(struct parport *pp)
 		return;
 	mos7715_change_mode(mos_parport, PS2);
 	mos_parport->shadowDCR |= 0x20;
-	write_mos_reg(mos_parport->serial, dummy, DCR, mos_parport->shadowDCR);
+	write_mos_reg(mos_parport->serial, dummy, parport_DCR, mos_parport->shadowDCR);
 	parport_epilogue(pp);
 }
 
@@ -633,7 +633,7 @@ static void parport_mos7715_restore_state(struct parport *pp,
 		spin_unlock(&release_lock);
 		return;
 	}
-	write_parport_reg_nonblock(mos_parport, DCR, mos_parport->shadowDCR);
+	write_parport_reg_nonblock(mos_parport, parport_DCR, mos_parport->shadowDCR);
 	write_parport_reg_nonblock(mos_parport, ECR, mos_parport->shadowECR);
 	spin_unlock(&release_lock);
 }
@@ -719,7 +719,7 @@ static int mos7715_parport_init(struct usb_serial *serial)
 
 	/* initialize device registers */
 	mos_parport->shadowDCR = DCR_INIT_VAL;
-	write_mos_reg(mos_parport->serial, dummy, DCR, mos_parport->shadowDCR);
+	write_mos_reg(mos_parport->serial, dummy, parport_DCR, mos_parport->shadowDCR);
 	mos_parport->shadowECR = ECR_INIT_VAL;
 	write_mos_reg(mos_parport->serial, dummy, ECR, mos_parport->shadowECR);
 
-- 
1.8.1.2

