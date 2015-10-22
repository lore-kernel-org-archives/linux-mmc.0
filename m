From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] mmc: pwrseq: Use highest priority for eMMC restart handler
Date: Thu, 22 Oct 2015 17:51:17 +0200
Message-ID: <19278822.W8IRxl9izA@diego>
References: <1445440540-21525-1-git-send-email-javier@osg.samsung.com> <56283F27.9060804@samsung.com> <CAD=FV=VZJ9Tc4G-Xiw60DmfC4izU_6dVwwa0N0ePM0eaJfcqkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:58005 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964875AbbJVPva (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 Oct 2015 11:51:30 -0400
In-Reply-To: <CAD=FV=VZJ9Tc4G-Xiw60DmfC4izU_6dVwwa0N0ePM0eaJfcqkg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Markus Reichl <m.reichl@fivetechno.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>

Am Donnerstag, 22. Oktober 2015, 08:34:38 schrieb Doug Anderson:
> Note that personally I would only choose the "highest" priority as an
> absolute last resort.  Leaving a little extra slack in there means
> that when the next person comes up with a really good reason to run
> before you do that they can do it without changing your code. 

just to reiterate, restart-handlers are generally not meant as "things to do 
before restart", but "are supposed to restart the system, nothing else" [0].

Just in this case there hasn't been a better solution found for the needed 
reset even in emergency-reboots ... but this misappropriation of restart-
handlers should not spread into further realms, so there shouldn't be a "next 
person" ;-) .


[0] http://permalink.gmane.org/gmane.linux.kernel/1968815



