From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 5/5] mmc: card: Add RPMB support in IOCTL interface
Date: Sun, 8 Jul 2012 21:22:04 +0200
Message-ID: <CACRpkdZXStms8tnsUDKp-TxWMFNt-m6USAM1Gcp3X8Ttp7hhXg@mail.gmail.com>
References: <1341564244-6178-1-git-send-email-loic.pallardy@stericsson.com>
	<1341564244-6178-6-git-send-email-loic.pallardy@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:55256 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab2GHTWF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Jul 2012 15:22:05 -0400
Received: by qadb17 with SMTP id b17so1271338qad.19
        for <linux-mmc@vger.kernel.org>; Sun, 08 Jul 2012 12:22:04 -0700 (PDT)
In-Reply-To: <1341564244-6178-6-git-send-email-loic.pallardy@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Loic Pallardy <loic.pallardy@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Alex Macro <alex.macro@stericsson.com>

On Fri, Jul 6, 2012 at 10:44 AM, Loic Pallardy
<loic.pallardy@stericsson.com> wrote:

> RPMB partition is accessing though /dev/block/mmcXrpmb device
> User callers can read and write entire data frame(s) as defined
> by JEDEC Standard JESD84-A441, using standard IOCTL interface.
>
> Signed-off-by: Alex Macro <alex.macro@stericsson.com>
> Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
