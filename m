From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: next-20170926 build: 2 failures 1 warnings (next-20170926)
Date: Fri, 29 Sep 2017 20:44:23 +0200
Message-ID: <CAPDyKFoVaYoMVv4C+6prgZfHgAD8gMBGJTMzzNP24czyj_goww@mail.gmail.com>
References: <E1dwn6w-0002eY-VE@optimist> <20170926161100.nzyb33o6l6lad2da@sirena.org.uk>
 <20170928190020.yyntjpmh5jebydsa@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:51177 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752351AbdI2SoY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Sep 2017 14:44:24 -0400
Received: by mail-io0-f169.google.com with SMTP id w94so569218ioi.7
        for <linux-mmc@vger.kernel.org>; Fri, 29 Sep 2017 11:44:24 -0700 (PDT)
In-Reply-To: <20170928190020.yyntjpmh5jebydsa@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@linaro.org>
Cc: Ritesh Harjani <riteshh@codeaurora.org>, Jeremy McNicoll <jeremymc@redhat.com>, kernel-build-reports@lists.linaro.org, linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>

+Stephen

On 28 September 2017 at 21:00, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Sep 26, 2017 at 09:11:00AM -0700, Mark Brown wrote:
>> On Tue, Sep 26, 2017 at 11:29:06AM +0100, Build bot for Mark Brown wrote:
>>
>> Today's -next fails to build an arm and arm64 allmodconfig with:
>>
>> >     arm64-allmodconfig
>> > ERROR: "clk_bulk_prepare" [drivers/mmc/host/sdhci-msm.ko] undefined!
>> >
>> >     arm-allmodconfig
>> > ERROR: "clk_bulk_prepare" [drivers/mmc/host/sdhci-msm.ko] undefined!
>>
>> caused by d8034e3379a83 (mmc: sdhci-msm: Utilize bulk clock API).
>
> This is still present in today's -next.

There is a fix for this, Stephen told me off list that is going to
pick it up and send it for rcs.

https://patchwork.kernel.org/patch/9967381/

If the error remains, I will drop the changes causing it.

Kind regard
Uffe
