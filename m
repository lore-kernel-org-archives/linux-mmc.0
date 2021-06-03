Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E4DC47082
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Jun 2021 13:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C297613E3
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Jun 2021 13:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhFCNft (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Jun 2021 09:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhFCNfs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Jun 2021 09:35:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724EFC06174A;
        Thu,  3 Jun 2021 06:33:49 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id q25so4884008pfh.7;
        Thu, 03 Jun 2021 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ctsfVI/vZCq/FOh8pV2IxR33N4F11DLsoUQif+z3UzE=;
        b=hY2sbz7eOOPEGtagTymBW5uROJEgCZ8/Fu02Xv3WqalSrRXwNE0RtDjBIC6hbkMINr
         KoljsG47j0/Hzc0YeS7yBtOBmXrF2yn4Ybr6ZKHt+GDENeh6yPx9qK0ntJccyuTkLsAd
         0CjfEUcKp3xwuNYL12Zhr7CE7GU5ByZVeXYj90u+fZ2uLOz0QkLXaMZrzic+N2Oo/Fqk
         WB6E3KNi8s6X6L/0N5OUmShsAO6Xygk71K5l8UyFMjMVfacrMFtdi4UGsiwfAf+nd6L2
         S9fvDX6VG8F36x8iEFlWKdCNQCcN1Hu8jK/fZ/2dIPJ0veOfl0JJeeaKIwT6UBy/4uB5
         rkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ctsfVI/vZCq/FOh8pV2IxR33N4F11DLsoUQif+z3UzE=;
        b=n1RvLOmyWYmQFFRanNcXRAzOSbYDcvLIywHMin0iY7NuXJbtbp+wfEePfFDCmVFyhE
         8Tu3mUweI+jvuKa9/bult9FWuj0i3010gS3xRdbZteuaE+h8dwJurAKU6YVBIQuf5s+Q
         aGJU9fr8GCLyOX1a1pkYNKzmwfKJyS9YrvKMT4CzX6vD1Umnwr9QZ86Tz3Ps+vzO4UnY
         D4uTQ3kHWud32yHcMF/8IIJPoCNa9MKwOCYvxZHkt8zUeBoIXKaEZfi1QrfgP/TeJd58
         oVZSdL+zNOwio7bhLHC7uKJrBd1IBgdMDziCf6K5Q0BtPPP7DOE9Sn/YJ7ahWF2XWBtZ
         9qRw==
X-Gm-Message-State: AOAM5302kT78CDPzbtpHRoATugcW24PjBja2OgWYW/qQ1usSBC2xuLWy
        FA5gb8S7R/n2rW5xDRd2pA==
X-Google-Smtp-Source: ABdhPJwAhMwMeJNlqE9O9VHJRgIXWaYCOkvO4H+RrsgOUacLLhSTmalEb9W7S0xUdEohB/cACCwSHA==
X-Received: by 2002:a05:6a00:856:b029:2dc:bd34:9f7e with SMTP id q22-20020a056a000856b02902dcbd349f7emr33046158pfk.0.1622727228947;
        Thu, 03 Jun 2021 06:33:48 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id o133sm2476302pfd.49.2021.06.03.06.33.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 06:33:48 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     brucechang@via.com.tw, HaraldWelte@viatech.com,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] mmc: via-sdmmc: add a check against NULL pointer dereference
Date:   Thu,  3 Jun 2021 13:33:20 +0000
Message-Id: <1622727200-15808-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Before referencing 'host->data', the driver needs to check whether it is
null pointer, otherwise it will cause a null pointer reference.

This log reveals it:

[   29.355199] BUG: kernel NULL pointer dereference, address:
0000000000000014
[   29.357323] #PF: supervisor write access in kernel mode
[   29.357706] #PF: error_code(0x0002) - not-present page
[   29.358088] PGD 0 P4D 0
[   29.358280] Oops: 0002 [#1] PREEMPT SMP PTI
[   29.358595] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.12.4-
g70e7f0549188-dirty #102
[   29.359164] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[   29.359978] RIP: 0010:via_sdc_isr+0x21f/0x410
[   29.360314] Code: ff ff e8 84 aa d0 fd 66 45 89 7e 28 66 41 f7 c4 00
10 75 56 e8 72 aa d0 fd 66 41 f7 c4 00 c0 74 10 e8 65 aa d0 fd 48 8b 43
18 <c7> 40 14 ac ff ff ff e8 55 aa d0 fd 48 89 df e8 ad fb ff ff e9 77
[   29.361661] RSP: 0018:ffffc90000118e98 EFLAGS: 00010046
[   29.362042] RAX: 0000000000000000 RBX: ffff888107d77880
RCX: 0000000000000000
[   29.362564] RDX: 0000000000000000 RSI: ffffffff835d20bb
RDI: 00000000ffffffff
[   29.363085] RBP: ffffc90000118ed8 R08: 0000000000000001
R09: 0000000000000001
[   29.363604] R10: 0000000000000000 R11: 0000000000000001
R12: 0000000000008600
[   29.364128] R13: ffff888107d779c8 R14: ffffc90009c00200
R15: 0000000000008000
[   29.364651] FS:  0000000000000000(0000) GS:ffff88817bc80000(0000)
knlGS:0000000000000000
[   29.365235] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.365655] CR2: 0000000000000014 CR3: 0000000005a2e000
CR4: 00000000000006e0
[   29.366170] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[   29.366683] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[   29.367197] Call Trace:
[   29.367381]  <IRQ>
[   29.367537]  __handle_irq_event_percpu+0x53/0x3e0
[   29.367916]  handle_irq_event_percpu+0x35/0x90
[   29.368247]  handle_irq_event+0x39/0x60
[   29.368632]  handle_fasteoi_irq+0xc2/0x1d0
[   29.368950]  __common_interrupt+0x7f/0x150
[   29.369254]  common_interrupt+0xb4/0xd0
[   29.369547]  </IRQ>
[   29.369708]  asm_common_interrupt+0x1e/0x40
[   29.370016] RIP: 0010:native_safe_halt+0x17/0x20
[   29.370360] Code: 07 0f 00 2d db 80 43 00 f4 5d c3 0f 1f 84 00 00 00
00 00 8b 05 c2 37 e5 01 55 48 89 e5 85 c0 7e 07 0f 00 2d bb 80 43 00 fb
f4 <5d> c3 cc cc cc cc cc cc cc 55 48 89 e5 e8 67 53 ff ff 8b 0d f9 91
[   29.371696] RSP: 0018:ffffc9000008fe90 EFLAGS: 00000246
[   29.372079] RAX: 0000000000000000 RBX: 0000000000000002
RCX: 0000000000000000
[   29.372595] RDX: 0000000000000000 RSI: ffffffff854f67a4
RDI: ffffffff85403406
[   29.373122] RBP: ffffc9000008fe90 R08: 0000000000000001
R09: 0000000000000001
[   29.373646] R10: 0000000000000000 R11: 0000000000000001
R12: ffffffff86009188
[   29.374160] R13: 0000000000000000 R14: 0000000000000000
R15: ffff888100258000
[   29.374690]  default_idle+0x9/0x10
[   29.374944]  arch_cpu_idle+0xa/0x10
[   29.375198]  default_idle_call+0x6e/0x250
[   29.375491]  do_idle+0x1f0/0x2d0
[   29.375740]  cpu_startup_entry+0x18/0x20
[   29.376034]  start_secondary+0x11f/0x160
[   29.376328]  secondary_startup_64_no_verify+0xb0/0xbb
[   29.376705] Modules linked in:
[   29.376939] Dumping ftrace buffer:
[   29.377187]    (ftrace buffer empty)
[   29.377460] CR2: 0000000000000014
[   29.377712] ---[ end trace 51a473dffb618c47 ]---
[   29.378056] RIP: 0010:via_sdc_isr+0x21f/0x410
[   29.378380] Code: ff ff e8 84 aa d0 fd 66 45 89 7e 28 66 41 f7 c4 00
10 75 56 e8 72 aa d0 fd 66 41 f7 c4 00 c0 74 10 e8 65 aa d0 fd 48 8b 43
18 <c7> 40 14 ac ff ff ff e8 55 aa d0 fd 48 89 df e8 ad fb ff ff e9 77
[   29.379714] RSP: 0018:ffffc90000118e98 EFLAGS: 00010046
[   29.380098] RAX: 0000000000000000 RBX: ffff888107d77880
RCX: 0000000000000000
[   29.380614] RDX: 0000000000000000 RSI: ffffffff835d20bb
RDI: 00000000ffffffff
[   29.381134] RBP: ffffc90000118ed8 R08: 0000000000000001
R09: 0000000000000001
[   29.381653] R10: 0000000000000000 R11: 0000000000000001
R12: 0000000000008600
[   29.382176] R13: ffff888107d779c8 R14: ffffc90009c00200
R15: 0000000000008000
[   29.382697] FS:  0000000000000000(0000) GS:ffff88817bc80000(0000)
knlGS:0000000000000000
[   29.383277] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.383697] CR2: 0000000000000014 CR3: 0000000005a2e000
CR4: 00000000000006e0
[   29.384223] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[   29.384736] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[   29.385260] Kernel panic - not syncing: Fatal exception in interrupt
[   29.385882] Dumping ftrace buffer:
[   29.386135]    (ftrace buffer empty)
[   29.386401] Kernel Offset: disabled
[   29.386656] Rebooting in 1 seconds..

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/mmc/host/via-sdmmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index a1d098560099..c32df5530b94 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -857,6 +857,9 @@ static void via_sdc_data_isr(struct via_crdr_mmc_host *host, u16 intmask)
 {
 	BUG_ON(intmask == 0);
 
+	if (!host->data)
+		return;
+
 	if (intmask & VIA_CRDR_SDSTS_DT)
 		host->data->error = -ETIMEDOUT;
 	else if (intmask & (VIA_CRDR_SDSTS_RC | VIA_CRDR_SDSTS_WC))
-- 
2.17.6

