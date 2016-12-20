From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v10 0/8] Cavium MMC driver
Date: Tue, 20 Dec 2016 13:24:37 +0100
Message-ID: <20161220122437.GD26097@hardcore>
References: <20161219121552.18316-1-jglauber@cavium.com>
 <CAPDyKFqXDt9zBphrSPqMpbzBJsj1zECGBb5DugOEj1eLs9-xPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam01on0067.outbound.protection.outlook.com ([104.47.32.67]:64918
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752523AbcLTMYu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 20 Dec 2016 07:24:50 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFqXDt9zBphrSPqMpbzBJsj1zECGBb5DugOEj1eLs9-xPQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>

On Tue, Dec 20, 2016 at 01:10:56PM +0100, Ulf Hansson wrote:
> Hi Jan,
> 
> On 19 December 2016 at 13:15, Jan Glauber <jglauber@cavium.com> wrote:
> > While this patch series seems to be somehow overdue, in the meantime the
> > same MMC unit was re-used on Cavium's ThunderX SOC so our interest in making
> > progress upstreaming this driver has doubled now...
> >
> > Glancing over the history of the series I think most of the high-level
> > comments should be adressed by now (like DTS representation of the
> > multiple slots). I've added some new features for the ARM64 port
> > and in the process re-wrote parts of the driver and split it into smaller,
> > hopefully easier to review parts.
> 
> I only had a quick review, but the overall impression is that it's
> getting far better. Here follows my summary.
> 
> 1) I intend to especially look at DTS representation for the slot
> nodes, to make sure we have a good solution. Allow me to get back on
> this.
> 
> 2) I don't like how you have named files, as it doesn't express the
> obvious relationship between the core library and the drivers. I would
> rather see something similar to dw_mmc or sdhci.
> 
> 3) Related to 2), I would also like to have a prefix of the commit
> messages which express the relationships. Again follow dw_mmc/sdhci.
> 
> 4) GPIO powers should be modelled as GPIO regulators. I believe we
> have discussed this earlier as well (I don't really recall in detail
> about the last things). It gives us the opportunity to via the
> regulator framework to find out the supported voltage levels. This is
> the generic method which is used by mmc drivers, you need to adopt to
> this as well.
> 
> 5) Please reorder the series so the DT bindings doc change comes
> first. I need an ack from the DT maintainer for it.
> 
> 6) The most important feedback:
> This driver has been posted in many versions by now. Perhaps I could
> have been more responsive throughout the attempts, I apologize for
> that. On the other hand, you seems to have a round robin schedule for
> whom that sends a new version. :-) That makes me wonder about your
> support in the maintenance phase. I hope my concern is wrong, but how
> about that you point out a responsible maintainer? Especially since
> this seems to become a family of Cavium variants, it would help me if
> I could rely on someone providing acks for future changes. Would you
> be able to accept that role?

Hi Uffe,

thanks for your feedback! To answer only point 6 for now, I was not to
keen on being the next poster of this series ;- Nevertheless, I'm
comitted to keep working on this driver to bring it finally upstream and
also to maintain it in the future. To make this clear I'll add myself
and possibly also David or Steven to MAINTAINERS.

Cheers,
Jan
