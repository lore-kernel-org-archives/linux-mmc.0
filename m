From: Da Shi Cao <dscao999@gmail.com>
Subject: unrecognised SCR structure version when using beaglebone black MMC0
Date: Mon, 23 Mar 2015 23:01:41 +0800
Message-ID: <CAG3POBmJnZvzwsnXuZBKqEw=XnT+b-20RddaJ6nVaxw9G-fAGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:36683 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbbCWPBx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Mar 2015 11:01:53 -0400
Received: by qgez102 with SMTP id z102so59900400qge.3
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2015 08:01:52 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Da Shi Cao <dscao999@gmail.com>

When using my stripped version of kernel (3.18.9), the MMC0 will
sometimes complain "unrecognized SCR structure..." when a microSD is
inserted. This is because the driver function "omap_hsmmc_request"
will always return garbage when called by "mmc_app_send_scr".
I didn't experienced this issue while using the OS shipped with the board.
I'd like to know where I may be wrong.

Thanks,
Thomas
