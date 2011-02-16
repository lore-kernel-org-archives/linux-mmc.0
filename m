From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 00/12] add support for sd host controller v3.00
Date: Wed, 16 Feb 2011 20:55:21 +0000
Message-ID: <20110216205521.GA19127@void.printf.net>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41702 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754388Ab1BPUzX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Feb 2011 15:55:23 -0500
Content-Disposition: inline
In-Reply-To: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

Hi Arindam,

On Tue, Feb 15, 2011 at 03:04:58PM +0530, Arindam Nath wrote:
> The patches below add support for Host Controller v3.00 as per the
> spec v3.00. It also adds support for UHS-I cards as per Physical
> Layer Specification v3.01.

Could you base v2 of the patchset on top of my mmc-next branch=B9, plea=
se?
I'm not sure what v1 was prepared against, but patch [2/12] onwards
don't apply successfully here.

Thanks!

=B9: git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git mmc-next
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
