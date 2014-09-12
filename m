From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 00/12] clk: sunxi: Improve MMC clocks support
Date: Fri, 12 Sep 2014 09:22:06 +0200
Message-ID: <54129F1E.30207@redhat.com>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2122 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbaILHWz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 12 Sep 2014 03:22:55 -0400
In-Reply-To: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Mike Turquette <mturquette@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, wens@csie.org

Hi,

On 09/11/2014 10:18 PM, Maxime Ripard wrote:
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
> Thanks,
> Maxime

I've not done a full review this time around (-ENOTIME), but I've taken
a look at the changed bits, and those look good to me.

Regards,

Hans
