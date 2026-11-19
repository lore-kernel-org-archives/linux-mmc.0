Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110617;
	b=qBc92YgpGFQBAy+zcbvH1/oIrfocfC4rP08M0EMM+abIzZM7tRluX01jdWayiv5bK5kT
	 ZMKzbtBwhFxmNZTeMcCo5HSyfbcOMbdc1iiL+kj5D2at6bYCHe8H655oorw1FshZ8fawK
	 bnAiekVSBCrSvoSYakmNyT6vkuLN0akYilY8dmhyoJemQWjQYUeherXqu+C33NoaIjaw4
	 3z16zw5fNfKk9MToyp5+MqZDcJDWKF7EhOOfVJtVDOT/+JeqC66S1wHZTPTMU+xrwE+Ih
	 GyNYlJKDQkIui0o8bjSQylc9QEI6qQsqpnLHr7OeZ2alM+JYSlKu9WHBv+7i/R4JvfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=biZE2CTLfp37QMWttMCLwen07TVkYszR0CyrzZrWaac=;
	b=zASKIPNf6gRNHB+2Gvlsfhb4etEoCT3XMJaY3Z5YapzGYDqqSCcuBEjV5xYthDgB03G6
	 3yH2r3wKsS2EAbyn/EbdzHS+HIazYlqnTC8KHZreIEGzA/er47MzTI//sxRvvU77zfGK9
	 nBY9Otmb+aZ8zDVQ4+sbbogZhzrP1CVgXTa1ffuOaDP/PjciMYL6oVzSEt2cvMnE+3UAA
	 Qe4o7SfHZpeyKCIixQ1CFn5cljsWAFi7kiQNr5x3Awbr1UOzNU6i+eCyruaIeal8UJ9F3
	 j4ASFizKqpMaWY/mCAJEJrXgzGszSNvGnmLYmTAIaqoN9bzf/nKdrH1GKEBZBveuFBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aheymans.xyz;
	spf=pass smtp.mailfrom=aheymans.xyz;
	dkim=pass header.d=aheymans-xyz.20260707.gappssmtp.com header.i=@aheymans-xyz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lSL5zlD1;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6160A5BD3
	for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 17:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62F6160A5BD3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aheymans-xyz.20260707.gappssmtp.com header.i=@aheymans-xyz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lSL5zlD1
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so28295085e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 09:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aheymans-xyz.20260707.gappssmtp.com; s=20260707; t=1795110615; x=1795715415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=biZE2CTLfp37QMWttMCLwen07TVkYszR0CyrzZrWaac=;
        b=lSL5zlD1j7RAVJ1qICNT31/bpiBPPKF5PXRc6gv3yE2j5Dpkp9kwmh1JQV+sTW67wO
         WSmLhGumALbGklJZ6zRwIJBWEj11lGW+CtFtAt2mCZcypeOQVygOZvQO50+qg2hdjazp
         rHKPSNvXwJ1eZ4ZTj8y60BU/6lg5Qz4jIbV+y0ljR/2GxopDezI7xrwMKlT00/ryiAI3
         7YnvbDM6OYrSPij4e/Hp4VXpnvtnscg9UqUe/UiGnff9qAhT+BHN/bszIB8HNA4SRGG2
         fjeBGWCA+G8fz4TdFO05wV/dh1UkPq2Rcv6zZIPxGxkcRAKeBIUa+4F/yDQCuHSjZ4+0
         vvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795110615; x=1795715415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=biZE2CTLfp37QMWttMCLwen07TVkYszR0CyrzZrWaac=;
        b=x3u4/9GfuvslZOz0WVWQLW+9Cf+GXaOFTupj1/YEPey7qajx80UAnbhi4WX6hmp92O
         KQ9xKLkZSahdCUI6U1o1rJ2EwMPjfr7Ewhm1GzdPIiwRy2fmNJ8A1CcixBJ0v6rcYbkq
         +xkDBeRoBt/Wn36VN4FJTa0cfwXQpDmgBiHN+q+2yeEwXiz/7TjXHe184qtVAmVZ/AwF
         5DwT6nNsA9jav9/dPoUsAMhaRhiQLKU6XesrQ+1KzwJSEY/jUJLBTGUi7+KPDKxcOAai
         BoxIyE6/2XPwRyHP18f7yYAiJfNKl+QLjXOSf+0CDP7GOVuy/grGYlVk4f9xiUrOL/iw
         jrYw==
X-Forwarded-Encrypted: i=1; AL+hErHYuIUvAbHiVrvQLuTn9zYz1GzP1g5jChYi2ttMJGqbyc02Cxs1w7XTOBkjk7AqIbvSyXHO3wkTo4I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZDeeUF5BUaGeXUBJuY63OEOUagIS6yknLOJzM0YtMFKbKJ2ha
	6ohRscJzLGuhZTj/oInDKONlwN+g+kBKRsXN5Zxy6maKNGboP4wazKle9U6odKe53c9BYYqMPRv
	aYQ7/gX4=
X-Gm-Gg: AYBFou2IZTcu2PoYkyDNDlSZZjiinomS16AoGOi19TgmhNv51X5+zYi6TdHFfyCbrqy
	6ACpLX6s/lZ1hTendpOfc7taDgnb2oqdFXHzwTfGmBeMKmGYI+MdkPfQ40kHQvgwFL0zL9iPav7
	IXuzlhz+DTj5epVJZDUlt4rKfNwY2wKAjT40A8xZhm1E/6mUUyJTZtCQ53hZpbqTDEfpJf/Gy1y
	mY5Er6Q0g6wnMXCcBjt57KHmvpLnbpZVcN0ZcBZLu+RJ9DXjrajb+tqxHeRrFP6tbLNw+1wyGUH
	/v4HXHwO/ULqhcucuuilLdJC7bk+oXhd4MoWZ2+W2sedtOlFtOG4h5V1dV2lw2BUnwos8BaHJkU
	vamZpOA5dtHclELkxJr8B19PJN6kHPUa0yf/S9RGinYkh0f43YTwT/T0hHmQjfNi5L+pz0nEcRe
	Al0xg/aTsrmid944s9zrhjPIIblPTDs4xndhouPwnGTkhJ2DyDzDtTHJ7fkrWzPMp3ts2MUHAXp
	IA0BpIEwrQkYmpopN0One4cguGNzTs6mLhOcmpG6ADEEmqMaWKq9oXm3AvMjNTg418h//XKJUWb
	OauggDJ1qW8/nvz8KRNGKMxd0HYrX71VmAvmyso0OXzb2owpt3rSZstE9L77yLSUK5GMQNHZU23
	L6al6ignUGKz5hbn8RDhGnqmTqzhKRjYD2vs8Q+EemoeNRSFZrJlb/s8nUU2mLhsFpNomIJrVYc
	GPbVZyKXv9W8PDvzUwhRmk2iY=
X-Received: by 2002:a05:600c:1c21:b0:4bb:52bd:a3c7 with SMTP id 5b1f17b1804b1-4bb88804d41mr6984725e9.6.1795110614628;
        Thu, 19 Nov 2026 09:50:14 -0800 (PST)
Received: from localhost (2a02-1810-b422-d400-611-84c9-252f-74ad.ip6.access.telenet.be. [2a02:1810:b422:d400:611:84c9:252f:74ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989e3sm939503f8f.52.2026.11.19.09.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:50:14 -0800 (PST)
From: Arthur Heymans <arthur@aheymans.xyz>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org,
	Solomon Peachy <pizza@shaftnet.org>,
	linux-kernel@vger.kernel.org,
	Arthur Heymans <arthur@aheymans.xyz>
Subject: [PATCH wireless-next 08/10] wifi: cw1200: load the XR819 bootloader into SRAM
Date: Thu, 19 Nov 2026 18:50:00 +0100
Message-ID: <20261119175002.458988-9-arthur@aheymans.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119175002.458988-1-arthur@aheymans.xyz>
References: <20261119175002.458988-1-arthur@aheymans.xyz>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XR819 shares the CW1x60 revision field but needs a first-stage loader
at 0x08000000. Write it before releasing the CPU from reset, then use
the existing firmware download path.

Prepared with OpenAI Codex.

Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
---
 drivers/net/wireless/st/cw1200/cw1200.h |  8 +++
 drivers/net/wireless/st/cw1200/fwio.c   | 67 +++++++++++++++++++++++--
 drivers/net/wireless/st/cw1200/fwio.h   |  3 ++
 drivers/net/wireless/st/cw1200/hwio.h   |  1 +
 drivers/net/wireless/st/cw1200/main.c   | 37 +++++++++++---
 5 files changed, 105 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/cw1200.h b/drivers/net/wireless/st/cw1200/cw1200.h
index 6dc85ef6e0fa..b25b60d377f6 100644
--- a/drivers/net/wireless/st/cw1200/cw1200.h
+++ b/drivers/net/wireless/st/cw1200/cw1200.h
@@ -116,7 +116,9 @@ struct cw1200_common {
 		CW1200_HW_REV_CUT20 = 20,
 		CW1200_HW_REV_CUT22 = 22,
 		CW1X60_HW_REV       = 40,
+		XR819_HW_REV        = 41,
 	} hw_revision;
+	bool				is_xr819;
 	int                             hw_refclk;
 	bool				hw_have_5ghz;
 	const struct firmware		*sdd;
@@ -293,6 +295,12 @@ int cw1200_core_probe(const struct hwbus_ops *hwbus_ops,
 		      struct cw1200_common **pself,
 		      int ref_clk, const u8 *macaddr,
 		      const char *sdd_path, bool have_5ghz);
+int cw1200_core_probe_xr819(const struct hwbus_ops *hwbus_ops,
+			    struct hwbus_priv *hwbus,
+			    struct device *pdev,
+			    struct cw1200_common **pself,
+			    int ref_clk, const u8 *macaddr,
+			    const char *sdd_path);
 void cw1200_core_unregister(struct cw1200_common *self);
 void cw1200_core_release(struct cw1200_common *self);
 
diff --git a/drivers/net/wireless/st/cw1200/fwio.c b/drivers/net/wireless/st/cw1200/fwio.c
index 2a03dc533b6a..08b6f02e3ffd 100644
--- a/drivers/net/wireless/st/cw1200/fwio.c
+++ b/drivers/net/wireless/st/cw1200/fwio.c
@@ -14,6 +14,7 @@
 #include <linux/vmalloc.h>
 #include <linux/sched.h>
 #include <linux/firmware.h>
+#include <linux/unaligned.h>
 
 #include "cw1200.h"
 #include "fwio.h"
@@ -116,6 +117,11 @@ static int cw1200_load_firmware_cw1200(struct cw1200_common *priv)
 		if (!priv->sdd_path)
 			priv->sdd_path = SDD_FILE_CW1X60;
 		break;
+	case XR819_HW_REV:
+		fw_path = FIRMWARE_XR819;
+		if (!priv->sdd_path)
+			priv->sdd_path = SDD_FILE_XR819;
+		break;
 	default:
 		pr_err("Invalid silicon revision %d.\n", priv->hw_revision);
 		return -EINVAL;
@@ -128,9 +134,11 @@ static int cw1200_load_firmware_cw1200(struct cw1200_common *priv)
 	APB_WRITE(DOWNLOAD_STATUS_REG, DOWNLOAD_PENDING);
 	APB_WRITE(DOWNLOAD_FLAGS_REG, 0);
 
-	/* Write the NOP Instruction */
-	REG_WRITE(ST90TDS_SRAM_BASE_ADDR_REG_ID, 0xFFF20000);
-	REG_WRITE(ST90TDS_AHB_DPORT_REG_ID, 0xEAFFFFFE);
+	if (!priv->is_xr819) {
+		/* Write the NOP Instruction */
+		REG_WRITE(ST90TDS_SRAM_BASE_ADDR_REG_ID, 0xFFF20000);
+		REG_WRITE(ST90TDS_AHB_DPORT_REG_ID, 0xEAFFFFFE);
+	}
 
 	/* Release CPU from RESET */
 	REG_READ(ST90TDS_CONFIG_REG_ID, val32);
@@ -261,6 +269,45 @@ static int cw1200_load_firmware_cw1200(struct cw1200_common *priv)
 #undef REG_READ
 }
 
+static int cw1200_load_bootloader_xr819(struct cw1200_common *priv)
+{
+	const struct firmware *bootloader;
+	u32 addr = XR819_BOOT_BASE;
+	size_t i;
+	int ret;
+
+	ret = request_firmware(&bootloader, BOOTLOADER_XR819, priv->pdev);
+	if (ret) {
+		dev_err(priv->pdev, "can't load bootloader file %s\n",
+			BOOTLOADER_XR819);
+		return ret;
+	}
+
+	if (!bootloader->size || bootloader->size > U32_MAX - addr ||
+	    !IS_ALIGNED(bootloader->size, sizeof(u32))) {
+		dev_err(priv->pdev, "invalid bootloader size %zu\n", bootloader->size);
+		ret = -EINVAL;
+		goto release;
+	}
+
+	for (i = 0; i < bootloader->size; i += sizeof(u32), addr += sizeof(u32)) {
+		u32 word = get_unaligned_le32(bootloader->data + i);
+
+		ret = cw1200_reg_write_32(priv, ST90TDS_SRAM_BASE_ADDR_REG_ID,
+					  addr);
+		if (ret)
+			goto release;
+
+		ret = cw1200_reg_write_32(priv, ST90TDS_AHB_DPORT_REG_ID, word);
+		if (ret)
+			goto release;
+	}
+
+release:
+	release_firmware(bootloader);
+	return ret;
+}
+
 
 static int config_reg_read(struct cw1200_common *priv, u32 *val)
 {
@@ -443,8 +490,13 @@ int cw1200_load_firmware(struct cw1200_common *priv)
 		break;
 	}
 	case 4:
-		pr_info("CW1x60 silicon detected.\n");
-		priv->hw_revision = CW1X60_HW_REV;
+		if (priv->is_xr819) {
+			dev_info(priv->pdev, "XR819 silicon detected\n");
+			priv->hw_revision = XR819_HW_REV;
+		} else {
+			pr_info("CW1x60 silicon detected.\n");
+			priv->hw_revision = CW1X60_HW_REV;
+		}
 		break;
 	default:
 		pr_err("Unsupported silicon major revision %d.\n",
@@ -473,6 +525,11 @@ int cw1200_load_firmware(struct cw1200_common *priv)
 			ret = -ENOTSUPP;
 			goto out;
 		}
+		if (priv->is_xr819) {
+			ret = cw1200_load_bootloader_xr819(priv);
+			if (ret)
+				goto out;
+		}
 		ret = cw1200_load_firmware_cw1200(priv);
 		break;
 	default:
diff --git a/drivers/net/wireless/st/cw1200/fwio.h b/drivers/net/wireless/st/cw1200/fwio.h
index c287160a492e..a3effef6d500 100644
--- a/drivers/net/wireless/st/cw1200/fwio.h
+++ b/drivers/net/wireless/st/cw1200/fwio.h
@@ -25,6 +25,9 @@
 #define SDD_FILE_20		"sdd_20.bin"
 #define SDD_FILE_11		"sdd_11.bin"
 #define SDD_FILE_10		"sdd_10.bin"
+#define BOOTLOADER_XR819	"xr819/boot_xr819.bin"
+#define FIRMWARE_XR819		"xr819/fw_xr819.bin"
+#define SDD_FILE_XR819		"xr819/sdd_xr819.bin"
 
 int cw1200_load_firmware(struct cw1200_common *priv);
 
diff --git a/drivers/net/wireless/st/cw1200/hwio.h b/drivers/net/wireless/st/cw1200/hwio.h
index d1e629a566c2..376dd1525fe2 100644
--- a/drivers/net/wireless/st/cw1200/hwio.h
+++ b/drivers/net/wireless/st/cw1200/hwio.h
@@ -89,6 +89,7 @@ struct download_cntl_t {
 
 
 #define SYS_BASE_ADDR_SILICON		(0)
+#define XR819_BOOT_BASE			0x08000000
 #define PAC_BASE_ADDRESS_SILICON	(SYS_BASE_ADDR_SILICON + 0x09000000)
 #define PAC_SHARED_MEMORY_SILICON	(PAC_BASE_ADDRESS_SILICON)
 
diff --git a/drivers/net/wireless/st/cw1200/main.c b/drivers/net/wireless/st/cw1200/main.c
index ee9fcecb0100..998b8e45e503 100644
--- a/drivers/net/wireless/st/cw1200/main.c
+++ b/drivers/net/wireless/st/cw1200/main.c
@@ -515,12 +515,13 @@ u32 cw1200_dpll_from_clk(u16 clk_khz)
 	}
 }
 
-int cw1200_core_probe(const struct hwbus_ops *hwbus_ops,
-		      struct hwbus_priv *hwbus,
-		      struct device *pdev,
-		      struct cw1200_common **core,
-		      int ref_clk, const u8 *macaddr,
-		      const char *sdd_path, bool have_5ghz)
+static int __cw1200_core_probe(const struct hwbus_ops *hwbus_ops,
+			       struct hwbus_priv *hwbus,
+			       struct device *pdev,
+			       struct cw1200_common **core,
+			       int ref_clk, const u8 *macaddr,
+			       const char *sdd_path, bool have_5ghz,
+			       bool is_xr819)
 {
 	int err = -EINVAL;
 	struct ieee80211_hw *dev;
@@ -535,6 +536,7 @@ int cw1200_core_probe(const struct hwbus_ops *hwbus_ops,
 		goto err;
 
 	priv = dev->priv;
+	priv->is_xr819 = is_xr819;
 	priv->hw_refclk = ref_clk;
 	if (cw1200_refclk)
 		priv->hw_refclk = cw1200_refclk;
@@ -590,8 +592,31 @@ int cw1200_core_probe(const struct hwbus_ops *hwbus_ops,
 	*core = NULL;
 	return err;
 }
+
+int cw1200_core_probe(const struct hwbus_ops *hwbus_ops,
+		      struct hwbus_priv *hwbus,
+		      struct device *pdev,
+		      struct cw1200_common **core,
+		      int ref_clk, const u8 *macaddr,
+		      const char *sdd_path, bool have_5ghz)
+{
+	return __cw1200_core_probe(hwbus_ops, hwbus, pdev, core, ref_clk,
+				   macaddr, sdd_path, have_5ghz, false);
+}
 EXPORT_SYMBOL_GPL(cw1200_core_probe);
 
+int cw1200_core_probe_xr819(const struct hwbus_ops *hwbus_ops,
+			    struct hwbus_priv *hwbus,
+			    struct device *pdev,
+			    struct cw1200_common **core,
+			    int ref_clk, const u8 *macaddr,
+			    const char *sdd_path)
+{
+	return __cw1200_core_probe(hwbus_ops, hwbus, pdev, core, ref_clk,
+				   macaddr, sdd_path, false, true);
+}
+EXPORT_SYMBOL_GPL(cw1200_core_probe_xr819);
+
 /*
  * Removing the interfaces sends WSM commands, which need the device
  * interrupt for their confirmations, so the bus driver calls this before
-- 
2.56.0

