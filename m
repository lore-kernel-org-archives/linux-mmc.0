From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 0/3 v2] Add SDHCI driver for Tegra
Date: Wed, 22 Dec 2010 12:48:17 -0800
Message-ID: <AANLkTimgdsEM9hwSV5piei9F-9LOkMPLNbQpuB9KSq+8@mail.gmail.com>
References: <1293004871-1918-1-git-send-email-olof@lixom.net>
	<20101222160517.GB30951@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60861 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab0LVUsS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 15:48:18 -0500
In-Reply-To: <20101222160517.GB30951@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

Hi,

On Wed, Dec 22, 2010 at 8:05 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:

>> The one remaining quirk is of the kind that can be moved entirely into
>> the driver, and I will look at doing so when I get around to cleaning
>> up other quirks together with it. Until then, at least we have one more
>> bit left to allocate. :-)
>
> [BAZAAR MODE]
>
> So, when are going to remove them? And how many? And what happens if
> not? ;)
>
> [/BAZAAR MODE]


I'll probably take a go at a few of them over the holiday if I get bored.

If it doesn't happen, we'll run out of bits and someone will be forced
to clean up, or increase the data type. We already had that
discussion. :)


-Olof
