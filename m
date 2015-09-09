From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH-v2 4/7] mmc: sdhci-pxav3: Add pinctl setting according to
 bus clock
Date: Wed, 9 Sep 2015 10:39:46 +0200
Message-ID: <CACRpkdaQc8bH923D1bvoj2+2Puq8sSaLLf5Y8cHKbAKziOwJMg@mail.gmail.com>
References: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
	<1441624721-15612-5-git-send-email-vaibhav.hiremath@linaro.org>
	<CACRpkdY59roEBgUd9TR39yNgfhw393+WmHQQAeLkOEZLChOcWQ@mail.gmail.com>
	<55EEF99F.1020904@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35634 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643AbbIIIjr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2015 04:39:47 -0400
Received: by oiww128 with SMTP id w128so1582787oiw.2
        for <linux-mmc@vger.kernel.org>; Wed, 09 Sep 2015 01:39:46 -0700 (PDT)
In-Reply-To: <55EEF99F.1020904@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Liu <kliu5@marvell.com>

On Tue, Sep 8, 2015 at 5:07 PM, Vaibhav Hiremath
<vaibhav.hiremath@linaro.org> wrote:

> But I still have one small doubt on expectation from
> devm_pinctrl_get() function.
>
> If pinctrl properties are not populated in Devicetree node,
> then, shouldn't devm_pinctrl_get() return error ?
> I followed the code flow, and it seems even if pinctrl properties are
> not populated in DT node, the devm_pinctrl_get() returns valid
> pointer to "struct pinctrl", isn't this against the expectation of the
> call?
>
>
> Code flow -
>
> devm_pinctrl_get()
> ...
> --> creat_pinctrl()

That is the spelling mistake Dennis Ritchie and Ken Thompson
wish they had avoided in the first syscall interface :D

> --> pinctrl_dt_to_map()
> ...
>
> pinctrl_dt_to_map() iterates for pinctrl-x (x = 0,1,...) and if it
> founds the entry then it parses the node. If it doesn't find any
> pinctrl property then also it returns 0. and subsequently rreturns
> handle to "struct pinctrl" for the device. Why is so?

So pinctrl_dt_to_map() returns 0 if there are no maps in the
device tree.

This is correct: there may be systems that have a mixture
of device tree and platform data, and in that case the code
needs to continue after calling pinctrl_dt_to_map() because
else it bails out before coming to the loop in
create_pinctrl() where we iterate over the static maps.

So after the loop in create_pinctrl() it should be possible
to return something like -ENOENT if we didn't find
anything. The device core pinctrl handling in
drivers/base/pinctrl.c seems to cope with it.

It's a semantic change so we would need to test to toss
it in and see what happens on some different systems
but in principe I think you're right. What we get if there is
no state is basically a dummy pinctrl that does nothing.

Do you wanna make a patch for this?

(Looping in Stephen Warren so he can tell if I miss something
obviously evident in the design that require stubs to
be present.)

Yours,
Linus Walleij
