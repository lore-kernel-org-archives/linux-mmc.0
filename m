From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH 0/2] MMC: disable multiblock reads on controllers that
 don't support them
Date: Fri, 7 Oct 2011 16:22:54 -0700
Message-ID: <CAGDS+nmszKMRUvt83PFRk_tGsYrixw-XL2Bd424fZaJqfHK0ag@mail.gmail.com>
References: <20111006205002.7083.94088.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53787 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028Ab1JGXWz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Oct 2011 19:22:55 -0400
In-Reply-To: <20111006205002.7083.94088.stgit@dusk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dhylands@gmail.com, cjb@laptop.org

On Thu, Oct 6, 2011 at 1:50 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello,
>
> Some MMC controller instances integrated on older OMAP34xx/35xx chips
> don't work correctly with multiple-block reads, due to a hardware bug.
> This series fixes the problem by adding an MMC capability flag for this
> case and making the appropriate changes to the MMC core code and OMAP HSMMC
> driver to support this.
>
> Once this series is merged, a subsequent patch will be needed by us OMAP
> folks to pass the appropriate device data via hwmod - this will be posted
> separately.

I tested these patches with my own version of the above mentioned
hwmod patch on:

3503 - ES2.1 and ES3.1
3530 - ES3.1
3703 - ES1.2
3730 - ES1.0

All worked successfully.

Tested-by: Steve Sakoman <steve@sakoman.com>
