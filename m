From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 2/5] mmc: card: Do not scan RPMB partitions
Date: Sun, 8 Jul 2012 21:18:44 +0200
Message-ID: <CACRpkdZVj6vmm1YJyCMT_JceO=b52CPxAMUqQEow7-fvEfQPaA@mail.gmail.com>
References: <1341564244-6178-1-git-send-email-loic.pallardy@stericsson.com>
	<1341564244-6178-3-git-send-email-loic.pallardy@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:38697 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab2GHTSp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Jul 2012 15:18:45 -0400
Received: by qaas11 with SMTP id s11so1272163qaa.19
        for <linux-mmc@vger.kernel.org>; Sun, 08 Jul 2012 12:18:44 -0700 (PDT)
In-Reply-To: <1341564244-6178-3-git-send-email-loic.pallardy@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Loic Pallardy <loic.pallardy@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Johan Rudholm <johan.rudholm@stericsson.com>

On Fri, Jul 6, 2012 at 10:44 AM, Loic Pallardy
<loic.pallardy@stericsson.com> wrote:

> Do not scan rpmb partitions for "soft" partitions, since the rpmb
> partition contains protected data. Silences the following
> message during boot:
>
>  mmcblkXRPMB: unknown partition table
>
> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
