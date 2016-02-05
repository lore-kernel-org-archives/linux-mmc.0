From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] mmc-utils: Merge the lsmmc tool into mmc-utils
Date: Fri, 5 Feb 2016 10:29:51 +0100
Message-ID: <CACRpkdZjJ1nOmFcznXx-RXVcwKgbp0rhPSy85cyui5_2x8X4zw@mail.gmail.com>
References: <32aeb1c8c24a29aabe3f58bcdf60faf7a39c6491.1454660477.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34575 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbcBEJ3w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Feb 2016 04:29:52 -0500
Received: by mail-oi0-f46.google.com with SMTP id w5so37550581oie.1
        for <linux-mmc@vger.kernel.org>; Fri, 05 Feb 2016 01:29:51 -0800 (PST)
In-Reply-To: <32aeb1c8c24a29aabe3f58bcdf60faf7a39c6491.1454660477.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Sebastian Rasmussen <sebras@gmail.com>

On Fri, Feb 5, 2016 at 9:23 AM, Baolin Wang <baolin.wang@linaro.org> wrote:

> From: Sebastian Rasmussen <sebras@gmail.com>
>
> The lsmmc tools contains an extensive parser of the CID, CSD, SCR, EXT_CSD
> registers from userspace. The utility works as-is and uses sysfs to read
> the register values.
>
> The original code is created by Sebastian Rasmussen and still lives in
> an attachment in the mail archive of linux-mmc. It need to be merged into
> mmc-utils repository, which is convenient for testing MMC device from userspace.
>
> Signed-off-by: Sebastian Rasmussen <sebras@gmail.com>
> Signed-off-by: Chris Ball <chris@printf.net>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
