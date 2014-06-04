From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [linux-sunxi] [PATCH v2 1/4] dt: bindings: mmc: Document the
 practice of using subnodes for slots
Date: Wed, 04 Jun 2014 21:14:38 +0900
Message-ID: <001501cf7fee$8ec6c910$ac545b30$%jun@samsung.com>
References: <1401563014-13856-1-git-send-email-hdegoede@redhat.com>
 <1401563014-13856-2-git-send-email-hdegoede@redhat.com>
 <CAOesGMisqtPWKY6N5ch36c0VyBP1Pu725cehBU+2gYtKXQs=hQ@mail.gmail.com>
 <538AF124.9040106@redhat.com>
 <CAPDyKFon5J6aUTzSmqGn_pkxgud26=+KBW0pkim-adMmWG_xXg@mail.gmail.com>
 <538C3812.9060705@samsung.com>
 <CAPDyKFp1KcQaOAqKBA7xrq85mVoNFecqO8QLT3EBzST6Giv-Sw@mail.gmail.com>
 <538D29CF.9070102@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:38169 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbaFDMOl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 08:14:41 -0400
In-reply-to: <538D29CF.9070102@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>
Cc: 'Hans de Goede' <hdegoede@redhat.com>, 'Olof Johansson' <olof@lixom.net>, linux-sunxi@googlegroups.com, 'Chris Ball' <chris@printf.net>, 'Sascha Hauer' <s.hauer@pengutronix.de>, 'Maxime Ripard' <maxime.ripard@free-electrons.com>, 'Arend van Spriel' <arend@broadcom.com>, 'Chen-Yu Tsai' <wens@csie.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, 'devicetree' <devicetree@vger.kernel.org>

On Tue, June 03, 2014, Jaehoon Chung wrote:
> +Suegnwon Jeon
> 
> On 06/02/2014 05:48 PM, Ulf Hansson wrote:
> > On 2 June 2014 10:38, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> >> On 06/02/2014 05:29 PM, Ulf Hansson wrote:
> >>> On 1 June 2014 11:23, Hans de Goede <hdegoede@redhat.com> wrote:
> >>>> Hi,
> >>>>
> >>>>
> >>>> On 05/31/2014 10:13 PM, Olof Johansson wrote:
> >>>>>
> >>>>> On Sat, May 31, 2014 at 12:03 PM, Hans de Goede <hdegoede@redhat.com>
> >>>>> wrote:
> >>>>>>
> >>>>>> The following existing MMC host controller bindings use slot subnodes:
> >>>>>>
> >>>>>> Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> >>>>>> Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> >>>>>> Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> >>>>>> Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> >>>>>> Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
> >>>>>> Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> >>>>>>
> >>>>>> This commit documents this practice in the standard mmc bindings
> >>>>>> documentation.
> >>>>>>
> >>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>>>>
> >>>>>
> >>>>> There are today only two drivers that use this kind of binding, dw_mmc
> >>>>> and the at91 one.
> >>>>
> >>>>
> >>>> Correct.
> >>>>
> >>>>
> >>>>> Neither seems to actually ever have been used with
> >>>>> more than one slot. I doubt anyone building an exynos-based system
> >>>>> will ever do a multi-slot solution, and it seems that the at91 driver
> >>>>> doesn't actually handle more than one slot.
> >>>>>
> >>>>> I'm personally not that excited about complicating the bindings by
> >>>>> opening up for this -- I would rather work towards removing the
> >>>>> concept of slots if it's one of those things that are going to remain
> >>>>> unused. We have actually been talking about reworking the dw_mmc
> >>>>> binding to remove the slot concept (and simplify the driver by doing
> >>>>> so).
> >>>>
> >>>>
> >>>> I'm fine with removing the slot subnode, I added it because of it being
> >>>> brought up in the powerup sequence discussion. I explicitly asked there
> >>>> if adding such a subnode level was seen as desirable but nobody
> >>>> answered :|
> >>>>
> >>>> Anyways, either way works for me. I can do a v3 dropping the slot subnode
> >>>> level again. I would really like to move forward with a decision on how-to
> >>>> represent non probable info for sdio devices in device nodes. So do you
> >>>> have any other remarks other then that the slot subnode should be dropped ?
> >>>> And if not can you please review and ack (*) v3 of this patch-set once
> >>>> I've send it?
> >>>>
> >>>> Chris Ball and Ulf Hansson, what is your take on this, are you willing to
> >>>> take this patch set? And do you want it with or without the slot subnodes ?
> >>>
> >>> I certainly appreciate you working actively on this Hans, I will look
> >>> into the patchset as soon as I can.
> >>>
> >>> I share Olof's view about the slot nodes, we must not add DT bindings
> >>> that isn't really needed.
> >>>
> >>> Regarding the slot subnodes; Jaehoon Chung recently posted a patchset
> >>> for adding the parsing of it, intended for dwmmc. I withdraw my ack
> >>> for it, and let's try to go in the other direction instead.
> >>>
> >>> [PATCHv3 0/4] mmc: fixed the mmc_of_parse for dwmmc.
> >>>
> >>> Thus I suggest we should clean-up host drivers to support only one
> >>> card per host, and entirely skip the slot concept.
> >>
> >> Well, almost platform is used the only one card per host, although some controller is supported the
> slot concept.
> >> But we don't know that controller should be used the multi slot per host, in future.
> >> So I think we can't skip the slot concept.
> >
> > The mmc core only supports one card per host.
> 
> Right, mmc core supports one card per host, but host controller can be supported the multiple slot,
> right?
> Of course, it should be handled at host controller, not core.
> >
> > Adding DT bindings for something that seems unlikely to be supported
> > in future, seems like a bad idea. It's better to add it when/if
> > needed.
> If some SoC use the multiple slot for dw-mmc controller, we can't prevent to use the multiple slot.
> So i'm not sure that host controller's subnode didn't need to support.
> Right. this is bad idea, i also hope that it will not use the multiple slot at dw-mmc in future.
> 
> To Seungwon,
> 
> how about this?

I have no objection to remove multi-slot.
It seems not useful considering performance. Above all, there is no actual use case.

Thanks,
Seungwon Jeon


