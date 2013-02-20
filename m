From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/4] ARM: tegra: add SDHCI support for Dalmore
Date: Wed, 20 Feb 2013 12:16:19 -0700
Message-ID: <51252103.70202@wwwdotorg.org>
References: <1361385317-6020-1-git-send-email-rklein@nvidia.com> <1361385317-6020-3-git-send-email-rklein@nvidia.com> <51251EF3.4050901@wwwdotorg.org> <512520A2.5060005@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:46026 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934854Ab3BTTQW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Feb 2013 14:16:22 -0500
In-Reply-To: <512520A2.5060005@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rhyland Klein <rklein@nvidia.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Pritesh Raithatha <praithatha@nvidia.com>

On 02/20/2013 12:14 PM, Rhyland Klein wrote:
> On 2/20/2013 2:07 PM, Stephen Warren wrote:
>> On 02/20/2013 11:35 AM, Rhyland Klein wrote:
>>> Based on changes by: Pritesh Raithatha <praithatha@nvidia.com>
>>> Signed-off-by: Rhyland Klein <rklein@nvidia.com>
>> A patch description would be useful here. Something simple like:
>>
>> Dalmore has a built-in eMMC device and a user-accessible SD card slot.
>> Add device tree nodes to enable these.
>>
>> The same rebasing comment will apply here too.
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Will update patch description for next series.
> 
> I can rebase on the cpp usage, but for some stuff like the #define
> replacements, it sounded like things were still being hashed out (like
> .h location, include paths, etc) so I figured its safer not to base on
> those initially. If they are settled by the time i send this out again,
> i can use them as a base.

Yes, it's not all 100% settled yet; I pointed it out more as a heads-up
that I might ask you to rebase later. There's no need to actively rebase
just yet.
