From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/3] dmaengine: add new dma API for max_segment_number
Date: Wed, 8 Jun 2011 14:52:17 -0700
Message-ID: <BANLkTi=Z7gXjEAPrdkF1x34Y5KzMH67aVA@mail.gmail.com>
References: <BANLkTin7mqqTsosPHbztaPfL7s_TUGT1qg@mail.gmail.com>
	<20110608142121T.fujita.tomonori@lab.ntt.co.jp>
	<BANLkTi=FcNncT_6HpvB_6OnQ94f0_sz7Gw@mail.gmail.com>
	<20110608160844E.fujita.tomonori@lab.ntt.co.jp>
	<BANLkTikFKr+3Qph+CR40SUV-DCir1v=KBg@mail.gmail.com>
	<20110608204127.GC13151@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:59113 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446Ab1FHVwT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2011 17:52:19 -0400
In-Reply-To: <20110608204127.GC13151@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, cjb@laptop.org, patches@linaro.org, vinod.koul@intel.com, gregkh@suse.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org

On Wed, Jun 8, 2011 at 1:41 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jun 08, 2011 at 01:05:57PM -0700, Dan Williams wrote:
>> Even if that were the case it would be same situation that the scsi =
device
>> driver reports maximum parameters, but the subsystem opts for
>> something tighter. =A0Whether the maximal parameters come from the s=
csi
>> device or the dma channel is moot.
>
> Except for the small issue that many DMA-engine using devices do not
> have _any_ DMA capabilities of their own, which means they don't have
> anything to put in their own struct device's DMA parameters. =A0We ca=
n't
> go around making up random insane parameters in the hope that they'll
> exceed whatever DMA-engine is being used with the device - that's a
> hack not a solution.

So, I was operating under the assumption that most dmaengine drivers
would ignore this api, it's just useful to the subset of slave-dma
consumers that have apriori knowledge that the best answer for the dma
geometry comes from the channel.  But not sure how we prevent abuse of
this api for cases where a better answer is available from another
source, which I think is what Tomonori-san is worried about.
