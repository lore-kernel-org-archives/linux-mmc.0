From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC 2/3] mmc: sdhci: add host_ops->voltage_switch callback for
 all other voltages
Date: Fri, 2 Oct 2015 03:00:10 -0700
Message-ID: <CACRpkdbQX1xfMEiHwUe7FRUvtsQGbNhO6VK2=8FAgrYE9GzsoA@mail.gmail.com>
References: <1441135938-8056-1-git-send-email-vaibhav.hiremath@linaro.org>
	<1441135938-8056-3-git-send-email-vaibhav.hiremath@linaro.org>
	<20150902150442.118d3305@xhacker>
	<55E6B129.1030002@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34774 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbbJBKAL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Oct 2015 06:00:11 -0400
Received: by oiev17 with SMTP id v17so55163851oie.1
        for <linux-mmc@vger.kernel.org>; Fri, 02 Oct 2015 03:00:10 -0700 (PDT)
In-Reply-To: <55E6B129.1030002@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: Jisheng Zhang <jszhang@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Sep 2, 2015 at 1:19 AM, Vaibhav Hiremath
<vaibhav.hiremath@linaro.org> wrote:

> Not quite sure whether regulator would be right fit for this.
>
> Initially I was thinking of making use of pinconf framework, using
> PIN_CONFIG_POWER_SOURCE, but that too I am not sure is the right way of
> doing it.
>
> Probably, question for pinctrl maintainer. Looping Linus Walleji.

We have another pinctrl driver exposing the occasional fixed regulator
for exactly this purpose, see:
sh-pfc/pfc-sh73a0.c

So use the same mechanism for this driver.

Yours,
Linus Walleij
