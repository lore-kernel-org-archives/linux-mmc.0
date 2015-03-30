From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH v2 8/8] ARM: STi: DT: STiH407: Add dt nodes for sdhci and
 emmc.
Date: Mon, 30 Mar 2015 12:23:57 +0100
Message-ID: <20150330112357.GE21893@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org>
 <1424956227-18258-9-git-send-email-peter.griffin@linaro.org>
 <54F594F8.50306@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54F594F8.50306@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Coquelin <maxime.coquelin@st.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org, lee.jones@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, peppe.cavallaro@st.com
List-Id: linux-mmc@vger.kernel.org

Hi Maxime,

On Tue, 03 Mar 2015, Maxime Coquelin wrote:

> 
> On 02/26/2015 02:10 PM, Peter Griffin wrote:
> >The nodes have been split to allow as much commonality as possible.
> >The stih407 has a silicon bug with eMMC UHS modes (with top regs)
> >and as such doesn't have any of the uhs dt properties.
> >
> >Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> >---
> >  arch/arm/boot/dts/stih407-family.dtsi | 30 ++++++++++++++++++++++++++++++
> >  arch/arm/boot/dts/stih410-b2120.dts   | 10 ++++++++++
> >  arch/arm/boot/dts/stihxxx-b2120.dtsi  |  8 ++++++++
> >  3 files changed, 48 insertions(+)
> >
> >
> Maybe you could also add SD/eMMC support to the b2199 too?

Yes ok, I will add support for stih418-b2199 in v3.

> I can test if you don't have the hardware yet.

Yes please, as I don't have any stih418 hardware yet

regards,

Peter.
