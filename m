From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 01/21] sh: sh7724: Don't use a public mmc header for MMC_PROGRESS*
Date: Tue, 10 Jan 2017 16:28:37 +0100
Message-ID: <CAPDyKFr04PkRL66=ZCBG1Hx1cjeMV487NevGJRUDkrSydV81dw@mail.gmail.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
 <1483102054-1752-2-git-send-email-ulf.hansson@linaro.org> <CACRpkdaSzQHj0UC+bLO1DyTADCvPLZOLsJVJtVC+V83-udZeOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37979 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765815AbdAJP2k (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2017 10:28:40 -0500
Received: by mail-wm0-f52.google.com with SMTP id k184so165648231wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2017 07:28:39 -0800 (PST)
In-Reply-To: <CACRpkdaSzQHj0UC+bLO1DyTADCvPLZOLsJVJtVC+V83-udZeOw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>

On 9 January 2017 at 16:00, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Dec 30, 2016 at 1:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> The enum that specifies the MMC_PROGRESS* types, is a sh mmcif specific
>> thing and has no relevance in a public mmc header. Currently it's used only
>> by the sh romImage MMCIF boot, so let's instead define the enum in there
>> and rename the types to MMCIF_* to show this.
>>
>> Cc: linux-sh@vger.kernel.org
>> Cc: Simon Horman <horms@verge.net.au>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Rich Felker <dalias@libc.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> As Simon notices: this also needs to delete <linux/mmc/boot.h>.

Yes, it's done as change on top of this one.

https://patchwork.kernel.org/patch/9492077/

Kind regards
Uffe
