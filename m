From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: implement driver stage register handling
Date: Mon, 16 Jun 2014 12:48:06 +0100
Message-ID: <20140616114806.GA23430@n2100.arm.linux.org.uk>
References: <1400852087-32442-1-git-send-email-s.hauer@pengutronix.de> <CAPDyKFotJr1UkKFs8vqaeh+=VqZvbxY6KmzDQ0HQKFkkr=07ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:59214 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751039AbaFPLsO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 07:48:14 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFotJr1UkKFs8vqaeh+=VqZvbxY6KmzDQ0HQKFkkr=07ug@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Markus Niebel <Markus.Niebel@tqs.de>, linux-mmc <linux-mmc@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Jun 16, 2014 at 01:36:38PM +0200, Ulf Hansson wrote:
> On 23 May 2014 15:34, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > @@ -970,6 +971,9 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> >                         goto free_card;
> >         }
> >
> > +       if (card->csd.dsr_imp && (host->dsr & 0xffff) == host->dsr)
> 
> To clarify, maybe add an extra pair of parentheses around the above expression?

To which I say, don't you bloody dare.  It's perfectly readable as it
is, it doesn't need any additional parenthesis.

Additional useless parenthesis detracts from readability.  Don't encourage
stuch stuff.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
