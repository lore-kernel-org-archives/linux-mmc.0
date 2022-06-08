Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B160CCA47A
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jun 2022 23:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbiFHXkK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jun 2022 19:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbiFHXj7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2022 19:39:59 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8880D169DF4
        for <linux-mmc@vger.kernel.org>; Wed,  8 Jun 2022 16:39:35 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id n197so9608070qke.1
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jun 2022 16:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=kc8hDtKnDcjkjtnpKv99miwrNZ1mscnVCOSjHJGhRR0=;
        b=TGdTe8ftgW2E2QSXLDATWBAXq3sauk3KYSj6BMlJLGO6AIyIfhb5n1gjvAikC5sfj1
         pnF2q+aa3J49SlWeHoe8utIJbft2tfdvJWfSA/DWdGmQ81xwpFbbShsO99rjEfX37VOJ
         O7nf0OOCHhgW59XOZB2AYutoUpxS75uohsXNuBYCQ74OZWV0IkfqStkyQpIXIgp5Yu/X
         /b47CaBvS9tF2RvKGzD2OXWMoCKHHF/JqW3mtCMGdzWVyYoNxEJonBGyxomdCDOnzKP5
         Wm0OipG0BCiWNN5Q3OyAx5VK7fAStBf4WuoirjR9Gnpdd0r+CJ+NosZexvzLXB8JwqtT
         YXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kc8hDtKnDcjkjtnpKv99miwrNZ1mscnVCOSjHJGhRR0=;
        b=7/jHFobptZQdi3wAkQZfwwLpQ6BNwDoYxF6v+aAG7dQwWAC6YIg/rAxVcL+vaa5SZp
         Mta3+K58EZ2uBkrqlox7kn7iHf+NEvYz7zuYWvNmY0xpDcX24CVhUO+lyE/3D3uoa805
         MjClxEuLicAOkvsxDtZqNk2gwI5AfhsFB14bcYZZYVkMJ3wbthh0abfCf7zuiscXmAmn
         qrg8JHPssaeDoRVyCBBCN0I4UEbx/hWcbo3MrhmXoRsOz6oR0RxCYreluQNzdsBTFcIp
         hdcFruS/UDO9JByhK07VkX45smKjnQlPzDRFBhLm7NkYnOMCl4UxE3MgXj+6hdW79tIm
         8rrw==
X-Gm-Message-State: AOAM530HThi1rPonBUiyDYY4H+xOU97vvEzRJWt2hcTRo9BX+qrqVybZ
        jkvQ1HPB3L4fOpJIz3VB4NqxNQ6U6eeN1WwQGZW0JA==
X-Google-Smtp-Source: ABdhPJwwoi0drQjkYJ1j2Qdt6XiU3x2RVVqapgseeDGRMrMmyQCzzXLwavj3DbqQ68d+IFyAWbxsz4ReHsk+ofIZ0q4=
X-Received: by 2002:a05:620a:1911:b0:6a6:e8e9:70cd with SMTP id
 bj17-20020a05620a191100b006a6e8e970cdmr6816152qkb.627.1654731574196; Wed, 08
 Jun 2022 16:39:34 -0700 (PDT)
MIME-Version: 1.0
From:   Atul Khare <atulkhare@rivosinc.com>
Date:   Wed, 8 Jun 2022 16:39:23 -0700
Message-ID: <CABMhjYp3xUyQ9q6nXHvEA2zuzhYi0ETn6UETeH1apWf2n2eP7A@mail.gmail.com>
Subject: [PATCH v2 0/2] dt-bindings: sifive: fix dt-schema errors
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Atul Khare <atulkhare@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The patch series fixes dt-schema validation errors that can be reproduced
using the following: make ARCH=riscv defconfig; make ARCH=riscv
dt_binding_check dtbs_check

This is a rebased version of https://tinyurl.com/yvdvmsjd, and excludes
two patches that are now redundant.

Atul Khare (2):
  dt-bindings: sifive: add cache-set value of 2048
  dt-bindings: sifive: add gpio-line-names

 Documentation/devicetree/bindings/gpio/sifive,gpio.yaml      | 3 +++
 Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

--
2.34.1
