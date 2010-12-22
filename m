From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Fwd: [PATCH 7/23]  Alternative mmc structure to support pxa168, pxa910, mmp2 family SD
Date: Thu, 23 Dec 2010 00:23:54 +0100
Message-ID: <201012230023.55062.arnd@arndb.de>
References: <C8F2F5E1-E72D-4679-AB8F-748CBE736262@marvell.com> <C514DA21-446D-4153-B5B9-E4AE4D0A06CA@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:49740 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320Ab0LVXYL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 18:24:11 -0500
In-Reply-To: <C514DA21-446D-4153-B5B9-E4AE4D0A06CA@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Brown <markb@marvell.com>

On Thursday 23 December 2010 00:06:51 Philip Rakity wrote:
> 
> host-&gt;ops-&gt;platform_reset_exit(host, mask);<br>+<br> <span class=3D"A=
> pple-tab-span" style=3D"white-space:pre">	</span>if (host-&gt;quirks &amp; =
> SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)<br> <span class=3D"Apple-tab-span" st=
> yle=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" style=3D"whi=
> te-space:pre">	</span>sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);<=
> br> }<br>diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h<b=
> r>index 6e0969e..9dd7bc1 100644<br>--- a/drivers/mmc/host/sdhci.h<br>+++ b/=
> drivers/mmc/host/sdhci.h<br>@@ -222,6 +222,8 @@ struct sdhci_ops {<br> <spa=
> n class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>void (*platfor=
> m_send_init_74_clocks)(struct sdhci_host *host,<br> <span class=3D"Apple-ta=

This must be the first time I've seen someone post a patch as HTML ;-)

Please reread Documentation/SubmittingPatches. I doubt that you will be
able to make your current email client do the right thing, so best
start looking at "git send-email", which should solve most of the basic
problems you currently experience.

Feel free to send the patch to me in private (after sending it to yourself
first and convincing yourself that you did it right) first if you want to
avoid spamming the mailing lists with more patches that are somewhat wrong.

	Arnd
