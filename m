Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF034C433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 07:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD779611CA
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 07:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243833AbhKIIBQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Nov 2021 03:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbhKIIBP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2021 03:01:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22007C061764;
        Mon,  8 Nov 2021 23:58:30 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p18so19403235plf.13;
        Mon, 08 Nov 2021 23:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vb4eBAY7N0LkA2iKekvmFSd0kTlc+hgeAZzRroUDRuw=;
        b=kpLT0wPZJt6N/49Pzo75OHSy2fqytkL41+ufcjkYpfslXkv3VR+ssVUG7Gru6hZdAb
         BR6paiz71+CewpnfAb6crR2dRV5bM8sSc7U864hrzw3TlxFoTdrt9nLxXK40dcOnEFlr
         pvILyaldpTye8QyT8kBZZHky4Cy7w3mN6NKEnnCwEi0rm2MJb9Vb94giXZGmnua3PHJq
         0DK3FrfXqXymLu+MGP5rvEX9uqHYgYYbBIO8KFQvJPEwPAQYRSVGmcHaQkbMCWoHGfxF
         1Yw5w1lMhyE5F2loMRunWKnRxiOnhBzpKkHlV2bVRJw8No7UWyvnLImBRgX3l2noCj1Z
         k6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vb4eBAY7N0LkA2iKekvmFSd0kTlc+hgeAZzRroUDRuw=;
        b=YUAGzIJjqLhHMaXN3+9hUfUokO8yaCJ8J1XVoOImnvQ/IlZ+Z2iihAFslqUb9y8JL2
         b3d7zNmjeKUF6x6vOq27DvNGJqFXBIYPJ1MbVl6zN+CStcfIuT5dDiys7FXVp1xf3dBc
         ax/tQ4kznZNAwnVWTdbECncpnLsFMDVSVFXmpPJ8/MF8yeoLX+vnbABIvp2mNVJlkLcT
         lem8ZKwvoZXZws6DHVSPKruhvmUJOpFrPLIr7E9IDriQ5CI4CMgvvdSTcgso/j2DFXL1
         XEwwvGFKm1YBa+10XO0srZ5kLjN6TfpFPSoqyNCZnG20wZ5LfxKUG5g5XaPjsVByPXlM
         OtTw==
X-Gm-Message-State: AOAM531bxMNgnqkSuoI2XzGw74BS7n3jq328DzE3/CqFR3EuqP6RjmqI
        kyyjgaOJNmSXMyPme59L0xI=
X-Google-Smtp-Source: ABdhPJxnmtWC3JYFZjtqMdreyxgTZBG8189r0SLPti74aaLSDn2TxU+yRGNkh4u+6hEc9AB6Hy0mIA==
X-Received: by 2002:a17:90b:1806:: with SMTP id lw6mr5049028pjb.59.1636444709599;
        Mon, 08 Nov 2021 23:58:29 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id x135sm10635714pfd.78.2021.11.08.23.58.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Nov 2021 23:58:29 -0800 (PST)
From:   "LH.Kuo" <lhjeff911@gmail.com>
X-Google-Original-From: "LH.Kuo" <lh.kuo@sunplus.com>
To:     p.zabel@pengutronix.de, daniel.thompson@linaro.org,
        lee.jones@linaro.org, u.kleine-koenig@pengutronix.de,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: [PATCH v2 0/2] Add SD/SDIO control driver for Sunplus SP7021 SoC               
Date:   Tue,  9 Nov 2021 15:58:23 +0800
Message-Id: <1636444705-17883-1-git-send-email-lh.kuo@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635487055-18494-1-git-send-email-lh.kuo@sunplus.com>
References: <1635487055-18494-1-git-send-email-lh.kuo@sunplus.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

	This is a patch series for SD/SDIO driver for Sunplus SP7021 SoC.										
											
	Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates										
	many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and										
	etc.) into a single chip. It is designed for industrial control.										
											
	Refer to:										
	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview										
	https://tibbo.com/store/plus1.html	

LH.Kuo (2):
  mmc: Add SD/SDIO driver for Sunplus SP7021
  devicetree bindings mmc Add bindings doc for Sunplus SP7021

 .../devicetree/bindings/mmc/sunplus-sd2.yaml       |   82 ++
 MAINTAINERS                                        |    7 +
 drivers/mmc/host/Kconfig                           |   10 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/sunplus_sd2.c                     | 1068 ++++++++++++++++++++
 drivers/mmc/host/sunplus_sd2.h                     |  155 +++
 6 files changed, 1323 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
 create mode 100644 drivers/mmc/host/sunplus_sd2.c
 create mode 100644 drivers/mmc/host/sunplus_sd2.h

-- 
2.7.4

