From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH V4 1/4] mmc: core: Stop bkops for eMMC only from mmc suspend
Date: Sun, 26 May 2013 10:22:46 +0800
Message-ID: <CAMj5BkiFcH2s42kB7DZ=tk36A6fzr8EwbxRNLMDhUdfKEPRFPw@mail.gmail.com>
References: <1367496159-7090-1-git-send-email-ulf.hansson@stericsson.com>
	<1367496159-7090-2-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:45403 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758816Ab3EZCWs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 25 May 2013 22:22:48 -0400
Received: by mail-ee0-f52.google.com with SMTP id c13so3249967eek.11
        for <linux-mmc@vger.kernel.org>; Sat, 25 May 2013 19:22:47 -0700 (PDT)
In-Reply-To: <1367496159-7090-2-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, Maya Erez <merez@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Liu <kliu5@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>, Daniel Drake <dsd@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

On Thu, May 2, 2013 at 8:02 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
>
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Move mmc suspend specific operations to be executed from the .suspend
> callback in the mmc bus_ops. This simplifies the mmc_suspend_host
> function which is supposed to handle nothing but common suspend tasks.
>
> Since eMMC can be considered non-removable there are no need to check
> for ongoing bkops at PM_SUSPEND_PREPARE notification so remove it.


Sorry, a bit confused about this desc.
How about mmc card, which can be removable.
