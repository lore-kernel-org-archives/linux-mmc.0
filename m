Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B09C54EBD
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Jan 2023 13:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjAINER (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Jan 2023 08:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjAINDJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2023 08:03:09 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAAE17050
        for <linux-mmc@vger.kernel.org>; Mon,  9 Jan 2023 05:02:26 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hw16so8007443ejc.10
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jan 2023 05:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LkzjllfIyWMzDeEVD7OKUMHITseBrUR0IuEgUUno/hw=;
        b=HVejhwClRNQ3MUtfWYs0WnCJRsAnIzlGhfP+OnefrHhLWhWhcDmk/dY2bj9CfU7+EE
         In84VnurTtcFTxUrxWjFoLx6E60B13rANMzMHJfvaMaeCAqqA/8VB0vv7CKNiPabcFeO
         xp007nViaZqnrqXDgI9XXZXKke4bqpEvGAP1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LkzjllfIyWMzDeEVD7OKUMHITseBrUR0IuEgUUno/hw=;
        b=2rj+pNqy2n+RmKfHNMRu+RnfDtBzWpvR9aMI7xDBFGyi4fytAf8y84miXkqT8v7zbU
         1VDhcW7VKfaz1SyH4u31Bjmy3h95w4h1/Xz16b1jEksZ8iTRBK97VgWdhOFRDw+1Q37Q
         C1iLon4E26IcFA0s/iONcWAl2vz9rUQ+INGtC8clGLkbAY/y7DqLoGCkrZwG3YIVkJFP
         LZhNav082kyHJW+QSPZTuPesGN8Hvl8kEcgDNfFvlNXx66wwbleGq+rR6lxrgCWnPMdX
         WruuVFEHB6cvBWZXmgg4QgB5sGKha5MAPvdDXLT4Vn1NQ0UtVoN5WaL+8xTlA1BJyQZ0
         M+9A==
X-Gm-Message-State: AFqh2kq8RtsC8Dvkw/5RZroq2Ca0Ohe7cNg23kVVr0jiGYEiTwLfu7tq
        jZikPadCikHwcl2yhIRox0ofPQnw0j0RI/N6JOuhrwg3lGMR+c0g3t0=
X-Google-Smtp-Source: AMrXdXuYd8ep0FE4rsIiKYO8EGoVrT8K6dwHvKpNV3yPBrN9VUSuX2TpZrcn2sMDaeDRWd6E4UufeUUjTqw6lUXPiPM=
X-Received: by 2002:a17:906:4e98:b0:82d:e2a6:b04 with SMTP id
 v24-20020a1709064e9800b0082de2a60b04mr8059816eju.748.1673269345065; Mon, 09
 Jan 2023 05:02:25 -0800 (PST)
MIME-Version: 1.0
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 9 Jan 2023 14:02:14 +0100
Message-ID: <CAOf5uwns3YZMY5xhM+o0rNvtTqEDwCbua5HuSy-LBwgZq_eWYg@mail.gmail.com>
Subject: NXP imx6ull nonalignment buffer question
To:     Bough Chen <haibo.chen@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Haibo

Working on imx6ulz design and found that if I send a sdio packet using
the sdio_writesb the adma driver tries to handle it with two dma
descriptors. The first one filled with the bytes up to 3 to cover the
misalign and then another buffer descriptor

  offset = (SDHCI_ADMA2_ALIGN - (addr & SDHCI_ADMA2_MASK)) &
                         SDHCI_ADMA2_MASK;
                if (offset) {
                        if (data->flags & MMC_DATA_WRITE) {
                                buffer = sdhci_kmap_atomic(sg);
                                memcpy(align, buffer, offset);
                                sdhci_kunmap_atomic(buffer);
                        }

                        /* tran, valid */
                        __sdhci_adma_write_desc(host, &desc, align_addr,
                                                offset, ADMA2_TRAN_VALID);

                        BUG_ON(offset > 65536);

                        align += SDHCI_ADMA2_ALIGN;
                        align_addr += SDHCI_ADMA2_ALIGN;

                        addr += offset;
                        len -= offset;
                }

In 48.7.4 Data Length Setting
For either ADMA (ADMA1 or ADMA2) transfer, the data in the data buffer must be
word aligned, so the data length set in the descriptor must be a
multiple of 4. I have noticed that this code does not work as
expected.

Did you have any feedback?

Michael
