From: bojan prtvar <prtvar.b@gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: core: prepend 0x to OCR entry in sysfs
Date: Tue, 28 Nov 2017 07:44:52 +0100
Message-ID: <CAOmT4fTBTiQZBSQqR5Y+dQG_bsOdNtnAFETMECgFROj8qa1hrA@mail.gmail.com>
References: <20171127131721.865-1-bst@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34623 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbdK1Gox (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Nov 2017 01:44:53 -0500
Received: by mail-qt0-f178.google.com with SMTP id 33so33531645qtv.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 Nov 2017 22:44:53 -0800 (PST)
In-Reply-To: <20171127131721.865-1-bst@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bastian Stender <bst@pengutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Jungseung Lee <js07.lee@samsung.com>, Sascha Hauer <kernel@pengutronix.de>

Hi Bastian,

On Mon, Nov 27, 2017 at 2:17 PM, Bastian Stender <bst@pengutronix.de> wrote:
>
> The sysfs entry "ocr" was missing the 0x prefix to identify it as hex
> formatted.
>
>
> -MMC_DEV_ATTR(pre_eol_info, "%02x\n", card->ext_csd.pre_eol_info);
> +MMC_DEV_ATTR(pre_eol_info, "0x%02x\n", card->ext_csd.pre_eol_info);


Commit messages are swapped for pre_eol_info and ocr patches.

Regards,
Bojan
