Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBF8C77B61
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Mar 2023 13:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjC0Nrt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Mar 2023 09:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjC0Nrs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Mar 2023 09:47:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AD43C0D
        for <linux-mmc@vger.kernel.org>; Mon, 27 Mar 2023 06:47:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h8so36449615ede.8
        for <linux-mmc@vger.kernel.org>; Mon, 27 Mar 2023 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679924864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t7BV/Kx6UCtJpUovRhPsWRP5SzZ7y1ukt8uk3iZ8eAE=;
        b=IewDs8GfHgkOhz6SEJ76/sfVp2pbQV1qLHUFVt9GRUWIq1NZA0XMYREj5e4akzn1dG
         lsffQvwAOqeoRRbA2dwP2l9prPLaageiaAgiUoLpPHc2yvjOoVZQZJ5MArHpqUDfdowd
         OoUCSigMB7NJHVF3pQlYyHBL/ySMsK9DjyK81FHyBVgXlXTCdYOGeVb7HkENSIGwSa/2
         2Upn7J23OxE5ZIKjgU3RS9oqiAByAs7uaGqtgX6GKKF0P22yvhJJZsXOnqVsK1j2YToT
         4WWHxRWNjm6FqOGzDPqwQ4K9FM3uPeYfm5jdQ3OsvHZTh043qyblUEeNDSdhvrqx7WF5
         1skA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679924864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7BV/Kx6UCtJpUovRhPsWRP5SzZ7y1ukt8uk3iZ8eAE=;
        b=VfNrkmOyCapsxTGGC9vo9CdniOg6uodSdJi/TZ0MiAscPY2Njhz7jVJGFGoNMnBUF/
         YIMLrvcfBR5rpIH38RwkDg+tfv46pu3Xqsi2SNy3gTiUAlqt5RTNRT15AT8rtaNr4Bhb
         ZKU+7NyT+/NwsTLU9eB1HfLa+TPqd1pvjUmWIKvjhgYMng1nULncyP2KwvpSrOXEREz8
         oa8Jj7sfmYZl2YXEzaGkyjeui1md2mjouFfDsr2JmByxCjAoVmS4VAJ1Fnul//vPyN2k
         texcmcRAHHU4KyO01l64nEW68jBLPnQE+JB1f4XJRu8rxWZACPt3j4S5teWWk/ZewJ+f
         0aIA==
X-Gm-Message-State: AAQBX9fGhz/gppC3jYseD6C0BnxC1h/jsffl472TQb76toa2fZvsFIFj
        IuTCalIe9leCXXtvLYOvcd1Vyw==
X-Google-Smtp-Source: AKy350Y6BVy0kKsBIvMlaCwci6jrmq2SWtNUQBKSoPRQSgF4V0DbngHfYOsYUcqXoCyxZHTNP9etyQ==
X-Received: by 2002:a17:906:5288:b0:932:3d1b:b67a with SMTP id c8-20020a170906528800b009323d1bb67amr12335753ejm.41.1679924864341;
        Mon, 27 Mar 2023 06:47:44 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id n7-20020a509347000000b005023ddb37eesm2394303eda.8.2023.03.27.06.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:47:43 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH v4 0/7] Add dedicated Qcom ICE driver
Date:   Mon, 27 Mar 2023 16:47:27 +0300
Message-Id: <20230327134734.3256974-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As both SDCC and UFS drivers use the ICE with duplicated implementation,
while none of the currently supported platforms make use concomitantly
of the same ICE IP block instance, the new SM8550 allows both UFS and
SDCC to do so. In order to support such scenario, there is a need for
a unified implementation and a devicetree node to be shared between
both types of storage devices. So lets drop the duplicate implementation
of the ICE from both SDCC and UFS and make it a dedicated (soc) driver.
Also, switch all UFS and SDCC devicetree nodes to use the new ICE
approach.

See each individual patch for changelogs.

The v3 is here:
https://lore.kernel.org/all/20230313115202.3960700-1-abel.vesa@linaro.org/

Abel Vesa (7):
  dt-bindings: crypto: Add Qualcomm Inline Crypto Engine
  dt-bindings: mmc: sdhci-msm: Add ICE phandle
  dt-bindings: ufs: qcom: Add ICE phandle
  soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver
  scsi: ufs: ufs-qcom: Switch to the new ICE API
  mmc: sdhci-msm: Switch to the new ICE API
  arm64: dts: qcom: sm8550: Add the Inline Crypto Engine node

 .../crypto/qcom,inline-crypto-engine.yaml     |  42 +++
 .../devicetree/bindings/mmc/sdhci-msm.yaml    |   4 +
 .../devicetree/bindings/ufs/qcom,ufs.yaml     |   4 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  10 +
 drivers/mmc/host/Kconfig                      |   2 +-
 drivers/mmc/host/sdhci-msm.c                  | 220 +++--------
 drivers/soc/qcom/Kconfig                      |   4 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/ice.c                        | 342 ++++++++++++++++++
 drivers/ufs/host/Kconfig                      |   2 +-
 drivers/ufs/host/Makefile                     |   4 +-
 drivers/ufs/host/ufs-qcom-ice.c               | 244 -------------
 drivers/ufs/host/ufs-qcom.c                   |  95 ++++-
 drivers/ufs/host/ufs-qcom.h                   |  32 +-
 include/soc/qcom/ice.h                        |  37 ++
 15 files changed, 591 insertions(+), 452 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
 create mode 100644 drivers/soc/qcom/ice.c
 delete mode 100644 drivers/ufs/host/ufs-qcom-ice.c
 create mode 100644 include/soc/qcom/ice.h

-- 
2.34.1

