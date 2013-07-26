From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 2/2 V2] mmc: esdhc: get voltage from dts file
Date: Fri, 26 Jul 2013 12:18:59 -0700
Message-ID: <20130726191858.GB14216@lizard>
References: <1374712691-12807-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:64646 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405Ab3GZTXp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jul 2013 15:23:45 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so2388389pbc.10
        for <linux-mmc@vger.kernel.org>; Fri, 26 Jul 2013 12:23:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1374712691-12807-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cjb@laptop.org, scottwood@freescale.com, AFLEMING@freescale.com

On Thu, Jul 25, 2013 at 08:38:11AM +0800, Haijun Zhang wrote:
> Add voltage-range support in esdhc of T4, So we can choose
> to read voltages from dts file as one optional.
> If we can get a valid voltage-range from device node, we use
> this voltage as the final voltage support. Else we still read
> from capacity or from other provider.
> 
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>

Development process nitpick...

The code originated from me, but I did not sign off this patch...

Per Documentation/SubmittingPatches:

  The Signed-off-by: tag indicates that the signer was involved in the
  development of the patch, or that he/she was in the patch's delivery path.

The order of the sign-off lines also has a meaning. Putting my sign off
below yours means that I was not only involved in the development of the
patch but also somehow approved the patch (but I did not :).

[..]
> +void sdhci_get_voltage(struct platform_device *pdev)

You still duplicate the code... Per my previous email, this should
probably go into mmc/core (with the function renamed to something more
generic, of course.)

Thanks,

Anton
