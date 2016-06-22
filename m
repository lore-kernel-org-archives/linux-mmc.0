From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 0/5] mmc: bcm2835-sdhost: Add new driver for the
 internal SD controller.
Date: Wed, 22 Jun 2016 19:02:07 +0200
Message-ID: <1466614927.16954.66.camel@redhat.com>
References: <1466595738-2229-1-git-send-email-kraxel@redhat.com>
	 <CAPDyKFpak075H7aAH14-LLzKFtE6-n+x5u+k_dvT6Oi5=sgXeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56759 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbcFVRCL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2016 13:02:11 -0400
In-Reply-To: <CAPDyKFpak075H7aAH14-LLzKFtE6-n+x5u+k_dvT6Oi5=sgXeQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-rpi-kernel@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Eric Anholt <eric@anholt.net>

On Mi, 2016-06-22 at 16:41 +0200, Ulf Hansson wrote:
> On 22 June 2016 at 13:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >   Hi,
> >
> > Here is the bcm2835-sdhost driver.  Patches 1+2 are unmodified from
> > Eric, patches 3+4 are incremental fixes.  Left them separate for now,
> > to make it easier to review, should probably squashed in for the final
> > version.  Patch 5 adds it to the device tree, in disabled state.
> >
> > Actually enabling the thing depends on a bunch of changes in the gpio
> > handling of the device tree.  Leaving that for another day ...

> Why did you post this?

See patch 2/5:

<quote>
The 2835 has two SD controllers: The Arasan SDHCI controller that we
currently use, and a custom SD controller.  The custom one runs faster
</quote>

> I think you should be adopting sdhci-iproc - in case there are issues
> with its bcm2835 support, right!?

sdhci-iproc drives the sdhci controller just fine, the new driver is for
the custom controller.  On the rpi3 you can even use both in parallel,
with the sdcard handled via custom sd controller and the wifi handled by
sdhci-iproc.

cheers,
  Gerd

