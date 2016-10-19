From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v4] MMC: meson: initial support for GX platforms
Date: Wed, 19 Oct 2016 09:12:37 -0700
Message-ID: <7hvawo8gi2.fsf@baylibre.com>
References: <20161018195605.21145-1-khilman@baylibre.com>
        <CAPDyKFps2QYq9N1erqDdCnmXJyUT60HLQDe8+gR7A571-F8NLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36677 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941272AbcJSQMj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2016 12:12:39 -0400
Received: by mail-pf0-f174.google.com with SMTP id e6so18526071pfk.3
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2016 09:12:38 -0700 (PDT)
In-Reply-To: <CAPDyKFps2QYq9N1erqDdCnmXJyUT60HLQDe8+gR7A571-F8NLg@mail.gmail.com>
        (Ulf Hansson's message of "Wed, 19 Oct 2016 09:19:43 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 18 October 2016 at 21:56, Kevin Hilman <khilman@baylibre.com> wrote:
>> Initial support for the SD/eMMC controller in the Amlogic S905/GX*
>> family of SoCs.
>>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>> Changes from v3:
>> - better handling of clock error paths
>> - rename to meson-gx to reflect support for newer SoCs
>> - has now been tested with SDIO
>>
>>  .../devicetree/bindings/mmc/amlogic,meson-gxbb.txt |  33 +
>
> Just realize this. You should split the DT doc into a separate patch,
> such the DT maintainers can ack it.

OK, I separated out the binding and sent a v5.

> Otherwise this looks good to me!

Thanks for the review!

Kevin
