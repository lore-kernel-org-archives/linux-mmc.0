From: Sebastian Rasmussen <sebras@gmail.com>
Subject: Re: [PATCH] mmc: mmci: Improve runtime PM support
Date: Mon, 24 Oct 2011 11:11:28 +0200
Message-ID: <CAAgDR1MxvhXKwDoBMZF44gJXTigWNDQCkZXsueAqUxw4Rf5fkw@mail.gmail.com>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com>
	<20111021173637.GG21648@n2100.arm.linux.org.uk>
	<CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com>
	<CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com>
	<4EA51C4A.7040802@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53222 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab1JXJL3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 05:11:29 -0400
Received: by ywm3 with SMTP id 3so1268191ywm.19
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2011 02:11:28 -0700 (PDT)
In-Reply-To: <4EA51C4A.7040802@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>

Hi!

> If the ARM PL180 TRM prevent us from from doing this kind of operations in
> runtime_suspend, we must think of an alternative solution which just apply
> for ST-Ericssons derivative of PL180. THIS IS VERY IMPORTANT to be able to
> implement a proper power management solution.

I believe that what it boils down to is how the power regulators are controlled.

In ST-Ericssons PL180 derivative there must be two independent regulators,
controlled by something outside the PL180 itself, one for the controller and
one for the external card. So if you know what you are doing you can power
down the controller while still keeping the card powered.

In the case of ARM PL180 it seems to me as if there is one power regulator,
controlled by something outside the PL180, that supplies power to the
controller, and one power regulator, controlled by the PL180, that supplies
power to the card. Therefore it is simply not possible to clear the ARM
PL180s MCIPower register (because that means that the card will loose
power since the control signals to the card's power regulator are now asking
it to cut power to the card). In addition I believe that it may not be
possible to
power the controller down...

 / Sebastian
