From: "Luis R. Rodriguez" <lrodriguez@atheros.com>
Subject: Re: [RFC 0/4] sdhci: few patches for ENE 712 support
Date: Fri, 18 Mar 2011 15:29:26 -0700
Message-ID: <AANLkTinVRMr2D6oKAS0xQjBcG=OQyUMnoYDLMBR385rq@mail.gmail.com>
References: <1300486320-23607-1-git-send-email-lrodriguez@atheros.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47830 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932978Ab1CRW3s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Mar 2011 18:29:48 -0400
In-Reply-To: <1300486320-23607-1-git-send-email-lrodriguez@atheros.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, vmehta@atheros.com, naveen.singh@atheros.com, kvalo@adurom.com, j@w1.fi, "Luis R. Rodriguez" <lrodriguez@atheros.com>

On Fri, Mar 18, 2011 at 3:11 PM, Luis R. Rodriguez
<lrodriguez@atheros.com> wrote:
> I was pulled in to help with ath6kl development work. As part
> of this I was given some PCI "ENE" SDHCI card which can I can slap
> on to my desktop. I was then given this dump of patches to apply
> to sdhci code to get it to work:

http://www.kernel.org/pub/linux/kernel/people/mcgrof/patches/ath6kl/2011/03/18/sdhci-orig.patch

> I prefer code upstream though so here is my split and cleanup
> of these patches. I've tested it with my ENE card. Since I am
> new to SDHCI I would prefer someone with more experience review
> these chagnes and the respective commit log messages. I've
> tried to make sense of them as best as I can. Unfortunately
> I was not given any explanation to these changes except the
> patch I got so I tried to make the best of it.

  Luis
