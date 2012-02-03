From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [RESEND PATCH V3] mmc: core: Detect card removal on I/O error
Date: Fri, 3 Feb 2012 18:46:43 +0900
Message-ID: <CAKYAXd_a0rwRxcee1CH0TPMc0uQT99N0f3z8vX7AfgXjZryusg@mail.gmail.com>
References: <1328261593-6112-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55610 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab2BCJqo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2012 04:46:44 -0500
Received: by bkcjm19 with SMTP id jm19so2903738bkc.19
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2012 01:46:43 -0800 (PST)
In-Reply-To: <1328261593-6112-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@intel.com>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

2012/2/3 Ulf Hansson <ulf.hansson@stericsson.com>:
> To prevent I/O as soon as possible at card removal, a new
> detect work is re-scheduled without a delay to let a rescan
> remove the card device as soon a possible.
>
> Additionally, MMC_CAP2_DETECT_ON_ERR can now be used to handle
> "slowly" removed cards that a scheduled detect work did not
> detect as removed. To prevent further I/O requests for these
> lingering removed cards, check if card has been removed and then
> schedule a detect work to properly remove it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>

Hi. Ulf.
Looks good to me.
Thanks.
> ---
