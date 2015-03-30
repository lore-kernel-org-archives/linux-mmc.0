From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 8/8] ARM: STi: DT: STiH407: Add dt nodes for sdhci and
 emmc.
Date: Mon, 30 Mar 2015 12:37:51 +0100
Message-ID: <20150330113751.GE9447@x1>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org>
 <1424956227-18258-9-git-send-email-peter.griffin@linaro.org>
 <54F594F8.50306@st.com>
 <20150330112357.GE21893@griffinp-ThinkPad-X1-Carbon-2nd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35392 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbbC3Lh4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Mar 2015 07:37:56 -0400
Received: by wgdm6 with SMTP id m6so171108814wgd.2
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2015 04:37:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150330112357.GE21893@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Maxime Coquelin <maxime.coquelin@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, peppe.cavallaro@st.com

On Mon, 30 Mar 2015, Peter Griffin wrote:

> Hi Maxime,
>=20
> On Tue, 03 Mar 2015, Maxime Coquelin wrote:
>=20
> >=20
> > On 02/26/2015 02:10 PM, Peter Griffin wrote:
> > >The nodes have been split to allow as much commonality as possible=
=2E
> > >The stih407 has a silicon bug with eMMC UHS modes (with top regs)
> > >and as such doesn't have any of the uhs dt properties.
> > >
> > >Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > >---
> > >  arch/arm/boot/dts/stih407-family.dtsi | 30 +++++++++++++++++++++=
+++++++++
> > >  arch/arm/boot/dts/stih410-b2120.dts   | 10 ++++++++++
> > >  arch/arm/boot/dts/stihxxx-b2120.dtsi  |  8 ++++++++
> > >  3 files changed, 48 insertions(+)
> > >
> > >
> > Maybe you could also add SD/eMMC support to the b2199 too?
>=20
> Yes ok, I will add support for stih418-b2199 in v3.

Is there any reason why this can't be actioned in a subsequent patch?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
