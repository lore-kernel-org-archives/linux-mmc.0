From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [PATCH v2 8/8] ARM: STi: DT: STiH407: Add dt nodes for sdhci
 and emmc.
Date: Tue, 3 Mar 2015 12:03:20 +0100
Message-ID: <54F594F8.50306@st.com>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org> <1424956227-18258-9-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46908 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756280AbbCCLD4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Mar 2015 06:03:56 -0500
In-Reply-To: <1424956227-18258-9-git-send-email-peter.griffin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org
Cc: lee.jones@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, peppe.cavallaro@st.com


On 02/26/2015 02:10 PM, Peter Griffin wrote:
> The nodes have been split to allow as much commonality as possible.
> The stih407 has a silicon bug with eMMC UHS modes (with top regs)
> and as such doesn't have any of the uhs dt properties.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>   arch/arm/boot/dts/stih407-family.dtsi | 30 ++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/stih410-b2120.dts   | 10 ++++++++++
>   arch/arm/boot/dts/stihxxx-b2120.dtsi  |  8 ++++++++
>   3 files changed, 48 insertions(+)
>
>
Maybe you could also add SD/eMMC support to the b2199 too?
I can test if you don't have the hardware yet.

Kind regards,
Maxime
