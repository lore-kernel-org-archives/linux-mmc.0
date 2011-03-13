From: Andrei Warkentin <andreiw@motorola.com>
Subject: MMC quirks support.
Date: Sun, 13 Mar 2011 08:48:36 -0500
Message-ID: <1300024118-23771-1-git-send-email-andreiw@motorola.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og116.obsmtp.com ([64.18.0.147]:34953 "EHLO
	exprod5og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754605Ab1CMNFf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Mar 2011 09:05:35 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2DD4B4w016880
	for <linux-mmc@vger.kernel.org>; Sun, 13 Mar 2011 09:04:11 -0400 (EDT)
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com [209.85.160.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2DD4Axa016876
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sun, 13 Mar 2011 09:04:11 -0400 (EDT)
Received: by gyb11 with SMTP id 11so1008417gyb.15
        for <linux-mmc@vger.kernel.org>; Sun, 13 Mar 2011 06:05:33 -0700 (PDT)
In-Reply-To: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: tardyp@gmail.com, linus.walleij@linaro.org, arnd@arndb.de

This is the third version of the patch set that adds MMC block. Omitting
the Toshiba quirks for now as I need to revalidate the data behind the quirks.

Table of Contents:
[PATCH 1/2] MMC: Extends card quicks with MMC/SD quirks matching the CID.
[PATCH 2/2] MMC: Support for block quirks.

Thanks,
A
