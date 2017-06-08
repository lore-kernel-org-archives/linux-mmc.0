From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/8] omap*: Fixes/Cleanups for MMC devicetree node
Date: Thu, 8 Jun 2017 01:46:20 -0700
Message-ID: <20170608084619.GH3730@atomide.com>
References: <20170607093749.15656-1-kishon@ti.com>
 <CAPDyKFrJh9qAz6q2-TH8rMshuMjDTkT5pHP==FUUH9KZEOehOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:50862 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751475AbdFHIqY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Jun 2017 04:46:24 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFrJh9qAz6q2-TH8rMshuMjDTkT5pHP==FUUH9KZEOehOQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

* Ulf Hansson <ulf.hansson@linaro.org> [170608 00:24]:
> If it helps, I can host a branch with the updates on the omap_hsmmc
> driver, such it can be pulled in from arm soc?

Great that works for me. Let's just make sure git bisect
keeps working.

> I guess you need that as, the DT changes relies on the new vqmmc
> binding. Or you thing it doesn't matter, because for the current
> changes that regulator is always an always on regulator?

Or maybe we can just add the new regulator, then do a
follow-up series to remove the old ones?

Regards,

Tony
