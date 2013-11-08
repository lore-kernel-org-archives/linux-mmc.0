From: Tim Kryger <tim.kryger@linaro.org>
Subject: Re: [RESEND PATCH v2 1/6] ARM: dts: Declare clocks as fixed on bcm11351
Date: Fri, 8 Nov 2013 11:42:12 -0800
Message-ID: <CAAYSxhoHYaFzcoxEAJrNb6d8n1aKGDN68K3eekRT22s0h7960w@mail.gmail.com>
References: <1381960030-1640-1-git-send-email-tim.kryger@linaro.org>
	<1381960030-1640-2-git-send-email-tim.kryger@linaro.org>
	<527CC2A5.7080000@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:41436 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758017Ab3KHTmN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Nov 2013 14:42:13 -0500
Received: by mail-oa0-f54.google.com with SMTP id n16so2911796oag.13
        for <linux-mmc@vger.kernel.org>; Fri, 08 Nov 2013 11:42:13 -0800 (PST)
In-Reply-To: <527CC2A5.7080000@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Christian Daudt <bcm@fixthebug.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, Device Tree List <devicetree@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Patch Tracking <patches@linaro.org>

On Fri, Nov 8, 2013 at 2:53 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> I was wondering what is the status of this patchset ?
>
> The patchset touches different areas maintained by different people. Through
> what tree do you expect this patchset to be merged ??

Hi Daniel,

I plan to send an updated version soon to address some concerns raised by Mark.

Once all the maintainers are satisfied and provide their acks, I would
like Christian to take the series into his tree.

I expect Christian will have a few other Broadcom DTS file changes in
his tree so sending the series through him should make it easier to
avoid/manage conflicts.

Christian, would that work for you?

Thanks,
Tim Kryger
