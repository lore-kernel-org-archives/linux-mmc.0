From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/5] mmc: core: Expose access to RPMB partition
Date: Sun, 8 Jul 2012 21:17:52 +0200
Message-ID: <CACRpkdb7JbOpEBYEsbe0OgH0com=eTfv-dnqz+XCDtyjTaAGPQ@mail.gmail.com>
References: <1341564244-6178-1-git-send-email-loic.pallardy@stericsson.com>
	<1341564244-6178-2-git-send-email-loic.pallardy@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:51755 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab2GHTRx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Jul 2012 15:17:53 -0400
Received: by qadb17 with SMTP id b17so1270305qad.19
        for <linux-mmc@vger.kernel.org>; Sun, 08 Jul 2012 12:17:52 -0700 (PDT)
In-Reply-To: <1341564244-6178-2-git-send-email-loic.pallardy@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Loic Pallardy <loic.pallardy@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Alex Macro <alex.macro@stericsson.com>

On Fri, Jul 6, 2012 at 10:44 AM, Loic Pallardy
<loic.pallardy@stericsson.com> wrote:

> Following JEDEC standard, if the mmc support RPMB partition,
> a new interface is created and exposed via /dev/block.
> Users will be able to access RPMB partition using standard
> mmc IOCTL command.
>
> Signed-off-by: Alex Macro <alex.macro@stericsson.com>
> Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
