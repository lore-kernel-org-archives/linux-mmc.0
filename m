From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/3] dmaengine: add new dma API for max_segment_number
Date: Tue, 7 Jun 2011 23:56:21 -0700
Message-ID: <BANLkTi=FcNncT_6HpvB_6OnQ94f0_sz7Gw@mail.gmail.com>
References: <20110606094751.GC10508@n2100.arm.linux.org.uk>
	<20110606191041U.fujita.tomonori@lab.ntt.co.jp>
	<BANLkTin7mqqTsosPHbztaPfL7s_TUGT1qg@mail.gmail.com>
	<20110608142121T.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35443 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab1FHG4W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2011 02:56:22 -0400
In-Reply-To: <20110608142121T.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: shawn.guo@linaro.org, linux@arm.linux.org.uk, patches@linaro.org, vinod.koul@intel.com, gregkh@suse.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org

On Tue, Jun 7, 2011 at 10:23 PM, FUJITA Tomonori
<fujita.tomonori@lab.ntt.co.jp> wrote:
> On Mon, 6 Jun 2011 11:48:56 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
>> dmaengine expands the class of dma providers to include standalone d=
ma
>> agents on a host bus (or elsewhere) in addition to the traditional b=
us
>> mastering host-bus-adapters that the existing api understands. =A0So=
 in
>> the case of slave dma the dma capabilities of the block-device are
>> irrelevant because another agent will do the transfer on behalf of t=
he
>> block-device driver. =A0So the value should be whatever the dma devi=
ce
>> driver says it is.
>
> The dma parameter restriction could be due to software (HBA drivers,
> or subsystem). The value should be whatever the dma device driver say=
s
> it is in such case?

I'm assuming that the dma driver is taking responsibility for setting
this correctly.  How would this work otherwise... HBA driver or
subsystem queries the dmaengine device and then sets this parameter on
its behalf?  In other words dmanengine *is* the subsystem, if I am
understanding your definition.
