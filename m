From: bojan prtvar <prtvar.b@gmail.com>
Subject: Re: [PATCH] mmc: core: Extend sysfs with OCR register
Date: Mon, 4 Jul 2016 16:34:29 +0200
Message-ID: <CAOmT4fSX8du7zXcMyOFA8JAams2OWvxUvMJc66wsyVNSL+v9Uw@mail.gmail.com>
References: <20160704115818.35614-1-prtvar.b@gmail.com> <20160704141345.GA1410@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:35381 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbcGDOef (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jul 2016 10:34:35 -0400
In-Reply-To: <20160704141345.GA1410@tetsubishi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Dong Aisheng <aisheng.dong@nxp.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Gwendal Grignou <gwendal@chromium.org>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-doc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

Hi,

On Mon, Jul 4, 2016 at 4:13 PM, Wolfram Sang <wsa@the-dreams.de> wrote:

>> Make operation conditions register (OCR) easily accessible from user space.
>>
> You described "what" above. Can you add the "why", too?
>

According to JEDEC v5.0 chapter 7 the OCR, CID and CSD registers carry
the Device/content specific information.
Registers CID and CSD are already exported through sysfs so let's make
this interface complete by adding missing OCR register.

Do I need to send v2 with updated change log?

Regards,
Bojan
