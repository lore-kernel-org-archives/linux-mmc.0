Return-Path: <SRS0=dEAU=3X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BDDC35247
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Feb 2020 19:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DB62082E
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Feb 2020 19:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTUu1JKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgBCTUD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:20:03 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:39723 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgBCTUC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Feb 2020 14:20:02 -0500
Received: by mail-lj1-f182.google.com with SMTP id o15so10331014ljg.6
        for <linux-mmc@vger.kernel.org>; Mon, 03 Feb 2020 11:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nslNUHlX7EIFDFgPaHrgVbpEWBtUd3831cJkStBtU+I=;
        b=lTUu1JKZSt4xgIzEs9N8gfA2saROUBzQ0miGai6+hBgzfuwNWHwgf8nqSSmobAYzT9
         7A/N52yVg3+/75muokcHAgBFZQv4bKgbiV0LjU/vQ3/ZcLm45pLwtnKeogCX06qxKRci
         Xe/SPIiVRB9EesuLwyZnUjK9M1roNi7BBKMA/SaeBaNa/M06IQhhAnh2lDcsV1uZkOx6
         oR7rySnkLTvhx9LR5c4TJD5FG0+naADZAyvlXeA9vb9QZ6HOF9nsX4+q92A81Sv+0K10
         7CMq4b7mLNlFnMP5pLq297ZGI3NAeB6m4qekeJPF6b5cvGDbsDk1Z3/GBlj5jbl/E84u
         rPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nslNUHlX7EIFDFgPaHrgVbpEWBtUd3831cJkStBtU+I=;
        b=iNJ3Ki/5TuwGPmGPC6IlAavJXuAyTFRs5hbYdgmHa489GcV6XonYkiD9AJDHY68cq3
         LlQ7Zq5/KqN1yI0kxk5KcoMHtd/VPW7RcxIHjLWl3NcJoYZ3RpLkjRNGwwpF1CF59bTN
         4f1XS5pa5rZZZxF1IThlEnbuOSpBdIze/A8LAZ7VmJ/zlh5cjdOQWmNb+toyx8i5+vph
         7UYqL9COlpE8NTXcRzN/1AfqqkQpOOq4OuT34jlRfeu7dHzlVg6NEPSpI/RIsdrk8sW0
         jY6Mz8Ujjl0jn8kO/DHfWveB1EihFmZ23RJf+UyfLllp5+lDvG+5xcZCyH4rZptfIWnJ
         FLvg==
X-Gm-Message-State: APjAAAWlQKFfft7kqZmf774zPVLGPYgAPyi9ftHvgtXeGL/TdsoJp5zH
        EjCFwLyW6DULliz11Akm/BgVxSfFnVHcxFHMo1U=
X-Google-Smtp-Source: APXvYqy9VZXDKV6EWHZytu77dkYEL5aEYN3h8uHqYAAxCABEFswLglssF50W2f+jmCtcbKoVjX5fElIjvVv3d3X7muQ=
X-Received: by 2002:a2e:2e11:: with SMTP id u17mr14375443lju.117.1580757599170;
 Mon, 03 Feb 2020 11:19:59 -0800 (PST)
MIME-Version: 1.0
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 3 Feb 2020 16:19:50 -0300
Message-ID: <CAOMZO5DMMCZPfwNbTaG8_iQhWg2K1XeO719nSA0Gsf2ywHy4jQ@mail.gmail.com>
Subject: sdhci timeout on imx8mq
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

I observe the following timeout on a imx8mq-evk running linux-next 20200203:

# [   11.747858] mmc0: Timeout waiting for hardware interrupt.
[   11.753264] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[   11.759705] mmc0: sdhci: Sys addr:  0x00000800 | Version:  0x00000002
[   11.766145] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001
[   11.772584] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
[   11.779024] mmc0: sdhci: Present:   0x01f88a0a | Host ctl: 0x00000011
[   11.785463] mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
[   11.791902] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x000020ff
[   11.798342] mmc0: sdhci: Timeout:   0x0000008f | Int stat: 0x00000000
[   11.804781] mmc0: sdhci: Int enab:  0x117f100b | Sig enab: 0x117f100b
[   11.811220] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00008402
[   11.817660] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x8000b407
[   11.824100] mmc0: sdhci: Cmd:       0x0000083a | Max curr: 0x00ffffff
[   11.830539] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
[   11.836978] mmc0: sdhci: Resp[2]:   0x320f5913 | Resp[3]:  0x00d04f01
[   11.843416] mmc0: sdhci: Host ctl2: 0x00000008
[   11.847860] mmc0: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0xf97d2200
[   11.854297] mmc0: sdhci: ============================================
[   11.860908] mmc0: error -110 whilst initialising MMC card
[   12.027806] mmc0: new HS400 MMC card at address 0001
[   12.033283] mmcblk0: mmc0:0001 R1J56L 13.8 GiB
[   12.038007] mmcblk0boot0: mmc0:0001 R1J56L partition 1 4.00 MiB
[   12.044112] mmcblk0boot1: mmc0:0001 R1J56L partition 2 4.00 MiB
[   12.050172] mmcblk0rpmb: mmc0:0001 R1J56L partition 3 128 KiB,
chardev (235:0)
[   12.058210]  mmcblk0: p1 p2

Haven't had a chance to debug this yet, but just reporting in case
anyone has any ideas.

Thanks
