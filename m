From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 01/13] mmc: bcm2835: add bcm2835_read_wait_sdcmd
Date: Fri, 27 Jan 2017 10:23:07 -0800
Message-ID: <b08c276b-706f-3bd3-828d-fe4ee0ae971b@gmail.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
 <1485473846-24537-2-git-send-email-kraxel@redhat.com>
 <30bf98f0-c893-d306-ab79-3ba741790919@gmail.com>
 <1485504250.19754.22.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35801 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdA0SXh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Jan 2017 13:23:37 -0500
In-Reply-To: <1485504250.19754.22.camel@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org, Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>

On 01/27/2017 12:04 AM, Gerd Hoffmann wrote:
> On Do, 2017-01-26 at 15:51 -0800, Florian Fainelli wrote:
>> On 01/26/2017 03:37 PM, Gerd Hoffmann wrote:
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>
>> Few things with your submission:
>>
>> - if you send more than one patch, a cover letter is a welcome to
>> explain your changes
> 
> There actually is a cover letter.  The git-send-email "cccmd =
> scripts/get_maintainer.pl" hook doesn't work for the cover letter though
> because it isn't a patch.  I've hand-picked some people who
> touched/reviewed the driver before to the git-send-email command line,
> but everybody else got the patches only.
> 
> Anyone has a good solution for this btw?

Do a dry run against all patches, collect the cclist in a file, and have
a script that outputs one line, something like this:

./scripts/get_maintainer.pl patches/*.patch > cclist

cclist.sh:

#!/bin/sh
cat $(dirname $0)/cclist

git send-email --cc-cmd=cclist.sh patches/*.patch

> 
>> - try to provide commit messages for things that are not obvious (in
>> fact, most maintainers actually request commit messages even for trivial
>> things)
> 
> The driver is out of tree still, these are cleanups Ulf Hansson asked
> for last time the driver was submitted.
> 
> Full set of patches:
>   https://www.kraxel.org/cgit/linux/log/?h=bcm2837-sdhost-cleanup
> 
> Plan for upstream merge is to actually squash all the incremental
> cleanups, but for now I kept them as separate changes.  I think this
> makes it easier to spot mistakes and it'll also help in case there are
> regressions b/c you can bisect things.
> 
>> - have not we switched to the iproc SDHCI driver, or is this for the
>> other SDIO connected peripherals here?
> 
> The 2835 has two SD controllers: The Arasan SDHCI controller that we
> currently use (iproc drives that one), and a custom SD controller.
> 
> This is a driver for the custom one.  Has better performance than the
> sdhci controller (according to Eric Anholt).  For the rpi3 switching to
> this driver has the additional advantage that we can use the iproc
> driver driver to handle the wifi.

OK
-- 
Florian
