From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Avoid swiotlb buffer being full
Date: Fri, 1 Dec 2017 11:28:06 +0100
Message-ID: <CAPDyKFrxeTQ2K5jV9tkdkX3hMyYSv__BD_2P+oX990cjNdEAyQ@mail.gmail.com>
References: <1511778530-6761-1-git-send-email-ulf.hansson@linaro.org> <CACRpkdabdijCiy4CV23erUKwaTT1pQOJKMjPuv6BFrd-MC8vLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:46304 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbdLAK2H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Dec 2017 05:28:07 -0500
Received: by mail-io0-f171.google.com with SMTP id x129so10712680iod.13
        for <linux-mmc@vger.kernel.org>; Fri, 01 Dec 2017 02:28:06 -0800 (PST)
In-Reply-To: <CACRpkdabdijCiy4CV23erUKwaTT1pQOJKMjPuv6BFrd-MC8vLQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Linus <torvalds@linux-foundation.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Rzeszutek Wilk <konrad@kernel.org>, Jiri Slaby <jslaby@suse.cz>, "# v4 . 14+" <stable@vger.kernel.org>

On 1 December 2017 at 11:01, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Nov 27, 2017 at 11:28 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> The commit de3ee99b097d ("mmc: Delete bounce buffer handling") deletes the
>> bounce buffer handling, but also causes the max_req_size for sdhci to be
>> increased, in case when max_segs == 1. This causes errors for sdhci-pci
>> Ricoh variant, about the swiotlb buffer to become full.
>>
>> Fix the issue, by taking IO_TLB_SEGSIZE and IO_TLB_SHIFT into account when
>> deciding the max_req_size for sdhci.
>>
>> Reported-by: Jiri Slaby <jslaby@suse.cz>
>> Fixes: de3ee99b097d ("mmc: Delete bounce buffer handling")
>> Cc: <stable@vger.kernel.org> # v4.14+
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Tested-by: Jiri Slaby <jslaby@suse.cz>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Sorry, but this was too late, I just sent the PR to Linus.

Thanks anyway!

[...]

Kind regards
Uffe
