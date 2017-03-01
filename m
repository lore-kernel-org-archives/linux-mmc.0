From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v3 1/10] mmc: meson-gx: simplify bounce buffer setting in
 meson_mmc_start_cmd
Date: Wed, 1 Mar 2017 21:20:19 +0100
Message-ID: <9259ab6f-fc7e-bcb3-ddd0-5ff3da3b391a@gmail.com>
References: <583f6496-68a9-b8e1-6b25-1f073f819a3c@gmail.com>
 <m2d1e0zx5l.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36062 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753761AbdCBAWs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Mar 2017 19:22:48 -0500
Received: by mail-wr0-f196.google.com with SMTP id l37so7479493wrc.3
        for <linux-mmc@vger.kernel.org>; Wed, 01 Mar 2017 16:22:32 -0800 (PST)
In-Reply-To: <m2d1e0zx5l.fsf@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Am 01.03.2017 um 19:09 schrieb Kevin Hilman:
> Hi Heinar,
> 
> Heiner Kallweit <hkallweit1@gmail.com> writes:
> 
>> Core ensures that there are no commands with cmd->data being set and
>> nothing to transfer. And we don't have to reset bit CMD_CFG_DATA_NUM
>> because cmd_cfg was zero-initialized and this bit isn't set.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> Acked-by: Kevin Hilman <khilman@baylibre.com>
> 
> Could you send this series one more time, collecting the remaining tags
> and including the patches from Michał Zegan?
> 
Patchwork tracks all the tags coming in for a patch, there it's visible
that you acked my 10 patches + the two from Michal.
So I would leave it up to Ulf whether he prefers to have the series
re-sent (with just the few remaining acks as changes).

Heiner

> I think the MMC maintainers would appreciate one final batch with
> everything collected together, and including a cover letter.
> 
> Thanks for all your great work on improving this driver,
> 
> Kevin
> 

