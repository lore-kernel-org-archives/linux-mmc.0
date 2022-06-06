Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F51C433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jun 2022 20:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbiFFUOH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jun 2022 16:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiFFUOF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jun 2022 16:14:05 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22A8110473
        for <linux-mmc@vger.kernel.org>; Mon,  6 Jun 2022 13:14:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id p10so21277967wrg.12
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jun 2022 13:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BI7QjWVmpuIIWqYE8RAGE9+KBCb5m1yaNT/iNRoF5ZQ=;
        b=CurdJRrwRpbC0c4Itoz9kpdvNjjrqwG0W4Bxx7JyZo7MHvXz6QE91X5Do/ZmFIibkB
         YT4ptws23TVyHtMEK2dfTg51Wdm9O0VoEXQtId9PMthGhtUcAFUhRQwkiiN4KGw6iQFS
         g5kwKs6MTUAvWSGdpghRjR++l8WmEA4NOMDiJt9B/dEQh1IBmDN5JF9JyNDj7jQDgpDl
         tfyb6FEpySUePsx3ZFl8a10KI9x6dc9sCYtQbwfubvyUk1OpdMngAYhgHkaW4wKDT404
         X9QryiFgRhIq2iu2Lndy2/BwW2FPv9gdbcG96G3K/gYrOxokyN5wGRW+nKKqor7EXwT3
         B8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BI7QjWVmpuIIWqYE8RAGE9+KBCb5m1yaNT/iNRoF5ZQ=;
        b=pUVcv2yUP08FWepKj8buLSm+6+jTsYO2Kt4YSKNx0sV/qMhLSA5bjVslAev/1F0tGq
         ffeDfmlFYzxvrEElJ8ndobpXg29TOXkaoK4m87rMF3VjBNAGXuhCmPhshew88x0pn4gw
         0a4S8TKZMdKLNeYs3caMvCU6X5R4sK5Ba1W/TZO09XJn+1xnya29NP2IzSxwOc+K5HhH
         0POSAhEwTvANzYjKUKhqC+OPcYlBzELcWaWnuvchXUBKlquhflHKBaQ1RmdpRoyamIwH
         mI3smfLOVcj6O8xQiaEj75sMLoMKZo+TG6ojzlVHMySMH3LxUezIz4guJMBNulpYlrhP
         jh4Q==
X-Gm-Message-State: AOAM532DvgVt4ShYbtVTqKjb8B7PzAF6LqhFRdCvE6mLqdLsBx+E0N0o
        luTGKNpXg0IHOv+It5OIQqs19A==
X-Google-Smtp-Source: ABdhPJx4Tj3fXU8Oa81ZJEnl1+5UHUvX/FBSXyCX7Oaw5uHbxBpQhAWUOZNwRRlTlfhdRjet9ZyAFg==
X-Received: by 2002:a5d:4087:0:b0:213:983f:2198 with SMTP id o7-20020a5d4087000000b00213983f2198mr21509092wrp.399.1654546442102;
        Mon, 06 Jun 2022 13:14:02 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d4589000000b0020fcf070f61sm16038489wrq.59.2022.06.06.13.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:14:01 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Atul Khare <atulkhare@rivosinc.com>
Subject: [PATCH v3 0/4] clear riscv dtbs_check errors
Date:   Mon,  6 Jun 2022 21:13:40 +0100
Message-Id: <20220606201343.514391-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Hey,
Couple conversions from txt to yaml here with the intent of fixing the
the dtbs_check warnings for riscv when building with "defconfig".
Atul Khare already sent patches for the gpio-line-names & cache-sets
(which went awol) and will clear the remaining two errors.

Apologies for sending v3 so quick on the heels of v2, but I realised
I screwed up copy paste in the i2c clock-frequency description & wanted
to rectify that.

Thanks,
Conor.

Changes from v2:
- ocores: remove part of clock-frequency description that was added by accident
  while copy pasting as a template...
- ocores: remove the enum (added in v2) for clock-frequency since that
  limitation was incorrectly copy pasted
- ocores: drop #{size,address}-cells
- mmc-spi-slot: use an array rather than a matrix for voltage-ranges

Changes from v1:
- squashed the maintainers changes
- dlg: added da9063 changes that landed in 5.19 (dlg,use-sw-pm)
- dlg: use absolute paths to schemas & unevaluatedProperties: false
- dlg: added vendor prefix to filename
- ocores: dropped "dummy" devices
- ocores: added vendor name to filename
- ocores: use enum for compatibles
- ocores: add enum for clock-frequency
- ocores: add reg-shift default
- ocores: reorder properties in examples
- mmc-spi-slot: use common gpio defines
- mmc-spi-slot: add ref to peripherl schema
- mmc-spi-slot: removed unneeded quotes, fixed a line length & s/spi/SPI

Conor Dooley (4):
  dt-bindings: mmc: convert mmc-spi-slot to yaml
  dt-bindings: i2c: convert ocores binding to yaml
  dt-bindings: mfd: convert da9063 to yaml
  riscv: dts: sifive: "fix" pmic watchdog node name

 .../devicetree/bindings/i2c/i2c-ocores.txt    |  78 -----------
 .../bindings/i2c/opencores,i2c-ocores.yaml    | 113 +++++++++++++++
 .../devicetree/bindings/mfd/da9063.txt        | 114 ---------------
 .../devicetree/bindings/mfd/dlg,da9063.yaml   | 132 ++++++++++++++++++
 .../devicetree/bindings/mmc/mmc-spi-slot.txt  |  29 ----
 .../devicetree/bindings/mmc/mmc-spi-slot.yaml |  77 ++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |   2 -
 MAINTAINERS                                   |   3 +-
 .../boot/dts/sifive/hifive-unmatched-a00.dts  |   2 +-
 9 files changed, 325 insertions(+), 225 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-ocores.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/opencores,i2c-ocores.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/da9063.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1

