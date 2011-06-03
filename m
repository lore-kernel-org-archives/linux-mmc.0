From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH v3 0/3] provide sdhci driver for mmp2 and pxa910
Date: Fri, 3 Jun 2011 17:48:50 +0800
Message-ID: <BANLkTikP72ybaqa8zDgNjBQg8Q6SH5fMdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60510 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab1FCJsv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jun 2011 05:48:51 -0400
Received: by vws1 with SMTP id 1so1263371vws.19
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jun 2011 02:48:50 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, linux-mmc@vg

v2->v3, modify according to Arnd and Philip suggestion.

Here are patches to provide separate sdhci driver for mmp2 and pxa910
based on sdhci-platfm.
Rename to sdhci-pxav3.c and sdhci-pxav2.c
Remove sdhci-pxa.c, which is used to share among pxa serious, since
under this method, platform difference have to be put under arch/arm,
which is not easy to track.
As a result, mmp2 mmc resource should be updated accordingly.
