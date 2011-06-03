From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 0/3] provide sdhci driver for mmp2 and pxa910
Date: Fri, 3 Jun 2011 18:20:51 +0200
Message-ID: <201106031820.51922.arnd@arndb.de>
References: <BANLkTikP72ybaqa8zDgNjBQg8Q6SH5fMdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56598 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716Ab1FCQVF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jun 2011 12:21:05 -0400
In-Reply-To: <BANLkTikP72ybaqa8zDgNjBQg8Q6SH5fMdw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Qiming Wu <wuqm@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Friday 03 June 2011, zhangfei gao wrote:
> Here are patches to provide separate sdhci driver for mmp2 and pxa910
> based on sdhci-platfm.
> Rename to sdhci-pxav3.c and sdhci-pxav2.c
> Remove sdhci-pxa.c, which is used to share among pxa serious, since
> under this method, platform difference have to be put under arch/arm,
> which is not easy to track.
> As a result, mmp2 mmc resource should be updated accordingly.

Looks all good content-wise. I do have a few comments regarding the
style of submission, please follow that the next time:

* Make all patches a reply to the  [PATCH 0/x] email, so they show up
  as a single thread. This helps finding the emails when your mail 
  client sorts threads by last reply. The option in git-send-email
  is '--thread --no-chain-reply'.

* The changelog has extra spaces in it that shouldn't be there. I assume
  they come from using git-show instead of git-format-patch to create
  the emails.

* Make sure a series is bisectable. This means that each patch results
  in a working kernel without regressions when you apply only part of
  the series. There are multiple ways to get there. In this case, you
  could fold the patch that updates the resources into the patch that
  changes the format. Alternatively, you could first create the new driver
  in the new format, then change the resources, and finally remove the
  now obsolete driver.

	Arnd
