Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C45C4320A
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Jul 2021 07:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC8F61057
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Jul 2021 07:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhG2H3o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Jul 2021 03:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbhG2H3n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jul 2021 03:29:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D914C0613C1
        for <linux-mmc@vger.kernel.org>; Thu, 29 Jul 2021 00:29:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1m90U7-0000u7-F0; Thu, 29 Jul 2021 09:29:39 +0200
Received: from [2a0a:edc0:0:900:2e4d:54ff:fe67:bfa5] (helo=ginster)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1m90U6-0002Ix-El; Thu, 29 Jul 2021 09:29:38 +0200
Received: from jbe by ginster with local (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1m90U6-0002gg-Dq; Thu, 29 Jul 2021 09:29:38 +0200
From:   Juergen Borleis <jbe@pengutronix.de>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, festevam@gmail.com,
        wsa+renesas@sang-engineering.com, dianders@chromium.org,
        ulf.hansson@linaro.org, kernel@pengutronix.de
Subject: Make the i.MX MMC device using DMA again
Date:   Thu, 29 Jul 2021 09:29:27 +0200
Message-Id: <20210729072929.10267-1-jbe@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jbe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

These patches try to repair the MMC DMA use on i.MX27 based platforms. Its worth the
effort since it doubles the speed of SD card operations for example.

I stumbled across this issue, while a system shutdown:

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000018
pgd = 3be189ab
[00000018] *pgd=a1569831, *pte=00000000, *ppte=00000000
Internal error: Oops: 817 [#1] PREEMPT ARM
CPU: 0 PID: 154 Comm: init Tainted: G        W         5.10.51-00002-gf0033953d4b5-dirty #4
Hardware name: Freescale i.MX27 (Device Tree Support)
PC is at mxcmci_start_cmd+0x190/0x200
LR is at mxcmci_start_cmd+0x1c8/0x200
pc : [<c044a34c>]    lr : [<c044a384>]    psr: 40000013
sp : c0f8bd68  ip : 40000013  fp : 00000000
r10: c14d384c  r9 : c0940288  r8 : c0e4ee80
r7 : 00000200  r6 : c0f8be18  r5 : 00000200  r4 : c0e4ee80
r3 : 00000000  r2 : c044a6ac  r1 : 00000004  r0 : 00000000
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 0005317f  Table: a1554000  DAC: 00000051
Process init (pid: 154, stack limit = 0xf5d79e18)
Stack: (0xc0f8bd68 to 0xc0f8c000)
bd60:                   c0e4ec00 00000000 c0f8bdcc c044a87c c0f8bdac c057ab78
bd80: 00000000 c0e4ec00 c0f8bdcc 00000000 c0f8a000 c0930018 c0940288 c14d384c
bda0: 00000000 c0436ca8 c0f8bdcc c0e4ec00 00000003 c0436e7c c0f8be18 c0e4ec00
bdc0: 00000003 c0436f50 c0f8bddc 00000000 c0f8be18 00000000 00000000 00000000
bde0: c0f8bde0 c0f8bde0 00000000 c0f8bdec c0f8bdec c04367b4 00000000 00000000
be00: 00000000 00000000 c0e4ec00 c0e4ec08 c14d3808 c043db80 00000007 00000000
be20: 00000000 00000000 00000000 00000000 00000000 00000003 00000000 00000000
be40: 00000000 c0f8bdcc c0e4ec00 c043f230 c0e4ec00 c0e4ec08 c14d3808 c0439734
be60: c14d380c c039cbfc 00000000 fee1dead 00000000 c09090a8 c0100224 c0f8a000
be80: 00000000 c012dd90 01234567 c012e038 00000000 00000000 00000000 00000000
bea0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bec0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bee0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bf00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bf20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bf40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bf60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bf80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0008ba44
bfa0: 00000058 c0100040 00000000 00000000 fee1dead 28121969 01234567 00000000
bfc0: 00000000 00000000 0008ba44 00000058 00000000 00000000 b6f52000 00000000
bfe0: 0008b138 bee3bcc8 0005d3b4 b6ea02b8 60000010 fee1dead 00000000 00000000
[<c044a34c>] (mxcmci_start_cmd) from [<c044a87c>] (mxcmci_request+0x114/0x268)
[<c044a87c>] (mxcmci_request) from [<c0436ca8>] (mmc_start_request+0x70/0xa0)
[<c0436ca8>] (mmc_start_request) from [<c0436e7c>] (mmc_wait_for_req+0x58/0xd0)
[<c0436e7c>] (mmc_wait_for_req) from [<c0436f50>] (mmc_wait_for_cmd+0x5c/0x84)
[<c0436f50>] (mmc_wait_for_cmd) from [<c043db80>] (mmc_deselect_cards+0x34/0x3c)
[<c043db80>] (mmc_deselect_cards) from [<c043f230>] (_mmc_sd_suspend+0x3c/0x70)
[<c043f230>] (_mmc_sd_suspend) from [<c0439734>] (mmc_bus_shutdown+0x40/0x68)
[<c0439734>] (mmc_bus_shutdown) from [<c039cbfc>] (device_shutdown+0x150/0x23c)
[<c039cbfc>] (device_shutdown) from [<c012dd90>] (kernel_restart+0x30/0xa0)
[<c012dd90>] (kernel_restart) from [<c012e038>] (__do_sys_reboot+0xb4/0x1b8)
[<c012e038>] (__do_sys_reboot) from [<c0100040>] (ret_fast_syscall+0x0/0x50)
Exception stack(0xc0f8bfa8 to 0xc0f8bff0)
bfa0:                   00000000 00000000 fee1dead 28121969 01234567 00000000
bfc0: 00000000 00000000 0008ba44 00000058 00000000 00000000 b6f52000 00000000
bfe0: 0008b138 bee3bcc8 0005d3b4 b6ea02b8
Code: e3530000 0a00000b e59f2060 e3a01004 (e5832018)
---[ end trace 2eac4fc5f6f6ce33 ]---

In this case it hits the line

   host->desc->callback = mxcmci_dma_callback;

in mxcmci_start_cmd(), where host->desc isn't setup because of bugs in the
corresponding i.MX27 DMA driver and this MMC driver.

The state machine in mxcmmc.c is broken and always expects a working DMA if a
call to dma_request_chan() in its probe function was successfull. Since the
i.MX27 DMA driver (imx-dma.c) is broken as well regarding its channel configuration,
DMA wasn't possible since commit dea7a9f (at least for a generic DMA type).
I don't know, why the MMC driver worked at regular SD card usage (e.g. mounted
filesystem), but a system shutdown seems to hit a corner case and crashes.

Comments are welcome.

jb

