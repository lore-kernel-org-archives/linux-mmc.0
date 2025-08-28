Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A0C311943
	for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386926; cv=none; b=neJKYa4uFtNu/zsCrSNvQS0ryk9WGz1IRcYBgVO3bkdwlabUB4MB4iUHTcTqrkcu5gxGoJKpcu3BL5KhzEtslpAmrYwNeFVOsiSaAI/UkfZPitLbxRDirVsdPJQqQSxYP2Z7jNlhGAseLfciBS1/5e0UXGgmLZAQuZ2SgzxCE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386926; c=relaxed/simple;
	bh=ZoIUG0DIhl93kANAYC/KTgnrxzk10nq584qp1jORNOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YY/fa/d34kVvr/8AekOKVIs0HEq1awFOCtmcUlr0INsKRvI64BFmOr8ggpg+BGdTcpVwhKizaN0uRbV/p7kjDuSN1ugBGVDzCkA873Qfjnh/ORE9KQTgvINF5xXB2auGPA+qcPrXOS01liTOpeeRC/tqQ2a9zbSE9ZE3xxOAINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UDxeT+q/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UDxeT+q/"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afebe21a1c0so143301166b.1
        for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756386923; x=1756991723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UuiNHpICi9Fji/fQ9rrN9zvOKJszsHimGcUCBamZ0/A=;
        b=UDxeT+q/XzByfuzaddUNdzlWksMM2SSrbqSy9niuu71+kfILDKdcbKUx+v1X22aThW
         DDYQyxyViQBz3+72P3iA7wGVe9+JlkmQPiuArYkQWqF6Yj6CZ5w6v7hCAHAUdAEky7SH
         407h3p0WrV1xl8IO9SGnYbiS0NWb2N1zf+L8ZBpDrG6zVbM6QW/y8fEgctfX9dV1S+dW
         5yJF+rmTXh8GL/KPkkRCBWfTsa4mLlz15EA6MCznMf8/fjyXjcDKx4Cnxf3QEGbXURGi
         wv5kLD/sZAsQfdtD7t6B+/5YayCAsvOY1PzlJv/sRkWr1QziXkAuKYt/7fIuyZ+7sgcy
         46cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386923; x=1756991723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UuiNHpICi9Fji/fQ9rrN9zvOKJszsHimGcUCBamZ0/A=;
        b=SMOT/NKfHxG4GNCodPSu0/ti8gFHKc+EXXVArdCiS2EHn4FE/VqqFHLAmlm2ohzTyf
         Wr0/HXR00vpK6wzKHF1Fg7pXus1S+2sekq1rK4r7iB/tJSjyluuAytgvjJJApFYQO2E0
         aimewP3nZFwlECi0mRQf5tpx7PwihedT/6qX4DYT61gHyG4jHL/U+CuwMNi1jVrrWhBY
         kkLlMLFuPFhm1ZtZ4JPceb2j3xm1AkFVi1PLhcy2TM3LEpihAdPInwaa9aaThjnWtjNn
         m8GvEl4uPEHONfWVSMT3IXlWspG7AlB7EIWP1MU19gu2LZozj1uFpJjyRxvymBtz/N5v
         w1aw==
X-Forwarded-Encrypted: i=1; AJvYcCXkn57Zrz4KSjLZa1OWkMhrBnoYU3TKV+aY71lNrXlEgOd8KdbYa2tt9VsQ04GC7Ad0lxeY7oCHY1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZFJ01YGwBlONLrU+uh0TAQghgFGYTyaMEPtE+76hJVx762pV9
	kGeOsaqpdq1VNX00BXu9FHaGYx0FffxT2OYyaChN3fR8i6JdhBD8oL1Sp2GIH/lIwaE=
X-Gm-Gg: ASbGncsIuD2BompXerdtdA6rYvsXl6u869Kkk1etmOqaNDlpf3O/VCQO5ArgahGUGPg
	76WI8gjs/j6u4MTTGEkmou2uL81oz8S0a4zsFpOi5W9VdKHNQ11VlJzK3VY03z3eykDOj4GFt/K
	PsjPMqYWYzcKHDLGv4X3NsAaTVcbRWckxh0R56DzBL+1D0WazTGGxtxRlxCTp2CseydIPiHvnVX
	lM6WDCdTbTUOnUxl5OiVqJTS5zZOXbazAtIdFCvnyF6UKxmdTdB5eD/fJPFOlFlC7IZhaPkPz7R
	DZPfTWGMgzXW19DiWyhMIeWV1cyLJRMsqiHIbQ5en/bp3x7k4FTIUsRo976n/NXdoVJftXDwoTi
	6xYP04ukUgWvjoP9UKIytVOumOMzWoUwsNEY2EB85q7Z7Xk9x02NlV9QJrnzBMmGc+QvN6In0BA
	RJwVfywkIQydfUWb5h2vG8lCgazNQ=
X-Google-Smtp-Source: AGHT+IFlRXZ8/HbEmILGPaaFC7SuIScItZJp+ONwofS1lsM9bJRSD1VLJx+ZjAEGaQZGAUqEEvUm5A==
X-Received: by 2002:a17:907:2d0d:b0:afe:a615:39ef with SMTP id a640c23a62f3a-afea6154a04mr947914466b.9.1756386922803;
        Thu, 28 Aug 2025 06:15:22 -0700 (PDT)
Received: from localhost (host-79-36-0-44.retail.telecomitalia.it. [79.36.0.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe7fd59b00sm872678766b.106.2025.08.28.06.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:15:22 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: linus.walleij@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	wahrenst@gmx.net,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	linux-mmc@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 0/5] Add peripheral nodes to RaspberryPi 5 DT
Date: Thu, 28 Aug 2025 15:17:09 +0200
Message-ID: <cover.1756386531.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The following patches add a few peripheral DT nodes and related pin/gpio
nodes for Raspberry Pi 5.

- Patch 1: Amend the bindings to avoid DT compiler warnings.

- Patch 2: Adds core pinctrl nodes and defines SD pins as a first appliance
  for the pinctrl.  

- Patch 3: Wires the gpio-key for power button and related gpio controller.

- Patch 4: Adds DT node for WiFi.

- Patch 5: Adds Bluetooth DT node.

All comments and suggestions are welcome!

Happy hacking!
Ivan and Andrea


CHANGES in V2:

--- DTS ---

- bcm2712.dtsi: added a proper clocks node to the uarta serial
  in order to replace the legacy clock-frequency property. As
  a result, the following patch from the previous patchset
  has been dropped since it's now useless:

  "dt-bindings: serial: Add clock-frequency property as an alternative to clocks"


Andrea della Porta (1):
  dt-bindings: mmc: Add support for capabilities to Broadcom SDHCI
    controller

Ivan T. Ivanov (4):
  arm64: dts: broadcom: bcm2712: Add pin controller nodes
  arm64: dts: broadcom: bcm2712: Add one more GPIO node
  arm64: dts: broadcom: bcm2712: Add second SDHCI controller node
  arm64: dts: broadcom: bcm2712: Add UARTA controller node

 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   2 +-
 .../dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts  | 133 ++++++++++++++++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     |  55 ++++++++
 3 files changed, 189 insertions(+), 1 deletion(-)

-- 
2.35.3

