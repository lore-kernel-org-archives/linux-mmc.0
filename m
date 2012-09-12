From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
Date: Tue, 11 Sep 2012 20:38:11 -0700
Message-ID: <20120912033811.GA1886@lizard>
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com>
 <20120911075429.GA27028@lizard>
 <20120911080457.GA28235@lizard>
 <504F82C1.2000907@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C176E94@039-SN1MPN1-002.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43009 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab2ILDku (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Sep 2012 23:40:50 -0400
Received: by ieje11 with SMTP id e11so2163942iej.19
        for <linux-mmc@vger.kernel.org>; Tue, 11 Sep 2012 20:40:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C176E94@039-SN1MPN1-002.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Sep 12, 2012 at 03:19:18AM +0000, Huang Changming-R66093 wrote:
[...]
> I don't think it is the best way to do it.  For the VVN2.2 or older,
> some silicon support this feature (mpc8536 and p2020), but other
> silicones don't support it (e.g. p4080, p102x).  Though, the current
> p5/p4/p3 has supported this feature, can we sure the future silicon
> support it?  So I think the best way is to specify it in device tree
> as 'sdhci,auto-cmd12'

In addition to your current patches, you could just add another patch
that blacklists affected SOC revisions based on the info from PVR/SVR.

For example, see gfar_detect_errata() in
drivers/net/ethernet/freescale/gianfar.c.

That way you could help users that don't have the newest device trees.

Thanks,
Anton.
