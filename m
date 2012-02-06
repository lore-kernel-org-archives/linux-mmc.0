From: loody <miloody@gmail.com>
Subject: Fwd: how to trigger /proc/sys/kernel/hotplug
Date: Mon, 6 Feb 2012 11:57:08 +0800
Message-ID: <CANudz+se9iXBROD_1-Zn1jp0gZ9wRjPnj9Xp6ttL2at9az_jEA@mail.gmail.com>
References: <CANudz+s=DRjUpKBVoLpZKwfJEbPJJR-2yz6+Wjdbywe5tSLKtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:51155 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753204Ab2BFD5I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Feb 2012 22:57:08 -0500
Received: by obcva7 with SMTP id va7so6294914obc.19
        for <linux-mmc@vger.kernel.org>; Sun, 05 Feb 2012 19:57:08 -0800 (PST)
In-Reply-To: <CANudz+s=DRjUpKBVoLpZKwfJEbPJJR-2yz6+Wjdbywe5tSLKtg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

hi all:
I cat "/sbin/mdev" to /proc/sys/kernel/hotplug, but the mdev is not
been called when my sd card plug in.
But it will be called when usb devices plug in, so I think kernel
configs about hotplog is ok.

Is there any additional configs or driver api I need to select and
implement especially for sd card?


--
Thanks for your help,


-- 
Regards,
