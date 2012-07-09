From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH v1 5/5] mmc: card: Add RPMB support in IOCTL interface
Date: Mon, 9 Jul 2012 19:54:06 +0200
Message-ID: <CA+20K0CpZqD6ngCKf+VnatsSpHmX2P75v-DcGQwsXVRUevUruQ@mail.gmail.com>
References: <1341564244-6178-1-git-send-email-loic.pallardy@stericsson.com>
	<1341564244-6178-6-git-send-email-loic.pallardy@stericsson.com>
	<CACRpkdZXStms8tnsUDKp-TxWMFNt-m6USAM1Gcp3X8Ttp7hhXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:41732 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab2GIRyH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jul 2012 13:54:07 -0400
Received: by ghrr11 with SMTP id r11so10375108ghr.19
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jul 2012 10:54:07 -0700 (PDT)
In-Reply-To: <CACRpkdZXStms8tnsUDKp-TxWMFNt-m6USAM1Gcp3X8Ttp7hhXg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Loic Pallardy <loic.pallardy@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Alex Macro <alex.macro@stericsson.com>

2012/7/8 Linus Walleij <linus.walleij@linaro.org>:
> On Fri, Jul 6, 2012 at 10:44 AM, Loic Pallardy
> <loic.pallardy@stericsson.com> wrote:
>
>> RPMB partition is accessing though /dev/block/mmcXrpmb device
>> User callers can read and write entire data frame(s) as defined
>> by JEDEC Standard JESD84-A441, using standard IOCTL interface.
>>
>> Signed-off-by: Alex Macro <alex.macro@stericsson.com>
>> Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Johan Rudholm <johan.rudholm@stericsson.com>
