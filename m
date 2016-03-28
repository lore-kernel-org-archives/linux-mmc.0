From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/2] regulator: core: Ensure we are at least in bounds for
 our constraints
Date: Mon, 28 Mar 2016 09:16:15 -0700
Message-ID: <CAOCOHw7Gwy1a0+UfteQJ3rs_sL1iip9EN-3GhTYW0BrHD5jhKg@mail.gmail.com>
References: <1458587912-32665-1-git-send-email-broonie@kernel.org>
	<1458587912-32665-2-git-send-email-broonie@kernel.org>
	<56F0624C.8010004@gmail.com>
	<CAJKOXPd5h0Cq++OxdiXytNJH94PN4Kh_wM3M=p3JdU1m_qyFTA@mail.gmail.com>
	<CAJKOXPcBOT_8NOH-=sEHSP0Rc+=Dvz-aqVTsBTMKg-VNWqQotw@mail.gmail.com>
	<CAJAp7OgGQ3qm-_QhydvN0n6QeNoHFdso4zOk41qvVJhKNeRn8Q@mail.gmail.com>
	<20160327090859.GH5028@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33780 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691AbcC1QQQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Mar 2016 12:16:16 -0400
Received: by mail-ob0-f181.google.com with SMTP id x3so34582149obt.0
        for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2016 09:16:16 -0700 (PDT)
In-Reply-To: <20160327090859.GH5028@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Bjorn Andersson <bjorn@kryo.se>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On Sun, Mar 27, 2016 at 2:08 AM, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Mar 26, 2016 at 04:50:41PM -0700, Bjorn Andersson wrote:
>
>> Reinstating the following snippet in of_get_regulation_constraints()
>> sort this out:
>
>> if (constraints->min_uV && constraints->max_uV)
>>                                        constraints->apply_uV = true;
>
> The existing check in the patch should be an || not an ==, or possibly
> we should just not bother looking for min_uV at all.  I just pushed out
> a version of that, let's see how that goes.
>

Either way is fine with me, as long as we either go ahead and apply a
voltage setting now or allow a consumer to do so later (your posted
patch does both).

>> I did look at an alternative of having regulator_set_voltage() pass
>> and call set_voltage() if the requested voltage matches the
>> constraints, but this does indeed seem to mess things up. So checking
>> in with you before continuing on that hack.
>
> Yes, not everything is writeable.

Right, looking at your posted patch [1] we're changing this logic so
that normal regulators defined with min == max will be allowed to
set_voltage(). Thinking about it that makes sense and cleans the logic
up, so I'm in favor of this.

I know it's published, but fwiw you have my Acked-by on the posted patch.


[1] https://git.kernel.org/cgit/linux/kernel/git/broonie/regulator.git/commit/?h=for-next&id=fa93fd4ecc9c58475abac6db93a797bff893bc16

Regards,
Bjorn
