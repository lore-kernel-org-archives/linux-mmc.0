Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027172DD60F
	for <linux-mmc@vger.kernel.org>; Mon, 11 Aug 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925488; cv=none; b=WJ/KBOgq00HiQVbhFNBkKPIRFQNUvQLk0mfKb4LpBQCVia2o9TXeZk9OhW+hnuHG9w9MqksA7mAVWLNIil282+KydD/0uUozPwsnrvmbfSQSk8kE/4FWo1Bb8+2Yj/7spvuod3CYkKKGFX7MGr8yfUWlbfiA3PAWSi6HXKYdwvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925488; c=relaxed/simple;
	bh=6a2jpr8RqbOo+9g1f65WPhHWahy1fmVBwuuQHvaAios=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GLstnycLJyHZDEv61JQPUpQsTz8bcu5f+zZyEuX1/rpR/aAFOCfFb+vfPF0oI8+cJXBvOJe50MuvqI4mrnvrJenYLbIHVGUEA/zyZbXTKTQQAUDT59OFCbqo5L0rawJrvHMflloNqHMqJxm5g05pqeqgB6SJfi7F2xUGDfKs7sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PTz32NZK; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PTz32NZK"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-6155e75a9acso7041353a12.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 Aug 2025 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754925484; x=1755530284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ihP/wnPXyZhWgHPlteto2ft6qT692i4bL35PGC7Kwgs=;
        b=PTz32NZKUVFpakySMNj8LpNGl769jNxKtf2Wy2ymGDpQ1rdL34X1N0i6Iw8o+o2MM/
         YgToy6bi3CvB09Thb9NkMbRZgGzIPfjFqW8Tym+y3F2q/UqbFF+c9n1Gce2zRoHdbyqA
         if5T7ME6CpfQHdBtTWcFmjSFbhz48aK87tXccE6m0GR3KIsthGXl+b+Gma3jOJETjc6i
         p+y04GYSnB6IuQUMzz0DePBr8f6NK4PzxfEfBOQJ9IXVwqA5p3fBB4uP/CKQkKhRZAt6
         8yFUS+C1VkvuYKAu9T3zmnUcwVJbSvFpuout3mjbyjYwA3bwoPafqymJZP7KrTEOWrGQ
         ayYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754925484; x=1755530284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihP/wnPXyZhWgHPlteto2ft6qT692i4bL35PGC7Kwgs=;
        b=MR5f1TDsh6A88HkLeZqI7l7Dc/6OFkLf3LFkthEeUBjSaKBV8Z+lKmZ/nTt0ZoYp0G
         iQYwnt0fAsiZw9UNjU8m/DCz820zcnbTyQ+UbFYcJeVDNEM1Jo35pDMdTr44/TaQLSOV
         EX500CTfnwsPxit6P8xdmcGsQ86DuXqBrD7S1jv+aoLSXEsRM/tHP/gNVGPEiPlk/H0E
         QiNsMy0W7z45HG0r3cRHG/40UPmUc22BTXHs3lMMcvOXqGkMyCRRMqFw9qFLRV5Z9Cfw
         lVCHIDeF1nm0gcc3XyGCkv+jjv+H+caj85N4N9TsHbcW8ZwTE5hSyjn+xEWFKrzgdrGs
         MBjg==
X-Forwarded-Encrypted: i=1; AJvYcCWINVwVUcv9ekMdjfUWqEbmRnb81DNJEWP8Bs0MlVf/GarblrxeHO3q7qPljUdCxLJL3ceVodvBSjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YweJUxBge9Q7Y7Veh0osVKNtHRukzA7VGX0GD5oz0eMOrP/mzo9
	VmhDhxyd7Nge7tW/LjuApaVwFCb+LaQ8v/ImOdVDC6FsJEwpt6ZlHuyqCQScv75Wd4Q=
X-Gm-Gg: ASbGnctF+16mmF00qEUeJU+uwcPBRULrd5RY8zWRuQ7D2JMtmuyaEd1p6c/og7+o/h+
	KXikfJcl9IqKLnabu/KTveaudp1MpCAqxx5c+gjr0SCa3ILnLZDCEk/R2stqwkPvoWpNqOmebRU
	oFnDntgKRU2jKOj2HAyG6rGSh8tHBKWl3E6TYeo7LVT4Ek63+SFKmSAtp4nrPKERjtu4V/F/LOt
	aGZHLKHSgHysD9debsSikuvYkdpsuYGKugraPzC/79gV+vyFVBH2p+xZ7EM5x+w2qReGZOySJe8
	hwCoW0M1CfDsKFrDO8XLypxCibHCwfaIj+Lv4oYt1GUV7NmEFbhvK/dv82k6kVtwojceca5oB7O
	F/vHePCJpuq6fqEPMcf+PeBLLZzuNj7YYIUfAA8r9dARRxwZ2L8p/MpaR/4lsDeQ8HA==
X-Google-Smtp-Source: AGHT+IGvJ3ayAmkrGkViVLnbNoPZ1sMap6TBv2tr1d6iu6pDDVV5j4fRLfmHXE5vLfntRBsHIUMHNQ==
X-Received: by 2002:a17:907:608b:b0:af9:5b1f:b87a with SMTP id a640c23a62f3a-af9c64791a2mr1210151866b.20.1754925484035;
        Mon, 11 Aug 2025 08:18:04 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c081sm2014946666b.97.2025.08.11.08.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:18:03 -0700 (PDT)
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
Subject: [PATCH 0/6] Add peripheral nodes to RaspberryPi 5 DT
Date: Mon, 11 Aug 2025 17:19:44 +0200
Message-ID: <cover.1754924348.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
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

This brand new patchset (hence it's a V1) is the second part of the split-up
of the patchset [1]. It tooks patches 3 to 6 from there and adds a couple
of new patches that amend the DT bindings.
As a result, patchset [2] is a prerequisite for this patchset.

- Patch 1 and 2: Amend the bindings to avoid DT compiler warnings.

- Patch 3: Adds core pinctrl nodes and defines SD pins as a first appliance
  for the pinctrl.  

- Patch 4: Wires the gpio-key for power button and related gpio controller.

- Patch 5: Adds DT node for WiFi.

- Patch 6: Adds Bluetooth DT node.

All comments and suggestions are welcome!

Happy hacking!
Ivan and Andrea

Links:
[1] - https://lore.kernel.org/all/cover.1752584387.git.andrea.porta@suse.com/
[2] - https://lore.kernel.org/all/cover.1754922935.git.andrea.porta@suse.com/


CHANGES since [1]:

--- PATCHES ---

- Add two new patches (1 and 2) that amend the DT bindings.


--- DTS ---

- bcm2712.dtsi: Added 'interrupt-names' and dropped 'reg-shift' and
  'reg-io-width' properties in uarta DT node. The latter two are
  just overridden by driver code so setting them in DT is useless.

- bcm2712-rpi-5-b-ovl-rp1.dts: dropped 'auto-flow-control' property
  since it's not parsed in driver code.


--- DT BINDINGS ---

- brcm,sdhci-brcmstb.yaml: added SDHCI capabilities by including
  sdhci-common.yaml.

- serial/brcm,bcm7271-uart.yaml: let clock-frequency be an alternative way
  to specify the clock speed instead of clocks/clock-names.


Andrea della Porta (2):
  dt-bindings: mmc: Add support for capabilities to Broadcom SDHCI
    controller
  dt-bindings: serial: Add clock-frequency property as an alternative to
    clocks

Ivan T. Ivanov (4):
  arm64: dts: broadcom: bcm2712: Add pin controller nodes
  arm64: dts: broadcom: bcm2712: Add one more GPIO node
  arm64: dts: broadcom: bcm2712: Add second SDHCI controller node
  arm64: dts: broadcom: bcm2712: Add UARTA controller node

 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   2 +-
 .../bindings/serial/brcm,bcm7271-uart.yaml    |  19 ++-
 .../dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts  | 133 ++++++++++++++++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     |  47 +++++++
 4 files changed, 198 insertions(+), 3 deletions(-)

-- 
2.35.3

