From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] mmc: sdhci-esdhc-imx: add device tree probe support
Date: Tue, 5 Jul 2011 11:20:48 -0600
Message-ID: <CACxGe6sxRZbWO_HzfCZzn2S=o06M=JyAiuLZig4v=cNgCuu9OQ@mail.gmail.com>
References: <1309681851-23052-1-git-send-email-shawn.guo@linaro.org>
 <1309681851-23052-4-git-send-email-shawn.guo@linaro.org> <20110704062548.GI15152@ponder.secretlab.ca>
 <20110705153509.GA14954@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62055 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732Ab1GERVJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jul 2011 13:21:09 -0400
Received: by gxk21 with SMTP id 21so2316449gxk.19
        for <linux-mmc@vger.kernel.org>; Tue, 05 Jul 2011 10:21:08 -0700 (PDT)
In-Reply-To: <20110705153509.GA14954@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, patches@linaro.org, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>

On Tue, Jul 5, 2011 at 9:35 AM, Shawn Guo <shawn.guo@freescale.com> wro=
te:
> On Mon, Jul 04, 2011 at 12:25:48AM -0600, Grant Likely wrote:
>> > + =A0 =A0"none" : No CD
>> > + =A0 =A0"controller" : Uses eSDHC controller internal CD signal
>> > + =A0 =A0"gpio" : Uses GPIO pin for CD
>>
>> I would say the presence of a "cd-gpios" property would implicitly
>> mean gpio is to be used for the CD pin.
>>
> Yes, you are right. =A0But I would say this is a direct translation o=
f
> the existing platform_data. =A0After all, we are sharing most of code
> path between platform and dt.

Meh, that's just implementation detail and the DT bindings should
*not* be focused on what Linux happens to currently do.  Define a
binding that makes sense first and foremost, and then make the driver
use it.

g.
