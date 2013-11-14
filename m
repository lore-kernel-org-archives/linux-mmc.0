From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/16] ARM: shmobile: SDHI support for r8a7790
Date: Thu, 14 Nov 2013 14:46:22 +0100
Message-ID: <2008878.YfHkJYy4No@avalon>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com> <87txffxofc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:42018 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415Ab3KNNpn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Nov 2013 08:45:43 -0500
In-Reply-To: <87txffxofc.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org

Hi Morimoto-san,

Thank you for the patches.

On Thursday 14 November 2013 02:34:03 Kuninori Morimoto wrote:
> Hi Simon
> 
> These are SDHI support for r8a7790.
> 
> Kuninori Morimoto (14):
>       ARM: shmobile: lager: add SDHI0/2 support
>       ARM: shmobile: lager: use gpio/fixed regulator for SDHI

As the second patches fixes a problem in the first one, I'd like to split them 
differently. Could you please submit a first patch that adds the regulators, 
and a second patch that adds SDHI0/2 support using the regulators ?

-- 
Regards,

Laurent Pinchart

