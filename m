Return-Path: <SRS0=i1XN=4W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343F4C3F2D1
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 20:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A18021556
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 20:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtvBAHkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgCEU4e (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:56:34 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]:36982 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgCEU4e (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2020 15:56:34 -0500
Received: by mail-qt1-f169.google.com with SMTP id j34so153494qtk.4;
        Thu, 05 Mar 2020 12:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WtPw0stoh3nCyfnoHQJntC/GNRmbWPKHGLa4u3rPj7Q=;
        b=ZtvBAHkKETrMBnbu22gqYBsmB1fw4t35WFMaQViF8T1VChEiS7fB+Q77tYkJ95BrL9
         K825QVlXQMLvUrSSieLtyqVRggX1gn4Srnry546Vi7XWvdxQ3wEY3RCgjnIbt2QADBdd
         I+JjdYyh5oIZRF/DsVejlRbwu4QCp3AE96m76LythBXGVsxtQMCRNLzWM32rbkmiAeyR
         56j5jdVFSGY34DDYFpRNslkUV4ldmd0dFwUStl/aOS7R0pQcMLmOqOijm13GWd9vAnis
         Kd0PiyyKsWhnEC91c5xhhCCkO1gx+IUVmoghLY0jrtQilJ3rQhbdGGrkJ4gGYghGSS2R
         zLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WtPw0stoh3nCyfnoHQJntC/GNRmbWPKHGLa4u3rPj7Q=;
        b=BRE0AKeBedidanT2rp4AeuTH1gwBLXjhMBU4lRojtj9ReiD7Hj97Xx6hOTy4K2QsAC
         jvWBI7Whc+SfoJCtD0LCOzyrKq9AeiLtipIs+hP2J6p3L/2XhC9cST7Ktk4tb0sK9Ofn
         REOT9NRvL077Is/T7BjVHvSWY21CmgUqcoqkVYtSSTCcB6gcu2PdTXrBRmKicBCfELE+
         5tQBWz5MTDDiG24eY36p0JF1n9x7mp0O6ApNjYybeqeksi/DeqaVSyovXZqEscyacoeH
         3ltSebJeVvyRWIQIs6apw5DRGty6x4KTLg6Wk801zbxRmIemB5pFR2VX+ZBrBR+A37dI
         0mrA==
X-Gm-Message-State: ANhLgQ1yen6+a0JZD1yLtiDaWeCR751zoSyl09Utn0YiAIc4JpxIZApa
        ywpHFdjvB67QFpwbYYdyngYSwdrf96GLaQr7zHuxuOvs
X-Google-Smtp-Source: ADFU+vuieypY3p+x0i35TJ747jI6n6AD97ihAmQRC5IbKbB/eCdY7pM/mCkAtO4Acqv8hFMN1IdmSSrSpUoyazy7MdU=
X-Received: by 2002:ac8:6753:: with SMTP id n19mr49512qtp.193.1583441792920;
 Thu, 05 Mar 2020 12:56:32 -0800 (PST)
MIME-Version: 1.0
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 5 Mar 2020 15:56:22 -0500
Message-ID: <CAMdYzYoxsBAyBhp+S6LKE060qLLq=XioVVPUmOka0auOo8aXcg@mail.gmail.com>
Subject: [BUG] 5.6-rc1 breaks sdhci on tegra-30 ouya
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Good Afternoon,

I have been fighting a bug with sdhci on the tegra-30 based ouya since 5.6-rc1.
I've traced it to the following commit:

mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC
24ed3bd01d6a844fd5e8a75f48d0a3d10ed71bf9

[   51.401369] mmc0: Card stuck being busy! mmc_poll_for_busy
[   51.407288] mmc0: cache flush error -110
[   51.412347] blk_update_request: I/O error, dev mmcblk0, sector 0 op
0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0

It also caused issues with hitching with the bcm4330 sdio wifi chip.

Reverting this commit fixes the issue.

After reverting this commit, with the following commit still intact:

mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()

I am seeing a lot of the following messages:
[   22.626377] mmc0: unspecified timeout for CMD6 - use generic
[   22.687349] mmc0: unspecified timeout for CMD6 - use generic
[   23.362736] mmc0: unspecified timeout for CMD6 - use generic
[   23.487824] mmc0: unspecified timeout for CMD6 - use generic
[   23.547674] mmc0: unspecified timeout for CMD6 - use generic
[   23.745527] mmc0: unspecified timeout for CMD6 - use generic
[   23.817678] mmc0: unspecified timeout for CMD6 - use generic
[   24.045600] mmc0: unspecified timeout for CMD6 - use generic
[   24.155577] mmc0: unspecified timeout for CMD6 - use generic
[   24.223448] mmc0: unspecified timeout for CMD6 - use generic
[   24.286257] mmc0: unspecified timeout for CMD6 - use generic

Very Respectfully,
Peter Geis
