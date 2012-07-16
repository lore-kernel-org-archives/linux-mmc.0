From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v2 2/5] mmc: card: Do not scan RPMB partitions
Date: Mon, 16 Jul 2012 22:25:36 +0900
Message-ID: <CAKYAXd8Ztfrb4798PH-71z=b5DS3n7oL3Z2SfEJwuGLieFP8sg@mail.gmail.com>
References: <1342011675-11221-1-git-send-email-loic.pallardy-ext@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:62519 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319Ab2GPNZh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jul 2012 09:25:37 -0400
Received: by wgbfm10 with SMTP id fm10so2391793wgb.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jul 2012 06:25:36 -0700 (PDT)
In-Reply-To: <1342011675-11221-1-git-send-email-loic.pallardy-ext@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Loic Pallardy <loic.pallardy-ext@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Loic Pallardy <loic.pallardy@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>

2012/7/11, Loic Pallardy <loic.pallardy-ext@stericsson.com>:
> From: Loic Pallardy <loic.pallardy@stericsson.com>
>
> Do not scan rpmb partitions for "soft" partitions, since the rpmb
> partition contains protected data. Silences the following
> message during boot:
>
>  mmcblkXRPMB: unknown partition table
>
> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
Looks good to me.
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
You sent only 2/5 patch...
Would you resend all v2 patches after including tag linus's ack and my
reviewed-by ?
Thanks.
> ---
