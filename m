From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH] mmc: dt: Add property for broken hs200 quirk
Date: Fri, 19 Dec 2014 12:01:44 -0800
Message-ID: <CAJAp7OhSZ7CZedXAsWPf0XYv8RESQxXe4L1LZjOmVW4nGpFiHw@mail.gmail.com>
References: <1418412516-10682-1-git-send-email-bjorn.andersson@sonymobile.com>
	<CAPDyKFrPC_MphsLHHZ=uFjcF8SsdkVmzez9R=gas7_ihn63Q5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:62566 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbaLSUBp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Dec 2014 15:01:45 -0500
Received: by mail-lb0-f169.google.com with SMTP id p9so1387661lbv.14
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2014 12:01:44 -0800 (PST)
In-Reply-To: <CAPDyKFrPC_MphsLHHZ=uFjcF8SsdkVmzez9R=gas7_ihn63Q5A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>, Anton Vorontsov <anton@enomsg.org>, Chris Ball <chris@printf.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>

On Fri, Dec 19, 2014 at 3:38 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 12 December 2014 at 20:28, Bjorn Andersson
> <bjorn.andersson@sonymobile.com> wrote:
>
> Some more explanation to why this needed would be good.
>

Because (according to the git log) some of the memories that we
mounted in Xperia Z1 does not support HS200 even though they advertise
they are.

I thought we needed for the device I'm testing with, but a couple of
regulator_set_optimum_mode() solved that - so I have to provide a
patch for that as well...

>> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
>
> This file lists the generic mmc DT bindings, but you want to add a
> specific binding for sdhci?
>

Looking in sdhci_get_of_property() it's a mash of device specific
properties, sdhci specific properties documented in mmc.txt and
generic sdhci properties documented in device specific bindings.

Would you like me to move it to a generic sdhci.txt binding and update
the individual sdhci-* to reference that instead of mmc.txt? Or should
I just add the property in the device specific bindings? Or maybe we
could keep it as a optional property in mmc.txt?

Regards,
Bjorn
