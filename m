From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 00/14] clk: sunxi: Improve MMC clocks support
Date: Sat, 19 Jul 2014 12:47:38 +0200
Message-ID: <53CA4CCA.5040303@redhat.com>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7714 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760940AbaGSKsX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 19 Jul 2014 06:48:23 -0400
In-Reply-To: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Mike Turquette <mturquette@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Hi,

On 07/17/2014 11:08 AM, Maxime Ripard wrote:
> Hi everyone,
>
> Here is an attempt at improving the MMC clock support in the Allwinner
> SoCs.
>
> Until now, the MMC clocks were having a custom phase function that was
> directly setting an obscure value in the right register, because we
> were not really having any idea of what these values were.
>
> Now that we have more informations, we can introduce a common function
> call to get and set the phase of a particular clock, and use this in
> both our provider and our client.
>
> Another issue we had so far on the A13 was that, out of reset, the
> PLL6 driving the MMC was running too high to be working. We can solve
> that by adding two new properties in the DT to setup the rate
> constraints we might have on a clock.

Looks good to me, thanks for working on this.

Question have you dumped the raw mmc0 clk reg before and after this
patch set to verify that the end result is the same ?

Regards,

Hans
