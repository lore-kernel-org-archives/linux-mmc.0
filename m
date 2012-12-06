From: Bing Zhao <bzhao@marvell.com>
Subject: RE: [PATCH v1 2/3] mmc: sdio: Fix SDIO 3.0 UHS-I initialization
 sequence
Date: Thu, 6 Dec 2012 10:48:50 -0800
Message-ID: <477F20668A386D41ADCC57781B1F70430D13B36B9D@SC-VEXCH1.marvell.com>
References: <1354620980-23764-1-git-send-email-subhashj@codeaurora.org>
 <1354620980-23764-3-git-send-email-subhashj@codeaurora.org>
 <477F20668A386D41ADCC57781B1F70430D13A09A1A@SC-VEXCH1.marvell.com>
 <0C8FBB70FF40A94D98BE847F9C171A98033FE4EE@SCYBEXDAG04.amd.com>
 <477F20668A386D41ADCC57781B1F70430D13A09DC6@SC-VEXCH1.marvell.com>
 <0C8FBB70FF40A94D98BE847F9C171A98033FE94B@SCYBEXDAG04.amd.com>
 <477F20668A386D41ADCC57781B1F70430D13A09FAE@SC-VEXCH1.marvell.com>
 <50C039B1.8030004@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <50C039B1.8030004@codeaurora.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: "Shen, Jackey" <Jackey.Shen@amd.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Hi Subhash,

> >> sdhci_add_host() reads host controller's capabilities and initialize host->caps of function
> >> mmc_host_uhs(). So mmc_host_uhs() only return this cached values.
> > So, it does represent host controller's capabilities, not the capabilities of the card.
> > What happens if I have a UHS capable controller and a 2.0 card?
> > The S18R bit will be set in this case, which might cause problem for the card?
> Hi Bing,
> 
> Why do you see an issue with setting S18R bit when sending CMD5 to
> SDIO2.0 compliant card? 
> If SDIO2.0 card don't support it, return OCR won't have the S18A bit set.

Some times ago I ever encountered a problem with CMD52 when I played with an SDIO driver and accidentally set one of the reserved bits to 1. The issue was resolved immediately after I realized it and cleared that bit to 0.

This experience makes me thinking that CMD5 S18R might confuse some 2.0 cards, because bit24 is also a reserved bit in 2.0 spec.

> We are already doing same thing for SD cards as well (check
> mmc_sd_get_cid function). There also even if we set the S18R bit which
> sending OCR to non-SD3.0 cards, they respond back with S18A bit cleared.

Then it's fair enough to handle SDIO the same way. Thanks for the elaboration.

> 
> If non-SDIO3.0 card misbehaves after receiving the OCR with S18R bit set
> then it means card is not compliant to specification properly and in
> that case those cards can be handled with QUIRKs. But there is no need
> to add any QUIRKs as of now.

That sounds reasonable. The quirk for non-compliant cards can be done later when they come up.

Regards,
Bing

> 
> I hope this make sense.
> 
> Regards,
> Subhash
> 
