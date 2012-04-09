From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2]mmc: remove MMC bus legacy suspend/resume method
Date: Mon, 9 Apr 2012 23:07:23 +0200
Message-ID: <CACRpkdaS8f3KT+f1oPXiRhSoxwVOL5s69mMZCz__6WvtfKY=Ag@mail.gmail.com>
References: <20120405075118.GA29395@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64441 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756821Ab2DIVHY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Apr 2012 17:07:24 -0400
Received: by yhmm54 with SMTP id m54so2051475yhm.19
        for <linux-mmc@vger.kernel.org>; Mon, 09 Apr 2012 14:07:23 -0700 (PDT)
In-Reply-To: <20120405075118.GA29395@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-pm@lists.linux-foundation.org, rjw@sisk.pl

On Thu, Apr 5, 2012 at 9:51 AM, Chuanxiao Dong <chuanxiao.dong@intel.co=
m> wrote:

> MMC bus is using legacy suspend/resume method, which is not compatibl=
e if
> runtime pm callbacks are used. In this scenario, MMC bus suspend/resu=
me
> callbacks cannot be called when system entering S3. So change to use =
the new
> defined dev_pm_ops for system sleeping mode
>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
> Changes in v2:
> =A0 =A0 =A0 =A0use SET_SYSTEM_SLEEP_PM_OPS to define sleep callbacks =
as Rafael
> =A0 =A0 =A0 =A0suggested

This looks so much more sane.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
