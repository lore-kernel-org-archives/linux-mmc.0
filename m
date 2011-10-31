From: Jun Nie <niej0001@gmail.com>
Subject: Question: kick SDIO irq when resume
Date: Mon, 31 Oct 2011 13:50:51 +0800
Message-ID: <CAGA24MKE-FLRBk2zHk_Wy2Apg8-epC6Q38W2csTs7YSN1gHzhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62011 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676Ab1JaFuv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Oct 2011 01:50:51 -0400
Received: by ggnb1 with SMTP id b1so5551911ggn.19
        for <linux-mmc@vger.kernel.org>; Sun, 30 Oct 2011 22:50:51 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>, Bing Zhao <bzhao@marvell.com>, frankh@marvell.com, yongd@marvell.com, tianfh@marvell.com, njun@marvell.com
Cc: linux-mmc@vger.kernel.org

Hi Nico,
    We are debugging fake SDIO irq when 8787 SDIO card resume and
found below patch. The issue is that 8787 driver can not handle card
irq if neither 8787 nor host trigger resume event in some cases. Do
you remember what SDIO card need below patch? What's your idea on this
issue? How about add a SDIO function flag to decide the irq thread
kick off in resume?
    Thanks!


commit 40216842dca4fa485cb1aa5eb231149a4a57cc85
Author: Nicolas Pitre <nico@fluxnic.net>
Date:   Fri Mar 5 13:43:34 2010 -0800

    sdio: kick the interrupt thread upon a resume

Jun
