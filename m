From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v9] mmc: OCTEON: Add host driver for OCTEON MMC
 controller.
Date: Sat, 8 Apr 2017 11:14:02 +0200
Message-ID: <20170408091402.GA2930@hardcore>
References: <836c0ca9-18f0-f6b5-bb79-8d0301d54154@cavium.com>
 <c1d0ccad-10e2-9d5d-8192-2bbd7d7357b3@cavium.com>
 <20170408001335.2eyajki3ujgomcz4@raspberrypi-3.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam02on0061.outbound.protection.outlook.com ([104.47.36.61]:14240
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751968AbdDHJOY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 8 Apr 2017 05:14:24 -0400
Content-Disposition: inline
In-Reply-To: <20170408001335.2eyajki3ujgomcz4@raspberrypi-3.musicnaut.iki.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "Steven J. Hill" <Steven.Hill@cavium.com>, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, David Daney <david.daney@cavium.com>

On Sat, Apr 08, 2017 at 03:13:35AM +0300, Aaro Koskinen wrote:
> Hi,
> 
> On Mon, Oct 03, 2016 at 08:18:59PM -0500, Steven J. Hill wrote:
> > On 09/19/2016 03:24 PM, Steven J. Hill wrote:
> > > The OCTEON MMC controller is currently found on cn61XX and cn71XX
> > > devices. Device parameters are configured from device tree data.
> > > eMMC, MMC and SD devices are supported. Tested on Cavium CN7130.
> > > 
> > > Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> > > Acked-by: David Daney <david.daney@cavium.com>
> > 
> > Have any MMC maintainers gotten a chance to review our driver now
> > that v4.8 is out? Thanks.
> 
> Also v4.9, v4.10 and v4.11 went by.

Hi Aaro,

we went through several new revisions of the driver in the meantime.

> I think you should resend the patch, to get this driver finally merged.

the last version (v13) was posted here (waiting for feedback from maintainer):

https://lkml.org/lkml/2017/3/30/683

Unfortunately I had to drop the Octeon changes from v13 as Steven
reported problems on some models with that.

--Jan

> A.
