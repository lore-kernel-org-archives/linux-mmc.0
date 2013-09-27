From: Matt Sealey <neko@bakuhatsu.net>
Subject: Re: [PATCH 5/8] sdhci: sdhci-esdhc-imx: change pinctrl state
 according to uhs mode
Date: Thu, 26 Sep 2013 19:28:03 -0500
Message-ID: <CAHCPf3t=ozAA1sNp6ARMxEugoWO3bxeFhk_dr2Z20YC_VQ=4+Q@mail.gmail.com>
References: <1378299257-2980-1-git-send-email-b29396@freescale.com>
	<1378299257-2980-6-git-send-email-b29396@freescale.com>
	<CAHCPf3tYXsT6kTbJcqJx1gN_G9G2iqi1-f+jRcpw95CEPkW8NQ@mail.gmail.com>
	<20130911092605.GA2891@b29396-Latitude-E6410>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:36362 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab3I0A2E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Sep 2013 20:28:04 -0400
Received: by mail-qc0-f172.google.com with SMTP id l13so1303934qcy.17
        for <linux-mmc@vger.kernel.org>; Thu, 26 Sep 2013 17:28:03 -0700 (PDT)
In-Reply-To: <20130911092605.GA2891@b29396-Latitude-E6410>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, "anton@enomsg.org" <anton@enomsg.org>, "cjb@laptop.org" <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Sep 11, 2013 at 4:26 AM, Dong Aisheng <b29396@freescale.com> wrote:
> Hi Matt,
>
> I somehow agree with your idea on the naming.
> But currently i'm just using the standard property defined in:
> Documentation/devicetree/bindings/mmc/mmc.txt
> - no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
>   this system, even if the controller claims it is.

Whoever did that needs kicking :<

>> This property should probably be called "voltage-selects" or something
>> and you should put in a list of supported voltages (in uV units just
>> like cpufreq operating points and regulators, please, for consistency,
>> and update the binding).
>
> Here the no-1-8-v is for indicating no 1.8v signal voltage switch support,
> not the host supply voltage.
> The spec only defines 1.8v/3.3v switch, so no-1-8-v seems ok for me currently.

I thought the spec also has a 1.2V mode.. so what do the MMC guys
propose, adding no-1-2-v properties too? And if there exists in the
future a 0.8V mode, another property? And another?

> That's how sdhci driver used currently.
> So i'm not sure if we really need add the voltage-selects on device tree
> for mmc since that's regulator's work.

Understood. My initial thought is simply that the MMC class should
define a behavior which you could assume - in this case, that a host
supports a certain set of voltages (for supply and for signalling),
and a card supports a certain set of voltages (for supply and for
signalling). In the case of the combinations here, this is all in the
spec and defined.

However, what device trees should do is essentially provide
information where the defaults or documentation contain assumptions,
and supplant them when necessary.

An MMC host controller given a regulator now knows it can change
voltages. But to what values? Most regulators are fixed or have a wide
range. A regulator that is defined for 1.8V and 3.3V is defined as
1.8V *through* 3.3V meaning you COULD set it to 2.5V if you wanted to.
A property defining the valid voltages is good here.

For the case where someone screwed a board design or a regulator is
weak somehow, you could put 1.85V in the property to say, this is my
close-enough-to-1.8V value. Otherwise what happens is you get a
regulator set failure if the range didn't include 1.8V, or weird
issues because the voltage isn't high enough *for the design*.

For signalling voltage, sure, there could be 1.8V and 3.3V defined in
the host and the card, but the same applies - assume those in the
driver, and the DT can define which ones are valid. For a driver
probing, it can look in the DT table and see, I have a matching
1800000uV and a matching 3300000uV voltage. If it sees 1200000uV and
it has no clue how to orient the system into using that voltage, it
ignores it (it couldn't use it anyway, since it would have no
knowledge of how to instruct a card to signal at that voltage). This
works for the supply regulator setting and the signalling setting with
a common, future-proof format..

In the future, it may work when the kernel is updated to support this
as-of-yet non-existing functionality and the DT would have been
correct from the start.

> Anyway, above is just my initial thoughts on your question.
> Since this issue actually is not related to this series,
> maybe you could create a new mail thread about this if you want
> or patching is welcome for the further discussion more specific.

Well, a new thread.. sure. That might be for another day (it took me 2
weeks to get back to this one, I don't know the next time I will have
enough time to go through LAKML :)

I have written it on my whiteboard for future discussion, so I'll
bring it up again as soon as I can..

-- 
Matt Sealey <neko@bakuhatsu.net>
