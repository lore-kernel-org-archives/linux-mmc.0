From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH] mmc: core: Do not pre-claim host in suspend
Date: Thu, 19 Apr 2012 12:02:51 +0200
Message-ID: <CAMJBoFNO7aKge9BqawRJdr=k_HxOOaeoPaif1sed_vN7kSF35g@mail.gmail.com>
References: <1334829325-3464-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37372 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717Ab2DSKCw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Apr 2012 06:02:52 -0400
Received: by obbta14 with SMTP id ta14so7877412obb.19
        for <linux-mmc@vger.kernel.org>; Thu, 19 Apr 2012 03:02:52 -0700 (PDT)
In-Reply-To: <1334829325-3464-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Daniel Drake <dsd@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Hi Ulf,

On Thu, Apr 19, 2012 at 11:55 AM, Ulf Hansson
<ulf.hansson@stericsson.com> wrote:
> Since SDIO drivers may want to do some SDIO operations
> in their suspend callback functions, we must not keep
> the host claimed when calling them.
>
> Daniel Drake reported that libertas_sdio encountered
> a deadlock in it's suspend function.

I think it looks like a hack. Can you provide a better description of
where this deadlock actually happens?

If libertas_sdio claims host as a part of its suspend operation from a
context different from the suspend context, isn't it libertas_sdio
that has to be fixed?

Vitaly
