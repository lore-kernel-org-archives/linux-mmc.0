From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 1/9 v2] sh: define DMA slaves per CPU type, remove now
	redundant header
Date: Thu, 6 May 2010 13:41:47 +0900
Message-ID: <AANLkTim4bALDN9ojsPXBhbMHMSSYDY-Z1PeXfADGNzP7@mail.gmail.com>
References: <Pine.LNX.4.64.1005041318200.4925@axis700.grange>
	 <Pine.LNX.4.64.1005041336080.4925@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:36064 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442Ab0EFElv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2010 00:41:51 -0400
In-Reply-To: <Pine.LNX.4.64.1005041336080.4925@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>

On Tue, May 4, 2010 at 11:06 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Now that DMA slave IDs are only used used in platform specific code and have
> become opaque cookies for the rest of the code, we can make the, CPU specific
> too.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> This patch is new in v2 - added per request from Magnus.

Thank you Guennadi, this looks very good!

/ magnus
