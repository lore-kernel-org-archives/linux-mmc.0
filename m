From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH 6/8] ARM: mvebu: enable SDHCI card detection using DAT3
 pin on A388-GP
Date: Tue, 6 Oct 2015 17:05:21 +0200
Message-ID: <CAPv3WKfOkTHTSXqzZNr+-E20nHr40jqw_Dg6qz24uDa+nB5-BA@mail.gmail.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
	<1444094562-31165-7-git-send-email-mw@semihalf.com>
	<20151006033131.GA24230@lunn.ch>
	<CAPv3WKeUQ6rsYWJ3C+aX8eHTAdS4SmQ3oCjA9feFf+d-n1RvhA@mail.gmail.com>
	<20151006144523.GA32615@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33405 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbbJFPFW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Oct 2015 11:05:22 -0400
Received: by oixx17 with SMTP id x17so110209813oix.0
        for <linux-mmc@vger.kernel.org>; Tue, 06 Oct 2015 08:05:21 -0700 (PDT)
In-Reply-To: <20151006144523.GA32615@lunn.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?UTF-8?Q?Gregory_Cl=C3=A9ment?= <gregory.clement@free-electrons.com>, nadavh@marvell.com, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Grzegorz Jaszczyk <jaz@semihalf.com>

Andrew,

2015-10-06 16:45 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
>> I expected this patch would be controversial, hence I propose a
>> compromise: set A388-GP SDHCI to 'broken-cd' by defeault.
>
> So for boards < 1.5, you are introducing a regression. It used to work
> via GPIO. Now that is ignored and it is declared broken. Or am i
> mis-understanding what broken-cd means, and it actually means, poll
> it?
>

"broken-cd" property means that the mmc subsystem is polling instead
of using hardware detection.

>> However Marvell insisted on HW card detection
>
> Marvell does not get to decide what goes into the kernel and what can
> be deliberately broken. Marvell can make recommendations, provide
> benchmarks reports, etc. But the community, and ultimately the
> responsible maintainer decides.

Sure, this is why I submitted the patch to the list in order to get
review. Please bear in mind, that I do not work in Marvell and I just
wanted to present some justification of the decision, about which I
got informed. Personally I think it would be reasonable to keep GPIO
detect as is, but maybe I'm lacking some background.

>
>> because software polling spoils the SD/MMC benchmarks, but this way
>> the user would decide whether to stay with broken-cd or switch to
>> GPIO/DAT3 detection. What do you think?
>
> So rather than presenting a solution, please could you list all the
> different options you can think of, and how they would work for < 1.5
> and >= 1.5.
>

We have three options here:
- leave GPIO-based card detection and see if in future anyone
complains about not working detection
- switch to DAT3 detection - yes you're right, that it is a regression
for all boards < 1.5
- enable SW polling for detection ("broken-cd") which should satisfy
all kind of boards

> One other useful bit of information. How many < 1.5 boards are there,
> and who has them. Are they internal to Marvell and Free Electrons, or
> do a lot of people have them? We have thrown away fixes which are
> requires for A0 stepping SoCs, because very few people have such
> devices and they can easily replace them for B1. If nearly nobody
> actually has < 1.5, ....

I have no information, nor an access to such data, I can have only
suspicions which cannot be a reference in any way.

Best regards,
Marcin
