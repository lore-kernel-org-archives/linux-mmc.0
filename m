From: "C. B." <cbrookes@gmail.com>
Subject: Baytrail MMC Hang
Date: Mon, 4 Jan 2016 19:33:16 -0600
Message-ID: <CAAzPvNzT7XFOU5-NX7mdD00Mqb1eFJzJ6xJUZTECrG--GpzfSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:34972 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbcAEBdR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jan 2016 20:33:17 -0500
Received: by mail-lb0-f195.google.com with SMTP id tz10so17498662lbb.2
        for <linux-mmc@vger.kernel.org>; Mon, 04 Jan 2016 17:33:17 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

Re:https://lkml.org/lkml/2015/3/24/271

>Adrian Hunter wrote:
>Here are some patches to address an issue with SDHCI in Intel Baytrail. Intel Baytrail has >been observed sometimes to hang if host controllers are using DMA while deep C-states are >used

I have been attempting to run Linux on a Baytrail based Dell Venue 8
Pro. It mostly works but there are MMC issues which cause a hang. If I
boot with intel_idle.max_cstate=0 it works flawlessly , and without
that, I can reliably crash it with a couple of minutes worth of dd
if=/dev/mmcblk0 | pv > /dev/null.

I am presently running Kernel 4.4.0-rc6 so it seems like these patches
may never have got in to the main kernel?  Are these patches likely to
apply easily to a 4.4 tree, or do they rely upon stuff inside the
"driver strength" and "re-tuning" patches? I'm sure they wouldn't
apply cleaning by now but if they were stitched in "by hand", so to
speak..?

Cheers

CB
