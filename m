From: nits ambastha <nits.ambastha@gmail.com>
Subject: TI OMAP3430 Host controller query
Date: Thu, 20 May 2010 15:58:13 +0530
Message-ID: <AANLkTinAKrIhGxCPeQ2QR-JYnv7GLepdX-itA0d_4ost@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f227.google.com ([209.85.217.227]:44509 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab0ETK2O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 May 2010 06:28:14 -0400
Received: by gxk27 with SMTP id 27so5102034gxk.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 May 2010 03:28:13 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi

I was referring to the OMAP3430 Host controller in 2.6.29.4 kernel for
some study purpose and have some queries related to it.
The card insertion/removal interrupt handler invokes a workqueue
function mmc_omap_detect() which calls mmc_detect_change i.e process
change of state on a MMC socket where we schedule a workqueue function
at host->detect with some delay.
This delay time is different for insertion/removal scenarios.
Can anyone please clarify me why do we have different delays in
insertion/removal? Does it have any specific reason?

Thanks
Nitish
