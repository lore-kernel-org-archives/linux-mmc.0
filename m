Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F0122D9F3
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953702; cv=none; b=cGDOzcwqxRss7l6Ml5NWbCyqps3deBRwEiH7mx6+aN2UILey4iAweUb3ELTrR5A+gK1TG49MEmKKDCbXtJkITOooOgphIgXbCe3PSIxowZ5Pd8Ozi1IkgPpeXhL4xZFVSMeAENE6Qc2fxgYeL028pM9VgVX+2DJncMdbA3tBF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953702; c=relaxed/simple;
	bh=vO8EuJzra62iDa5CewKLAOxaDBT9Lusz+6UuPzelPxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6LsNhzE/BHuQroEAXL17YiqZ2OXL8fhueaktWQU0INlQp9t2CGIbGD/4PiPKgOY3s8K6TCU/Mui1qrPBYFsKqYKkQ/rifJK8MLR61sxXYBo5LQh3jrzHDKOzLyGmVvtiwuazYIgvDELw1/evH+woO7sBx4vmAdKTg/M0mEoh6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxbeJf6j5ozzYKAQ--.60592S3;
	Tue, 03 Jun 2025 20:28:15 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBx3xte6j5oVA8HAQ--.36867S2;
	Tue, 03 Jun 2025 20:28:15 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 30/36] mmc: vub300: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:28:02 +0800
Message-ID: <f023d2caa02fab405f089c5170b686529857fb70.1748933789.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748933789.git.zhoubinbin@loongson.cn>
References: <cover.1748933789.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx3xte6j5oVA8HAQ--.36867S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr4kWw4UCr18ZFW8uw1Utwc_yoW5urW8pF
	WfGa9rKr4DXF15Xr48Ja1DZa4rWw1xtryUCFyjk395ZwnxKr9FyF12kay8tFyrCFykAa17
	XFWDJFy5ZayDGFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW8Xw0E3s1lYx0Ex4A2jsIE
	14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y40E4I
	xF1VCIxcxG6Fyj6r4UJwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IUYfsqJUUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/vub300.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index dd71e5b8e1a5..5a5eeeaa4321 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -369,13 +369,11 @@ struct vub300_mmc_host {
 static void vub300_delete(struct kref *kref)
 {				/* kref callback - softirq */
 	struct vub300_mmc_host *vub300 = kref_to_vub300_mmc_host(kref);
-	struct mmc_host *mmc = vub300->mmc;
 	usb_free_urb(vub300->command_out_urb);
 	vub300->command_out_urb = NULL;
 	usb_free_urb(vub300->command_res_urb);
 	vub300->command_res_urb = NULL;
 	usb_put_dev(vub300->udev);
-	mmc_free_host(mmc);
 	/*
 	 * and hence also frees vub300
 	 * which is contained at the end of struct mmc
@@ -2114,7 +2112,7 @@ static int vub300_probe(struct usb_interface *interface,
 		goto error1;
 	}
 	/* this also allocates memory for our VUB300 mmc host device */
-	mmc = mmc_alloc_host(sizeof(struct vub300_mmc_host), &udev->dev);
+	mmc = devm_mmc_alloc_host(&udev->dev, sizeof(*vub300));
 	if (!mmc) {
 		retval = -ENOMEM;
 		dev_err(&udev->dev, "not enough memory for the mmc_host\n");
@@ -2271,7 +2269,7 @@ static int vub300_probe(struct usb_interface *interface,
 		dev_err(&vub300->udev->dev,
 		    "Could not find two sets of bulk-in/out endpoint pairs\n");
 		retval = -EINVAL;
-		goto error5;
+		goto error4;
 	}
 	retval =
 		usb_control_msg(vub300->udev, usb_rcvctrlpipe(vub300->udev, 0),
@@ -2280,14 +2278,14 @@ static int vub300_probe(struct usb_interface *interface,
 				0x0000, 0x0000, &vub300->hc_info,
 				sizeof(vub300->hc_info), 1000);
 	if (retval < 0)
-		goto error5;
+		goto error4;
 	retval =
 		usb_control_msg(vub300->udev, usb_sndctrlpipe(vub300->udev, 0),
 				SET_ROM_WAIT_STATES,
 				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 				firmware_rom_wait_states, 0x0000, NULL, 0, 1000);
 	if (retval < 0)
-		goto error5;
+		goto error4;
 	dev_info(&vub300->udev->dev,
 		 "operating_mode = %s %s %d MHz %s %d byte USB packets\n",
 		 (mmc->caps & MMC_CAP_SDIO_IRQ) ? "IRQs" : "POLL",
@@ -2302,7 +2300,7 @@ static int vub300_probe(struct usb_interface *interface,
 				0x0000, 0x0000, &vub300->system_port_status,
 				sizeof(vub300->system_port_status), 1000);
 	if (retval < 0) {
-		goto error5;
+		goto error4;
 	} else if (sizeof(vub300->system_port_status) == retval) {
 		vub300->card_present =
 			(0x0001 & vub300->system_port_status.port_flags) ? 1 : 0;
@@ -2310,7 +2308,7 @@ static int vub300_probe(struct usb_interface *interface,
 			(0x0010 & vub300->system_port_status.port_flags) ? 1 : 0;
 	} else {
 		retval = -EINVAL;
-		goto error5;
+		goto error4;
 	}
 	usb_set_intfdata(interface, vub300);
 	INIT_DELAYED_WORK(&vub300->pollwork, vub300_pollwork_thread);
@@ -2340,8 +2338,6 @@ static int vub300_probe(struct usb_interface *interface,
 	return 0;
 error6:
 	timer_delete_sync(&vub300->inactivity_timer);
-error5:
-	mmc_free_host(mmc);
 	/*
 	 * and hence also frees vub300
 	 * which is contained at the end of struct mmc
-- 
2.47.1

