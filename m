From: Paul Mansfield <paul-kernel@mansfield.co.uk>
Subject: Re: [Regression: mmc: sdhci-esdhc-imx: add runtime pm support]
Date: Wed, 1 Jul 2015 21:20:47 +0100
Message-ID: <CAGwpYocghRP5Dfe_fbY_UgcScUZG1RdnEmu_Vjz7TepdKT6ZgQ@mail.gmail.com>
References: <52F3A267.8030302@parkeon.com> <CAA+hA=Qvnm4S1tEQbfopegTeE4uHDdu9nY=fnYAYqdzPrUP8CQ@mail.gmail.com>
 <loom.20150701T150850-834@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:34710 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbbGAUVI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jul 2015 16:21:08 -0400
Received: by wgqq4 with SMTP id q4so46110714wgq.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2015 13:21:06 -0700 (PDT)
In-Reply-To: <loom.20150701T150850-834@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

On 1 July 2015 at 14:13, Bastien Nocera <hadess@hadess.net> wrote:
> Hey Dong,
> <snip>
>> Some SDIO cards may not be able to work well without clock.
>
> I've been needing to use this particular patch on a BayTrail tablet with a
> Realtek 8723BS SDIO Wi-Fi chip to get Wi-Fi to be stable. This is using

I've got a Toshiba Click Mini which has that same WiFi. Whilst the
driver works when build with kernel 4.1-release, it seems to make the
system unstable.
