Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980529;
	b=RVYymuhOn4k9QiUAengcqf5ShAjrLfsPKL7o+VGKEDQfgK9A/FHlQhiND7OoS01nFj5M
	 DW1kwdLCMehfEXlyea1xn60rsJJ8D+/1OEipbtNrcvBk/CRT5amL+gApQuBZNIA2rS7fs
	 q/oRgTpqCcwONwzIFbU6ZH/hHpL5b+c3wxggzQFfkPUzefiWCXp7QzsP+aqyHdEvJoJ2A
	 XYfgZhMi/JrVIdIjokEbLlZD16OYb/K9gHbIc1tS0TMZ197u1MJPAvtC513dztQsLIPFv
	 RrV1e3n4DG56QwfLhk3m88V+61bZ0N0HLgSozQxYCLPK8jfiuCmuRmKJrGDstHfvlTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=o9kbdoBsE4U8B/2v2AZP0fcQdT5UCzBPj2wIoqruvs4=;
	b=qcmYMfgA7P+kKeJ+ZZapcIcnPod8gEhoMsOAHGaTd5nrsgJwAxAovG6RfsYxdD5poKiW
	 tekJcQxxrpSQ6GpgJ2gg5FVFCkkijSEBdADMKymUiNrPNv82orPPNGiyB7xRwHpG6DEIx
	 z9PtT0Jy02jK9fnSoDTIyaTpOXG0PiPmber7CnJ/UZejRKZbUaQ6+OgfVepe/pveMuPRI
	 oK43cawu0E2VdtqUAtxbdFxcsTT1Hs7JRQEasdJu6f4pKar0ScHCxUIRioQVT1zFzCxTm
	 UHpvK6s3U83+vt3p6F0nuYMEI7LxbDfKzhln9KLMP1OgvmysrMZCjTYsQlI3eC9gnDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=thegoodpenguin.co.uk;
	spf=pass smtp.mailfrom=thegoodpenguin.co.uk;
	dkim=pass header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OvhWqfKe;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3965606A329
	for <linux-mmc@vger.kernel.org>; Fri,  6 Nov 2026 15:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3965606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OvhWqfKe
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso1208340f8f.1
        for <linux-mmc@vger.kernel.org>; Fri, 06 Nov 2026 07:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20260707.gappssmtp.com; s=20260707; t=1793980527; x=1794585327; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o9kbdoBsE4U8B/2v2AZP0fcQdT5UCzBPj2wIoqruvs4=;
        b=OvhWqfKeNlNBrueqsKnaYRAeQPjoWvwmd9mwEND/vwmG+jm+NDNInHisaJfoIz/EBC
         4WXVVTozXz0azIu0+5loTudCJuxf/t7UP1vrsp5aXLYBoGoIuWHa5FSjFDHr2YdPXq2U
         OxiEi2Yzz7ByRPqueo8Jk35tmvwubKhLo3mDhoxxofTaKYYQ4wrs7y9jjZJqMCP4d8n4
         rG5ncxfJLzqP93+TfhBvcbKURXCXQ3dXOjo+IuLJvdkmduTY12kpwAk+Dwyow8XPuCgR
         iRfSQBgKE6Da2tZwJN4uJ++ReYCEF5WCq0CSNGz29J4XsouZ9EjGZNqNAYYnFBe7uHlb
         xB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793980527; x=1794585327;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o9kbdoBsE4U8B/2v2AZP0fcQdT5UCzBPj2wIoqruvs4=;
        b=iWzkaB4r1NQzf0NQM5poCwQ+2CpnC7zKEaaXUoultQ1oJ7LH1XKo7dG+eKWVjMl19w
         P2+sN5mFjwyN0wM7CZghPErHhtAc9Ds9OgeXde0vu9yXX3Z8Oa+LSZR0PdxwGRzROeyu
         y4bbJ4Gv0ojXHUQXdiKs8PDzr1AuolxC1JAp1t54irc+0ytqajv8tKKNVy5mOHroZQmK
         XWoGsm+44TXbbVN90TFlNb6v79KGleT9KetkQdhl4pu0FY1Ey7dyrB1RWaJlvVnO2oqj
         nP+yjo6MEYgGpqsOP4JTqcazvBE8Sk/8hvsCSIVb9jRSYRTOgIK61pfsSxBd/w59dr57
         /J/w==
X-Gm-Message-State: APuU4Z/UbtrA+0l1C659A+sy/ICqvX4ZgvKNlf0I+t/MaP8T6M6tBzv1
	A3Rnzf/8nxlwLoyS3WxRAZxBMNfNeU3DSvTXn4BOQ9m7NBwu6ed1s6851WEAaSme390=
X-Gm-Gg: AYBFou0DhbRedScXy3FHFizr3f6W6D0hfi6ku2uAKzOWtMdTgVbSD2zL98aL4niEUYs
	xCQK0prQWMLjeFDTR6nhNqlVnfG8fJXutAY9drSEjgowuOlZguWyM0HMi2Fs3pQaTRv3slPpl94
	LcclCCjq6dTMf9J1Ww2hpoEeC2ni6PJ7Y7S+P941DBxKqTlkTg0yTr97XlS3rXuN2KWKuMv34Ux
	VOeHCopu43sGZuEjCQIvgcLEXeGdxsA4K3rj0NWJoOn5n4brRQMQKJEWQVjTcQOSTMzBKr/yIVg
	Iypn3puEG5IbpGPLi6qVwiXkRwCIT76ZG232hVPo1iNiw9U88/BWnaYREQyKqEK6G2ynbWR9HHL
	7DaBeDhnL5BW5oCJNIlx+nzavgz9G8xWG30T1dP0F7ythPVhS0wWJdceNOLfW1xFx+5Np3vrT75
	A4LTRdWwXd3F2HwJ3qsb+ezp6rZmgl6bi8jqHkK6oQ27bhb4UQem/Y0VLnjUwH6P2MdgQ1lfuOs
	I+743h4G4ZVc8cAA29rP0SyFijAIg/1H5fqtweaUnRf9x7AIRGJP8Ht8AkFlv2OUTI3ErZ2+f2O
	M/9UspSYK4Tikq/6kB1vxn9tq9E4cYzgTRFq7y001zsqi8DysVpN5zPgdTuB6oiPcg==
X-Received: by 2002:a05:6000:2893:b0:48e:7833:2e7b with SMTP id ffacd0b85a97d-49115c978f5mr13236722f8f.1.1793980527027;
        Fri, 06 Nov 2026 07:55:27 -0800 (PST)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:153c:4b80:6e11:422])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d809ddbbsm4492288f8f.53.2026.11.06.07.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:55:26 -0800 (PST)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Fri, 06 Nov 2026 15:55:16 +0000
Subject: [PATCH] mmc: sdhci: Use named initializers for acpi_device_id
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-acpi-mmc-v1-1-00934babd69e@thegoodpenguin.co.uk>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwMj3cTkgkzd3NxkXfOkpCRLMxMz85QUCyWg8oKi1LTMCrBR0bEQfnF
 pUlZqcglIv1JtLQABnyAqbAAAAA==
X-Change-ID: 20261102-acpi-mmc-7bbb96467dd8
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Hu Ziji <huziji@marvell.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793980525; l=5528;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=wk0vJLpQ6eLGpzrrOfKv/kURpO3tO1+Cxw3RmtkJnps=;
 b=w4MPYYFZwmLZeAw2/+63BAo7MARTNN03UeXZvJKjaw4YFtVxwA3b1mxsR+J0DpD3p+f2D1Jpj
 EchWeco3koqDhaHCp0G1RXvxaQT3Gf186PUHp5qnBqR4NFHcjXSlAcs
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a designated initializer for the acpi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base.

Unify the list terminator to have a single space between the brackets and
no trailing comma.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
This series is converting lists that contain the acpi_device_id struct,
which is defined in the include/linux/device-id/acpi.h to make use of named
initializers (which they do not use currently). This work is part of the on
going effort in the kernel associated with device-ids [1]

The plan is to convert acpi_device_id::driver_data to have an anonymous
union, similarly to what was introduced for PCI and I2C device ID tables.
The goal is to increase type-safety (most of the existing casts are gone),
to improve readability and to make use intent a bit more clear:

```
union {
	kernel_ulong_t driver_data;
	const void *driver_data_ptr;
}
```

But for that to work all lists containing the structs need to use named
initializers first to avoid triggering -Wmissing-braces. I already have
patches that implement this and touching a lot of kernel subsystmes that
use the acpi_device_id struct and that list keeps on growing. Therefore,
I have decided to split the series per every subsystem into:
- pre-clean-ups that convert the lists to use named initializers
  (which is this series)
- actual implementations that make some of the modules use the new
  driver_data_ptr member

That way the task can be fragmented into manageable and independent chunks
of work and makes this effort easier to review.

[1] https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
---
 drivers/mmc/host/sdhci-acpi.c       | 30 +++++++++++++++---------------
 drivers/mmc/host/sdhci-iproc.c      |  2 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c |  2 +-
 drivers/mmc/host/sdhci-xenon.c      |  8 ++++----
 drivers/mmc/host/sdhci_f_sdh30.c    |  4 ++--
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 84c7054607fc..e97c33614fd1 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -704,21 +704,21 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
 };
 
 static const struct acpi_device_id sdhci_acpi_ids[] = {
-	{ "80865ACA" },
-	{ "80865ACC" },
-	{ "80865AD0" },
-	{ "80860F14" },
-	{ "80860F16" },
-	{ "INT33BB"  },
-	{ "INT33C6"  },
-	{ "INT3436"  },
-	{ "INT344D"  },
-	{ "PNP0D40"  },
-	{ "QCOM8051" },
-	{ "QCOM8052" },
-	{ "AMDI0040" },
-	{ "AMDI0041" },
-	{ },
+	{ .id = "80865ACA" },
+	{ .id = "80865ACC" },
+	{ .id = "80865AD0" },
+	{ .id = "80860F14" },
+	{ .id = "80860F16" },
+	{ .id = "INT33BB" },
+	{ .id = "INT33C6" },
+	{ .id = "INT3436" },
+	{ .id = "INT344D" },
+	{ .id = "PNP0D40" },
+	{ .id = "QCOM8051" },
+	{ .id = "QCOM8052" },
+	{ .id = "AMDI0040" },
+	{ .id = "AMDI0041" },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
 
diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 35ef5c5f5146..db5bed2397f6 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -350,7 +350,7 @@ static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
 	{ .id = "BRCM5872", .driver_data = (kernel_ulong_t)&iproc_data },
 	{ .id = "BCM2847",  .driver_data = (kernel_ulong_t)&bcm_arasan_data },
 	{ .id = "BRCME88C", .driver_data = (kernel_ulong_t)&bcm2711_data },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_iproc_acpi_ids);
 #endif
diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 09702022e708..113a9399d7dc 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -2400,7 +2400,7 @@ static const struct acpi_device_id sdhci_dwcmshc_acpi_ids[] = {
 		.id = "MLNXBF30",
 		.driver_data = (kernel_ulong_t)&sdhci_dwcmshc_bf3_pdata,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_dwcmshc_acpi_ids);
 #endif
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 046e8100dd08..2e4926e722f3 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -700,10 +700,10 @@ MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id sdhci_xenon_acpi_ids[] = {
-	{ .id = "MRVL0002", XENON_AP806},
-	{ .id = "MRVL0003", XENON_AP807},
-	{ .id = "MRVL0004", XENON_CP110},
-	{}
+	{ .id = "MRVL0002", .driver_data = XENON_AP806 },
+	{ .id = "MRVL0003", .driver_data = XENON_AP807 },
+	{ .id = "MRVL0004", .driver_data = XENON_CP110 },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_xenon_acpi_ids);
 #endif
diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index e9b934e159ad..f3d0a50d1a6f 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -227,8 +227,8 @@ MODULE_DEVICE_TABLE(of, f_sdh30_dt_ids);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id f_sdh30_acpi_ids[] = {
-	{ "SCX0002" },
-	{ /* sentinel */ }
+	{ .id = "SCX0002" },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, f_sdh30_acpi_ids);
 #endif

---
base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
change-id: 20261102-acpi-mmc-7bbb96467dd8

Best regards,
--  
Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>

