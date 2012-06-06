From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH REPOST 1/2] mmc: tegra: use bus-width property instead
 of support-8bit
Date: Wed, 06 Jun 2012 11:34:48 -0600
Message-ID: <4FCF94B8.6000400@wwwdotorg.org>
References: <1338834755-6900-1-git-send-email-swarren@wwwdotorg.org> <20120606135647.GA3423@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:51488 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab2FFRev (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jun 2012 13:34:51 -0400
In-Reply-To: <20120606135647.GA3423@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Colin Cross <ccross@android.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

On 06/06/2012 07:56 AM, Chris Ball wrote:
> On Mon, Jun 04, 2012 at 12:32:34PM -0600, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Update the driver to parse the new unified bus-width property introduced
>> in commit 7f21779 "mmc: dt: Consolidate DT bindings", instead of the legacy
>> support-8bit property.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> Chris, It's probably easiest conflict-wise if I take this through the Tegra
>> tree. (Note: When I posted this series before, I said there shouldn't be any
>> conflicts if you take them through the MMC tree. That's probably still true,
>> but unforseen future conflicts seem more likely in the .dts files in the
>> second patch than sdhci-tegra.c in this patch, so the Tegra tree may make
>> more sense). Since the second patch depends on the first, it's easiest if
>> these go in through the same tree. Does this sound OK?
> 
> Yes, makes sense -- taking this via the Tegra tree is fine:
> 
> Acked-by: Chris Ball <cjb@laptop.org>

Thanks. I have applied the series.
