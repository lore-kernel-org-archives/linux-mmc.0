From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 1/4] mmc: core: Stop bkops for eMMC only from mmc suspend
Date: Mon, 27 May 2013 09:26:34 +0200
Message-ID: <CAPDyKFrzF8nGO7Ow+GK-W8W4CYZDBpaEw5mNZWFC01vTEZc83Q@mail.gmail.com>
References: <1367496159-7090-1-git-send-email-ulf.hansson@stericsson.com>
	<1367496159-7090-2-git-send-email-ulf.hansson@stericsson.com>
	<CAMj5BkiFcH2s42kB7DZ=tk36A6fzr8EwbxRNLMDhUdfKEPRFPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f54.google.com ([209.85.212.54]:42029 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756651Ab3E0H0f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 May 2013 03:26:35 -0400
Received: by mail-vb0-f54.google.com with SMTP id f13so4450629vbg.41
        for <linux-mmc@vger.kernel.org>; Mon, 27 May 2013 00:26:34 -0700 (PDT)
In-Reply-To: <CAMj5BkiFcH2s42kB7DZ=tk36A6fzr8EwbxRNLMDhUdfKEPRFPw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Maya Erez <merez@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Liu <kliu5@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>, Daniel Drake <dsd@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

On 26 May 2013 04:22, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> On Thu, May 2, 2013 at 8:02 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
>>
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Move mmc suspend specific operations to be executed from the .suspend
>> callback in the mmc bus_ops. This simplifies the mmc_suspend_host
>> function which is supposed to handle nothing but common suspend tasks.
>>
>> Since eMMC can be considered non-removable there are no need to check
>> for ongoing bkops at PM_SUSPEND_PREPARE notification so remove it.
>
>
> Sorry, a bit confused about this desc.
> How about mmc card, which can be removable.

It is only eMMC that supports BKOPS, thus no need to check for it at
PM_SUSPEND_PREPARE notification.

Kind regards
Ulf Hansson
