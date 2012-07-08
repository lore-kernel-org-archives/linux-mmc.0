From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 4/5] mmc: core: Add mmc_set_blockcount feature
Date: Sun, 8 Jul 2012 21:20:08 +0200
Message-ID: <CACRpkdYYgPviMzTvtBfWmbM0CWDrwMpVrjn+Dscwx6X_xaZMuA@mail.gmail.com>
References: <1341564244-6178-1-git-send-email-loic.pallardy@stericsson.com>
	<1341564244-6178-5-git-send-email-loic.pallardy@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:55896 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab2GHTUJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Jul 2012 15:20:09 -0400
Received: by qcro28 with SMTP id o28so6340929qcr.19
        for <linux-mmc@vger.kernel.org>; Sun, 08 Jul 2012 12:20:08 -0700 (PDT)
In-Reply-To: <1341564244-6178-5-git-send-email-loic.pallardy@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Loic Pallardy <loic.pallardy@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Alex Macro <alex.macro@stericsson.com>

On Fri, Jul 6, 2012 at 10:44 AM, Loic Pallardy
<loic.pallardy@stericsson.com> wrote:

> Provide support for automatically sending Set Block Count
> (CMD23) messages. Used at least for RPMB support.
>
> Signed-off-by: Alex Macro <alex.macro@stericsson.com>
> Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
