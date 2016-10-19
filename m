From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Regression after "do not use CMD13 to get status after speed mode switch"
Date: Wed, 19 Oct 2016 18:41:26 +0200
Message-ID: <CAPDyKFp097rBjcJuT1os7W+B5zVUVuprU5_gyE0qU4K=AnA88w@mail.gmail.com>
References: <CACRpkdbfNq+R9U9AwsKBM=xyKKTzyVDkiW4jqJ0Nb2LXvq20BA@mail.gmail.com>
 <CACRpkdaUf+YpUEhi-njseR1GQXvM3GuA97Q5GuEpQ3NtFdkoHw@mail.gmail.com> <d08ed4e8-84b2-e337-c9ea-a6e36fb6b9e7@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35064 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbcJSQl3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2016 12:41:29 -0400
Received: by mail-qt0-f173.google.com with SMTP id f6so29111506qtd.2
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2016 09:41:29 -0700 (PDT)
In-Reply-To: <d08ed4e8-84b2-e337-c9ea-a6e36fb6b9e7@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Andy Gross <andy.gross@linaro.org>

Adrian, Linus,

Thanks for looking into this and reporting!

On 18 October 2016 at 15:23, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 18/10/16 11:36, Linus Walleij wrote:
>> On Mon, Oct 17, 2016 at 4:32 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>>> Before this patch the eMMC is detected and all partitions enumerated
>>> immediately, but after the patch it doesn't come up at all, except
>>> sometimes, when it appears minutes (!) after boot, all of a sudden.
>>
>> FYI this is what it looks like when it eventually happens:
>> root@msm8660:/ [  627.710175] mmc0: new high speed MMC card at address 0001
>> [  627.711641] mmcblk0: mmc0:0001 SEM04G 3.69 GiB
>> [  627.715485] mmcblk0boot0: mmc0:0001 SEM04G partition 1 1.00 MiB
>> [  627.736654] mmcblk0boot1: mmc0:0001 SEM04G partition 2 1.00 MiB
>> [  627.747397] mmcblk0rpmb: mmc0:0001 SEM04G partition 3 128 KiB
>> [  627.756326]  mmcblk0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 p11 p12 p13
>> p14 p15 p16 p17 p18 p19 p20 p21 >
>>
>> So after 627 seconds, a bit hard for users to wait this long for their
>> root filesystem.
>
> If the driver does not support busy detection and the eMMC card provides
> zero as the cmd6 generic timeout (which it may especially as cmd6 generic
> timeout wasn't added until eMMCv4.5), then __mmc_switch() defaults to
> waiting 10 minutes i.e.
>
> #define MMC_OPS_TIMEOUT_MS      (10 * 60 * 1000) /* 10 minute timeout */

Urgh! Yes, I have verified that this is exactly what happens.

>
> So removal of CMD13 polling for HS mode (as per commit
> 08573eaf1a70104f83fdbee9b84e5be03480e9ed) is going to be a problem for some
> combinations of eMMC cards and host drivers.

I was looking in the __mmc_switch() function, it's just a pain to walk
trough it :-) So first out I decided to clean it up and factor out the
polling parts. I will post the patches first out tomorrow morning,
running some final test right now.

Although, that of course doesn't solve our problem. As I see it we
only have a few options here.

1) In case when cmd6 generic timeout isn't available, let's assign
another empirically selected value.
2) Use a specific timeout when switching to HS mode.
3) Even if we deploy 1 (and 2), perhaps we still should allow polling
with CMD13 for switching to HS mode - unless it causes issues for some
cards/drivers combination?

BTW, I already tried 2) and it indeed solves the problem, although
depending on the selected timeout, it might delay the card detection
to process.

Thoughts?

Kind regards
Uffe
