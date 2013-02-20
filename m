From: Rhyland Klein <rklein@nvidia.com>
Subject: Re: [PATCH 2/4] ARM: tegra: add SDHCI support for Dalmore
Date: Wed, 20 Feb 2013 14:14:42 -0500
Message-ID: <512520A2.5060005@nvidia.com>
References: <1361385317-6020-1-git-send-email-rklein@nvidia.com> <1361385317-6020-3-git-send-email-rklein@nvidia.com> <51251EF3.4050901@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:10986 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935103Ab3BTTOr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Feb 2013 14:14:47 -0500
In-Reply-To: <51251EF3.4050901@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Chris Ball <cjb@laptop.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Pritesh Raithatha <praithatha@nvidia.com>

On 2/20/2013 2:07 PM, Stephen Warren wrote:
> On 02/20/2013 11:35 AM, Rhyland Klein wrote:
>> Based on changes by: Pritesh Raithatha <praithatha@nvidia.com>
>> Signed-off-by: Rhyland Klein <rklein@nvidia.com>
> A patch description would be useful here. Something simple like:
>
> Dalmore has a built-in eMMC device and a user-accessible SD card slot.
> Add device tree nodes to enable these.
>
> The same rebasing comment will apply here too.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Will update patch description for next series.

I can rebase on the cpp usage, but for some stuff like the #define 
replacements, it sounded like things were still being hashed out (like 
.h location, include paths, etc) so I figured its safer not to base on 
those initially. If they are settled by the time i send this out again, 
i can use them as a base.

-rhyland

-- 
nvpublic

