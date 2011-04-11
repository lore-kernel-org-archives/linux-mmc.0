From: Andrei Warkentin <andreiw@motorola.com>
Subject: SanDisk 4.3+ iNAND eMMC devices TRIM bug workaround.
Date: Mon, 11 Apr 2011 17:20:39 -0500
Message-ID: <1302560441-10565-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:39148 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755928Ab1DKVlk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 17:41:40 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3BLg1kX018837
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 17:42:01 -0400 (EDT)
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3BLg0M7018834
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 17:42:01 -0400 (EDT)
Received: by gwb17 with SMTP id 17so3891901gwb.15
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 14:41:38 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org

This fixes the out-of-spec erase/trim support. CMD38 argument
is passed through an EXT_CSD byte instead of as the command
argument. This has the effect that trims act as group erases,
erasing more data than necessary. Secure trims/erases were also affected.

N.B. This depends on the mmc_switch patch from the earlier boot partition
patchset (MMC: Allow setting CMD timeout for CMD6 (SWITCH)). This also
depends on the update core/quirks.c code.

ToC:
[PATCH 1/2] MMC: Support for block quirks.
[PATCH 2/2] MMC: Fix erase/trim for certain SanDisk cards.

A
