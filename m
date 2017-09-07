From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: cavium: Fix use-after-free in of_platform_device_destroy
Date: Thu, 7 Sep 2017 17:00:53 +0200
Message-ID: <CAPDyKFqnCLnhv2OQwD1zHsbVgNvkNHaWE-1kBpUOBHPKiLCTaA@mail.gmail.com>
References: <20170907112417.21495-1-jglauber@cavium.com> <CAPDyKFos=uPbuy1oQREMpE6hyaYbVxhVKSQNWkrE3VyoxzoL8g@mail.gmail.com>
 <20170907121940.GA22336@hc> <CAPDyKFri9EFwAk3n0Oxt-+pNQak9KT5V9mURevgEN_CEF0Gmfw@mail.gmail.com>
 <20170907123355.GB22336@hc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:34933 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755364AbdIGPAz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Sep 2017 11:00:55 -0400
Received: by mail-io0-f169.google.com with SMTP id i14so4670794ioe.2
        for <linux-mmc@vger.kernel.org>; Thu, 07 Sep 2017 08:00:54 -0700 (PDT)
In-Reply-To: <20170907123355.GB22336@hc>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: David Daney <david.daney@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 7 September 2017 at 14:33, Jan Glauber
<jan.glauber@caviumnetworks.com> wrote:
> On Thu, Sep 07, 2017 at 02:21:17PM +0200, Ulf Hansson wrote:
>> On 7 September 2017 at 14:19, Jan Glauber
>> <jan.glauber@caviumnetworks.com> wrote:
>> > Thanks Uffe. The fix would only be required for 4.13, as only with that the
>> > Cavium GPIO driver became available.
>>
>> Okay, I drop the fixes tag then, because it points to a commit present
>> in 4.12 as well.
>>
>> Make sense?
>
> Thinking twice it may still be a good idea to have the fixes tag, for
> distribution backports. So yes, please keep it.

Got it, okay!

[...]

Kind regards
Uffe
