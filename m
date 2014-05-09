From: Grant Grundler <grundler@chromium.org>
Subject: Re: [RFC PATCH 1/1 v6 ]mmc: Support-FFU-for-eMMC-v5.0
Date: Fri, 9 May 2014 11:06:34 -0700
Message-ID: <CANEJEGu3e9eMB5qxHXAyWGDbECi4P77sv+SZWr8c9WkKFsd4tw@mail.gmail.com>
References: <FDD07FEB422EF948A392FDC201AEEAE641188997@SACMBXIP01.sdcorp.global.sandisk.com>
	<CANEJEGvPyHhWDSykx_zdEiA7WOYMkFtDwWjhF9kjo-7+Hp_EYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:56073 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465AbaEISGe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 May 2014 14:06:34 -0400
Received: by mail-oa0-f45.google.com with SMTP id l6so5377984oag.32
        for <linux-mmc@vger.kernel.org>; Fri, 09 May 2014 11:06:34 -0700 (PDT)
In-Reply-To: <CANEJEGvPyHhWDSykx_zdEiA7WOYMkFtDwWjhF9kjo-7+Hp_EYQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>

follow up on "malformed patch" problem:

On Fri, May 9, 2014 at 9:44 AM, Grant Grundler <grundler@chromium.org> wrote:
...
>> diff --git a/include/linux/mmc/ffu.h b/include/linux/mmc/ffu.h new file mode 100644 index 0000000..be70880
>
> This diff line "looks correct" to me. But pwclient reported this error:
> $ pwclient list -p linux-mmc -w "Avi Shchislowski"
> Patches submitted by Avi Shchislowski <Avi.Shchislowski@sandisk.com>:
> ...
> 4039281 New          [RFC,1/1,v6] mmc: Support-FFU-for-eMMC-v5.0
> ...
> $ pwclient apply 4039281
> ...
> patching file drivers/mmc/card/ffu.c
> patch: **** malformed patch at line 678: diff --git
> a/include/linux/mmc/ffu.h b/include/linux/mmc/ffu.h new file mode
> 100644 index 0000000..be70880


678 turned out to be this part of the (new code) ffu.h patch:
+ * the Free Software Foundation; either version 2 of the License, or =

+(at
+ * your option) any later version.

I'm just guessing: This looks like a "=" line extension somehow landed
in the code and was picked up by the patch. pwclient appears to know
how to deal with "=" at the end of the line otherwise.

cheers
grant
