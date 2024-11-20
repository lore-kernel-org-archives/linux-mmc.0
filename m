Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933CE16A92D
	for <linux-mmc@vger.kernel.org>; Wed, 20 Nov 2024 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091278; cv=none; b=XO6j/Lif6rO4xr2h6q7eh7pOHHvKT2hiEtUnOaIzjEnHa1Vtwloa0Km0BJqCarKGGCiQbKcsdjKbHZSY+NiEdEDYZ7p6WHVnE7NoPrxuJmUyrSwRKHr0t0ge3bTQAVW5Xg65BQZyBt0bGq+Zo9Uypt5QV4xV1f1CzWDFDYOyLBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091278; c=relaxed/simple;
	bh=AZTERNuleHXeOvSbNtYvsGSmgxQQQR3YBgip3g1Rrjk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mzbn7m6LV3pZ//NK1kqQkd9IxF21KuS/T0phiNDiT8s/lEh+2nrtvxdBGdXgfPvbWgTpSpwk50lphLQeLUT/8M4Cp8CsuK67dAUX3xHHHbQloni4jhK3eEWuUL53wVCWZK2Hi1c9CmEwBsHhHimNwhLGuFX+YO76JUOGi/24DGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8+wZZG3; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8+wZZG3"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ea1bc2a9c5so485355a91.0
        for <linux-mmc@vger.kernel.org>; Wed, 20 Nov 2024 00:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732091275; x=1732696075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gMvpT5A+ifyqcafcrhWkxY6R3c2usb1ZMdboz4kOqls=;
        b=W8+wZZG3zBTTDIMQ6F1JWHZNAE34TvMmxC3Uqy2ULWgU+WjNbBSwnwsoXddaSlrDQZ
         rSMQCGMMpHRYRn1kYcpLK1zeuPk3HsP/GHZ3WJICQETKx3TWRypFbYSbS9P0qWt4Pziq
         Tec7PsduUN/kcObdnRU2c2G6UezqWy5KCcbMs/HxhO7+4iV4W1l9w5g8rVXu5Om8JRB8
         y9MiDCQ2hSZQ6EaqLkLAr1TX0NxMJB1c3laPyjGpA5oJv9pg7Z6vpAW8Y7qOZ0p6VM5e
         Of8AWRyBdyqOMUhq5tjxZHF/ztFarwuiHACk3UiJCKxIT+SDYfgpamU5L4QDbxHfeQx7
         vOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732091275; x=1732696075;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gMvpT5A+ifyqcafcrhWkxY6R3c2usb1ZMdboz4kOqls=;
        b=dFn1xy+DXCINAk3vQEMyJqm39GBXWRdIY1peg1Sk2k0lYJE7uxRJYHTaI3R7yEl7aA
         G+gJW0gXUGky0w+zwDaZghbE2ilag0ona3pwV7+EDgQJ/qUhxJfsVe3nZxhM5yU4ggZk
         ZiGmtYI/iM/lKZm/F7LhvLl6JS5CEmXbW/LTJCJjEuyqnqU/5j1cq5/f2VPpoyRiTg7e
         WsTkTgs1zqY9zpHkG/5zPGunRQuJEhmDL15pb5fSWGJHqTVMSY9v6ATWA55PBVst4QtK
         hudvxCW45wIk6ThnXGZcJhZXBswK74UfKo7rBFDTQDvM0quZ3bfDnCLC9btc2ie2DClb
         lcMw==
X-Gm-Message-State: AOJu0Ywr68P5XurSExacVPXAfsn6Uy+dP0XE+/vWEL7L/CdkJlRtp2Sx
	MrZ2F7A+FkikadlgiLkLG40kTYlJzCpYboB4qugzwDt7sinQMl3Tl3HTgYhxy5hyJFLEH/uY3Pz
	Bgowa0m+uthvRqjxiHkWMiqC2TUf372Cu
X-Google-Smtp-Source: AGHT+IHpGvGFFJV10hcenlSGvTYSeBZ+ZYR/uL0RmUfCIBIub+/1JZqjgPxMA2QMFVLGUV1TGb46EA9+cF+rXwUMu4c=
X-Received: by 2002:a17:90b:1343:b0:2ea:7814:1d9f with SMTP id
 98e67ed59e1d1-2eaaa767187mr9436044a91.6.1732091275447; Wed, 20 Nov 2024
 00:27:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pankaj Pandey <pankaj.embedded@gmail.com>
Date: Wed, 20 Nov 2024 13:57:43 +0530
Message-ID: <CAOdCjQuiLHkX+ZJT6RbG01gxMo-Q9Y80P=FpNnS35rYWWV3eLw@mail.gmail.com>
Subject: SDHCI: linux-6.11: mmc0: Reset 0x2 never completed
To: linux-mmc@vger.kernel.org
Cc: "pierre@ossman.eu" <pierre@ossman.eu>, isheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi All,

My target board(ARMv8-A AArch32 processor), supports the "Synopsys DWC
MSHC controller." I am using the Linux 5.4 kernel and have enabled the
following configurations to support the "SDHCI platform driver for
Synopsys DWC MSHC":

CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_OF_DWCMSHC=y

This setup works perfectly on Linux 5.4, successfully detecting all
microSD cards. However, when I use the same driver configuration with
Linux 6.11.0, I encounter the below mentioned error:

sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
mmc0: sdhci: Version:   0x00000005 | Present:  0x020f0000
mmc0: sdhci: Caps:      0x276e648a | Caps_1:   0x08008071
SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
mmc0: sdhci: Auto-CMD23 available
mmc0: SDHCI controller on 48102000.sdhci [48102000.sdhci] using ADMA
mmc0: Timeout waiting for hardware cmd interrupt.
mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000005
mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
mmc0: sdhci: Argument:  0x00000c00 | Trn mode: 0x00000000
mmc0: sdhci: Present:   0x020f0000 | Host ctl: 0x00000001
mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa07
mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
mmc0: sdhci: Int enab:  0x00ff1083 | Sig enab: 0x00ff1083
mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
mmc0: sdhci: Caps:      0x276e648a | Caps_1:   0x08008071
mmc0: sdhci: Cmd:       0x0000341a | Max curr: 0x00000000
mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
mmc0: sdhci: Host ctl2: 0x00000000
mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
mmc0: sdhci: ============================================
mmc0: Reset 0x2 never completed.

=====================================================

Please find mmc debug info and dts file changes for references:-

root@devkit-e7:~# cat /sys/kernel/debug/mmc0/ios
clock:          400000 Hz
actual clock:   400000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    1 (active high)
power mode:     2 (on)
bus width:      0 (1 bits)
timing spec:    0 (legacy)
signal voltage: 0 (3.30 V)
driver type:    0 (driver type B)

sdmmc: sdhci@48102000 {
                        compatible = "snps,dwcmshc-sdhci";
                        reg = <0x48102000 0x1000>;
                        interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
                                     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
                        clocks = <&syst_hclk>, <&syst_hclk>;
                        clock-names = "core", "bus";
                        bus-width = <4>;
max-frequency = <25000000>;
                        status = "okay";
                };

Kindly request you to please let me know if I am missing anything.

Regards,
Pankaj Pandey
