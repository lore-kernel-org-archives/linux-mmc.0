Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B5C363C78
	for <linux-mmc@vger.kernel.org>; Fri,  9 Jan 2026 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976915; cv=none; b=XCdjZk3+bBI6/5fH/YVaabW0Bike9HSl8NdNbbAlY+Sa2TVTK7prNgqgmoalTMAxIj3je4eLtPq/YF1POdJWQ7NNuWvGN392Bgcvt5i6EW/uRm7N2tpWW3Rimp+RirHn5Fof31PaJpsqWqtTSTyRbdZXZHYNn9mFPKui/c2LRsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976915; c=relaxed/simple;
	bh=ZysjqcFEA2M52Cw6hzhfoy4Mp8j+YWw+AXypIoyErFM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AGdfne+XItFepOEH8Q0fdB226AcJsz34Mf5duOoB/ExMRDsc6SLNGTZSxigHfPXwr/LWfxxuUCT516VWl5JRX3DtoQ8HuKxZd2dFp7ieOZChb18U1+x5c7zHmCJpt5szKctexFoqAH8mej3gF4PI4yPMvfRG2QQOWSLUcGOJ+So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXxVKYat; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z52+5WQI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXxVKYat";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z52+5WQI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767976912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8wvKExavjc6j+4IOpY8QllHRKJuz9b57L79LV3iAB+c=;
	b=HXxVKYateK/T2k8aoqO07GCmoBj5hV4PxMaMPEzdEdLNNQ089pL7BSEu07uHMJBnEAaw1p
	MdPFMNncytSSUQUgfgDA8STKS5/t51HUI0ZAdYR2w6EpzY8Q/qeHvMcMIxPn/2iA/iPqGJ
	hWsf5fS/TZke4LgNLWTkywAhKEln3S8=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-5d0P26aLO62MbD0j_z-4lA-1; Fri, 09 Jan 2026 11:41:51 -0500
X-MC-Unique: 5d0P26aLO62MbD0j_z-4lA-1
X-Mimecast-MFC-AGG-ID: 5d0P26aLO62MbD0j_z-4lA_1767976910
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5634f73edc2so1705664e0c.2
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jan 2026 08:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767976910; x=1768581710; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8wvKExavjc6j+4IOpY8QllHRKJuz9b57L79LV3iAB+c=;
        b=Z52+5WQI+NN5g3ZT6jt162y4fhE8bjrlrctINmJih1kHaPLLc9eUSP0dOG0lK3DgrZ
         ZCRGRt/I/jRLSdSzlg03dqs5XvU/b6YUQOhwcc8FjoV3mm8XVb6MfUOaDgcgAssWKlEX
         xi6Ke8VjgQZM1FdR9we6sXQPitzTZ1LNxCDxlyULEKfCoe8QLsP95y7b4e2yxGfDuGXu
         zp/jTYWvmjfMMUGdOPC8sSZS/N6OwFANfSJ9Jn6ZJdk1it/lhkoEKhaFxrzie1hRPYbe
         Q3QOsj+M/6SD3g33Bc8xn04Db7+e9DhwfBoeNT/lcZmrSks0kOzfJ/+BNz/rtgf4Ht7p
         HurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767976910; x=1768581710;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wvKExavjc6j+4IOpY8QllHRKJuz9b57L79LV3iAB+c=;
        b=M8GdN2VlixA3EEux09P4r6BGCZKeiCPWqDwVZ3iCVnALSMWOPLqAv9oBtcAmr/izuE
         bC0T0L5kQK9UZ2dlyVTGVVyomDWJTuBy7cxgrJv/CsTSHcmRRHEECRMo2zRt6OwYKDis
         0SE+q9Hm1bREv1fAxQE9LRSQ4HRJD3vuNkSqofCg2Qre8Ie9BcaoD0LpfF9s2OiqCPmx
         OVeertFD/AJrbaXfq1g88xshff6HBax7SmyQD0p5gtCqHb/kCbUyNWsJ5whszrLuI/Q+
         LW2mN9CD1LfP8NwEzYp30po5+Y5YsLtkzylma/aE9ZZ7MhVcWL2gQqNrfCX6cVvcM7YX
         jF6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXo2oXtrPAYyNzxU0nGB0soYrSDsEzxCdA9sF7X/7cc5JRZ53U85IGbULgfuSHUF5ZOPIHCQ47h7H8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNmlP1ko3DUvwp/1KKaHyIUOqVGnJR9DZ44CmcVm37cXQYU/Zq
	KrMpGaayIYxOfTDvyg+b2mVtJSGY8AEB9RZ9olBl6jifWIDjK6W83P2EyjXmlgjphSNnY3vJP7E
	WVW87AfpI1Jss+iWfDhbDTidmJOEosRP8ivRirNuAi8QmfOevceQQNu2IADBKkw==
X-Gm-Gg: AY/fxX55gpuXag+EzLf75YC+z2Cq4bxqhMyr8BzO/eDExoilaZRfeDyTaoyT0smsE+4
	891Ofj88I8jUL+Gklo/AbfWMiDn1JUSSEKvPVwr3/LXLR4RHR3JQnQfj3U7j5WqR64ShfIyD/TO
	lud5WaJMN+UCf7/xPbsf6E+Eu+2plUiYaEP/vtqYVP2pz55ZMsJ1ZBQ4di2Q7fBrtFjufcQGPUE
	tW6GGxQF3VaPS0U4+0q5r73gqREB+UNKmhyWismZHoRK1Ilf2vdRZJy1eMg5isAz4DQzBhXgzXf
	/8x32uKXF0iQGF6P058B1mGY9HQBA+jzw61rnbbC4SHZRCZKCud7fXI9S25S5/uULBneHE1NCAx
	FjofbJebKEZlixbCvAZuGxC0bDp6pRtakmFg5QG2VrtjVRuZ+
X-Received: by 2002:a05:6122:208a:b0:54a:a048:45a4 with SMTP id 71dfb90a1353d-56347fd2b82mr3687418e0c.16.1767976910325;
        Fri, 09 Jan 2026 08:41:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg2rR4icyXwYT9jLl1J1KKobpfXOb/9BW52Be/PiSmJMg278XTtW66CrE9UzYOdog/JJ04yQ==
X-Received: by 2002:a05:6122:208a:b0:54a:a048:45a4 with SMTP id 71dfb90a1353d-56347fd2b82mr3687412e0c.16.1767976909849;
        Fri, 09 Jan 2026 08:41:49 -0800 (PST)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5636c753392sm1267752e0c.6.2026.01.09.08.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:41:49 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH 00/13] MIPS: move pic32.h header file from asm to
 platform_data
Date: Fri, 09 Jan 2026 11:41:13 -0500
Message-Id: <20260109-mips-pic32-header-move-v1-0-99859c55783d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBswI8OuEi0GnXIWlShIEN09a
 fkW/z9QOAsXmNUDmasUuc6GvlPgI507o4RmMNpY3WuHh6SCSfxgMDIFznhcldGSd86ORJMmaHH
 KvMn9j5f1fT/DtL17aAAAAA==
X-Change-ID: 20260109-mips-pic32-header-move-6ac9965aa70a
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 linux-rtc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3223; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=ZysjqcFEA2M52Cw6hzhfoy4Mp8j+YWw+AXypIoyErFM=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDIT9Y8EPa6d/eBUAWMdbxCjsnf/NJeXP46LxMTuD2UoM
 b9WPPNiRykLgxgXg6yYIsuSXKOCiNRVtvfuaLLAzGFlAhnCwMUpABP56sDIsGifX88aoTcC29l8
 X7Bt/R7AtmvV9N0yR16d+cM+137JaVZGhu1L75968Cv7yO6mN9p5XJdDWrLOvyqsX7/+lL7/L89
 tczgA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

There are currently some pic32 MIPS drivers that are in tree, and are
only configured to be compiled on the MIPS pic32 platform. There's a
risk of breaking some of these drivers when migrating drivers away from
legacy APIs. It happened to me with a pic32 clk driver.

Let's go ahead and move the pic32.h from the asm to the platform_data
include directory in the tree. This will make it easier, and cleaner to
enable COMPILE_TEST for some of these pic32 drivers.

I included a patch at the end that shows enabling COMPILE_TEST for a
pic32 clk driver.

Merge Strategy
==============
- Patches 1-12 can go through the MIPS tree.
- Patch 13 I can repost to Claudiu after patches 1-12 are in Linus's
  tree after the next merge window. There is a separate patch set that
  fixes a compiler error I unintentionally introduced via the clk tree.
  https://lore.kernel.org/linux-clk/CABx5tq+eOocJ41X-GSgkGy6S+s+Am1yCS099wqP695NtwALTmg@mail.gmail.com/T/

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Brian Masney (13):
      MIPS: copy pic32.h header file from asm/mach-pic32/ to include/platform-data/
      MAINTAINERS: add include/linux/platform_data/pic32.h to MIPS entry
      MIPS: update include to use pic32.h from platform_data
      clk: microchip: core: update include to use pic32.h from platform_data
      irqchip/irq-pic32-evic: update include to use pic32.h from platform_data
      mmc: sdhci-pic32: update include to use pic32.h from platform_data
      pinctrl: pic32: update include to use pic32.h from platform_data
      rtc: pic32: update include to use pic32.h from platform_data
      serial: pic32_uart: update include to use pic32.h from platform_data
      watchdog: pic32-dmt: update include to use pic32.h from platform_data
      watchdog: pic32-wdt: update include to use pic32.h from platform_data
      MIPS: drop unused pic32.h header
      clk: microchip: core: allow driver to be compiled with COMPILE_TEST

 MAINTAINERS                                             |  1 +
 arch/mips/pic32/common/reset.c                          |  2 +-
 arch/mips/pic32/pic32mzda/config.c                      |  3 +--
 arch/mips/pic32/pic32mzda/early_clk.c                   |  2 +-
 arch/mips/pic32/pic32mzda/early_console.c               |  2 +-
 drivers/clk/microchip/Kconfig                           |  2 +-
 drivers/clk/microchip/clk-core.c                        |  6 +++++-
 drivers/irqchip/irq-pic32-evic.c                        |  2 +-
 drivers/mmc/host/sdhci-pic32.c                          |  2 +-
 drivers/pinctrl/pinctrl-pic32.c                         |  3 +--
 drivers/rtc/rtc-pic32.c                                 |  3 +--
 drivers/tty/serial/pic32_uart.c                         |  3 +--
 drivers/watchdog/pic32-dmt.c                            |  3 +--
 drivers/watchdog/pic32-wdt.c                            |  3 +--
 .../mach-pic32 => include/linux/platform_data}/pic32.h  | 17 +++++++++--------
 15 files changed, 27 insertions(+), 27 deletions(-)
---
base-commit: f417b7ffcbef7d76b0d8860518f50dae0e7e5eda
change-id: 20260109-mips-pic32-header-move-6ac9965aa70a

Best regards,
-- 
Brian Masney <bmasney@redhat.com>

