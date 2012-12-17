From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [QUESTION] mmc: mmci: Howto merge patches
Date: Mon, 17 Dec 2012 17:09:15 +0100
Message-ID: <CAPDyKFqdAff2sdSFWd7VKfyrt8GrHytiQ4uVO+y8d-TMGzBnMg@mail.gmail.com>
References: <CAPDyKFpXyVCzFWkyL3+92Zb9hoyKaEV4hpaUYO9O5o71nNmk8w@mail.gmail.com>
	<20121217154602.GT14363@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:60186 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678Ab2LQQJQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 11:09:16 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so2134837wib.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Dec 2012 08:09:15 -0800 (PST)
In-Reply-To: <20121217154602.GT14363@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>

On 17 December 2012 16:46, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Dec 17, 2012 at 04:29:51PM +0100, Ulf Hansson wrote:
>> Hi Russell and Chris,
>>
>> I would like to propose a change of how we handle mmci patches to be
>> merged. Instead of going through Russell's arm tree, I would like
>> Chris to handle the merge through his mmc tree.
>>
>> The reason is simply that patches can have dependencies to the
>> protocol layer and in seems a bit unnecessary to wait for another
>> merge window to occur to handle these patches.
>
> You're going to have to wait another merge window _anyway_ because no
> kernel developer should be stuffing their tree full of patches during
> any merge window that have not already been in linux-next well _before_
> the merge window.
>

I think you misunderstood me here.

If I add a patch on the protocol layer, that will provide a new option
for a host driver to support, I can not in same patchset send the mmci
patch. I will have to put the mmci patch on hold for the next merge
window to be completed and take through your tree instead. Thus I can
not provide a "proof of concept" patch for mmci driver. That is really
bad I think.

> So like it or not, this merge window already closed to new submissions
> maybe two weeks ago.

Not talking about _a_ specific merge window. Just how we could go
forward with a more simpler setup of merging patches.

>
>> Moreover, if most of the mmci patches goes through Chris mmc tree, I
>> believe we would minimize the number of possible conflicts. Russell
>> will then only need to NACK patches to prevent them from being merged.
>>
>> Do you think this could be and acceptable setup for both of you?
>
> The reason that you want to do this is because you're realising that it's
> taking a long time for you to get your patches into mainline.  The reason
> that I'm being slow with your patches is that you haven't built up the
> trust on my side that I can simply say "yes that's fine, I trust your
> patches."

You will only have to NACK patches to prevent them from going in. So
there is no difference here from what we have today.

I realize that trust is important, I am working on it. :-)

>
> That alone is good enough reason for me to say no way to this.

Kind regards
Ulf Hansson
