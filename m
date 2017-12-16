From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] mmc: block: fix logical error to avoid memory leak
Date: Sat, 16 Dec 2017 20:07:19 +0100
Message-ID: <CACRpkdYBnvD0syBQrx_H-rQaTWYU9LFCxMCX+_LG3XuEtfLyPQ@mail.gmail.com>
References: <20171214050305.GA135779@sofia> <f9294d5a-bd24-8b95-3666-fa75d681bec1@intel.com>
 <20171216151545.GA138678@sofia>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:38115 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756694AbdLPTHU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Dec 2017 14:07:20 -0500
Received: by mail-io0-f181.google.com with SMTP id 87so1744187ior.5
        for <linux-mmc@vger.kernel.org>; Sat, 16 Dec 2017 11:07:20 -0800 (PST)
In-Reply-To: <20171216151545.GA138678@sofia>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Liu, Changcheng" <changcheng.liu@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Sat, Dec 16, 2017 at 4:15 PM, Liu, Changcheng
<changcheng.liu@intel.com> wrote:

> If the MMC_DRV_OP_GET_EXT_CSD request completes successfully, then
> ext_csd must be freed, but in one case it was not. Fix that.
>
> Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
