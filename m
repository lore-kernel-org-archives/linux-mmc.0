From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH v2 0/3] provide sdhci driver for mmp2 and pxa910
Date: Wed, 25 May 2011 05:22:23 -0400
Message-ID: <BANLkTikyrZYZOct1ZFv8-FOJKAbyo-TwtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50979 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab1EYJWY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2011 05:22:24 -0400
Received: by vws1 with SMTP id 1so5624523vws.19
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2011 02:22:23 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, linux-mmc@vg

Here are patches to provide separate sdhci driver for mmp2 and pxa910
based on sdhci-platfm.
Remove sdhci-pxa.c, which is used to share among pxa serious, since
under this method, platform difference have to be put under arch/arm,
which is not easy to track.
As a result, mmp2 mmc resource should be updated accordingly.

The patches verified after Shawn's modification to sdhci-platfm.c.
