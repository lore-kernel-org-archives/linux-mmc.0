Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD075E71D2B
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Sep 2023 13:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjI2NAq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Sep 2023 09:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjI2NAq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Sep 2023 09:00:46 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9ADC0
        for <linux-mmc@vger.kernel.org>; Fri, 29 Sep 2023 06:00:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qmD6c-00045v-Ns; Fri, 29 Sep 2023 15:00:30 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qmD6a-009ojK-AN; Fri, 29 Sep 2023 15:00:28 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qmD6a-00C1Dp-7z; Fri, 29 Sep 2023 15:00:28 +0200
Date:   Fri, 29 Sep 2023 15:00:28 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Ye Bin <yebin10@huawei.com>, linux-mmc@vger.kernel.org,
        kernel@pengutronix.de
Subject: mmc: handling of Under-Voltage Events in eMMC
Message-ID: <20230929130028.GB2825985@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

I'm working on a project aiming to protect eMMC during power loss. Our
hardware setup includes an under-voltage detector, circuits to disable
non-critical components, and enough capacitance to allow the CPU to run
for 100ms.

I've added an interrupt handler to the fixed regulator to emit
REGULATOR_EVENT_UNDER_VOLTAGE events, and modified
drivers/mmc/host/sdhci.c to receive these events. Currently, the handler
only produces debug output.

What is the recommended approach for handling under-voltage situations?
Should the driver finish ongoing write commands, block new ones, and
shut down the eMMC? I'm looking for direction here.

Thanks,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
