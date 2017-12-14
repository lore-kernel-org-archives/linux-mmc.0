From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci: wait 5ms after set 1.8V signal enable
Date: Thu, 14 Dec 2017 09:41:11 +0100
Message-ID: <CAPDyKFp=B2EBBOVky=x89Bcqw77XZyXcW1Hyn_LEHOkhtyAyFA@mail.gmail.com>
References: <1513208929-13578-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:43014 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbdLNIlM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Dec 2017 03:41:12 -0500
Received: by mail-it0-f41.google.com with SMTP id u62so9613322ita.2
        for <linux-mmc@vger.kernel.org>; Thu, 14 Dec 2017 00:41:12 -0800 (PST)
In-Reply-To: <1513208929-13578-1-git-send-email-zjwu@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, xswang@marvell.com, Wilson Ding <dingwei@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, hongd@marvell.com, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On 14 December 2017 at 00:48, Zhoujie Wu <zjwu@marvell.com> wrote:
> According to SD spec 3.00 3.6.1 signal voltage switch
> procedure, host should wait 5ms after set 1.8V signal
> enable bit in Host Control 2 register and check if 1.8V
> is stable or not.
>

The core already deals with this. See mmc_set_uhs_voltage() and
mmc_host_set_uhs_voltage().

We even have a retry mechanism in place.

> On some cards, found without the delay would see "1.8V
> regulator output did not became stable" err log.

Seems like you need to fix the regulator instead.

BTW, is this a regression? No?

[...]

Kind regards
Uffe
