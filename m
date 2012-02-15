From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] sdhci-tegra: fix linux/module.h included twice
Date: Wed, 15 Feb 2012 10:38:16 -0800
Message-ID: <CAOesGMixdsMxJXaELs74X9ORHZzQFjAMFW+yZ1YaBHtJe_17bQ@mail.gmail.com>
References: <1329328466-4627-1-git-send-email-danny.kukawka@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56711 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273Ab2BOSiR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2012 13:38:17 -0500
In-Reply-To: <1329328466-4627-1-git-send-email-danny.kukawka@bisect.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Danny Kukawka <danny.kukawka@bisect.de>
Cc: Chris Ball <cjb@laptop.org>, Danny Kukawka <dkukawka@suse.de>, Stephen Warren <swarren@nvidia.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Feb 15, 2012 at 9:54 AM, Danny Kukawka <danny.kukawka@bisect.de> wrote:
> Remove double include of linux/module.h.
>
> Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>

Obviously correct, not that Chris needs it but anyway:

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
