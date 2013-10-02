From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] MIPS: db1235: Don't use MMC_CLKGATE
Date: Wed, 2 Oct 2013 16:11:26 +0200
Message-ID: <CAPDyKFo+RxX72Q3V9opOnXB=yUG4ZZ=KSTS_0jPL9D6V+5HbBw@mail.gmail.com>
References: <1380552120-31003-1-git-send-email-ulf.hansson@linaro.org>
	<1380552120-31003-2-git-send-email-ulf.hansson@linaro.org>
	<20131002092457.GB23236@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52785 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944Ab3JBOL0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Oct 2013 10:11:26 -0400
Received: by mail-vc0-f174.google.com with SMTP id gd11so503618vcb.5
        for <linux-mmc@vger.kernel.org>; Wed, 02 Oct 2013 07:11:26 -0700 (PDT)
In-Reply-To: <20131002092457.GB23236@linux-mips.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-mips@linux-mips.org

On 2 October 2013 11:24, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Sep 30, 2013 at 04:41:59PM +0200, Ulf Hansson wrote:
>
>> As a first step in removing code for MMC_CLKGATE, MIPS db1235 defconfig
>> which is the only current user, shall move away from this option.
>>
>> The mmc host drivers au1xmmc and jz4740_mmc, which are used on MIPS
>> don't support clock gating through MMC_CLKGATE, thus removing the
>> config option will have no effect on power save - clock gating wise.
>>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: linux-mips@linux-mips.org
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
>
> Feel free to feed this MIPS patch to Linus via the MMC tree.
>
>   Ralf

Thanks Ralf!

Chris, do you mind taking this through your tree?

Kind regards
Ulf Hansson
