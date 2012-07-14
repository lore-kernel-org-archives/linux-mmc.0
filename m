From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/5] mmc: card: Do not scan RPMB partitions
Date: Sat, 14 Jul 2012 22:25:50 +0200
Message-ID: <CACRpkdaErwNUYKsY+y23ONMk3V6kS0EQ7s+aLVBox5RA+hFw0A@mail.gmail.com>
References: <1342011675-11221-1-git-send-email-loic.pallardy-ext@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:37814 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab2GNUZv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 14 Jul 2012 16:25:51 -0400
Received: by qaas11 with SMTP id s11so954151qaa.19
        for <linux-mmc@vger.kernel.org>; Sat, 14 Jul 2012 13:25:50 -0700 (PDT)
In-Reply-To: <1342011675-11221-1-git-send-email-loic.pallardy-ext@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Loic Pallardy <loic.pallardy-ext@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Loic Pallardy <loic.pallardy@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>

On Wed, Jul 11, 2012 at 3:01 PM, Loic Pallardy
<loic.pallardy-ext@stericsson.com> wrote:

> From: Loic Pallardy <loic.pallardy@stericsson.com>
>
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
