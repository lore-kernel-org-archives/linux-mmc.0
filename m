From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] SDHCI: 8-bit data transfer width support
Date: Tue, 29 Jun 2010 11:37:56 -0700
Message-ID: <20100629113756.e8184ba2.akpm@linux-foundation.org>
References: <20100612054502.GA25686@july>
	<20100628113948.7778048d.akpm@linux-foundation.org>
	<AANLkTilBSjjmninq8VNxgFe2I41-b9guo5VKuiZWnAwU@mail.gmail.com>
	<20100628193334.GA1926@lixom.net>
	<AANLkTim4yfMX60NoHODkc695R7k0ZwRKPVTXB_JOg7C_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51606 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755137Ab0F2SiD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jun 2010 14:38:03 -0400
In-Reply-To: <AANLkTim4yfMX60NoHODkc695R7k0ZwRKPVTXB_JOg7C_@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Olof Johansson <olof@lixom.net>, Colin Cross <ccross@android.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

On Mon, 28 Jun 2010 12:48:29 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Mon, Jun 28, 2010 at 12:33 PM, Olof Johansson <olof@lixom.net> wrote:
> > On Mon, Jun 28, 2010 at 11:56:26AM -0700, Colin Cross wrote:
> >> These patches are not coming from the tegra/for-next branch, they are
> >> coming from Grant's devicetree-next branch. __Grant, why are these
> >> patches in your tree, and why is tegra/for-next in your tree? __It's
> >> going to cause conflicts when we rebase our for-next branch. __Please
> >> remove tegra and this sdhci patch from your tree.
> >
> > Yeah, this seems to be a mixup by Grant. I gave him a few patches I had
> > picked up locally to work with, and he seems to have published the
> > work accidentally.
> 
> Hi Colin,
> 
> I've fixed it now.  Profuse apologies, sorry for the noise, and I owe
> you a beer or 3.

Thanks, guys - I resurrected
sdhci-8-bit-data-transfer-width-support.patch and
sdhci-dont-assign-mmc-caps-at-sdhci-directly.patch

