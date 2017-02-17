From: =?UTF-8?Q?Micha=c5=82_Zegan?= <webczat@webczatnet.pl>
Subject: Re: [PATCH 1/2] mmc: meson-gx: prevent cfg_div_clk from being
 disabled on init
Date: Fri, 17 Feb 2017 20:49:23 +0100
Message-ID: <a7ea0b57-efa0-58a5-92d5-8bc97f357f4c@webczatnet.pl>
References: <20170216145222.1577-1-webczat@webczatnet.pl>
 <20170216145222.1577-2-webczat@webczatnet.pl> <m2k28o61qj.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from webczatnet.pl ([91.121.100.5]:51980 "EHLO webczatnet.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755769AbdBQTtd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Feb 2017 14:49:33 -0500
In-Reply-To: <m2k28o61qj.fsf@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org



W dniu 17.02.2017 o 20:44, Kevin Hilman pisze:
> Michał Zegan <webczat@webczatnet.pl> writes:
>
>> At the end of function meson_mmc_clk_init, the cfg_div clock was
>> prepared, enabled and configured, but then immediately disabled due to bogus if statements.
>> That made later calls to clk_disable_unprepare executed during module removal to fail with a kernel warning.
>> Fix that by changing the code to disable clock only when it failed to be configured.
>>
>> Signed-off-by: Michał Zegan <webczat@webczatnet.pl>
> I believe this one is not needed any more after Heiner's cleanups?
I think it is not needed, yes.
>
> Kevin

