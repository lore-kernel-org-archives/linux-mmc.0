From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 04/13] mmc: bcm2835: add bcm2835_check_data_error
Date: Fri, 27 Jan 2017 11:31:01 +0100
Message-ID: <1485513061.19754.62.camel@redhat.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
         <1485473846-24537-5-git-send-email-kraxel@redhat.com>
         <3876dea7-cd61-e7cf-e838-8bab6927c8fb@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3876dea7-cd61-e7cf-e838-8bab6927c8fb@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-rpi-kernel@lists.infradead.org, Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

  Hi,

> > @@ -1007,15 +1017,7 @@ static void bcm2835_data_irq(struct bcm2835_host *host, u32 intmask)
> >  	if (!host->data)
> >  		return;
> >
> 
> remove this check, !host->data, as well.

There is a comment in the code saying it is needed, here is more
context:

static void bcm2835_data_irq(struct bcm2835_host *host, u32 intmask)
{
	/* There are no dedicated data/space available interrupt
	 * status bits, so it is necessary to use the single shared
	 * data/space available FIFO status bits. It is therefore not
	 * an error to get here when there is no data transfer in
	 * progress.
	 */
	if (!host->data)
		return;

	bcm2835_check_data_error(host, intmask);

cheers,
  Gerd
