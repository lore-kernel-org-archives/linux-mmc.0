From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 3/3] SDHCI: 8-bit data transfer width support
Date: Mon, 28 Jun 2010 14:33:34 -0500
Message-ID: <20100628193334.GA1926@lixom.net>
References: <20100612054502.GA25686@july> <20100628113948.7778048d.akpm@linux-foundation.org> <AANLkTilBSjjmninq8VNxgFe2I41-b9guo5VKuiZWnAwU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([66.141.50.11]:57856 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752650Ab0F1TmG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Jun 2010 15:42:06 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTilBSjjmninq8VNxgFe2I41-b9guo5VKuiZWnAwU@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>

On Mon, Jun 28, 2010 at 11:56:26AM -0700, Colin Cross wrote:
> These patches are not coming from the tegra/for-next branch, they are
> coming from Grant's devicetree-next branch.  Grant, why are these
> patches in your tree, and why is tegra/for-next in your tree?  It's
> going to cause conflicts when we rebase our for-next branch.  Please
> remove tegra and this sdhci patch from your tree.

Yeah, this seems to be a mixup by Grant. I gave him a few patches I had
picked up locally to work with, and he seems to have published the
work accidentally.


-Olof

