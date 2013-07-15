From: Grant Grundler <grundler@google.com>
Subject: Bug in mmc_start_req() ?
Date: Mon, 15 Jul 2013 11:20:06 -0700
Message-ID: <CANEJEGs1Ke4bE+j+abBj8=NGuQxDXnL+P1NtpRauZYdB614mMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:44020 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab3GOSUH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jul 2013 14:20:07 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so14315650obb.11
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jul 2013 11:20:06 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

I don't understand all the implications...but my gut feeling is this
change is necessary. Can someone please explain why I'm wrong?

(key here is to use "err || start_err" - same logic as a few lines
above to call mmc_post_req(...-EINVAL))

-       if (err)
-               host->areq = NULL;
-       else
-               host->areq = areq;
+       host->areq = (err || start_err) ? NULL : areq;

If someone agrees, I'll post a proper patch.

thanks,
grant
