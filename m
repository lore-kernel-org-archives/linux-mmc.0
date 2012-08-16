From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: Add device tree support
Date: Thu, 16 Aug 2012 12:52:49 -0400
Message-ID: <87fw7mdbj2.fsf@octavius.laptop.org>
References: <CAJuYYwQjN9UtXcfjNXf1Ezw3igfUSQDNEP8X038L4=br6EROUA@mail.gmail.com>
	<1345134914-21635-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50691 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041Ab2HPQxD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Aug 2012 12:53:03 -0400
In-Reply-To: <1345134914-21635-1-git-send-email-thomas.abraham@linaro.org>
	(Thomas Abraham's message of "Thu, 16 Aug 2012 22:05:14 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org

Hi Thomas,

On Thu, Aug 16 2012, Thomas Abraham wrote:
> +Optional Board Specific Properties:
> +- One of the following properties for card detect type.
> +  - samsung,sdhci-cd-internal: Card detect line from the card slot is
> +    connected to the card detect pad of the sdhci controller. A gpio is
> +    used for this connection (with possible pin function settings).
> +  - samsung,sdhci-cd-gpio: A gpio line (with possible pin function settings)
> +    is used a card detect line. This gpio line is not connected to card detect
> +    pad of the sdhci controller.
> +  - samsung,sdhci-cd-none: There is no card detect line. Polling is used to
> +    detect the presence of the card. (DEFAULT, if no card detect property
> +    is specified).
> +  - samsung,sdhci-cd-permanent: There is no card detect line. The card is
> +    permanently connected to the sdhci controller.

sdhci-s3c isn't the only driver that's going to have options for
different cd configurations -- maybe now is the right time to move
these options into the core bindings?

At OLPC we've just started using:

 * "broken-cd" to mean "samsung,sdhci-cd-none",
 
 * the presence of a "cd-gpios" property to imply "samsung,sdhci-cd-gpio".
   
 * "non-removable" to mean "samsung,sdhci-cd-permanent" (this is already
   specified in mmc.txt)

Would these work for you?

We don't have a distinction between sdhci-cd-internal and sdhci-cd-gpio,
and I'm having trouble working out why one is necessary.  Why does the
driver need to know where the gpio came from, aside from knowing which
gpio it is and whether it needs to be inverted (with cd-inverted)?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
