From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] fix mmc hang during boot on socfpga
Date: Tue, 9 Sep 2014 10:32:14 -0700
Message-ID: <CAOesGMgvqvQw2WzdQWQ7NSE_CKgH0MR-46UABkck0cQbpV4P=g@mail.gmail.com>
References: <20140909121902.GA22965@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:45646 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbaIIRcQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Sep 2014 13:32:16 -0400
Received: by mail-la0-f44.google.com with SMTP id mc6so4592017lab.3
        for <linux-mmc@vger.kernel.org>; Tue, 09 Sep 2014 10:32:14 -0700 (PDT)
In-Reply-To: <20140909121902.GA22965@amd>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>

On Tue, Sep 9, 2014 at 5:19 AM, Pavel Machek <pavel@ucw.cz> wrote:
>
> Without this patch, boot hangs when trying to mount root filesystem on
> socfpga platform in about 50% cases.

I think this should have a better description than this -- this is too
vague. Did it use to always work, is this a new failure? You enable
some more error checking and improved stop handling, why was the
previous one inadequate on this platform?


-Olof
