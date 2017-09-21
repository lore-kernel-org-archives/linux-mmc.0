From: "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: Re: [PATCH] mmc: Delete bounce buffer handling
Date: Thu, 21 Sep 2017 11:35:18 -0500
Message-ID: <b70aea82-0e15-e27f-b443-078301ee5375@cavium.com>
References: <20170920085614.22697-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0055.outbound.protection.outlook.com ([104.47.34.55]:43280
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751436AbdIUQf2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 21 Sep 2017 12:35:28 -0400
In-Reply-To: <20170920085614.22697-1-linus.walleij@linaro.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On 09/20/2017 03:56 AM, Linus Walleij wrote:

[...]
> 
> I am pretty positively convinced that software
> scatter-gather emulation will do for any host controller what
> the bounce buffers were doing. Essentially, the bounce buffer
> was a reimplementation of software scatter-gather-emulation in
> the MMC subsystem, and it should be done away with.
> 
> Cc: Pierre Ossman <pierre@ossman.eu>
> Cc: Juha Yrjola <juha.yrjola@solidboot.com>
> Cc: Steven J. Hill <Steven.Hill@cavium.com>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Suggested-by: Steven J. Hill <Steven.Hill@cavium.com>
> Suggested-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Linus,

Thank you for doing all the research and getting this code removed.

-Steve
