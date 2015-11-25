From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] mmc: mvsdio: delete platform data code path
Date: Wed, 25 Nov 2015 16:04:35 +0100
Message-ID: <CACRpkdZQ2wXPkp30bPyMyigRwDCG09o-msyvpfoVXKz13rwKLg@mail.gmail.com>
References: <1448459877-32626-1-git-send-email-linus.walleij@linaro.org>
	<20151125150203.GG11384@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35117 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbbKYPEg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2015 10:04:36 -0500
Received: by obbnk6 with SMTP id nk6so40527605obb.2
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2015 07:04:35 -0800 (PST)
In-Reply-To: <20151125150203.GG11384@lunn.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Wed, Nov 25, 2015 at 4:02 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Wed, Nov 25, 2015 at 02:57:57PM +0100, Linus Walleij wrote:
>> There are no in-kernel users of the MVSDIO platform data method
>> (instantiating from a board file) so just delete this code and
>> make this a DT-only driver. We depend on OF and check that we have
>> an OF node in probe().
>>
>> Cc: Nicolas Pitre <nico@fluxnic.net>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Looks good. I guess i would of reversed the order of these two patches
> so you don't first add struct mvsdio_platform_data to the driver and
> then remove it, but that is a minor nit pick.
>
> Acked-by: Andrew Lunn <andrew@lunn.ch>

Ulf can just squash them if he likes, that'd do it.

Yours,
Linus Walleij
