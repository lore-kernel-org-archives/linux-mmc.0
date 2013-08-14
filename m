From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] mmc: dw_mmc-exynos: Common bindings for dw-mshc timing
Date: Wed, 14 Aug 2013 10:09:43 -0600
Message-ID: <520BABC7.8010100@wwwdotorg.org>
References: <1376002520-7461-1-git-send-email-dinguyen@altera.com> <52096C75.1030305@wwwdotorg.org> <20130814052940.GC16635@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:46901 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758570Ab3HNQJq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Aug 2013 12:09:46 -0400
In-Reply-To: <20130814052940.GC16635@quad.lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: dinguyen@altera.com, dinh.linux@gmail.com, Arnd Bergmann <arnd@arndb.de>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/13/2013 11:29 PM, Olof Johansson wrote:
> On Mon, Aug 12, 2013 at 05:15:01PM -0600, Stephen Warren wrote:
>> On 08/08/2013 04:55 PM, dinguyen@altera.com wrote:
>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>
>>> Remove the "samsung" in "samsung,dw-mshc-ciu-div", "samsung,dw-mshc-sdr-timing",
>>> and "samsung,dw-mshc-ddr-timing". These characteristics are not applicable to
>>> just Samsung platforms, but to any platform that uses the Synopsis SD/MMC IP.
>>
>> But the properties aren't globally standard; they apply specifically
>> anywhere that this particular Synopsis IP is present. As such, I think
>> at least a "synopsis," prefix is warranted.
> 
> A prefix is only really needed when a vendor is making a vendor-specific
> extension on a shared binding. Since the whole binding is
> synopsis-specific, I don't think there's need for a prefix here.

Oh! That definitely isn't the rule that's been applied before; I've been
asked to add "nvidia," prefixes to properties in entirely custom bindings...
