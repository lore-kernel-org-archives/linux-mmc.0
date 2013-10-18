From: Grant Grundler <grundler@chromium.org>
Subject: dw_mmc: priv->sdr_timing set wrong
Date: Fri, 18 Oct 2013 13:13:44 -0700
Message-ID: <CANEJEGt+kx3_EjgBGxkZ9TJec9ngf=FOcwhg2+eAtPY9-2xxCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:46931 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab3JRUNp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2013 16:13:45 -0400
Received: by mail-oa0-f41.google.com with SMTP id o9so3126450oag.14
        for <linux-mmc@vger.kernel.org>; Fri, 18 Oct 2013 13:13:45 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, ALIM AKHTAR <alim.akhtar@samsung.com>, Douglas Anderson <dianders@chromium.org>

Chris, Yuvaraj, Alim, Jaehoon,

This patch is wrong:
https://git.kernel.org/cgit/linux/kernel/git/cjb/mmc.git/commit/?h=mmc-next&id=e6c784eded7b39caeaf2e9206336fa1daeccfd09

sdr_timing needs to come from the of_property "samsung,dw-mshc-sdr-timing".
Assignment of priv->sdr_timing needs to move back where it was before.

Can one of you guys "just fix it" or do you need a patch from me (or Sonny)?

(This came up during my review of eMMC patches that sonny is
backporting to ChromeOS-3.8 kernel and I'm not done yet - have a ton
more to do here.)

thanks,
grant
