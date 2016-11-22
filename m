From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFCv2 01/10] mmc: core: Add support to read command queue parameters
Date: Tue, 22 Nov 2016 13:37:44 +0100
Message-ID: <CACRpkdZ4U=ho0o9X1z1NNM0oBijMsrf9euSoKkOPO+x7sat2Aw@mail.gmail.com>
References: <1467033757-32498-1-git-send-email-riteshh@codeaurora.org>
 <1467033757-32498-2-git-send-email-riteshh@codeaurora.org>
 <CACRpkdYDfdCoZUOryjVX4byu2BFx9KZx7YKoFG9wESDpaKtirg@mail.gmail.com>
 <e18147ff-ac6b-a48f-4487-18ebd51bbc99@intel.com> <CACRpkdaHgN7XGdXjeE1dwQ2gn0z=VXfjVdVGYcT0gRfASNUKbQ@mail.gmail.com>
 <0cf555d9-4e79-73fb-954d-8f022c90d4dc@intel.com> <CACRpkdZkYVJmZ_M3oYhY3i4JrqEA_Xxc3ZALKaMdQq2ybxfvZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34159 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932422AbcKVMhq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2016 07:37:46 -0500
Received: by mail-qk0-f179.google.com with SMTP id q130so21342854qke.1
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2016 04:37:45 -0800 (PST)
In-Reply-To: <CACRpkdZkYVJmZ_M3oYhY3i4JrqEA_Xxc3ZALKaMdQq2ybxfvZA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ritesh Harjani <riteshh@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Asutosh Das <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, kdorfman@codeaurora.org, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, venkatg@codeaurora.org, Shawn Lin <shawn.lin@rock-chips.com>, Subhash Jadavani <subhashj@codeaurora.org>

On Tue, Nov 22, 2016 at 1:30 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Nov 22, 2016 at 11:31 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:

>> I should have been more explicit.  SW CMDQ covers some of the same ground
>> and has basically the same patch:
>>
>>         https://marc.info/?l=linux-mmc&m=147729859922297&w=2
>
> OK it seems to define more of the constants, I'll go and review it.

Bah it's not in my INBOX for some reason, maybe I fell off the linux-mmc list
at some point :( I review it here:

Leave out this:

+ cmdq_en Command Queue enabled: 1 => enabled, 0 => not enabled
(...)
+MMC_DEV_ATTR(cmdq_en, "%d\n", card->ext_csd.cmdq_en);
(...)
+ &dev_attr_cmdq_en.attr,
(...)
+ bool cmdq_en; /* Command Queue enabled */

Because that is about enabling the *use* of this mechnism rather than
detecting its presence.

With the above removed it is superior to $SUBJECT so you
can add:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
