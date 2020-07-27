Return-Path: <SRS0=9Cpo=BG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A83C433E5
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jul 2020 13:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8A42083B
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jul 2020 13:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595857123;
	bh=bafirt8eG3bAnhbQomJL+lbC7o7oaIUWDBgbxYPMyAg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HnvkbwJyIyL4kvSJIOWmQAhr5dUzgDuk0DbvNZLslzgiuVhAecPBa7I3Ha+4yiuh8
	 chfac5c4VFMbqMSOUMikc4KIwcNCN2uApONK860hNa/8LXyPMP1UEXYomwVjjVc9HH
	 4zX8iJM87dNYyOSPOym+xR3Pgp3M40uFd2/golq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgG0Nin (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgG0Nim (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 27 Jul 2020 09:38:42 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E108D2083B;
        Mon, 27 Jul 2020 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595857122;
        bh=bafirt8eG3bAnhbQomJL+lbC7o7oaIUWDBgbxYPMyAg=;
        h=From:To:Cc:Subject:Date:From;
        b=KGLmBxyvMfNqEUSklx4QhC+8mySEiRI2Q54CN8T21jpd4DzJmNjUsF3lxgIRzhmKW
         ikjM6sgC++lkpv6Ni9ZougW/B1j3QBCzHUlCg3VR+7EkxGP6PUSABVahohM9nmTP1V
         9YIqo9bf4mZHaG4Ws8Ym/c4CuOp5qco11wRfhv9o=
Received: by pali.im (Postfix)
        id 9020FC89; Mon, 27 Jul 2020 15:38:39 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] mmc: sdio: Export CISTPL_VERS_1 attributes to userspace
Date:   Mon, 27 Jul 2020 15:38:33 +0200
Message-Id: <20200727133837.19086-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

CISTPL_VERS_1 structure contains useful information for identification
of SDIO cards. It contains revision number according to which standard
is SDIO card compliant. And also it contain human readable info strings
which should contain manufacturer name or product information, like for
old PCMCIA cards. SDIO simplified specification 3.00 just contain
reference to PCMCIA metaformat specification for definition of that
CISTPL_VERS_1 structure itself.

Human readable SDIO card strings can be useful for userspace to do card
identification. Until now kernel exported to userspace only vendor and
device numbers but these numbers do not help to identify new or unknown
cards.


I have tested these patches with Marwell 88W8997 SDIO card (WiFi+Bluetooth)
and here is content of attributes available in userspace:

$ grep . /sys/class/mmc_host/mmc0/mmc0:0001/* /sys/class/mmc_host/mmc0/mmc0:0001/*/*
/sys/class/mmc_host/mmc0/mmc0:0001/device:0x9140
/sys/class/mmc_host/mmc0/mmc0:0001/info1:Marvell
/sys/class/mmc_host/mmc0/mmc0:0001/info2:Wireless Device ID: 50
/sys/class/mmc_host/mmc0/mmc0:0001/ocr:0x00200000
/sys/class/mmc_host/mmc0/mmc0:0001/rca:0x0001
/sys/class/mmc_host/mmc0/mmc0:0001/revision:1.0
/sys/class/mmc_host/mmc0/mmc0:0001/type:SDIO
/sys/class/mmc_host/mmc0/mmc0:0001/uevent:MMC_TYPE=SDIO
/sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_ID=02DF:9140
/sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_REVISION=1.0
/sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_INFO1=Marvell
/sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_INFO2=Wireless Device ID: 50
/sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_INFO3=
/sys/class/mmc_host/mmc0/mmc0:0001/vendor:0x02df
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/class:0x00
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/device:0x9141
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/info1:Marvell WiFi Device
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/modalias:sdio:c00v02DFd9141
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/revision:1.0
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:DRIVER=mwifiex_sdio
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_CLASS=00
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_ID=02DF:9141
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_REVISION=1.0
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_INFO1=Marvell WiFi Device
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_INFO2=
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:MODALIAS=sdio:c00v02DFd9141
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/vendor:0x02df
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/class:0x00
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/device:0x9142
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/info1:Marvell Bluetooth Device
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/modalias:sdio:c00v02DFd9142
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/revision:1.0
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:DRIVER=btmrvl_sdio
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_CLASS=00
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_ID=02DF:9142
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_REVISION=1.0
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_INFO1=Marvell Bluetooth Device
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_INFO2=
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:MODALIAS=sdio:c00v02DFd9142
/sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/vendor:0x02df
/sys/class/mmc_host/mmc0/mmc0:0001/power/control:auto
/sys/class/mmc_host/mmc0/mmc0:0001/power/runtime_active_time:0
/sys/class/mmc_host/mmc0/mmc0:0001/power/runtime_status:unsupported
/sys/class/mmc_host/mmc0/mmc0:0001/power/runtime_suspended_time:0
/sys/class/mmc_host/mmc0/mmc0:0001/subsystem/drivers_autoprobe:1

As can be seen SDIO card does not provide all 4 info strings as required by
SDIO/PCMCIA specificaion and the third and the second strings are empty.


Pali Rohár (4):
  mmc: sdio: Check for CISTPL_VERS_1 buffer size
  mmc: sdio: Parse CISTPL_VERS_1 major and minor revision numbers
  mmc: sdio: Extend sdio_config_attr macro and use it also for modalias
  mmc: sdio: Export SDIO revision and info strings to userspace

 drivers/mmc/core/bus.c        | 12 ++++++++
 drivers/mmc/core/sd.c         | 36 +++++++++++++++++++++--
 drivers/mmc/core/sdio.c       | 24 ++++++++++++++++
 drivers/mmc/core/sdio_bus.c   | 54 ++++++++++++++++++++++++++---------
 drivers/mmc/core/sdio_cis.c   | 11 +++++++
 include/linux/mmc/card.h      |  2 ++
 include/linux/mmc/sdio_func.h |  2 ++
 7 files changed, 124 insertions(+), 17 deletions(-)

-- 
2.20.1

