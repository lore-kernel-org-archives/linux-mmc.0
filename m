From: Eliad Peller <eliad@wizery.com>
Subject: Re: SDIO device binding
Date: Thu, 11 Dec 2014 18:44:44 +0200
Message-ID: <CAB3XZEfZJDM590JtQLptQ8nG2PdKH7+UPLJR_+9YeHTzDZTatA@mail.gmail.com>
References: <CAB3XZEfX7oAmJe=86j+WC0w73kQxO4C=Ufdy6eMgtYYh8Swv2g@mail.gmail.com>
	<CAPDyKFrXHu_F5WH6HyvXY4+6e2Uq0ve31A2M=bP6iEhod6_nNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:37759 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbaLKQoo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Dec 2014 11:44:44 -0500
In-Reply-To: <CAPDyKFrXHu_F5WH6HyvXY4+6e2Uq0ve31A2M=bP6iEhod6_nNQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Hans de Goede <hdegoede@redhat.com>

On Thu, Dec 11, 2014 at 5:37 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 11 December 2014 at 14:32, Eliad Peller <eliad@wizery.com> wrote:
>> hi,
>>
>> I'm looking for the proper way to pass SDIO device properties using devicetree.
>>
>> There seems to be a patchset sent previously by Sascha Hauer to handle
>> it, but for some reason it didn't get merged, and i can't find any
>> further discussion regarding the patches.
>>
>> https://patchwork.ozlabs.org/patch/355235/
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/261575.html
>>
>> Was there any issue with the patches, or is there any other binding
>> that should be used instead?
>
> This above is most likely the correct solution. Thanks for the
> reminder, I will try to find some time to go through them again.
>
great, thanks.

> May I ask what kind of properties you would like to configure for the
> SDIO device?
>
The most important ones are the OOB irq (used by some wifi sdio cards)
and clocks, but i guess other device-specific properties might be
applicable as well.
(there's an actual example in the binding documentation patch)

thanks,
Eliad.
