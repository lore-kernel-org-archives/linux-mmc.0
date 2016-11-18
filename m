From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 7/9] mmc: core: Allow CMD13 polling when switch to HS200 mode
Date: Fri, 18 Nov 2016 14:16:47 +0100
Message-ID: <CAPDyKFpjmkOBp_Qh4Xbzf4BKZ1SdknSm-R199ujAb_VJcP7PgA@mail.gmail.com>
References: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
 <1479293481-20186-8-git-send-email-ulf.hansson@linaro.org>
 <e003f72a-6084-eb1a-6b44-c6a11d93b3ae@intel.com> <CAPDyKFrDP_K_muRArcNrMGBeTLB_XWawcMc9yb82k4cdd8z0eQ@mail.gmail.com>
 <2a2f1f8c-871c-164e-d4fe-abc0658df90f@intel.com> <CAPDyKFoAGeMqdUaniohshXDULpetNBxj-Tt6+oDzrWR6u9wcQQ@mail.gmail.com>
 <c0781701-5977-533d-6178-d8b5536a82bd@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35516 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbcKRNQu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2016 08:16:50 -0500
Received: by mail-wm0-f46.google.com with SMTP id a197so37754748wmd.0
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2016 05:16:49 -0800 (PST)
In-Reply-To: <c0781701-5977-533d-6178-d8b5536a82bd@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

[...]

>>>
>>> I should point out that retrying CMD13 will clear the error bits in the
>>> status so there is no point retrying when checking for the SWITCH_ERROR bit.
>>> i.e. we need a version of __switch_send_status() that sets retries to zero.
>>
>> Are you really sure about this?
>
> I don't think I have ever tested it.  I was going on what the spec says:
> "1) Error bit. Signals an error condition was detected by the device. These
> bits are cleared as soon as the response (reporting the error) is sent out."

Couldn't have been more clear than that.

So when doing CMD13 polling, it's seems like we should be validating
the SWITCH_ERROR bit for each successful CMD13 response, as otherwise
we may end up loosing that information.

[...]

Kind regards
Uffe
