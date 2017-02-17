From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/2] mmc: meson-gx: prevent cfg_div_clk from being disabled on init
Date: Fri, 17 Feb 2017 11:44:52 -0800
Message-ID: <m2k28o61qj.fsf@baylibre.com>
References: <20170216145222.1577-1-webczat@webczatnet.pl>
        <20170216145222.1577-2-webczat@webczatnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35488 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755769AbdBQToy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2017 14:44:54 -0500
Received: by mail-pg0-f48.google.com with SMTP id t188so17905417pgt.2
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2017 11:44:54 -0800 (PST)
In-Reply-To: <20170216145222.1577-2-webczat@webczatnet.pl> (=?utf-8?Q?=22M?=
 =?utf-8?Q?icha=C5=82?= Zegan"'s
        message of "Thu, 16 Feb 2017 15:52:21 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Zegan <webczat@webczatnet.pl>
Cc: Carlo Caione <carlo@caione.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

Micha=C5=82 Zegan <webczat@webczatnet.pl> writes:

> At the end of function meson_mmc_clk_init, the cfg_div clock was
> prepared, enabled and configured, but then immediately disabled due to bo=
gus if statements.
> That made later calls to clk_disable_unprepare executed during module rem=
oval to fail with a kernel warning.
> Fix that by changing the code to disable clock only when it failed to be =
configured.
>
> Signed-off-by: Micha=C5=82 Zegan <webczat@webczatnet.pl>

I believe this one is not needed any more after Heiner's cleanups?

Kevin
