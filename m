From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v3 0/1] mmc: omap_hsmmc: devm_pinctrl_get returns ERR_PTR
Date: Tue, 19 Apr 2016 23:04:12 +0200
Message-ID: <1461099853-15011-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:32825 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932377AbcDSVEX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 17:04:23 -0400
Received: by mail-wm0-f49.google.com with SMTP id 127so7467198wmz.0
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2016 14:04:22 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Andreas Fenkart <afenkart@gmail.com>

These are prevous submits:
v1: http://www.spinics.net/lists/linux-mmc/msg35861.html
v2: http://www.spinics.net/lists/linux-mmc/msg35869.html

Both patches tried to check for NULL and ERR_PTR, which makes the check verbose,
or loses the error code in ERR_PTR.  This patch tries to make hard dependency on
pinctrl.

The driver itself does not require pinctrl to work. The pinctrl_pm_select_*
calls in runtime suspend/resume can be dummies. The code section that needs
pinctrl functions, is used to give users a heads up, that requred pinctrl states
are missing. These are needed for the swakeup workaround. But technically the pm
layer selects them.

So pinctrl is needed for user feedback and only on those chips requiring the
SWAKEUP workaround. Most chips don't require that workaround, forcing pinctrl
for those might/might not be invasive.

Select pinctrl in the drivers Kconfig section only selects only the core layer,
which does nothing without an actual driver. Depending on pinctrl will break
keystone, that doesn't have pinctrl selected.

I chose 'select pinctrl' in Kconfig, since keystone and others will not
notice the change. 

v3:
- use select pinctrl in Kconf

v2:
- addressed issues from review
- race-condition issue discussed in patch description

Andreas Fenkart (1):
  mmc: omap_hsmmc: devm_pinctrl_get returns ERR_PTR upon error

 drivers/mmc/host/Kconfig      | 1 +
 drivers/mmc/host/omap_hsmmc.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.8.0.rc3

