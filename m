From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: Occasional crashes in suspend-resume with MMC transactions
Date: Thu, 22 Mar 2012 14:43:16 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D12143317FFAC0@DBDE01.ent.ti.com>
References: <B5906170F1614E41A8A28DE3B8D12143317FDFBB@DBDE01.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D12143317FF773@DBDE01.ent.ti.com>
 <CANfBPZ9b=6dLbY2D3oAg=Gz_vwAOJ+KC_Bo5ugVJEwumeej_Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35434 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753078Ab2CVOng convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Mar 2012 10:43:36 -0400
In-Reply-To: <CANfBPZ9b=6dLbY2D3oAg=Gz_vwAOJ+KC_Bo5ugVJEwumeej_Bw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "cjb@laptop.org" <cjb@laptop.org>

On Thu, Mar 22, 2012 at 19:57:16, S, Venkatraman wrote:
[...]
> 
> I see (in 3.3) that the host controller driver does a "return ret" and
> that means the errors is propagated.
> Where is the return code lost /overridden ?
> 

The return code gets overridden due to the call to host->pdata->resume()
which always returns 0.

static int omap_hsmmc_resume_cdirq(struct device *dev, int slot)
{
        struct omap_mmc_platform_data *mmc = dev->platform_data;

        enable_irq(mmc->slots[0].card_detect_irq);
        return 0;
}

Regards,
Vaibhav
