From: Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH] mmc: core: Fix calc_max_discard.
Date: Thu, 15 Dec 2016 02:12:05 -0800
Message-ID: <CAMHSBOVj3+xHhYG6iXS5x6bGVvJNyvC56TabLt5ouJcmkyjaYg@mail.gmail.com>
References: <1481656818-21141-1-git-send-email-gwendal@chromium.org>
 <8d4b89c1-678d-f85d-29b9-e2b8a5a3b40c@intel.com> <CAMHSBOUyZtSDy8VMwy8HTBUjNL7108mAJHKg-JpswFnhsjB8fQ@mail.gmail.com>
 <3c68bce2-8426-f1d6-03c3-9f285092091d@intel.com> <edd6d97c-2ef3-75bf-cbcc-a4604c2f2d70@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35195 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757792AbcLOKM1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Dec 2016 05:12:27 -0500
Received: by mail-vk0-f47.google.com with SMTP id w194so67937195vkw.2
        for <linux-mmc@vger.kernel.org>; Thu, 15 Dec 2016 02:12:26 -0800 (PST)
In-Reply-To: <edd6d97c-2ef3-75bf-cbcc-a4604c2f2d70@toshiba.co.jp>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: hisanao.kinkawa@toshiba.co.jp
Cc: Adrian Hunter <adrian.hunter@intel.com>, Gwendal Grignou <gwendal@chromium.org>, Doug Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, Dec 15, 2016 at 1:46 AM,  <hisanao.kinkawa@toshiba.co.jp> wrote:
> On 2016/12/15 17:14, Adrian Hunter wrote:

> But the current code is quite different now, so please have a look at that
> because this code does not apply anymore.
>
...
> The mmc core
> now does a split since commit 642c28ab86f7 ("mmc: core: Optimize case for
> exactly one erase-group budget")
You are correct. I should have looked at upstream kernel. My patch is
incomplete and the issue has already been addressed with 642c28ab86f7.
Gwendal.
>
