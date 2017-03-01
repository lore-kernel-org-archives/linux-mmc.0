From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3 1/10] mmc: meson-gx: simplify bounce buffer setting in meson_mmc_start_cmd
Date: Wed, 01 Mar 2017 10:09:42 -0800
Message-ID: <m2d1e0zx5l.fsf@baylibre.com>
References: <583f6496-68a9-b8e1-6b25-1f073f819a3c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36723 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdCBM7u (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Mar 2017 07:59:50 -0500
Received: by mail-pg0-f42.google.com with SMTP id s67so32209193pgb.3
        for <linux-mmc@vger.kernel.org>; Thu, 02 Mar 2017 04:59:18 -0800 (PST)
In-Reply-To: <583f6496-68a9-b8e1-6b25-1f073f819a3c@gmail.com> (Heiner
        Kallweit's message of "Sat, 18 Feb 2017 12:50:31 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Hi Heinar,

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Core ensures that there are no commands with cmd->data being set and
> nothing to transfer. And we don't have to reset bit CMD_CFG_DATA_NUM
> because cmd_cfg was zero-initialized and this bit isn't set.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Acked-by: Kevin Hilman <khilman@baylibre.com>

Could you send this series one more time, collecting the remaining tags
and including the patches from Micha=C5=82 Zegan?

I think the MMC maintainers would appreciate one final batch with
everything collected together, and including a cover letter.

Thanks for all your great work on improving this driver,

Kevin
